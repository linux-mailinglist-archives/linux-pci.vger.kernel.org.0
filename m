Return-Path: <linux-pci+bounces-38385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDABE4EBA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEBF1A64EEC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59955334697;
	Thu, 16 Oct 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7r4WbKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8961E49F;
	Thu, 16 Oct 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637227; cv=none; b=PXFTsrsUvA0c66Dxveq3dgy9DTSegjmwLNaz1PlTgeohXThvBTojIYCGncm0tPrr/zuzReR+xZi+73CiNWxfcygbPZ0SySZwOSDsBSI36o5jhjedks5CHj0eJMaZgegQUSOzW2ybsaFUC6LkoPiepWRIUBqCdDWLJ4Ecfyl5Acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637227; c=relaxed/simple;
	bh=bcq7dWKKhPAJAQH1BkuW4iJjxEE0ztxwKDkUSRYWSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DGl4iJP6JCZKl1qBu4fZcMsZYPF5j32pf4cYsIusXiZZkMfwNQmjKCXLFc1pTG+dri+2qV7ihRjqKxAOB/hzqLOFSgEMUEXD8wGGa9uFm+6bYRgv1woF6fMUakKRaqFSXYfCLpAaCaE4fI3p/bDzA6npyLksxJ1rSF7TQWo1iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7r4WbKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A09C4CEF1;
	Thu, 16 Oct 2025 17:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760637226;
	bh=bcq7dWKKhPAJAQH1BkuW4iJjxEE0ztxwKDkUSRYWSvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C7r4WbKNN5UzgAT8kp68WroN3O01umZ1ew9BKhuuFHuHpBQLWVNDtMdGpDWYqQwFg
	 1PZcA/RF64UIaOYvaxJ4H5Jqh8zCoIjBg4+fMpUcQMITsiO3/LNf/W93ZVqp3RZGE4
	 cqlrmH8bwxOBbIIuHD8J+qcEwKPj81L6U9RlKlu2e2Mx0dnzs2Qa+2ZOi5K3NMBi4d
	 +D+2YlqWLHUsqIxOP9j2Gqn7nIZ7FGWI58/tj4VfTdIq4CkNTfTz4uPDlq3c75AWXW
	 Hv+e3JqAgWzzqGvjxstRhsHmLY+JvQ68SKt5pBuanBwXSNzQ60yX+EXvqZfVRG0ysS
	 FFPkiW2/0H+9w==
Date: Thu, 16 Oct 2025 12:53:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Disable L1 substates
Message-ID: <20251016175345.GA993781@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016172504.GA991252@bhelgaas>

On Thu, Oct 16, 2025 at 12:25:04PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 16, 2025 at 11:04:22AM +0200, Niklas Cassel wrote:
> > The L1 substates support requires additional steps to work, see e.g.
> > section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.

> > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > +{
> > +	u32 cap, l1subcap;
> > +
> > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > +	if (cap) {
> > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> 
> I suspect this problem is specifically related to L1.2 and CLKREQ#,
> and L1.1 might work fine.  If so, can we update this so we still
> advertise L1.1 support?

Hmm, looking again at the spec (PCIe r7.0, sec 5.5), it looks like
CLKREQ# is required for both L1.1 and L1.2 (but not L1.0, the basic
L1), so ignore my comment here.

