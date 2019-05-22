Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B14325F11
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfEVIIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 04:08:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12935 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfEVIIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 04:08:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce503660001>; Wed, 22 May 2019 01:08:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 01:08:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 01:08:06 -0700
Received: from [10.24.45.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 08:08:01 +0000
Subject: Re: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-3-vidyas@nvidia.com> <20190521102729.GB29166@ulmo>
 <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
 <20190521193616.GE57618@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4a9dadc5-7e16-4893-c7c2-acd7f515e039@nvidia.com>
Date:   Wed, 22 May 2019 13:37:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521193616.GE57618@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558512486; bh=S3qg1DZrsjj7dBknX1Sd7FnNcS0V5oTUC1xCslRcFBw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AWdqHpM7dtZkVRmsszQ5JLOgOMdjk5aT6OpjxRX0jVR5xOEnTKH41lFcfDeR+P9O+
         qtsguVLnqrmnYEW8/NQel6Q3DzeTOHUZvNH8Kq6GEwq+DzFzO2QkzHF+2E8D0Yd6yX
         3eF8tUSXtzYOtzSxaV0MV1eZ3xXND2FxoMI0b1pOKeTe4MEPG+FLgxbxIQHpP66J7O
         CyXFXW+EYm7y1p+SaBekN2zSKWCnH8mR7V69+eUKC6GT2uXa9TME0qNIqytjTU8q7C
         NHYLQ2rLjkAc9rQID0clnHLuYDL0yV8+yLrvFSorlRjswGFpWSpCRw7vO1GBXB1NE4
         ddghXQzP14t7g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/22/2019 1:06 AM, Bjorn Helgaas wrote:
> On Tue, May 21, 2019 at 10:17:26PM +0530, Vidya Sagar wrote:
>> On 5/21/2019 3:57 PM, Thierry Reding wrote:
>>> On Fri, May 17, 2019 at 06:08:33PM +0530, Vidya Sagar wrote:
>>>> Tegra194 rootports don't generate MSI interrupts for PME events and hence
>>>> MSI needs to be disabled for them to avoid root ports service drivers
>>>> registering their respective ISRs with MSI interrupt.
> 
> The service drivers (AER, hotplug, etc) don't know whether the
> interrupt is INTx or MSI; they just register their ISRs with
> pcie_device.irq.
> 
> The point of this patch is that the PCI core doesn't support devices
> that use MSI and INTx at the same time, and since this device can't
> generate MSI for PME, we have to use INTx for *all* its interrupts.
> 
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> Changes since [v6]:
>>>> * This is a new patch
>>>>
>>>>    drivers/pci/quirks.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 0f16acc323c6..28f9a0380df5 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>>>>    			PCI_DEVICE_ID_NVIDIA_NVENET_15,
>>>>    			nvenet_msi_disable);
>>>> +/*
>>>> + * Tegra194's PCIe root ports don't generate MSI interrupts for PME events
>>>> + * instead legacy interrupts are generated. Hence, to avoid service drivers
>>>> + * registering their respective ISRs for MSIs, need to disable MSI interrupts
>>>> + * for root ports.
>>>> + */
>>>> +static void disable_tegra194_rp_msi(struct pci_dev *dev)
>>>> +{
>>>> +	dev->no_msi = 1;
>>>> +}
>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194_rp_msi);
>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194_rp_msi);
>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194_rp_msi);
>>>> +
>>>
>>> Later functions in this file seem to use a more consistent naming
>>> pattern, according to which the name for this would become:
>>>
>>> 	pci_quirk_nvidia_tegra194_disable_rp_msi
>>>
>>> Might be worth considering making this consistent.
>>>
>>> This could also be moved to the DWC driver to restrict this to where it
>>> is needed. In either case, this seems like a good solution, so:
>>>
>>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>>>
>> Ok. I'll move it to DWC driver along with name change for the quirk API.
> 
> Is there any possibility this hardware would be used in an ACPI
> system?  If so, the quirk should probably stay in drivers/pci/quirks.c
> because the DWC driver would not be present.
Yes. There is a plan to boot kernel through UEFI (using ACPI) on this system.
So, I'll move it to drivers/pci/quirks.c file.

> 
> Either way, please also add some PCIe spec references about this in
> the changelog and a comment in the code about working around this
> issue.  I think the MSI/MSI-X sections that prohibit a device from
> using both INTx and MSI/MSI-X are probably the most pertinent.
Ok. I'll take care of it in the next patch series.

> 
> The reason I want a comment about this is to discourage future
> hardware from following this example because every device that *does*
> follow this example requires a kernel update that would be otherwise
> unnecessary.
Ok. I'll take it up with our hardware engineers to have only MSI/MSI-X interrupts
getting generated for all root port received events.

> 
> Bjorn
> 

