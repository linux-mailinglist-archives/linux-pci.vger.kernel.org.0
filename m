Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C35EA878
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiIZOdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiIZOdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 10:33:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC68B18;
        Mon, 26 Sep 2022 05:49:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a3so10634476lfk.9;
        Mon, 26 Sep 2022 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YkGQAAfg57Cfd/8FuKOI870wl1nN5N2J93+1w00zmGo=;
        b=NwyJM6VOySK+25FSIrxnbBkMXJhyPQqFLGzincoJdqE4OI9oZ+icE81DVk3egpA6Zz
         HkZOLhZf70wcEBEJwnvUz4ByKya/1CkEhQBpPtOY6VCcij51LsX4O+CTh9WL2a3Dmssc
         M4bcePgDrKWXMbxiY2MIEVN4EuE4VBJfyXcHlcglTSSn9l66mgHGQQsXIYd+3r1vNcVr
         z8nZFxWiR/SYOP+bFzwk8yFwBTNRp4Z2PrNVflM/ZACu4a+oHh5el49bbwy8gsuPPbVo
         TCBaQY6gMWe/z8JmdLU54ARwhsQxXU7F8gDCt2G1NhhLh6jsaNXRn7hq4HSRkCs7Tv00
         ImvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YkGQAAfg57Cfd/8FuKOI870wl1nN5N2J93+1w00zmGo=;
        b=LGOZpIe/v0xHZQG+4CKV7RNjDu5WfY9i4P8XGzA2Yzyoao3ctUzqLDFKAtFrOFvo+3
         6j4S6VhEPXScsmnCh+/KXocJT8oGJyjY1Xbr0nbmE/TYRtiymStrm2uZRHVLPCSrTthW
         X/hSP1bB/L1RWGi4UMzdfGNE38nuhb/mpLJhBH4ehXBzpIIY+cfYTB03sL+krmCxrrcE
         2x3DnW817qvPE68zMLf5xr4PYfDPt3IJGEylAkJNUefl6lRJ7qTCIP3vA59pGIGfdxB0
         gkCDTf8emsjpsvJ6mdc9VeI+YwU6rzqv1eu/sHmM2fpqoADP9HVVLQDeySUx6DeZIeGq
         MUMg==
X-Gm-Message-State: ACrzQf0kgQjDszjHi+w4ISJfYYs6sgmku1gQABmesU1/FlchPkRIXFt6
        IRO2+aFoXJ1WzvevD3UxjjM=
X-Google-Smtp-Source: AMsMyM4IoQIaDvxmwMa4MgqckhNWBG+BScAVGmk4WGBC37tjy5AF6oKr4zPXvx9jW0h0s4CheAOe0Q==
X-Received: by 2002:a05:6512:2345:b0:49e:359f:5579 with SMTP id p5-20020a056512234500b0049e359f5579mr9521482lfu.478.1664196570350;
        Mon, 26 Sep 2022 05:49:30 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b0049a148eb003sm2515171lfs.178.2022.09.26.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 05:49:29 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:49:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        William McVicker <willmcvicker@google.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        willmcvicker@google.com
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220926124924.4vodhncnuaorrlwj@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <20220912000211.ct6asuhhmnatje5e@mobilestation>
 <YzF8N/jzkWsjcgdD@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzF8N/jzkWsjcgdD@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

@Christoph, @Marek, @Bjorn, @Rob could you please join to the
DMA-mask related discussion. @Lorenzo can't decide which driver should
initialize the device DMA-mask.

On Mon, Sep 26, 2022 at 12:17:27PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Sep 12, 2022 at 03:02:11AM +0300, Serge Semin wrote:
> 
> [...]
> 
> > > > +/*
> > > > + * Baikal-T1 MMIO space must be read/written by the dword-aligned
> > > > + * instructions. Note the methods are optimized to have the dword operations
> > > > + * performed with minimum overhead as the most frequently used ones.
> > > > + */
> > > > +static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
> > > > +{
> > > > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > > > +
> > > > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > > > +		return -EINVAL;
> > > > +
> > > > +	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
> > > 
> > 
> > > Is it always safe to read more than requested ?
> > 
> > This question is kind of contradicting. No matter whether it's safe or
> > not we just can't perform the IOs with size other than of the dword
> > size. Doing otherwise will cause the bus access error.
> 

> It is not contradicting. You are reading more than the requested
> size, which can have side effects.
> 
> I understand there is no other way around it - still it would be good
> to understand whether that can compromise the driver functionality.

In the framework of the current DW PCIe driver functionality it's
safe. Moreover all the DW PCIe Port-Logic CSRs are of the DWORD
size anyway.

> 
> > > > +	if (size == 4) {
> > > > +		return 0;
> > > > +	} else if (size == 2) {
> > > > +		*val &= 0xffff;
> > > > +		return 0;
> > > > +	} else if (size == 1) {
> > > > +		*val &= 0xff;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
> > > > +{
> > > > +	unsigned int ofs = (uintptr_t)addr & 0x3;
> > > > +	u32 tmp, mask;
> > > > +
> > > > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (size == 4) {
> > > > +		writel(val, addr);
> > > > +		return 0;
> > > > +	} else if (size == 2 || size == 1) {
> > > > +		mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
> > > > +		tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
> > > > +		tmp |= (val & mask) << ofs * BITS_PER_BYTE;
> > > > +		writel(tmp, addr - ofs);
> > > > +		return 0;
> > > > +	}
> > > 
> > 
> > > Same question read/modify/write, is it always safe to do it
> > > regardless of size ?
> > 
> > ditto
> 
> See above.

The same answer.

> 
> > > 
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static u32 bt1_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > > +			     size_t size)
> > > > +{
> > > > +	int ret;
> > > > +	u32 val;
> > > > +
> > > > +	ret = bt1_pcie_read_mmio(base + reg, size, &val);
> > > > +	if (ret) {
> > > > +		dev_err(pci->dev, "Read DBI address failed\n");
> > > > +		return ~0U;
> > > 
> > 
> > > Is this a special magic value the DWC core is expecting ?
> > > 
> > > Does it clash with a _valid_ return value ?
> > 
> > It's a normal return value if the PCIe IO wasn't successful.
> 

> I don't understand what you mean sorry. I understand you want to log
> the error - what I don't get is why you change val to ~0U - why ~0U
> and to what use, the function reading dbi can't use that value to
> detect an error anyway, it would read whatever value is returned by
> this function - regardless of the error condition.

Consider the returned FFs as a unsupported request returned for TLPs
sent to invalid or unreachable PCIe device. Though in this particular
case there is no actual TLP emitted, but just an MMIO operation
performed. Why is that needed? Mainly to somehow indicate a
malfunction access. It's also needed to detect the DW PCIe core
inconsistencies like requesting the IOs of the unsupported sizes or
from the size-unaligned addresses. See the way the dw_pcie_write() and
dw_pcie_read() are implemented in the DW PCIe core driver. The only
difference is that the later methods return garbage in case of the
errors and I don't use the PCIBIOS_SUCCESSFUL and
PCIBIOS_BAD_REGISTER_NUMBER macros in my driver by the @Rob earlier
request.

> 
> > In this particular case there is no actual PCIe-bus IO though, but
> > there are conditions which can cause the errors. So the error status
> > is still sanity checked. This part was already commented by Rob here:
> > https://lore.kernel.org/linux-pci/20220615171045.GD1413880-robh@kernel.org/
> > my response was:
> > https://lore.kernel.org/linux-pci/20220619203904.h7q2eb7e4ctsujsk@mobilestation/
> > 
> > > 
> > > > +	}
> > > > +
> > > > +	return val;
> > > > +}
> > > > +
> > > > +static void bt1_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > > +			       size_t size, u32 val)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > > > +	if (ret)
> > > > +		dev_err(pci->dev, "Write DBI address failed\n");
> > > > +}
> > > > +
> > > > +static void bt1_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> > > > +				size_t size, u32 val)
> > > > +{
> > > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > > +	int ret;
> > > > +
> > > > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > > > +			   BT1_CCU_PCIE_DBI2_MODE, BT1_CCU_PCIE_DBI2_MODE);
> > > > +
> > > > +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> > > > +	if (ret)
> > > > +		dev_err(pci->dev, "Write DBI2 address failed\n");
> > > > +
> > > > +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> > > > +			   BT1_CCU_PCIE_DBI2_MODE, 0);
> > > 
> > 
> > > IIUC the regmap_update_bits() set up decoding for DBI2.
> > 
> > Right and then switches it back off.
> > 
> > > Hopefully the
> > > DBI/DBI2 writes are sequentialized, this is a question valid also
> > > for other DWC controllers.
> > 
> > In general you are right, but not in particular case of the DW PCIe
> > Root Ports. So the concurrent access to DBI and DBI2 won't cause any
> > problem.
> > 
> > > 
> > > What I want to say is, the regmap update in this function sets the
> > > DWC HW in a way that can decode DBI2 (please correct me if I am wrong),
> > 
> > Right.
> > 
> > > between the two _update_bits() no DBI access should happen because
> > > it just would not work.
> > 
> > No. Because in case of the DW PCIe Root Ports, DBI and DBI2 are almost
> > identical. The difference is only in two CSR fields which turn to be
> > R/W in DBI2 instead of being RO in DBI. Other than that the DBI and
> > DBI2 spaces are identical. That's why we don't need any software-based
> > synchronization between the DBI/DBI2 accesses.
> > 
> > Moreover we won't need to worry about the synchronisation at all if
> > DBI2 is mapped via a separate reg-space (see dw_pcie.dbi_base2 field)
> > because any concurrency is resolved behind the scene by means of the
> > DBI bus HW implementation.
> > 
> > > 
> > > It is a question.
> > 
> > The situation gets to be more complex in case of DW PCIe End-points
> > because some of the DBI CSRs change semantics in DBI2. At the very
> > least it concerns the TYPE0_HDR.{BAR0-BAR5} registers, which determine
> > the corresponding BARx size and whether it is enabled in DBI2 (see the
> > reset_bar() and set_bar() methods implementation in
> > drivers/pci/controller/dwc/pcie-designware-ep.c). But my controller is
> > the Root Port controller, so the denoted peculiarity doesn't concern
> > it.
> > 
> > > 
> > > > +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > > +	int ret;
> > > > +
> > > > +	ret = bt1_pcie_get_resources(btpci);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	bt1_pcie_full_stop_bus(btpci, true);
> > > > +
> > > > +	return bt1_pcie_cold_start_bus(btpci);
> > > > +}
> > > > +
> > > > +static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> > > > +
> > > > +	bt1_pcie_full_stop_bus(btpci, false);
> > > > +}
> > > > +
> > > > +static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
> > > > +	.host_init = bt1_pcie_host_init,
> > > > +	.host_deinit = bt1_pcie_host_deinit,
> > > > +};
> > > > +
> > > > +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> > > > +{
> > > > +	struct bt1_pcie *btpci;
> > > > +
> > > > +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> > > > +	if (!btpci)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	btpci->pdev = pdev;
> > > > +
> > > > +	platform_set_drvdata(pdev, btpci);
> > > > +
> > > > +	return btpci;
> > > > +}
> > > > +
> > > > +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> > > > +{
> > > > +	struct device *dev = &btpci->pdev->dev;
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * DW PCIe Root Port controller is equipped with eDMA capable of
> > > > +	 * working with the 64-bit memory addresses.
> > > > +	 */
> > > > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > 
> > > Is this the right place to set the DMA mask for the host controller
> > > embedded DMA controller (actually, the dev pointer is the _host_
> > > controller device) ?
> > 
> > Yes it's. The DMA controller is embedded into the PCIe Root Port
> > controller. It CSRs are accessed via either the same CSR space or via
> > a separate space but synchronously clocked by the same clock source
> > (it's called unrolled iATU/eDMA mode). The memory range the
> > controller is capable to reach is platform specific. So the glue
> > driver is the best place to set the device DMA-mask. (For instance the
> > DW PCIe master AXI-bus width is selected by means of the
> > MASTER_BUS_ADDR_WIDTH parameter of the DW PCIe IP-core.)
> 

> I need to defer this question to Robin - I think the DMA mask for the
> DMA controller device should be set in the respective device driver
> (which isn't the host controller driver).

Which device driver? This driver is a vendor-specific DW PCIe
controller driver. It calls a function to register the PCIe host
device based on the DW PCIe platform device, which in its turn
registers the DMA-engine device based on the same platform device. The
platform device turns to be parental for both of them. It's used to
properly map the memory ranges for both of these devices. Anyway if
you say that some other device driver is supposed to initialize the
mask why on earth the pcie-designware-host.c driver sets the DMA mask
to the platform device then?

Note DMA-mask indicates the device DMA capability. It isn't something what
a generic driver can always detect especially in case of a platform
device. So the corresponding LLDD is the best place for it to be set
or overwritten anyway.

> 
> > > How this is going to play when combined with:
> > > 
> > > https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
> > > 
> > > It is getting a bit confusing. I believe the code in the link
> > > above sets the mask so that through the DMA API we are capable
> > > of getting an MSI doorbell virtual address whose physical address
> > > can be addressed by the endpoint; this through the DMA API.
> > 
> > I don't really understand why the code in the link above tries to
> > analyze the MSI capability of the DW PCIe Root Port in the framework
> > of the dw_pcie_msi_host_init() method. The method utilizes the iMSI-RX
> > engine which is specific to the DW PCIe AXI-bus controller
> > implementation. It has nothing to do with the PCIe MSI capability
> > normally available over the standard PCIe config space.
> > 
> > As Rob correctly noted here
> > https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com
> > MSI TLPs never reaches the system memory. (But I would add that this
> > only concerns the iMSI-RX engine.) So no matter which memory
> > allocated and where, the only thing that matters is the PCIe-bus
> > address specified to the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI CSRs,
> > which are the DW PCIe-specific and both are always available thus
> > supporting the 64-bit messages in any case. So if we had a way to just
> > reserve a PCIe-bus address range which at the same time wouldn't have
> > a system memory behind, we could have used the reserved range to
> > initialize the iMSI-RX MSI-address without need to allocate any
> > DMA-able memory at all. That's why the commit 07940c369a6b ("PCI: dwc:
> > Fix MSI page leakage in suspend/resume") was absolutely correct.
> 

> Again - I would appreciate if Will/Robin can comment on this given
> that it is down to DWC controller internals and their relation
> with the DMA core layer.

Again what William suggested was not that much useful. The only thing
which can and should be done based on his message is dropping the
dma_set_mask() method call from dw_pcie_msi_host_init() since the mask
is set to 32-bits by default anyway. Moreover as I said to William in
my response earlier having the DMA mask explicitly set to 32-bits for
all DW PCIe devices may cause the DMA performance degradation since in
that case the DMA above 4GB will be either bounce buffered to the
lower addresses or will fail on the memory mapping stage. But that is
a subject of another fixup-patch. Meanwhile this patch sets the
DMA-mask in accordance with the platform device capability no matter
what part of it performs DMA (Note it can be not only embedded eDMA,
but inbound iATU too).

-Sergey

> 
> Thanks,
> Lorenzo
> 
> > > This patch is setting the DMA mask for a different reason, namely
> > > setting the host controller embedded DMA controller addressing
> > > capabilities.
> > 
> > AFAIU what is done in that patch is incorrect.
> > 
> > > 
> > > AFAICS - both approaches set the mask for the same device - now
> > > the question is about which one is legitimate and how to handle
> > > the other.
> > 
> > That's simple. Mine is legitimate for sure. Another one isn't.
> > 
> > > 
> > > > +
> > > > +	btpci->dw.version = DW_PCIE_VER_460A;
> > > > +	btpci->dw.dev = dev;
> > > > +	btpci->dw.ops = &bt1_pcie_ops;
> > > > +
> > > > +	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> > > > +	btpci->dw.pp.ops = &bt1_pcie_host_ops;
> > > > +
> > > > +	dw_pcie_cap_set(&btpci->dw, REQ_RES);
> > > > +
> > > > +	ret = dw_pcie_host_init(&btpci->dw.pp);
> > > > +	if (ret)
> > > > +		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void bt1_pcie_del_port(struct bt1_pcie *btpci)
> > > > +{
> > > > +	dw_pcie_host_deinit(&btpci->dw.pp);
> > > > +}
> > > > +
> > > > +static int bt1_pcie_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct bt1_pcie *btpci;
> > > > +
> > > > +	btpci = bt1_pcie_create_data(pdev);
> > > 
> > 
> > > Do we really need a function for that ? I am not too
> > > bothered but I think it is overkill.
> > 
> > I prefer splitting the probe method up into a set of small and
> > coherent methods. It IMO improves the code readability for just no
> > price since the compiler will embed the single-time used static
> > methods anyway.
> > 
> > -Sergey
> > 
> > > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > +	if (IS_ERR(btpci))
> > > > +		return PTR_ERR(btpci);
> > > > +
> > > > +	return bt1_pcie_add_port(btpci);
> > > > +}
> > > > +
> > > > +static int bt1_pcie_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> > > > +
> > > > +	bt1_pcie_del_port(btpci);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id bt1_pcie_of_match[] = {
> > > > +	{ .compatible = "baikal,bt1-pcie" },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> > > > +
> > > > +static struct platform_driver bt1_pcie_driver = {
> > > > +	.probe = bt1_pcie_probe,
> > > > +	.remove = bt1_pcie_remove,
> > > > +	.driver = {
> > > > +		.name	= "bt1-pcie",
> > > > +		.of_match_table = bt1_pcie_of_match,
> > > > +	},
> > > > +};
> > > > +module_platform_driver(bt1_pcie_driver);
> > > > +
> > > > +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> > > > +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> > > > +MODULE_LICENSE("GPL");
> > > > -- 
> > > > 2.35.1
> > > > 
