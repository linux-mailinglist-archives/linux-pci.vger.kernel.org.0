Return-Path: <linux-pci+bounces-3041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF0847915
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5051C22184
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2022812D773;
	Fri,  2 Feb 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxF3wj8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D483A0C;
	Fri,  2 Feb 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900012; cv=none; b=gKuL/QY5vkWpAixYzx2HnYOCU5v5GKCmHbW0paXAv1Bil8EBaHABmUVbB1r0isS0fu8ffVTZhKSOeZAMgVeHSpgWzZO0ixeiAVr9ghtMGTh9HCCqq6yqYJhl6qZWpE16LrIIvcSeHLkiiqVTEWOPQylQiKJlb0Zonl2za0FFpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900012; c=relaxed/simple;
	bh=BfPWVLXVjqnU3vmc0U9hEmE5mio5hV7S7WnYSfm85Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSFd0JxNrN7BLan8/QFA7H5RQxRBr3J50ibtvzM45IY071YrU+VKwKeNuHD+RyD+3ZdWGtl45cnjHWApfuGTDzYmbA1V6QQPtGGsfbIkA4cVQN0jNUgu7l4j3E6wnZjyWPD3TWnZBxLMluXgusEnLurvOxO7Oq32w+414vbXIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxF3wj8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF8C433F1;
	Fri,  2 Feb 2024 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900011;
	bh=BfPWVLXVjqnU3vmc0U9hEmE5mio5hV7S7WnYSfm85Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxF3wj8I2VxPoq8egSbA5R0YteSmSNgyQVUNHdbT2JAAEHtxLynsEzCHnJUjzV9UN
	 FN6LOFbvl84FcQ69c0N4TaRgEMuxF/iEC7x76G5G3vAS5Nat7z9f/qi07x6VqVrio/
	 wxilcN3kCwrlPQNUI21rirBkMMxpTUx2WyZ+wUESqWHEU1NKrf00Z66OA41SUSQxx7
	 OPQ4sMFzMT80Aj/Y+Xrt7g2Uk2Yo7BKe+PFvqiAve8zuM/Igaka5F3uF9Iia5Z3cd0
	 rDMkw4UJ6kHvbjAfT/tBHU7qOdqbx33zxFwyQC1vZz8IhTqXQMXK81pSH0crRkVjTL
	 0TL/s5Z5AlQCQ==
Date: Fri, 2 Feb 2024 19:53:24 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <Zb06JL5X8EiHEyFD@lpieralisi>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-6-Frank.Li@nxp.com>
 <ZbzcOarorCS1MPRc@lpieralisi>
 <ZbztZkNQ+wydticD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbztZkNQ+wydticD@lizhi-Precision-Tower-5810>

On Fri, Feb 02, 2024 at 08:25:58AM -0500, Frank Li wrote:
> On Fri, Feb 02, 2024 at 01:12:41PM +0100, Lorenzo Pieralisi wrote:
> > "PCI: imx6: Use "linux,pci-domain" as slot ID"
> > 
> > On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > > Avoid use get slot id by compared with register physical address. If there
> > > are more than 2 slots, compared logic will become complex.
> > > 
> > > "linux,pci-domain" already exist at dts since commit:
> > > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > > 
> > > So it is safe to remove compare basic address code:
> > > 	...
> > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > 		imx6_pcie->controller_id = 1;
> > 
> > No it is not unless you magically update all firmware out
> > there in the field.
> 
> commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> Author:     Peng Fan <peng.fan@nxp.com>
> AuthorDate: Fri Jan 15 11:26:57 2021 +0800
> Commit:     Shawn Guo <shawnguo@kernel.org>
> CommitDate: Fri Jan 29 14:46:28 2021 +0800
> 
> I am not sure if it is neccesary to compatible with 2 years ago's dts.
> I think it may not boot at all with using 2 year agao dtb file directly.
> 
> Do you have other comments? I can remove it from this big patch series,

I will have a look at the full series first we can decide whether
to drop it later.

I am travelling so I am not sure I can review it before February
12th, FYI.

Lorenzo

