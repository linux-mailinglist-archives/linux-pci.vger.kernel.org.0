Return-Path: <linux-pci+bounces-6906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F778B817D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E6C1F237CE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D745190668;
	Tue, 30 Apr 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iamRaAMj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D2179B2;
	Tue, 30 Apr 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509293; cv=none; b=P6qbj/yk/+5H/0pzILK1ewOqC9PtUEUsKdkh/bV4BK8sz4EQHh3VqY/9xVzja9fnU4c5TZ/gavNLr8GTmAiSSiRX0tMvT70dXWuvLK2+XNJZpwjcEnQOCpRf2Q+p72hMsERB/dGLcdeVUDuKJjzD0MHTRQ5cJPwv46f9hKYhlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509293; c=relaxed/simple;
	bh=HtcQHmj985eQ+dg3uqxVTbR5cUoWPjp4+IhThC+KEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqKbcnHHFrfRrifzRL3BLrX93q+ViL/VRbYQzz7W3xc7GI8OVWB6llAr4NUF11+2ebGd+svWZU2UCVS/xrcwA/qVo+CSL/CSXXFpw/TsGLc7GwVH1LX8Ip2sXsKmHOmwchr7S9YJTC2/+P0mdIi5dtxqqOctd0s2JBsUUVioYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iamRaAMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA5C4AF17;
	Tue, 30 Apr 2024 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714509292;
	bh=HtcQHmj985eQ+dg3uqxVTbR5cUoWPjp4+IhThC+KEug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iamRaAMjbqYlRtYkrz98dWDUYhZmMcb96S8p7LdlmCtD4/yhJ8PQjUQr1Btp+8gJx
	 /6Ch4UmQM5/8EwAfTSUpsknGmRvk/dbKCpr1Pi1Ey1/c9twfezgVcvmFu/YocQjYIC
	 SUZIGp0RKKIKQ8IwXL33Mm7XKs2nHJVMonNJ1bTV/3EOg/+L0TZVZw2+xt2uuvLc98
	 wUxV/fK8Ts91A178VA8EhaC6AInd5GNuVtvHlJZrwN4NNZ0YAJ7rnbyk/sT8/G5Xfz
	 mXGtJY5YxB7RnPbnatdptWWdxXgCXge1K2zSbKP6Z+2QCbZ5VVL9pVxK8m2qcPsLz5
	 i9Wr//FfNBRZw==
Date: Tue, 30 Apr 2024 21:34:43 +0100
From: Simon Horman <horms@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Subject: Re: [PATCH 01/17] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240430203443.GG2575892@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430083730.134918-2-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:10AM +0200, Herve Codina wrote:
> From: Clément Léger <clement.leger@bootlin.com>
> 
> Syscon releasing is not supported.
> Without release function, unbinding a driver that uses syscon whether
> explicitly or due to a module removal left the used syscon in a in-use
> state.
> 
> For instance a syscon_node_to_regmap() call from a consumer retrieve a
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

...

> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index c315903f6dab..164b9bcb49c3 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  
>  struct device_node;
> +struct device;
>  
>  #ifdef CONFIG_MFD_SYSCON
>  struct regmap *device_node_to_regmap(struct device_node *np);
> @@ -28,6 +29,11 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
>  						    unsigned int *out_args);
>  struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
>  							const char *property);
> +void syscon_put_regmap(struct regmap *regmap);
> +
> +struct regmap *devm_syscon_regmap_lookup_by_phandle(struct device *dev,
> +						    struct device_node *np,
> +						    const char *property);
>  #else
>  static inline struct regmap *device_node_to_regmap(struct device_node *np)
>  {
> @@ -67,6 +73,18 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
>  	return NULL;
>  }
>  
> +static intline void syscon_put_regmap(struct regmap *regmap)

intline -> inline

> +{
> +}

...

