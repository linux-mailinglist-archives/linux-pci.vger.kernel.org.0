Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC54B087
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 05:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfFSD43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 23:56:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14842 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfFSD43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 23:56:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d09b26a0000>; Tue, 18 Jun 2019 20:56:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 20:56:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 20:56:26 -0700
Received: from [10.24.192.29] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 03:56:23 +0000
Subject: Re: [PATCH V6 20/27] PCI: tegra: Disable MSI for Tegra PCIe root port
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-21-mmaddireddy@nvidia.com>
 <20190618194830.GA110859@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e06f85eb-be0c-c2a5-84a9-51aa9b8372c3@nvidia.com>
Date:   Wed, 19 Jun 2019 09:25:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618194830.GA110859@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560916586; bh=4JstVY89KTv+Xb8i7slBmq/+fO6Mvwf3ij94+ExbInI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=Bmvrxy4T7vbdnMZSgVZC9KVFU7iUyru5X4Uf4a33CZY42bCc6WQm4WzKkDEiPPdVT
         7WMb8tavi7AkvANKRzJLnNAhuNelJrjWQbYArMS/9y32nmIdokw89cLsnNYqJCEcel
         56s4oxttrVFYuXEYCYwXRRQ3WO0j2mn6abh5F+GkjGXWrHCudL8mT9vkwGbRmcRPxv
         zTHAOOEDsY7KYYedOLBTewXGLXR+fKKepa8PGYpoI/0IUtIpJswg+p1QEfmcrmqaai
         hA4vH7akZ7I2FM26FDOBQ+QJYwbs86Mm77oIWuxiyGdiSi7GXAG50qNZDgiuKhD3Dp
         3XULOPXsIywFA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 19-Jun-19 1:18 AM, Bjorn Helgaas wrote:
> On Tue, Jun 18, 2019 at 11:31:59PM +0530, Manikanta Maddireddy wrote:
>> Tegra PCIe generates PME and AER events over legacy interrupt line. Disable
>> MSI to avoid service drivers registering interrupt routine over MSI IRQ
>> line.
>>
>> PME and AER interrupts registered to MSI without this change,
>> cat /proc/interrupts | grep -i pci
>> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
>> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
>> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
>>
>> PME and AER interrupts registered to legacy IRQ with this change,
>> cat /proc/interrupts | grep -i pci
>> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
>> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V6: Replaced pcie_pme_disable_msi() with no_msi quirk
>>
>> V5: No change
>>
>> V4: No change
>>
>> V3: Corrected typo in commit log
>>
>> V2: No change
>>
>>  drivers/pci/quirks.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index a59ad09ce911..20dcad421991 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2576,6 +2576,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>>  			PCI_DEVICE_ID_NVIDIA_NVENET_15,
>>  			nvenet_msi_disable);
>>  
>> +/*
>> + * Tegra PCIe generates PME and AER events over legacy interrupt line.
>> + * So disable msi for Tegra PCIe root ports.
> s/msi/MSI/
>
> What's going on here?  Vidya posted a very similar patch [1] (although

This series is focused on Tegra20, Tegra30, Tegra124, Tegra210 and Tegra186,
whereas Vidya's series is focused only on Tegra194. So I didn't include
Tegra194 device IDs.

> his included nice spec citations, which you omitted), but his added
> quirks for 0x1ad0, 0x1ad1, and 0x1ad2.  You didn't include any of
> those here.
>
> Maybe Lorenzo will sort this all out, but it would make things easier
> if you and Vidya got together and integrated your patches yourselves
> so Lorenzo didn't have to worry about it.
>
> [1] https://lore.kernel.org/lkml/20190612095339.20118-3-vidyas@nvidia.com

I talked with Vidya, he will take this changes in his series if he needs
to publish another version, or else he will publish a new patch to add
quirk for legacy Tegra SOCs.

Lorenzo,
If this series is ready for integration, please drop this patch.

Manikanta

>
>> + */
>> +static void pci_quirk_nvidia_tegra_disable_rp_msi(struct pci_dev *dev)
>> +{
>> +	dev->no_msi = 1;
>> +}
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e12,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e13,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0fae,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0faf,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
>> +			      PCI_CLASS_BRIDGE_PCI, 8,
>> +			      pci_quirk_nvidia_tegra_disable_rp_msi);
>> +
>>  /*
>>   * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
>>   * config register.  This register controls the routing of legacy
>> -- 
>> 2.17.1
>>

