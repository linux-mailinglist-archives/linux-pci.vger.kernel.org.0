Return-Path: <linux-pci+bounces-10197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12D92F76C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C552822C0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705431428E5;
	Fri, 12 Jul 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPD76uEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44585C56;
	Fri, 12 Jul 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774676; cv=none; b=gxQWr/8/4MXwj9J9ueLyFIrncBeqpzsN2SaJuoi5kSshkKHLVt7atIfgxyZMecq28vcND8P9/WNpycrHMJJ+kuxeK23s1jN73EGG7vVsMJPfr+O9IVdVp8onUbBdfgbf0Qu6eiaKHEGnyIUdVZQ1U8UM0GFelUqt0ID4Tq4TadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774676; c=relaxed/simple;
	bh=ZDPJYP6gEFHp66c3ESY9RhdT01J6PR01gUJB4J2mFHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiMICaO9BpCNMlBylaY2aAlZIsFhqBGhwtOjgdKxLsb0tUevz5/SyEPVCuY9Pv8pj9+O3lyyEXrdeLQjE9bfSu959p5zbE8FyubLe/a+walgsX03pkz0wdQU7qJ8FyzcReLY8dj66lXfHamMmd+6+hKu3vygKqPeulAvsSK9+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPD76uEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DECC4AF07;
	Fri, 12 Jul 2024 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720774676;
	bh=ZDPJYP6gEFHp66c3ESY9RhdT01J6PR01gUJB4J2mFHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPD76uEAdymfQ6rUYx7G7vVoXJ1i2ObDyz6P+jHwzw+AlM/MpAYOICVasBqnWnPyt
	 bt8SzfCuc1oYrNxwSmtgbxvUGgZB+U5m5idnQ2RM20MPreSDu1sJMR6OjzY1gP8tcu
	 iMvDNLxzaUpNRCY8Rgw4pW1A/YQyI82ki/+x48qE=
Date: Fri, 12 Jul 2024 10:57:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	UNGLinuxDriver@microchip.com,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Message-ID: <2024071226-cherisher-stumble-56e7@gregkh>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
 <20240627091137.370572-7-herve.codina@bootlin.com>
 <20240711152952.GL501857@google.com>
 <20240711184438.65446cc3@bootlin.com>
 <2024071113-motocross-escalator-e034@gregkh>
 <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>

On Thu, Jul 11, 2024 at 02:33:26PM -0600, Rob Herring wrote:
> In this case, all the child devices are already supported as platform
> devices. There would be zero benefit to add all the boilerplate to
> make their drivers both platform and aux bus drivers. Plus there is
> zero DT support in aux bus.

It is by design that there is 0 DT support in aux bus :)

But ok, I'll trust you on this usage...

greg k-h

