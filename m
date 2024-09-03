Return-Path: <linux-pci+bounces-12653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C3969984
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC82AB2200B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A119F437;
	Tue,  3 Sep 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE9Pjgo2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC363207;
	Tue,  3 Sep 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357117; cv=none; b=e654eQp2Hoqow/g8XSJuI08bDvwuDBsiQbsojaxB6vCtYF0kPB1nf0i7CjNbZrw7woBonOfcscCuYJ0hQHjX5mtwgp42HcLdLnipNRm1cttBQLLQrSIpM8G2E94zvdPl6YEGhtEfj+Y032OOrXbqL8EUFjIGL5JKxeXUTEViNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357117; c=relaxed/simple;
	bh=gAYyJ180rea+x6P6PLkWT1Nc5VwQs+jQogMrIZ/L/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjZz3ZaTItK1eYDoGvV67PqH8nRkBy5uiLUvSUFTdnOtIfqJH5VJN4e5r/kTrpvKfbNXm61xYyh1EEVg68QGs3j/uHyTIrkrT1yd79I2t0eIVrR61Rqme9PcuN2IcFHUVYgIprYTsM4saVAzEytX28+XmsblE9+T8q55Jx3VJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE9Pjgo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA39AC4CEC4;
	Tue,  3 Sep 2024 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725357116;
	bh=gAYyJ180rea+x6P6PLkWT1Nc5VwQs+jQogMrIZ/L/FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZE9Pjgo2OqPkmUuDeQAp/GzujhN6tPlg/Wz2VmdzMqM6+5MBNUcFBBS9A1KqDTy/s
	 8wpCR33z37YPSHNJKLFLP5GPa9Hr4YY0kzLL5zRPfjbf0lPh11q0IuYAj15hX1QWj6
	 Si4z7+fedl3RDJmFGhhhh13JLaN44Jlq8t9QPlw8v5bferof1ZqnoUt92iVfw3arFr
	 92KsfnO2H09KZD/HwS1uEAK+ZqYQo+kkAeawhDpqrZo9hbQEBc2Us4FSPTiC7dcyuw
	 95Ka40Db3hkslwYLwkednXAaAjAhuXMl3cXiytoCtEqFubleYUb/BHvg7qh+O4aP+X
	 KAgAbLnwbxr1w==
Date: Tue, 3 Sep 2024 10:51:47 +0100
From: Lee Jones <lee@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/8] Add support for the LAN966x PCI device using a DT
 overlay
Message-ID: <20240903095147.GU6858@google.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
 <20240903101724.291ad0f7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903101724.291ad0f7@bootlin.com>

On Tue, 03 Sep 2024, Herve Codina wrote:

> Hi,
> 
> On Thu,  8 Aug 2024 17:46:49 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> ...
> 
> > In order to add this PCI driver, a number of preparation changes are
> > needed:
> >  - Patches 1, 2 introduce the LAN996x PCI driver itself, together with
> >    its DT overlay and the related MAINTAINTER entry.
> > 
> >  - Patches 3 to 8 allow the reset driver used for the LAN996x to be
> >    built as a module. Indeed, in the case where Linux runs on the ARM
> >    cores, it is common to have the reset driver built-in. However, when
> >    the LAN996x is used as a PCI device, it makes sense that all its
> >    drivers can be loaded as modules.
> > 
> 
> Patch 7 was applied my Philipp and patch 1 was acked by Greg.
> 
> No feedback received on other patches.
> What can I do to move forward on this series and have it applied ?

Arnd needs to be okay with the syscon ref-counting idea.

-- 
Lee Jones [李琼斯]

