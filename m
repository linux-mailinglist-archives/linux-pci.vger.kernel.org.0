Return-Path: <linux-pci+bounces-989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E55812CDF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D351DB2101A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701F3BB22;
	Thu, 14 Dec 2023 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv2tPsSo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457E35EE8;
	Thu, 14 Dec 2023 10:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E97C433C7;
	Thu, 14 Dec 2023 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702549579;
	bh=Ca529sV92qk/IQqi7DJDlHxw7r9RJpdb/BthpFrWtt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pv2tPsSoc8IgdEWrLxFmboZzYmZ2QHOIv8b4tLpsnOG9EqSL9RDt65Ea9pPO4PIvI
	 UjYKtJz3Wl/JXQWXjmTdRv99mjEPGE5kVwKUZXgLrNwJhWN4gQNkBAqqb7tPz+7bwt
	 YGNcMRIkI/PgC+x8+KCpRiifAV9iHqLctBR7gqmsrcGf2aRuCihAI2BWdMM0oAsQ15
	 S+lLz+didj5ZkuUbijLQWVOleQAQe5FqQFnwHOyWfsG5BVzH+A6CBQx21Ltv8rP353
	 V+NIdRzvMx3KGCxZSxEd5iAS/yKHSQuYV0oBM+IodXVmr7GOmwtTJH9zDubh4pNT8d
	 cmuTk4RMOosyg==
Date: Thu, 14 Dec 2023 15:56:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] PCI: controllers: tidy code up
Message-ID: <20231214102605.GK2938@thinkpad>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <TYBPR01MB5341F846948DB6CFECA62187D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <rrgcf2jagjkiczb5tt56qm2jwvfyaor2mzjdqxrodrhzrn5j65@m7orqtcay3gg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rrgcf2jagjkiczb5tt56qm2jwvfyaor2mzjdqxrodrhzrn5j65@m7orqtcay3gg>

On Thu, Dec 14, 2023 at 12:40:13PM +0300, Serge Semin wrote:
> Hi Yoshihiro
> 
> On Thu, Dec 14, 2023 at 02:35:56AM +0000, Yoshihiro Shimoda wrote:
> > Hello PCIe maintainers,
> > 
> > > From: Yoshihiro Shimoda, Sent: Tuesday, November 14, 2023 2:55 PM
> > > 
> > > This patch series tidies the code of PCIe dwc controllers and some
> > > controllers up.
> > > 
> > > Changes from v1:
> > > https://lore.kernel.org/linux-pci/20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com/
> > >  - Based on the latest pci.git / next branch.
> > >  - Add a new patch to drop host prefix of members from dw_pcie_host_ops
> > >    in the patch 1/6.
> > >  - Add Reviewed-by tag in the patch 3/6.
> > >  - Drop unneeded local variable in the patch 4/6.
> > >  - Add new patches to resolve issues of clang warnings in the patch [56]/6.
> > > 
> > > Justin Stitt (1):
> > >   PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
> > > 
> > > Yoshihiro Shimoda (5):
> > >   PCI: dwc: Drop host prefix from struct dw_pcie_host_ops
> > >   PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
> > >   PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
> > >   PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers
> > >   PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
> > 
> > According to the patchwork [1], all patches have Reviewed-by tags.
> > So, I think the patches are acceptable for upstream, but what do you think?
> > I confirmed that the patches can be applied into the latest pci.git / next branch.
> 
> What actually matters is to get all Manivannan or Jingoo or Gustavo
> acks (the later two maintainers are unlikely to respond though) or any
> higher maintainers approval. AFAICS this patch still hasn't got any
> maintainers ack:
> https://patchwork.kernel.org/project/linux-pci/patch/20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com/
> https://lore.kernel.org/linux-pci/20231114055456.2231990-5-yoshihiro.shimoda.uh@renesas.com/
> I guess it's connected with a request to move the helpers to the
> header file.
> 

Yes. I recommended moving the helpers to header file to keep the consistency and
there was no reply from Yoshihiro.

Yoshihiro, should you have any objections, please counter in the patch thread
4/6. Otherwise, please implement the proposed change.

- Mani

> -Serge(y)
> 
> > 
> > [1]
> > https://patchwork.kernel.org/project/linux-pci/list/?series=800901
> > 
> > Best regards,
> > Yoshihiro Shimoda
> > 
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |   4 +-
> > >  drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c         |   6 +-
> > >  drivers/pci/controller/dwc/pci-keystone.c     |   8 +-
> > >  .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
> > >  drivers/pci/controller/dwc/pci-layerscape.c   |   2 +-
> > >  drivers/pci/controller/dwc/pci-meson.c        |   2 +-
> > >  drivers/pci/controller/dwc/pcie-al.c          |   2 +-
> > >  drivers/pci/controller/dwc/pcie-armada8k.c    |   2 +-
> > >  drivers/pci/controller/dwc/pcie-artpec6.c     |   4 +-
> > >  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +-
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 249 ++++++++++--------
> > >  .../pci/controller/dwc/pcie-designware-host.c |  30 +--
> > >  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  12 +-
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +-
> > >  drivers/pci/controller/dwc/pcie-fu740.c       |   2 +-
> > >  drivers/pci/controller/dwc/pcie-histb.c       |   2 +-
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c    |   2 +-
> > >  drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
> > >  drivers/pci/controller/dwc/pcie-kirin.c       |   2 +-
> > >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
> > >  drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  12 +-
> > >  drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
> > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
> > >  drivers/pci/controller/dwc/pcie-uniphier.c    |   2 +-
> > >  drivers/pci/controller/dwc/pcie-visconti.c    |   2 +-
> > >  drivers/pci/controller/pcie-iproc-platform.c  |   2 +-
> > >  30 files changed, 203 insertions(+), 177 deletions(-)
> > > 
> > > --
> > > 2.34.1
> > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

