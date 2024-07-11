Return-Path: <linux-pci+bounces-10172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5F92ED74
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 19:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FBA1C21005
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460816D4E7;
	Thu, 11 Jul 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npMBJKAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6A450FA;
	Thu, 11 Jul 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717760; cv=none; b=AshVg+WkTIP4hmp+l5XC+48fVfQfxHcMIWpfitpRxS3bJxFAuPgKFoOPswVaUWX3KTvUCgKTGzYus3CrIDTk8tODK9Bv/5OaKEH8vaRxhhYANWQrtfX1l8q/PHpU+k9u2fYtjImkdkosPHUig9QNcViBCSokVwpIMSPRDc77N+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717760; c=relaxed/simple;
	bh=4AsmtB1c0/haUg/T+xK8LCVjZIWcIFk1GR+agnIeol0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpbU9eEF5zr1N9qaNnnqHQqXoZxNh8pj0gMg7htuGhDJfnghrjM2uxVG5sF57HKbIl785aJv/1R+dSFlkZL4+YHSJyEl5/OoUt2Wr9Mr2MO7aTDPszsUYm2yCWjMi3xeN4xLshBkBCZmfqMpmApazpmisFyospbeLeqVX3vH2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npMBJKAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF51C116B1;
	Thu, 11 Jul 2024 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717759;
	bh=4AsmtB1c0/haUg/T+xK8LCVjZIWcIFk1GR+agnIeol0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npMBJKAK7s69Z/WDXZvryOrC1AXCklNKsLLxOCs3gsJfApoz0/Ox9lYee1sJ6JwFC
	 lzx5PgO1lGRj2EKUh3icE9RHKreJLdJFw+BKutxdCPSHRfth/k1X0ATH8iFfNL9fcK
	 AI83yw0uN4QfyYXRNmqakAMB+ri/2WvgtUJy8Mjvte/exqSdq9GP9l6B0P7O2MzXBy
	 YOUJ1fOXUHj22VvxXuP2nytibhRZMRTAMgjS3uLsA1nwarmZ1yF+vWOcbIiKCKhuJR
	 dY8lY7THLhQ9ec1bS3ImuG5ExziA3ve8s3lT6skT1KkhFWulvX1K9EsKrDDU/OQ5Bc
	 qrs9k3Yd9wRMQ==
Date: Thu, 11 Jul 2024 18:09:10 +0100
From: Lee Jones <lee@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Simon Horman <horms@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/7] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240711170910.GN501857@google.com>
References: <20240627091137.370572-2-herve.codina@bootlin.com>
 <91cfc410-744f-49f8-8331-733c41a43121@web.de>
 <20240711182528.1402892d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711182528.1402892d@bootlin.com>

On Thu, 11 Jul 2024, Herve Codina wrote:

> Hi Markus,
> 
> On Thu, 11 Jul 2024 18:09:26 +0200
> Markus Elfring <Markus.Elfring@web.de> wrote:
> 
> > …
> > > +++ b/drivers/mfd/syscon.c  
> > …
> > > +static struct syscon *syscon_from_regmap(struct regmap *regmap)  
> > +{
> > > +	struct syscon *entry, *syscon = NULL;
> > > +
> > > +	spin_lock(&syscon_list_slock);
> > > +
> > > +	list_for_each_entry(entry, &syscon_list, list)  
> > …
> > > +	spin_unlock(&syscon_list_slock);
> > > +
> > > +	return syscon;
> > > +}  
> > …
> > 
> > Under which circumstances would you become interested to apply a statement
> > like “guard(spinlock)(&syscon_list_slock);”?
> > https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/spinlock.h#L561
> > 
> 
> I used the spin_{lock,unlock}() pattern call already present in syscon.c.
> Of course, I can add a new patch in this series converting syscon.c to
> the guard() family and use guard() in my introduced lock/unlock.
> 
> Lee, any opinion ?

I'm intentionally leaving this one for Arnd.

-- 
Lee Jones [李琼斯]

