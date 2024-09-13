Return-Path: <linux-pci+bounces-13187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA309785CD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA61F21085
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494274418;
	Fri, 13 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppRDWLW6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5747A6A;
	Fri, 13 Sep 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245172; cv=none; b=PugG6nkMiJI0oECXxG/vP3dZT2J5iCf+fhGNP9OYn0TZqALh9dPNtWkfLgu/9BfFpXTIevHi48xkAj7A3wxcfjctwWFNaXll6UEdDoAaWDu0ZCE9W1e3VskhX9Mjr6id2Q2xbmbBhnoPgbxJruY6ZVyhsXWe0rUwlGatbzdMBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245172; c=relaxed/simple;
	bh=DO3SFd9RG+YcB7C4Gwv8+ajAVhl5Fgid+C3kBpkM3jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZpYYauTzioB4JloqFRBQ2K0sGggFkFGodOpBrgAAoEeVGip8QGGu/IQ0xnmvB1+r65drsrBTIzyK2cpe651fl/7PGnuclyTYmFDTI5zZagutc73rbL9inK2TbM5q7AQ4YE1riCnhmmYrM5WZdXy+ymxx/iktmMlVH1bbdDBouiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppRDWLW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBB2C4CEC0;
	Fri, 13 Sep 2024 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726245172;
	bh=DO3SFd9RG+YcB7C4Gwv8+ajAVhl5Fgid+C3kBpkM3jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ppRDWLW6lpJk/mxo8sB9ilT9Oy25Cm8UUwub6GrWWg1x5+dsgYQ7SYDtIzdxCCinC
	 LjFwQyJyPtZYaXpkT0AiaHKO03cB362pRiNfzIh/J29L9vU1iTK+03vyQEPhsh/6C6
	 hW3PNylVpxNRaItUgBr2LyMDgzR3bdfsZ/R3vGVOXGtEjCDno7TNTcQfbyVyr0hpVH
	 tZTBkrh0/rjvx/BbPu3+7cwF1wwjP+3/kZBx9rf7RUElFuEuFeqIShq+c3KIVUk/gR
	 isaUFrOtYKK4q/AbdzG4yQL4UA/uQ+Ah5RP0s1jIwROma4/MV0yp2RoAdnfeUG1s56
	 QjkwzHB68h9zQ==
Date: Fri, 13 Sep 2024 11:32:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [linux-next:master 11090/11210]
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000:
 reg: [[864026624, 4194304], [402653184, 134217728]] is too short
Message-ID: <20240913163249.GA713949@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409131940.gkwdcLJ6-lkp@intel.com>

[+cc Richard, Krzysztof, Frank, Rob, Lucas, linux-pci]

I don't know if this is a false positive or related to
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2f309c988b7c
("dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for
i.MX8M PCIe Endpoint") or what, but needs to be resolved before this
gets merged to mainline.

On Fri, Sep 13, 2024 at 07:27:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   57f962b956f1d116cd64d5c406776c4975de549d
> commit: b099c3ac1a08c08517c1ff05c52a7f5476020b02 [11090/11210] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> config: arm64-randconfig-051-20240911 (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> dtschema version: 2024.6.dev16+gc51125d
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131940.gkwdcLJ6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409131940.gkwdcLJ6-lkp@intel.com/
> 
> dtcheck warnings: (new ones prefixed by >>)
> >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> >> arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> --
> >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> >> arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> --
> >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> >> arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> --
> >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> >> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk-no-eth.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
>    	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

