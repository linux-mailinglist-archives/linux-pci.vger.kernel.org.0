Return-Path: <linux-pci+bounces-3434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6A854749
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872B7B2995B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B90125BB;
	Wed, 14 Feb 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM4tcHce"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B418635;
	Wed, 14 Feb 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907139; cv=none; b=np+6X3qzsbj/GFiYJ8ycgOGoZ9FQ0REFDu2gfJOH9Z+TBTiIYIEM86wWCLm+xQBE274Wtywn3gJ+rRXVl2juvV6YYmSN1D65OaQF3+IWc+ZEl1akG0H3v0WGnU+3YDzLOnvZOnrbQnlennqxM9r5EC/Di37BzRmcTwoHbVgqku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907139; c=relaxed/simple;
	bh=eslzQormGDUUKR6M3wUfA/wR65g2VVIMI2OcUV5+luQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGmiOxKTP5aigfW6Ejr05LluhYH4NDA2DiKCYH28SCxe0MXmw2dgsJhnok0jQrBeEVH4gPXeIG4bXq9xaXtLJp4Yo682pjSyAuSsA2OmEHBk/nb+MwpH09uub0KqAfYQppGKuQB+EXm4yoeNBxq9gor95lclggMSUhL3CC5oru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM4tcHce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55909C433C7;
	Wed, 14 Feb 2024 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707907139;
	bh=eslzQormGDUUKR6M3wUfA/wR65g2VVIMI2OcUV5+luQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NM4tcHcenWq1MQ46lCcjZguB2y0u9a08wBEfpVvvyTs7aHG6ltzW76Dp3veftpT3j
	 i1Z8OUTTxKwVUAmyDMA+HXFG+VHMfUSpBXFYQKnXtfp4zAw9tSsPC4LsKRiXuq2zAg
	 HvqopQ1KrOMmaeAddUivvw1SPeSBFS4rs/JYB6OWbu8LyMbywWfLlGHwIwSoPCUba+
	 CR/KZxC/S7C6BvcQ6xEq1ZAT/XwXhgiHFAmVMnZNvfQpiBQ54hkBW5XE+iCSel8XF/
	 fPXVUiky2QMlDUFAJiVqHbMLhldLNckU/yM4uw7ip+kHMlzdMUBZ1fj64JKT3Rpf6g
	 dEPOCUfNAx76A==
Date: Wed, 14 Feb 2024 11:38:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 0/2] PCI endpoint BAR hardware description cleanup
Message-ID: <ZcyYNzYo9HiQi4DY@x1-carbon>
References: <20240210012634.600301-1-cassel@kernel.org>
 <7a243a1e-6b47-bc2f-c538-b57db1c9c580@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a243a1e-6b47-bc2f-c538-b57db1c9c580@amd.com>

On Wed, Feb 14, 2024 at 09:47:54AM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On 2/10/2024 6:56 AM, Niklas Cassel wrote:
> > The series is based on top of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=endpoint
> > 
> > 
> > Hello all,
> > 
> > This series cleans up the hardware description for PCI endpoint BARs.
> > 
> > The problems with the existing hardware description:
> > -The documentation is lackluster.
> > -Some of the names are confusingly similar, e.g. fixed_64bit and
> >   fixed_size, even though these are for completely unrelated things.
> > -The way that the BARs are defined in the endpoint controller drivers
> >   is messy, because the left hand side is not a BAR, so you can mark a
> >   BAR as e.g. both fixed size and reserved.
> > 
> > This series tries to address all the problems above.
> > 
> > Personally, I think that the code is more readable, both the endpoint
> > controller drivers, but also pci-epc-core.c.
> 
> Thank you for cleaning this up!
> 
> FWIW:
> Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>

IMHO, a FWIW is quite the undersell here, as there is no R-b I would value
higher than the R-b from the original author or the pci endpoint subsystem :)


Kind regards,
Niklas

