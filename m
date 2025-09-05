Return-Path: <linux-pci+bounces-35535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240C4B45E55
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3533B958F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76002309EE0;
	Fri,  5 Sep 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyx6siAC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E046306B17;
	Fri,  5 Sep 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090346; cv=none; b=aobp78Zt0rEf2ugaJdvoUFT029iGPMGZz4jny1K69VHLLAdXwFb37gWJGdyNjBYYy9wsr6tjkpOPj1SRZ0o5+D5gyOXMraPczxD/GhdsCM8TW+vsGOX3asniRfDx3jrcawvwQa56/36TTPHuaWX05kwpI9FWHn+j47CWfP6O0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090346; c=relaxed/simple;
	bh=ZTdnF+C/S88gBhkB6Pc82Wg6hlAE2konqqf80SckUek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXQCvp2n+1QFCHK91p3fj2M8jNlvriddpoNH5hYwJ4VRnEiWiCs9sZ/nWjLlDG99en4K0QZ4cSQcFtmMHnokjm4cctXe4ZP4BU3mRBru8KRtEKcRhO9qoV7gV/uM+MnhC36/cvDs6KyPu57HOcUxM2NHMUg6xn0DhxQof/8jXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyx6siAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53622C4CEF1;
	Fri,  5 Sep 2025 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757090345;
	bh=ZTdnF+C/S88gBhkB6Pc82Wg6hlAE2konqqf80SckUek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cyx6siACrJv1UDhxtLvA5Dri3myVq5wdUJAaVm93147d0weeSC5PKxKkSfHilXkgL
	 MgzvI+vwHhQQoVg7dgB4gPVA4rVVK1mlpjFhjqX1CIK3WTkaFamuBAttl0xV69+6Y9
	 RvQppAjpLTt58Rpo2E1wvYU0CjCZWa6pX3/Y7KISyFbbfyM+jmytJch2RPbdqxf36D
	 qpl3qLXvCBIR9NhPQC6bD1qktLRyMdosihguRSBTyN23ptgWnmhWJQr8GgM+r+Xf1q
	 8z4DQ/csYXolvX6QpLh2FejVaxqSmNNw+yrsXADf4kq728y5Kczu89kQ23qQ5FcTup
	 CXzYltoaqSDEw==
Date: Fri, 5 Sep 2025 22:08:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_vpernami@quicinc.com, 
	mmareddy@quicinc.com
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
Message-ID: <gwaz7563akxeai4gar7etf4jp3c775fphkipn37alzjcjy6t66@2pa3ykv6kejp>
References: <20250903201233.GA1216782@bhelgaas>
 <79d44c24-d853-4128-b966-8a25aaefad73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d44c24-d853-4128-b966-8a25aaefad73@oss.qualcomm.com>

On Fri, Sep 05, 2025 at 10:47:42AM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/4/2025 1:42 AM, Bjorn Helgaas wrote:
> > On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
> > > The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> > > gives us the offset from which ELBI starts. So override ELBI with the
> > > offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
> > > 
> > > On root bus, we have only the root port. Any access other than that
> > > should not go out of the link and should return all F's. Since the iATU
> > > is configured for the buses which starts after root bus, block the
> > > transactions starting from function 1 of the root bus to the end of
> > > the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> > > outside the link through ECAM blocker through PARF registers.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 70 ++++++++++++++++++++++++++++++++++
> > >   1 file changed, 70 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 5092752de23866ef95036bb3f8fae9bb06e8ea1e..8f3c86c77e2604fd7826083f63b66b4cb62a341d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -55,6 +55,7 @@
> > >   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> > >   #define PARF_Q2A_FLUSH				0x1ac
> > >   #define PARF_LTSSM				0x1b0
> > > +#define PARF_SLV_DBI_ELBI			0x1b4
> > >   #define PARF_INT_ALL_STATUS			0x224
> > >   #define PARF_INT_ALL_CLEAR			0x228
> > >   #define PARF_INT_ALL_MASK			0x22c
> > > @@ -64,6 +65,16 @@
> > >   #define PARF_DBI_BASE_ADDR_V2_HI		0x354
> > >   #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> > >   #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
> > > +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
> > > +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
> > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
> > > +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
> > > +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
> > > +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
> > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
> > > +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
> > > +#define PARF_ECAM_BASE				0x380
> > > +#define PARF_ECAM_BASE_HI			0x384
> > >   #define PARF_NO_SNOOP_OVERRIDE			0x3d4
> > >   #define PARF_ATU_BASE_ADDR			0x634
> > >   #define PARF_ATU_BASE_ADDR_HI			0x638
> > > @@ -87,6 +98,7 @@
> > >   /* PARF_SYS_CTRL register fields */
> > >   #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> > > +#define PCIE_ECAM_BLOCKER_EN			BIT(26)
> > >   #define MST_WAKEUP_EN				BIT(13)
> > >   #define SLV_WAKEUP_EN				BIT(12)
> > >   #define MSTR_ACLK_CGC_DIS			BIT(10)
> > > @@ -134,6 +146,9 @@
> > >   /* PARF_LTSSM register fields */
> > >   #define LTSSM_EN				BIT(8)
> > > +/* PARF_SLV_DBI_ELBI */
> > > +#define SLV_DBI_ELBI_ADDR_BASE			GENMASK(11, 0)
> > > +
> > >   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > >   #define PARF_INT_ALL_LINK_UP			BIT(13)
> > >   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> > > @@ -317,6 +332,48 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> > >   	qcom_perst_assert(pcie, false);
> > >   }
> > > +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > +	u64 addr, addr_end;
> > > +	u32 val;
> > > +
> > > +	/* Set the ECAM base */
> > > +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> > > +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> > > +
> > > +	/*
> > > +	 * The only device on root bus is the Root Port. Any access to the PCIe
> > > +	 * region will go outside the PCIe link. As part of enumeration the PCI
> > > +	 * sw can try to read to vendor ID & device ID with different device
> > > +	 * number and function number under root bus. As any access other than
> > > +	 * root bus, device 0, function 0, should not go out of the link and
> > > +	 * should return all F's. Since the iATU is configured for the buses
> > > +	 * which starts after root bus, block the transactions starting from
> > > +	 * function 1 of the root bus to the end of the root bus (i.e from
> > > +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
> > > +	 */
> > > +	addr = pci->dbi_phys_addr + SZ_4K;
> > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> > > +
> > > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> > > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> > > +
> > > +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> > > +
> > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> > > +
> > > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> > > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> > > +
> > > +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
> > > +	val |= PCIE_ECAM_BLOCKER_EN;
> > > +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
> > > +}
> > > +
> > >   static int qcom_pcie_start_link(struct dw_pcie *pci)
> > >   {
> > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
> > >   		qcom_pcie_common_set_16gt_lane_margining(pci);
> > >   	}
> > > +	if (pci->pp.ecam_enabled)
> > > +		qcom_pci_config_ecam(&pci->pp);
> > > +
> > >   	/* Enable Link Training state machine */
> > >   	if (pcie->cfg->ops->ltssm_enable)
> > >   		pcie->cfg->ops->ltssm_enable(pcie);
> > > @@ -1314,6 +1374,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   {
> > >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > +	u16 offset;
> > >   	int ret;
> > >   	qcom_ep_reset_assert(pcie);
> > > @@ -1322,6 +1383,15 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	if (ret)
> > >   		return ret;
> > > +	if (pp->ecam_enabled) {
> > > +		/*
> > > +		 * Override ELBI when ECAM is enabled, as when ECAM
> > > +		 * is enabled ELBI moves along with the dbi config space.
> > > +		 */
> > > +		offset = FIELD_GET(SLV_DBI_ELBI_ADDR_BASE, readl(pcie->parf + PARF_SLV_DBI_ELBI));
> > > +		pci->elbi_base = pci->dbi_base + offset;
> > 
> > This looks like there might be a bisection hole between this patch and
> > the previous patch that enables ECAM in the DWC core?  Obviously I
> > would want to avoid a bisection hole.
> > 

Theoretically there is a hole, but practically there isn't. ELBI register is
only used by legacy Qcom SoCs and they do not support ECAM. So they will
continue to use the valid ELBI register region from DT.

> > What happens to qcom ELBI accesses between these two patches?  It
> > looks like they would go to the wrong address until this elbi_base
> > update.

Though there is no practical issue, it still makes sense to set 'elbi_base' to a
valid region before enabling ECAM.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

