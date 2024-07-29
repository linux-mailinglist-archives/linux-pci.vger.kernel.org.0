Return-Path: <linux-pci+bounces-10999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6F94015B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 00:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F41B1C20935
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 22:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF013B780;
	Mon, 29 Jul 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6VQuomt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43751824AD;
	Mon, 29 Jul 2024 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293465; cv=none; b=GjF+riSSOenkY/1eXnFrBY/TM9sc1FCMyyCriWwSmMTTbDbCggNEt6ibAqhrj+EjEL9cvAkUjEUqt3d2pCtZ3JLuadR/2Vk/pOKJwGTotBCPFzUQ0CJf1Kj81JfNT3ulFgPAzVS5hV2q0UWGWVNG2EtN4bVe2qAHLk79lFjXjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293465; c=relaxed/simple;
	bh=R/3Bp5nDPxYfZYzMdq/s37q7W4NYEETC7u1zeH2tWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hC/xRyQVz8wcIN4o2+Jjym9QnQQg4hUVbQoKebT/yxVPUqM32Ypeqs8Bnf7PmP3oDrQyUU0KY5ll7jkU2Dsw0E6Q2/p0XO0ymDXnnmMRN2ppSPSU27nMmsERDaxutAF/LY6XM5AaAMt440dLDXesxqnRWQ4Mp8ggsvGwtu9eeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6VQuomt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E76C32786;
	Mon, 29 Jul 2024 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722293464;
	bh=R/3Bp5nDPxYfZYzMdq/s37q7W4NYEETC7u1zeH2tWc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S6VQuomt2fZvGkX1iXywyQ8YuZgrsr/M1I+SS2lpQedfDdY//XYtmd5FVhY8RptEh
	 k/M3c/PAwnnam6q9EIM8y/DVF2X4C0l1ptrzHdffOs7P/bl1OrRFxqlFQkqImb//51
	 mYGqSAIiM/D5/DiJ1nRY4gCA40l6AeDg3GjpqsiVo5E2ss2t57vzkoElRZ7yCQErEp
	 BhOICcRWuqDDNfuybSnd6slLMUmCiKEzFiNaWUpI3JN2u9xBkFExut8B27O7IRK5kg
	 /Lx45HqDVhvZ1Wfw87iWrlzoMfNuM9Wl4mSdM5fQVD2pKbVnDLNYV4HLSrudVFVGtJ
	 9m6ufy8GOJMYw==
Date: Mon, 29 Jul 2024 17:51:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/2] PCI: qcom: Avoid DBI and ATU register space
 mirror to BAR/MMIO region
Message-ID: <20240729225102.GA8214@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704e4cd2-06ce-47f4-bdd0-1d5ddbe06850@quicinc.com>

On Thu, Jul 25, 2024 at 04:03:56PM -0700, Prudhvi Yarlagadda wrote:
> Hi Bjorn,
> 
> Thanks for the review comments.
> 
> On 7/24/2024 11:43 AM, Bjorn Helgaas wrote:
> > On Tue, Jul 23, 2024 at 07:27:19PM -0700, Prudhvi Yarlagadda wrote:
> >> PARF hardware block which is a wrapper on top of DWC PCIe controller
> >> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> >> register to get the size of the memory block to be mirrored and uses
> >> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> >> address of DBI and ATU space inside the memory block that is being
> >> mirrored.
> >>
> >> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> >> boundary is used for BAR region then there could be an overlap of DBI and
> >> ATU address space that is getting mirrored and the BAR region. This
> >> results in DBI and ATU address space contents getting updated when a PCIe
> >> function driver tries updating the BAR/MMIO memory region. Reference
> >> memory map of the PCIe memory region with DBI and ATU address space
> >> overlapping BAR region is as below.
> >>
> >>                         |---------------|
> >>                         |               |
> >>                         |               |
> >>         ------- --------|---------------|
> >>            |       |    |---------------|
> >>            |       |    |       DBI     |
> >>            |       |    |---------------|---->DBI_BASE_ADDR
> >>            |       |    |               |
> >>            |       |    |               |
> >>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
> >>            |    BAR/MMIO|---------------|
> >>            |    Region  |       ATU     |
> >>            |       |    |---------------|---->ATU_BASE_ADDR
> >>            |       |    |               |
> >>         PCIe       |    |---------------|
> >>         Memory     |    |       DBI     |
> >>         Region     |    |---------------|---->DBI_BASE_ADDR
> >>            |       |    |               |
> >>            |    --------|               |
> >>            |            |               |---->SLV_ADDR_SPACE_SIZE
> >>            |            |---------------|
> >>            |            |       ATU     |
> >>            |            |---------------|---->ATU_BASE_ADDR
> >>            |            |               |
> >>            |            |---------------|
> >>            |            |       DBI     |
> >>            |            |---------------|---->DBI_BASE_ADDR
> >>            |            |               |
> >>            |            |               |
> >>         ----------------|---------------|
> >>                         |               |
> >>                         |               |
> >>                         |               |
> >>                         |---------------|
> >>
> >> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> >> used for BAR region which is why the above mentioned issue is not
> >> encountered. This issue is discovered as part of internal testing when we
> >> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> >> we are trying to fix this.
> >>
> >> As PARF hardware block mirrors DBI and ATU register space after every
> >> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> >> U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
> >> mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
> >> of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
> >> PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
> >> blocks are at expected memory locations.
> >>
> >> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
> >> and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF
> >> Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
> >> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
> >> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
> >> Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()
> >> functions of the respective PARF versions to program applicable
> >> PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
> >> register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.
> >>
> >> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> >> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
> >>  1 file changed, 45 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 0180edf3310e..6976efb8e2f0 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -45,6 +45,7 @@
> >>  #define PARF_PHY_REFCLK				0x4c
> >>  #define PARF_CONFIG_BITS			0x50
> >>  #define PARF_DBI_BASE_ADDR			0x168
> >> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C
> >>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
> >>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
> >>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> >> @@ -52,8 +53,13 @@
> >>  #define PARF_LTSSM				0x1b0
> >>  #define PARF_SID_OFFSET				0x234
> >>  #define PARF_BDF_TRANSLATE_CFG			0x24c
> >> -#define PARF_SLV_ADDR_SPACE_SIZE		0x358
> >> +#define PARF_DBI_BASE_ADDR_V2			0x350
> >> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
> >> +#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> >> +#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35C
> >>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
> >> +#define PARF_ATU_BASE_ADDR			0x634
> >> +#define PARF_ATU_BASE_ADDR_HI			0x638
> >>  #define PARF_DEVICE_TYPE			0x1000
> >>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
> >>  #define PARF_BDF_TO_SID_CFG			0x2c00
> >> @@ -107,9 +113,6 @@
> >>  /* PARF_CONFIG_BITS register fields */
> >>  #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
> >>  
> >> -/* PARF_SLV_ADDR_SPACE_SIZE register value */
> >> -#define SLV_ADDR_SPACE_SZ			0x10000000
> >> -
> >>  /* PARF_MHI_CLOCK_RESET_CTRL register fields */
> >>  #define AHB_CLK_EN				BIT(0)
> >>  #define MSTR_AXI_CLK_EN				BIT(1)
> >> @@ -324,6 +327,39 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
> >>  	dw_pcie_dbi_ro_wr_dis(pci);
> >>  }
> >>  
> >> +static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
> >> +{
> >> +	struct dw_pcie *pci = pcie->pci;
> >> +
> >> +	if (pci->dbi_phys_addr) {
> >> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
> >> +							PARF_DBI_BASE_ADDR);
> >> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> >> +	}
> >> +}
> >> +
> >> +static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
> >> +{
> >> +	struct dw_pcie *pci = pcie->pci;
> >> +
> >> +	if (pci->dbi_phys_addr) {
> >> +		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
> >> +							PARF_DBI_BASE_ADDR_V2);
> >> +		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
> >> +						PARF_DBI_BASE_ADDR_V2_HI);
> >> +
> >> +		if (pci->atu_phys_addr) {
> >> +			writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
> >> +							PARF_ATU_BASE_ADDR);
> >> +			writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
> >> +							PARF_ATU_BASE_ADDR_HI);
> >> +		}
> >> +
> >> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
> >> +		writel(U32_MAX, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
> >> +	}
> >> +}
> > 
> > These functions write CPU physical addresses into registers.  I don't
> > know where these registers live.  If they are on the PCI side of the
> > world, they most likely should contain PCI bus addresses, not CPU
> > physical addresses.
> > 
> > In some systems, PCI bus addresses are the same as CPU physical
> > addresses, but on many systems they are not the same, so it's better
> > if we don't make implicit assumptions that they are the same.  
> 
> On Qualcomm platforms, CPU physical address and PCI bus addresses
> for DBI and ATU registers are same. PARF registers live outside the
> PCI address space in the system memory.
> 
> There is a mapping logic in the QCOM PARF wrapper which detects any
> incoming read/write transactions from the NOC towards PCIe
> controller and checks its addresses against PARF_DBI_BASE_ADDR and
> PARF_ATU_BASE_ADDR registers so that these transactions can be
> routed to DBI and ATU registers inside the PCIe controller.
> 
> So, these PARF registers needs to be programmed with base CPU
> physical addresses of DBI and ATU as the incoming DBI and ATU
> transactions from the NOC contain CPU physical adresses.

Can you add a comment to this effect that these registers are
effectively in the CPU address domain, not the PCI bus domain?
Otherwise the next person who reviews this will have the same
question, and somebody may even try to "fix" this by converting it to
a PCI bus address.

Bjorn

