Return-Path: <linux-pci+bounces-36059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75AB5580F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DABC1CC7160
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3B27280C;
	Fri, 12 Sep 2025 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmNyLeKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2A1946DF;
	Fri, 12 Sep 2025 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711280; cv=none; b=UXegrbWWWvV2ZuT5eOJnrHTfH3Qw01WCLgXYPczX21ph3o5aZZWlpeOsRQ7B6W+J3JQP3AnLR4amTrXdQ7QSGxE3hu3BaNbTOIzFSOw9uIouW2+NFElsPvOKC++TPN2LqUjnOsjzxqtaddVHhm/9ZBmr3U/ladjViW2YCSNA3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711280; c=relaxed/simple;
	bh=NIJe9mERpIKa7P3BRwvWUGSJaqJfWGo09ZUKZCduWIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BWttzulikl1OjLDVN9Zf/fR+UFn+wwLbDTXjQ1HXyZfgztnYFjyGoxdOnEXVnvJ2Gz+3BR67bd2slB07nvzpWZN1GcosQXFh/yAZzcewNvdyJN5x1B8geueVlkTP5ypBLNAq4CDO3DqcLl4CsBTtcWd++lAZE5AMgtg30Qe7oz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmNyLeKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB9AC4CEF1;
	Fri, 12 Sep 2025 21:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711278;
	bh=NIJe9mERpIKa7P3BRwvWUGSJaqJfWGo09ZUKZCduWIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cmNyLeKmgLuSrUJDD7Q8d7ASQTWuQT1hXG+cXJe2LkS7MM3vqBnH5I5ptTocWQgYs
	 0NDh4GkJC/Mu2UhbaD5n5/HVDCY0FqXxxQri6aWq1Z0QeQ8XHVlK67aFQEpvgYEgxP
	 FLjcaLyuKqm1uCNIWJVbug61TfcaNhx6hOEge0uj8eierD3YbzejUd5HWUUIwSIsUf
	 +6BCtXwdl047tguoa0jHckpR2XocPlBceBJDtnL/GMCDhHAGHoP66rZ4c4b8aeWk5/
	 tCzXTXhfPZikHsjmsRnxDbq9GBMaC38KJwnVgbXHX9td2W3x6sD9i7ZmodDOvQ+vQ8
	 7psgvIycDelGw==
Date: Fri, 12 Sep 2025 16:07:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
Message-ID: <20250912210756.GA1639208@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903195721.GA1216663@bhelgaas>

On Wed, Sep 03, 2025 at 02:57:21PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:
> > The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
> > gives us the offset from which ELBI starts. So override ELBI with the
> > offset from PARF_SLV_DBI_ELBI and cfg win to map these regions.
> > 
> > On root bus, we have only the root port. Any access other than that
> > should not go out of the link and should return all F's. Since the iATU
> > is configured for the buses which starts after root bus, block the
> > transactions starting from function 1 of the root bus to the end of
> > the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
> > outside the link through ECAM blocker through PARF registers.

> > +static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > +	u64 addr, addr_end;
> > +	u32 val;
> > +
> > +	/* Set the ECAM base */
> > +	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> > +	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> > +
> > +	/*
> > +	 * The only device on root bus is the Root Port. Any access to the PCIe
> > +	 * region will go outside the PCIe link. As part of enumeration the PCI
> > +	 * sw can try to read to vendor ID & device ID with different device
> > +	 * number and function number under root bus. As any access other than
> > +	 * root bus, device 0, function 0, should not go out of the link and
> > +	 * should return all F's. Since the iATU is configured for the buses
> > +	 * which starts after root bus, block the transactions starting from
> > +	 * function 1 of the root bus to the end of the root bus (i.e from
> > +	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
> > +	 */
> > +	addr = pci->dbi_phys_addr + SZ_4K;
> > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> > +
> > +	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> > +	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> > +
> > +	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
> 
> I guess this is an implicit restriction to a single Root Port on the
> root bus at bb:00.0, right?  So when the qcom IP eventually supports
> multiple Root Ports or even a single Root Port at a different
> device/function number, this would have to be updated somehow?

The driver already supported ECAM in the existing "firmware_managed"
path (which looks untouched by this series and doesn't do any of this
iATU configuration).

And IIUC, this series adds support for ECAM whenever the DT 'config'
range is sufficiently aligned.  In this new ECAM support, it looks
like we look for and pay attention to 'bus-range' in this path:

  qcom_pcie_probe
    dw_pcie_host_init
      devm_pci_alloc_host_bridge
        devm_of_pci_bridge_init
          pci_parse_request_of_pci_ranges
            devm_of_pci_get_host_bridge_resources
              of_pci_parse_bus_range
                of_property_read_u32_array(node, "bus-range", ...)
      dw_pcie_host_get_resources
        res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config")
        pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res)

Since qcom_pci_config_ecam() doesn't look at the root bus number at
all, is this also an implicit restriction that the root bus must be
bus 0?  Does qcom support root buses other than 0?  

> > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> > +
> > +	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> > +	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> > +
> > +	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
> > +	val |= PCIE_ECAM_BLOCKER_EN;
> > +	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
> > +}
> > +
> >  static int qcom_pcie_start_link(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
> >  		qcom_pcie_common_set_16gt_lane_margining(pci);
> >  	}
> >  
> > +	if (pci->pp.ecam_enabled)
> > +		qcom_pci_config_ecam(&pci->pp);

qcom_pcie_start_link() seems like a strange place to do this
ECAM-related iATU configuration.  ECAM is a function of the host
bridge, not of any particular Root Port or link.

> >  	/* Enable Link Training state machine */
> >  	if (pcie->cfg->ops->ltssm_enable)
> >  		pcie->cfg->ops->ltssm_enable(pcie);

