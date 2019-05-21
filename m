Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E179A255FC
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfEUQrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 12:47:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1173 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfEUQrg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 12:47:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce42ba70000>; Tue, 21 May 2019 09:47:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 09:47:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 09:47:34 -0700
Received: from [10.25.72.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 16:47:29 +0000
Subject: Re: [PATCH V7 02/15] PCI: Disable MSI for Tegra194 root port
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-3-vidyas@nvidia.com> <20190521102729.GB29166@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f63051b0-a220-125b-219e-25156d65ea6d@nvidia.com>
Date:   Tue, 21 May 2019 22:17:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521102729.GB29166@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558457255; bh=BlKoVyxfa3/PhGnDYxQwviA1iVDUS1wMLF49XD5WLTo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EeQpa9fitk/OpoQb5fgRexaj/4U0V03Hh0lFLdmYSKWSxWr0BxeUY1pOsh3perPWB
         SVrQaG2Es6cVEJE9EcAkpzaUoe60SPjdpXy08bnbbNt9SXoNgvTk4Zh9/BoEqEtNSW
         NPLtiibkt0oh3/H2R3pz2t8h0xyFRQ0W9hxD4848k7pI4sY8vWFWGltTlk8aT8G5wQ
         NdeLJpPeJqt0Z9aq2LNe77mtwWiM3EwVsYl7NZCFrZfxwU0pFW6XX/hp7Cet/gZsnm
         yjcGWIB56i2lBnp8u4z42Li1AYeei5ZBUCmPodnipCn0mPZNdyRypL1GmUo5PaUvx8
         /rRw7QYrXZMww==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/21/2019 3:57 PM, Thierry Reding wrote:
> On Fri, May 17, 2019 at 06:08:33PM +0530, Vidya Sagar wrote:
>> Tegra194 rootports don't generate MSI interrupts for PME events and hence
>> MSI needs to be disabled for them to avoid root ports service drivers
>> registering their respective ISRs with MSI interrupt.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v6]:
>> * This is a new patch
>>
>>   drivers/pci/quirks.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 0f16acc323c6..28f9a0380df5 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2592,6 +2592,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>>   			PCI_DEVICE_ID_NVIDIA_NVENET_15,
>>   			nvenet_msi_disable);
>>   
>> +/*
>> + * Tegra194's PCIe root ports don't generate MSI interrupts for PME events
>> + * instead legacy interrupts are generated. Hence, to avoid service drivers
>> + * registering their respective ISRs for MSIs, need to disable MSI interrupts
>> + * for root ports.
>> + */
>> +static void disable_tegra194_rp_msi(struct pci_dev *dev)
>> +{
>> +	dev->no_msi = 1;
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0, disable_tegra194_rp_msi);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1, disable_tegra194_rp_msi);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2, disable_tegra194_rp_msi);
>> +
> 
> Later functions in this file seem to use a more consistent naming
> pattern, according to which the name for this would become:
> 
> 	pci_quirk_nvidia_tegra194_disable_rp_msi
> 
> Might be worth considering making this consistent.
> 
> This could also be moved to the DWC driver to restrict this to where it
> is needed. In either case, this seems like a good solution, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
Ok. I'll move it to DWC driver along with name change for the quirk API.

