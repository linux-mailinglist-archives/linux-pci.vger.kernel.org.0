Return-Path: <linux-pci+bounces-12672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DE96A306
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9631F2A25F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F30187561;
	Tue,  3 Sep 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QODztkH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907518453F;
	Tue,  3 Sep 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377928; cv=none; b=tZWVn464Lsv8gATPQ9j8xeX3vduCFXfmUGIu5q9at5QRLsQJ6Yz9g4zZ0tAM+yuIVblHUj+uuoUp1nMaFrXKsJLN7WdYuKKZze0l8p7b2JADsv3KXL03NfDmSL3oPQX352Y0N+3ooqmFaxn0/uF7L+i7M27kPRVDLxK7JH4nU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377928; c=relaxed/simple;
	bh=S5CoP4L+Z9i13ubnj1t4i0TX9PPx6KHBRTxC+jRT8do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efM8tNXMMF3TELJtKI43atw2+m4ehJHVXZwVt5+TAbgQrv4zfVGP9mpna71Kqbv4uOOOjxN02N0+oSWcponFqPlaeJzCo0gYJ8H5PfxsE9NuaExJGpAgctxM5RuJalpTjlPOOU4z+sTxNL8rlb05NLXhviTS4Rwqsj5Pp9CGVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QODztkH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326CCC4CEC8;
	Tue,  3 Sep 2024 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377927;
	bh=S5CoP4L+Z9i13ubnj1t4i0TX9PPx6KHBRTxC+jRT8do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QODztkH6u7BRnJThucAKNoOr795B2lvtmtFY+IUg4yvPmPrqS+agtzwSw6CiGSsTr
	 36GwN4s7ehdVPUd54QoFjYOtThqT1cXEu/hA3bgENux1uxsfa0weXEoow0sXRNxj4T
	 MbhiHAzUKo/KHAHMqBB/WRJf5Su9O2cvVwo17ec3y5MSadZTXz3YV71O9IogkZe1PS
	 NaD/XrQftLmGcW1KMoLfeeqr2CZaRDdf9iV+qK7woBMpyhjtPVkAjK7SyaPklNHr4z
	 XHDaJ8wB2F+EY+Y9q+hbvClT7YWWSK7YAYXn6cSvMRXuPyJq8p1bDA3aJlL6SSS79R
	 m4X1SbPTkB6HQ==
Date: Tue, 3 Sep 2024 16:38:39 +0100
From: Lee Jones <lee@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Subject: Re: [PATCH v5 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240903153839.GB6858@google.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
 <20240808154658.247873-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808154658.247873-4-herve.codina@bootlin.com>

On Thu, 08 Aug 2024, Herve Codina wrote:

> From: Clément Léger <clement.leger@bootlin.com>
> 
> Syscon releasing is not supported.
> Without release function, unbinding a driver that uses syscon whether
> explicitly or due to a module removal left the used syscon in a in-use
> state.
> 
> For instance a syscon_node_to_regmap() call from a consumer retrieves a
> syscon regmap instance. Internally, syscon_node_to_regmap() can create
> syscon instance and add it to the existing syscon list. No API is
> available to release this syscon instance, remove it from the list and
> free it when it is not used anymore.
> 
> Introduce reference counting in syscon in order to keep track of syscon
> usage using syscon_{get,put}() and add a device managed version of
> syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> instance on the consumer removal.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/mfd/syscon.c       | 138 ++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/syscon.h |  16 +++++
>  2 files changed, 144 insertions(+), 10 deletions(-)

This doesn't look very popular.

What are the potential ramifications for existing users?

-- 
Lee Jones [李琼斯]

