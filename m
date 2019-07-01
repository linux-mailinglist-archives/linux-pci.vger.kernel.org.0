Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFB5B96B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfGAKus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 06:50:48 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18358 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGAKus (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 06:50:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d19e58a0000>; Mon, 01 Jul 2019 03:50:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Jul 2019 03:50:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Jul 2019 03:50:46 -0700
Received: from [10.24.46.111] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jul
 2019 10:50:43 +0000
Subject: Re: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190618073810.30270-1-vidyas@nvidia.com>
 <20190627100616.GA30071@e121166-lin.cambridge.arm.com>
 <716ad7c9-08bb-b885-69bd-a442d6f9b2eb@nvidia.com>
 <20190627152303.GE3782@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f54f595c-b03f-47d7-09d2-d0cf148b1ba3@nvidia.com>
Date:   Mon, 1 Jul 2019 16:20:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627152303.GE3782@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561978250; bh=q882PDq25kuZRevJKIe02NSInIQJ7WUfjiLxvUzGrhA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mkD5jrEuRdgEmAtbCqBCQnta/zLLCsP96c1vTGwSnhGLcpbr3GPIGCw7X1JCynwK/
         ZZQ3gEOlAv2mkCFAFpj3gKbJRcCkLPiRVU/asuaVhXigA4Nt31PkUNZTC/nhmNBl+s
         SvLxlB61Ct3/REOgnFZJSrNGDthohRt/nKHKgHXPcQoAMZq07ckNVPc18toD0tb1Bo
         PiRwWJTioi1VqPryS8ut6g+yjs+FQKJEqHo2j2fLb9pBlxVFXLsGC5+fbxaqpkG12D
         qZxAubY2BOvmu4lQ42gZEl6dshHDsm0GdvMTozrIh/1zEc/GoWPUAWtfRgebXWtmGY
         aHBzDcSozgA4g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/27/2019 8:53 PM, Lorenzo Pieralisi wrote:
> On Thu, Jun 27, 2019 at 08:41:37PM +0530, Vidya Sagar wrote:
>> On 6/27/2019 3:36 PM, Lorenzo Pieralisi wrote:
>>> On Tue, Jun 18, 2019 at 01:08:10PM +0530, Vidya Sagar wrote:
>>>> Currently Relaxed Ordering bit in the configuration space is enabled for
>>>> all devices whereas it should be enabled only for root ports for Tegra20
>>>> and Tegra30 chips to avoid deadlock in hardware.
>>>
>>> This is a fix so I think you had better add a Fixes: tag and if the
>>> erratum is a public document it would be good to add it to the log
>>> to explain what the problem is.
>>>
>>> Thanks,
>>> Lorenzo
>> This has been there from the beginning. I mean, if I have to give a tag as part
>> of Fixes: , then I should give the tag that adds this driver itself. Is that fine?
>> I can quote the following document section 31.1 for Tegra20, but the same information
>> is not mentioned in Tegra30 specific public document.
>> https://www.chiark.greenend.org.uk/~theom/riscos/docs/Tegra2_TRM_DP04508001v01p.pdf
>> Is it fine to just quote only this document?
> 
> I am pretty sure an errata document should exist about this and Nvidia
> owns it (if it is not public, well, there is nothing to quote then); I
> would not quote this website, it does not look like Nvidia official
> documentation.
We have the TRM (Technical Reference Manual) document available for Tegra20 at
https://developer.nvidia.com/embedded/downloads#?search=tegra%202 but basic registration
is required to download the document. I'll mention this link in the commit message.

> 
> For the Fixes: tag, it is up to you, to me this seems like a
> critical bug (deadlock in hardware) and I do not think you
> want to ship stable kernels with it. It depends on the entity
> of the bug we are fixing, I leave it to you to decide the
> best course of action, I am just trying to help.
Since there is no specific commit that introduced this issue and the issue has been there
from the beginning, I'm of the opinion that giving initial commit tag (the one that added
the driver itself) for 'Fixes: tag doesn't really help here.

> 
> Lorenzo
> 
>> Thanks,
>> Vidya Sagar
>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>>    drivers/pci/controller/pci-tegra.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>>>> index 464ba2538d52..bc7be369c1b3 100644
>>>> --- a/drivers/pci/controller/pci-tegra.c
>>>> +++ b/drivers/pci/controller/pci-tegra.c
>>>> @@ -545,12 +545,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
>>>>    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
>>>> -/* Tegra PCIE requires relaxed ordering */
>>>> +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
>>>>    static void tegra_pcie_relax_enable(struct pci_dev *dev)
>>>>    {
>>>>    	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
>>>>    }
>>>> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
>>>>    static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
>>>>    {
>>>> -- 
>>>> 2.17.1
>>>>
>>

