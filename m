Return-Path: <linux-pci+bounces-13190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758F978799
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 20:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD8B21B74
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBD126BF0;
	Fri, 13 Sep 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amYC6KlQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE479B8E;
	Fri, 13 Sep 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251140; cv=none; b=JFnQkCpJDgui06zclih4G3xXr7WCZIkrZG0gSawyhmtldDk7ZgEOPS6aoDXx/pyrgA0zKP8ZitPendnBxPISlzLxSJJakaN7oDelPDeelku6rj9KrGcR/Av6cSGdlW6W5ALGknMsznsKGRpFK3DsHniDK+J/5p2klXIQJnXPx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251140; c=relaxed/simple;
	bh=ELc+EZ6Ud+nuJFE/uD3oBDDq7oF9thBeZ2LWyjeuLTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmt23LDyyn31pa0JXvV6K2p0lqBe4cGxKKi614kihv4YaWQZHlfrW6BZdM80BKQrcFnIdGuy+rumVyW30YEvoVSKo7Dbogum8y5LEvpjm95dinpxxuo9X7EJ2saqp85GnSI6Jfgt+wQudsPbQV3VhjnyVwSCbmHSryQxSlJ7BKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amYC6KlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF54BC4CEC0;
	Fri, 13 Sep 2024 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726251140;
	bh=ELc+EZ6Ud+nuJFE/uD3oBDDq7oF9thBeZ2LWyjeuLTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amYC6KlQsEeRu1br1naI9PFxAp4xNZc1uIpm1fS11VIcupSakzGNwcLGcHu4sUhr8
	 zY3n/2KOSWizbRqWSmlXNGBo5BLtQqDbVTH5pEhy+4Y3V8Mt8kIncZEkj0+ynTu7ev
	 KzKKp6YKi2o6zsJ4Q0xBZjzbVmtHlWOn/mCnlPZwkA4DVwEN9A1QZjEqvSG/6EgvrR
	 s3imqLthMF766CTm0Pt6oKQ9LwILSsn8/YsLNE7i0pZCGFgutcD1o9RZZDtubVCxqi
	 vc9rYwoicw3eDz16YY5tx93mZpQGOG890aro/j6wIfB/BHQmDiEiWgC7oEASd6zx69
	 LrhAY9RH/ZBSA==
Date: Sat, 14 Sep 2024 03:12:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	Philip Li <philip.li@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [linux-next:master 11090/11210]
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000:
 reg: [[864026624, 4194304], [402653184, 134217728]] is too short
Message-ID: <20240913181218.GA3047723@rocinante>
References: <202409131940.gkwdcLJ6-lkp@intel.com>
 <20240913163249.GA713949@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913163249.GA713949@bhelgaas>

[+Cc Philip]

Hello,

> I don't know if this is a false positive or related to
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2f309c988b7c
> ("dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for
> i.MX8M PCIe Endpoint") or what, but needs to be resolved before this
> gets merged to mainline.

Philip, this is one of the false-positives, isn't it?  I believe we've got
a few of these recently.  See below for an example.

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   57f962b956f1d116cd64d5c406776c4975de549d
> > commit: b099c3ac1a08c08517c1ff05c52a7f5476020b02 [11090/11210] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > config: arm64-randconfig-051-20240911 (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/config)
> > compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > dtschema version: 2024.6.dev16+gc51125d
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409131940.gkwdcLJ6-lkp@intel.com/
> > 
> > dtcheck warnings: (new ones prefixed by >>)
> > >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > --
> > >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > --
> > >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > --
> > >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> > >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
> >    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#

Past conversation about these errors:

  - https://lore.kernel.org/all/202407041154.pTMBERxA-lkp@intel.com/

	Krzysztof

