Return-Path: <linux-pci+bounces-9358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019391A1E2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E221F21A09
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498212F59C;
	Thu, 27 Jun 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEA71OMW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71841A94;
	Thu, 27 Jun 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478275; cv=none; b=cmynan82nhajWv3WSvcKBTAyogO25+Dpz85ghqPkpOhhn+6bLz0+v9zsa5tCyiNDy44r2cV0OPtGJV0lGP2IjBBWb1KjNEFR5t+WGuNOLRb8Ynl8tyvLllxMY6/mLG+RIEMFN0lfhhbKnNNq9qrggOU0HrwcwgcsO9aoxT7wyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478275; c=relaxed/simple;
	bh=RNQYhslrCN1E1JQQ9hu0V0o+kjdwAkUIWyPDeNLPaCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF46wFGPuhwN9MurNrvvZ71pucicgf8RPOI/1V086fqh9/yhF85gP2u+1PNK7/v2SHo+i0kPcJfmeqWUFxOqglkcjy3ThS1iOSDcey7fTRXWxDPErIRc+EZ76aVTq4CwQMI5LKqTpR0M5sH92NRqnQPugIXLoU9s9HxKr3IoYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEA71OMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1E0C4AF07;
	Thu, 27 Jun 2024 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719478274;
	bh=RNQYhslrCN1E1JQQ9hu0V0o+kjdwAkUIWyPDeNLPaCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEA71OMWfVMTznmtLZiGZ2tqn/dg7C7Ga0Kq1v3m7Ypy3w0Bzq8rDJuDiMpfFaDEE
	 a7atnYGx105MwwHsnAOJKxugLPq59W1zPQjrIB9/yCCGVJmjpikQhHoi4+BLGR5ISJ
	 g2601RvDAzZO/HIDhAlAwW8aIJ44kFPdmDeIsL3QIR3gvnMxj76FJR0LRufr57Lrty
	 6NLrKEdxwrqiI98JHVSGkQwK3UeeB8FdvzDH4wV95yHACx/gOlInKJ24j53sYa/p4U
	 uaLmi604cQgxeGifZh5jTFg7NcfDmPuNRaResCuOFcXgR4HT7PD6ROFjvJPOT8Btkh
	 +Gwqb0U7AGoHg==
Date: Thu, 27 Jun 2024 10:51:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/rockchip 11/11]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:491:undefined reference to
 `pci_epc_init_notify'
Message-ID: <Zn0n_qvyd47Aw65E@ryzen.lan>
References: <202406270721.a8SQi2hn-lkp@intel.com>
 <Zn0j1LrkLELW0fO1@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0j1LrkLELW0fO1@ryzen.lan>

On Thu, Jun 27, 2024 at 10:33:24AM +0200, Niklas Cassel wrote:
> 
> Perhaps the smartest thing right now is to just recreate the
> pci/controller/rockchip branch, by:
> 1) reset the rockchip branch to v6.10-rc1
> 2) merge the pci/controller/dwc branch to the rockchip branch
> 3) merge the pci/endpoint branch to to the rockchip branch
> 4) pick all the patches that are currently on the pci/controller/rockchip
> 5) squash: 246afbe0f6fc ("PCI: dw-rockchip: Use pci_epc_init_notify() directly")
>    into the commit that adds dw-rockchip endpoint mode support
>    (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))
> 6) squash: https://lore.kernel.org/linux-pci/20240626191325.4074794-2-cassel@kernel.org/
>    into the commit that adds dw-rockchip endpoint mode support
>    (9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support"))
> 
> 
> This way:
> - All commits will build as individual patches, so no build errors from the
>   test robot (even when it builds a patch that is in the middle (e.g. 10/11)).
> - Even if futher commits are applied to pci/controller/dwc or pci/endpoint,
>   we will not depend on any newly applied patches to these branches, so there
>   will be no need to "re-merge" the branches to the rockchip branch.

The end result would look like this:
https://github.com/floatious/linux/commits/dw-rockchip-remerge-example/

(Just in case you want to git diff to see that we did the same thing...)


Kind regards,
Niklas

