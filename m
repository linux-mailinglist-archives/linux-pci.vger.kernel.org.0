Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C958346461
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhCWQFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:05:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhCWQFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 12:05:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12NG5Voo061626;
        Tue, 23 Mar 2021 11:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616515531;
        bh=K4fwQJg6ForgmFFqDP5hpVwKkfU//raomS14z9sDVDs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VlQNUlC4T4qbziL3cqSwVR78bDxHopSDUHyYWbLHoCL6RZs5quyDFcNsruukGC8ZX
         KW7AUDqVb3XSpway/2V1EhOyU7U21vLleVZBzndJMXU3LFYNdV/gEPnrWHXLYpXi6h
         BzIEuJ4s6zlKALTt8XkhdyKV/o34zjLcS3HJL3J4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12NG5VdQ049384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Mar 2021 11:05:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 23
 Mar 2021 11:05:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 23 Mar 2021 11:05:09 -0500
Received: from [10.250.232.230] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12NG55P4089384;
        Tue, 23 Mar 2021 11:05:06 -0500
Subject: Re: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20210323151250.GA576016@bjorn-Precision-5520>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <310d1d4b-a4b5-37c6-6f59-c822acbe9b19@ti.com>
Date:   Tue, 23 Mar 2021 21:34:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323151250.GA576016@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 23/03/21 8:42 pm, Bjorn Helgaas wrote:
> [-cc Dilip (mail to him bounced)]
> 
> On Tue, Mar 23, 2021 at 11:01:15AM +0800, Jisheng Zhang wrote:
>> On Mon, 22 Mar 2021 20:24:41 -0500 Bjorn Helgaas wrote:
>>>
>>> [+cc Kishon, Richard, Lucas, Dilip]
>>>
>>> On Mon, Mar 01, 2021 at 11:10:31AM +0800, Jisheng Zhang wrote:
>>>> After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
>>>> MSI stops working after resume. Because dw_pcie_host_init() is only
>>>> called once during probe. To fix this issue, we move dw_pcie_msi_init()
>>>> to dw_pcie_setup_rc().  
>>>
>>> This patch looks fine, but I don't think the commit log tells the
>>> whole story.
>>>
>>> Prior to 59fbab1ae40e, it looks like the only dwc-based drivers with
>>> resume functions were dra7xx, imx6, intel-gw, and tegra [1].
>>>
>>> Only tegra called dw_pcie_msi_init() in the resume path, and I do
>>> think 59fbab1ae40e broke MSI after resume because it removed the
>>> dw_pcie_msi_init() call from tegra_pcie_enable_msi_interrupts().
>>>
>>> I'm not convinced this patch fixes it reliably, though.  The call
>>> chain looks like this:
>>>
>>>   tegra_pcie_dw_resume_noirq
>>>     tegra_pcie_dw_start_link
>>>       if (dw_pcie_wait_for_link(pci))
>>>         dw_pcie_setup_rc
>>>
>>> dw_pcie_wait_for_link() returns 0 if the link is up, so we only call
>>> dw_pcie_setup_rc() in the case where the link *didn't* come up.  If
>>> the link comes up nicely without retry, we won't call
>>> dw_pcie_setup_rc() and hence won't call dw_pcie_msi_init().
>>
>> The v1 version patch was sent before commit 275e88b06a (PCI: tegra: Fix host
>> link initialization"). At that time, the resume path looks like this:
>>
>> tegra_pcie_dw_resume_noirq
>>   tegra_pcie_dw_host_init
>>     tegra_pcie_prepare_host
>>       dw_pcie_setup_rc
>>
>> so after patch, dw_pcie_msi_init() will be called. But now it seems that
>> the tegra version needs one more fix for the resume.
>>
>> So could I sent a new patch to update the commit-msg a bit?
> 
> This patch only touches the dwc core, and the commit log says
> generically that it fixes MSI after resume, so one could assume that
> it applies to all dwc-based drivers.  But I don't think it's that
> simple, so I'd like to know *which* drivers are fixed and which
> commits are related.  I don't see how 59fbab1ae40e breaks anything
> except tegra.
> 
>>> Since then, exynos added a resume function.  My guess is MSI never
>>> worked after resume for dra7xx, exynos, imx6, and intel-gw because
>>> they don't call dw_pcie_msi_init() in their resume functions.
>>>
>>> This patch looks like it should fix MSI after resume for exynos, imx6,
>>> and intel-gw because they *do* call dw_pcie_setup_rc() from their
>>> resume functions [2], and after this patch, dw_pcie_msi_init() will be
>>> called from there.
>>>
>>> I suspect MSI after resume still doesn't work on dra7xx.
>>
>> I checked the dra7xx history, I'm afraid that the resume never works
>> from the beginning if the host lost power during suspend, I guess the
>> platform never power off the host but only the phy?

Suspend on dra7xx disabled clocks and powered off phy (at-least while
suspend/resume hooks were merged) and resume enabled clocks and phy.
However suspend/resume is broken in dra7xx system and is not validated.
I'll send a patch to remove the suspend/resume hooks in dra7xx.

Thanks
Kishon

> 
> Sounds like that would make sense.
> 
>>> [1] git grep -A20 -e "static.*resume_noirq" 59fbab1ae40e^:drivers/pci/controller/dwc
>>> [2] git grep -A20 -e "static.*resume_noirq" drivers/pci/controller/dwc
>>>
>>>> Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>>> ---
>>>> Since v1:
>>>>  - collect Reviewed-by tag
>>>>
>>>>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 7e55b2b66182..e6c274f4485c 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>       }
>>>>
>>>>       dw_pcie_setup_rc(pp);
>>>> -     dw_pcie_msi_init(pp);
>>>>
>>>>       if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>>>>               ret = pci->ops->start_link(pci);
>>>> @@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>               }
>>>>       }
>>>>
>>>> +     dw_pcie_msi_init(pp);
>>>> +
>>>>       /* Setup RC BARs */
>>>>       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
>>>>       dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>>>> --
>>>> 2.30.1
>>>>  
>>
