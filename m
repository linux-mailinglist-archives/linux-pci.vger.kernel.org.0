Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8A5FA87
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGDPEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 11:04:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6207 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGDPEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jul 2019 11:04:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1e156c0000>; Thu, 04 Jul 2019 08:04:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jul 2019 08:04:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jul 2019 08:04:08 -0700
Received: from [10.25.75.131] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jul
 2019 15:04:04 +0000
Subject: Re: [PATCH V2] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <treding@nvidia.com>, <swarren@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190701110942.24305-1-vidyas@nvidia.com>
 <20190703161922.GA22679@e121166-lin.cambridge.arm.com>
 <be78c2c4-90bf-3c63-ace5-546e490c732c@nvidia.com>
 <20190704125547.GA17653@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <18fb7688-7c65-334f-8178-cc325b4a0e5b@nvidia.com>
Date:   Thu, 4 Jul 2019 20:34:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704125547.GA17653@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562252652; bh=244egi/Sdwj5ckyEFvG0x38RhLm25Bppuf4fSovjTnw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XP5M8T+ocMY3ZKerFsn5DFJTpE28L8yTZu96cZFw3GF5y64xiy19Lj8SYuZy1il/l
         il6wc6SSmq4sGFTgMKIivXc681pLn0Et8DibJBmJMnP4ieUix9Dozrw/s1G0rtaP5A
         JDF1Y2f3GOOGUOaNil/VlEryLDWjShNpReqN1XboiGNx2mrfZYlTLqWLrASWsAzQ46
         Vkn+nFc4DDEoveh9z0zW4Gw+NlrjNg96OGMmwQJY3tCgP4/i6m92vZL/JjKGlBupBo
         vKN1vICW65lVoGXhHEsAP84Yzr+WV1airI4TLjAIqUYU+IzwjTclJScY2cWE1aeUtb
         kpr313e/sywrg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/4/2019 6:25 PM, Lorenzo Pieralisi wrote:
> On Wed, Jul 03, 2019 at 10:20:23PM +0530, Vidya Sagar wrote:
>> On 7/3/2019 10:09 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jul 01, 2019 at 04:39:42PM +0530, Vidya Sagar wrote:
>>>> Currently Relaxed Ordering bit in the configuration space is enabled for
>>>> all devices, but, as per the Technical Reference Manual of Tegra20 which is
>>>
>>> What devices ?
>> All PCIe devices, because, current quirk uses PCI_ANY_ID for both Vendor-ID
>> and Device-ID and that makes it applicable for all PCIe devices.
> 
> And this is true regardless of whether the PCI tegra controller is
> *the* actual controller in the system, aka as long as the Tegra driver
> is compiled in, relaxed ordering is forced for any PCIe device.
> 
> This is gross and I do believe the fix should be propagated back to
> the commit that introduced it, it should have never been implemented
> like this.
Agree.
This was there in the very first commit of this driver i.e.
77ffc1465cec32489889d6bc9c288b7b0d2ce9fb which added this driver for Tegra20
as arch/arm/mach-tegra/pcie.c Since there was no device-tree concept back then,
could it be the case that this quirk comes into picture *only* if kernel is built
for Tegra20 and not otherwise? Even then, I agree that using PCI_ANY_ID is quite
wild way of applying a quirk.

> 
>>>> available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
>>>> in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
>>>> its root ports to avoid deadlock in hardware. The same is applicable for
>>>> Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
>>>> but the same should not be extended to root ports of other Tegra SoCs or
>>>> other hosts.
>>>
>>> Should not or must not ? What does this sentence mean ?
>> I think it is 'must not' here. Since the hardware deadlock issue is not present
>> in any other root ports other than Tegra20 and Tegra30, this quirk must not be
>> extended to any other root ports.
>>
>>>
>>> Can we try to be more precise please ?
>>>
>>> As I said before the commit log must be clear to anyone reading it
>>> even if he has no background information.
>> Would the following work?
>>
>> Currently Relaxed Ordering bit in the configuration space is enabled
>> for all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID
>> and Device-ID, but, as per the Technical Reference Manual of Tegra20
>> which is available at
>> https://developer.nvidia.com/embedded/downloads#?search=tegra%202 in
>> Sec 34.1, it is mentioned that Relexed Ordering bit needs to be
>> enabled in its root ports to avoid deadlock in hardware. The same is
>> applicable for Tegra30 as well though it is not explicitly mentioned
>> in Tegra30 TRM document, but the same must not be extended to root
>> ports of other Tegra SoCs or other hosts as the same issue doesn't
>> exist there.
> 
> More or less, I will tweak it myself. Regardless the way it is
> handled at the moment is really really not acceptable, one more
> reason why this patch should be backported IMO.
> 
> Lorenzo
> 
>>> Lorenzo
>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> V2:
>>>> * Modified commit message to include reference to Tegra20 TRM document.
>>>>
>>>>    drivers/pci/controller/pci-tegra.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>>>> index 9cc03a2549c0..241760aa15bd 100644
>>>> --- a/drivers/pci/controller/pci-tegra.c
>>>> +++ b/drivers/pci/controller/pci-tegra.c
>>>> @@ -787,12 +787,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
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

