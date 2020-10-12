Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52F128BC10
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgJLPgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 11:36:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2568 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389121AbgJLPgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 11:36:09 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8477dc0006>; Mon, 12 Oct 2020 08:35:56 -0700
Received: from [10.25.77.115] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Oct
 2020 15:35:58 +0000
Subject: Re: [PATCH v7 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
To:     Robin Murphy <robin.murphy@arm.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201009155311.22d3caa5@xhacker.debian>
 <20201009155505.5a580ef5@xhacker.debian>
 <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <1a1c41f1-4085-6b24-adea-d1e0867e7d9d@nvidia.com>
Date:   Mon, 12 Oct 2020 21:05:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602516956; bh=iMpY4EcqsltfDucfSgNi/HRriIso15sLE1BSSwyiAe4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=FBkDCHw2cXDvEjEFqo6jSf20McjZNBzqDWrpIwOoz29LA9n1utvEQPudD7NkLgntM
         sG6pDoAbhgNgMcMIDQSVuRgbzg60ZZOvyls7rxgbmlVdB4SUCdNFSEbd4QJDTJ2e2n
         N2pcTBjZxcv/MOb5rbtpHWezZfmPPt6Op6oTZ3Sy7jWawztXZoN2R5NsCDZ+qkPnSM
         GR+sGMa5G6UBWCymEKXoZdDYa1dBfiDAGl6RAFdDn9+TFpPxv8EczpalhV+FtXNBFy
         1byNv8AYZnTgn2iNnEhCeXpnAMdmWzQQb01I4Q5tFHZAzQcySE18ovp/3XYciLJf+2
         N4rY9Va+1Mffg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/12/2020 5:07 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>=20
>=20
> On 2020-10-09 08:55, Jisheng Zhang wrote:
>> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
>> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
>> may lose power during suspend-to-RAM, so when we resume, we want to
>> redo the latter but not the former. If designware based driver (for
>> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
>> msi page will be leaked.
>>
>> As pointed out by Rob and Ard, there's no need to allocate a page for
>> the MSI address, we could use an address in the driver data.
>>
>> To avoid map the MSI msg again during resume, we move the map MSI msg
>> from dw_pcie_msi_init() to dw_pcie_host_init().
>=20
> You should move the unmap there as well. As soon as you know what the
> relevant address would be if you *were* to do DMA to this location, then
> the exercise is complete. Leaving it mapped for the lifetime of the
> device in order to do not-DMA to it seems questionable (and represents
> technically incorrect API usage without at least a sync_for_cpu call
> before any other access to the data).
>=20
> Another point of note is that using streaming DMA mappings at all is a
> bit fragile (regardless of this change). If the host controller itself
> has a limited DMA mask relative to physical memory (which integrators
> still seem to keep doing...) then you could end up punching your MSI
> hole right in the middle of the SWIOTLB bounce buffer, where it's then
> almost *guaranteed* to interfere with real DMA :(
Agree with Robin. Since the MSI page is going to be locked till=20
shutdown/reboot, wouldn't it make sense to use dma_alloc_coherent() API?
Also, shouldn't we call dma_set_mask() to limit the address to only=20
32-bits so as to enable MSI for even those legacy PCIe devices with only=20
32-bit MSI capability?

- Vidya Sagar

>=20
> If no DWC users have that problem and the current code is working well
> enough, then I see little reason not to make this partucular change to
> tidy up the implementation, just bear in mind that there's always the
> possibility of having to come back and change it yet again in future to
> make it more robust. I had it in mind that this trick was done with a
> coherent DMA allocation, which would be safe from addressing problems
> but would need to be kept around for the lifetime of the device, but
> maybe that was a different driver :/
>=20
> Robin.
>=20
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> =C2=A0 drivers/pci/controller/dwc/pci-dra7xx.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 +++++++++-
>> =C2=A0 .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++----=
-----
>> =C2=A0 drivers/pci/controller/dwc/pcie-designware.h=C2=A0 |=C2=A0 2 +-
>> =C2=A0 3 files changed, 36 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c=20
>> b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 8f0b6d644e4b..6d012d2b1e90 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -466,7 +466,9 @@ static struct irq_chip=20
>> dra7xx_pci_msi_bottom_irq_chip =3D {
>> =C2=A0 static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_p=
p(pp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D pci->dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 ctrl, num_ctrls;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_irq_chip =3D &dra7xx_pci_msi_bott=
om_irq_chip;
>>
>> @@ -482,7 +484,21 @@ static int dra7xx_pcie_msi_host_init(struct=20
>> pcie_port *pp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 return dw_pcie_allocate_domains(pp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dw_pcie_allocate_domains(pp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_data =3D dma_map_single_attrs(dev, &pp=
->msi_msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(pp->msi_msg),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DMA_FROM_DEVICE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DMA_ATTR_SKIP_CPU_SYNC);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D dma_mapping_error(dev, pp->msi_data);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "Failed to map MSI data\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pp->msi_data =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dw_pcie_free_msi(pp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>> =C2=A0 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops =3D {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c=20
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index d3e9ea11ce9e..d02c7e74738d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -266,30 +266,23 @@ void dw_pcie_free_msi(struct pcie_port *pp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_domain_remove(pp->msi_domain);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_domain_remove(pp->irq_domain);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 if (pp->msi_page)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __free_page(pp->msi_page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (pp->msi_data) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct device *dev =3D pci->dev;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dma_unmap_single_attrs(dev, pp->msi_data,=20
>> sizeof(pp->msi_msg),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_FROM=
_DEVICE,=20
>> DMA_ATTR_SKIP_CPU_SYNC);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 void dw_pcie_msi_init(struct pcie_port *pp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dw_pcie *pci =3D to_dw_pcie_from_p=
p(pp);
>> -=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D pci->dev;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 u64 msi_target;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 msi_target =3D (u64)pp->msi_data;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ENABLED(CONFIG_PCI_MSI))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_page =3D alloc_page(GFP_KERNEL);
>> -=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_data =3D dma_map_page(dev, pp->msi_pag=
e, 0, PAGE_SIZE,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_FROM_DEVICE);
>> -=C2=A0=C2=A0=C2=A0=C2=A0 if (dma_mapping_error(dev, pp->msi_data)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "Failed to map MSI data\n");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __free_page(pp->msi_page);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pp->msi_page =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0 msi_target =3D (u64)pp->msi_data;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Program the msi_data */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO,=
=20
>> lower_32_bits(msi_target));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI,=
=20
>> upper_32_bits(msi_target));
>> @@ -394,6 +387,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>                              =20
>> irq_set_chained_handler_and_data(pp->msi_irq,
>>                                                          =20
>> dw_chained_msi_isr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pp);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_data =3D dma_ma=
p_single_attrs(pci->dev,=20
>> &pp->msi_msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizeof(pp->msi_msg),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 DMA_FROM_DEVICE,
>> +                                                  =20
>> DMA_ATTR_SKIP_CPU_SYNC);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dma_mapping_error(p=
ci->dev, pp->msi_data)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(pci->dev, "Failed to map MSI=20
>> data\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pp->msi_data =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free_msi;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pp->ops->msi=
_host_init(pp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h=20
>> b/drivers/pci/controller/dwc/pcie-designware.h
>> index 97c7063b9e89..9d2f511f13fa 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -190,8 +190,8 @@ struct pcie_port {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 msi_irq;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_domain=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *irq_domain;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_domain=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *msi_domain;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msi_msg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_addr_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi_data;
>> -=C2=A0=C2=A0=C2=A0=C2=A0 struct page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *msi_page;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_chip=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *msi_irq_chip;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 num_vectors;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 irq_mask[MAX_MSI_CTRLS];
>>
