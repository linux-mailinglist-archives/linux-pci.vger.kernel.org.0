Return-Path: <linux-pci+bounces-9391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B891B362
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C165CB2210B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136417F7;
	Fri, 28 Jun 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5HXbrMp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862F1860;
	Fri, 28 Jun 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534475; cv=none; b=Bn7oJ3a/appKt0nNmve5FgpKKq0EcTtelAUa35RXHHle+LpXtXjT69s4+sTlvUMT5O+xywLitj/ttW8mItPUJ2IV/x5O9ogTGkz5782TE4WWUaV4gb2olRRLJRvBOIrB7uFSXad6dmEO5OC4QVxU4E/A5UtQ3vWaDtKsCOH4Kxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534475; c=relaxed/simple;
	bh=ZGDPfGPafbptKV02HDRgJ92uEH2jSE9FtYmjSCAueUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeI8patIKtSPJ12UoCwlUzJ+vBn3/JE+EQN9BwTkCSvk7olrpn01k0IRsF6awm3U9oMcE0ltoBSQGD83g6i9LL9A4jVqZCJagwDr+U5YVKEMHUCda8NVKf/xTQKLcwiE+as8IKThTnDIt+HcO3lB1ua9aqDUzYbpMIGmUzCidwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5HXbrMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F4C2BBFC;
	Fri, 28 Jun 2024 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719534474;
	bh=ZGDPfGPafbptKV02HDRgJ92uEH2jSE9FtYmjSCAueUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5HXbrMpl/+H/xqjxf+2WeWG/1j4q2U3CprBmFIMNLGY/Gsh89cS1Yb4AlJVE7Dkl
	 fwp0JvidZK+9aaTJxMo/ex9Lv/tnEtAfZTWf6s2oKM/TU86qLtvo4NsSqNZvTtTXuR
	 Ly1TWUszRqqyPOJHrOGMiHHau/3DAgbaZ5kBmDYfr3sK2hPG+KdIDS7BOw53tMGt1R
	 WSgeD461j7Ji79vbeogZc6SbKcyWJtFFHg9kTJSYokcI+LH7JLRn2rHCm7BcRaADEi
	 8BHK1Wlt2T8ryA2ACr8e7SUoNdslC8EDDkkCMbZ9MM24aotf+fPuon2JLPaTWzhloD
	 DeS2j4mlPVo1w==
Date: Fri, 28 Jun 2024 09:27:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [pci:controller/rockchip 11/11]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:undefined reference to
 `pci_epc_init_notify'
Message-ID: <20240628002752.GA2068526@rocinante>
References: <202406270721.a8SQi2hn-lkp@intel.com>
 <Zn0j1LrkLELW0fO1@ryzen.lan>
 <Zn0n_qvyd47Aw65E@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0n_qvyd47Aw65E@ryzen.lan>

Hello,

> > Perhaps the smartest thing right now is to just recreate the
> > pci/controller/rockchip branch, by:
> > 1) reset the rockchip branch to v6.10-rc1
> > 2) merge the pci/controller/dwc branch to the rockchip branch
> > 3) merge the pci/endpoint branch to to the rockchip branch
> > 4) pick all the patches that are currently on the pci/controller/rockchip
> > 5) squash: 246afbe0f6fc ("PCI: dw-rockchip: Use pci_epc_init_notify() directly")
> >    into the commit that adds dw-rockchip endpoint mode support
> >    (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))
> > 6) squash: https://lore.kernel.org/linux-pci/20240626191325.4074794-2-cassel@kernel.org/
> >    into the commit that adds dw-rockchip endpoint mode support
> >    (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))
> > 
> > 
> > This way:
> > - All commits will build as individual patches, so no build errors from the
> >   test robot (even when it builds a patch that is in the middle (e.g. 10/11)).
> > - Even if futher commits are applied to pci/controller/dwc or pci/endpoint,
> >   we will not depend on any newly applied patches to these branches, so there
> >   will be no need to "re-merge" the branches to the rockchip branch.
> 
> The end result would look like this:
> https://github.com/floatious/linux/commits/dw-rockchip-remerge-example/
> 
> (Just in case you want to git diff to see that we did the same thing...)

Thank you for this!

I did some work on the branch with an aim to fix the issues bot kindly
reported to us, a bit before I saw your message.  Hopfully, I got things
right this time, and if not, then I will apply your steps/suggestion.

	Krzysztof

