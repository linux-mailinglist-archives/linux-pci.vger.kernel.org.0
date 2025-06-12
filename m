Return-Path: <linux-pci+bounces-29606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E2AD7B77
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC8E3A3392
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDE2D540D;
	Thu, 12 Jun 2025 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dgrFviZi"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF371D95B3;
	Thu, 12 Jun 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757901; cv=pass; b=iJvE/7JTDpX+6pEIdWh/R6HearuahSki9IzBxWgLPbe8hIw+VlMxJDd2Y/swkFAeJco3hM8vdpZXdVUmQM55ImBAU++MCRj3sjJzLQ5z86O/jox3w0y8jEwLvfi0xcVA62tnhE0DDUW+BELlmWtvR5alTUKbaio336NAqhzdAZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757901; c=relaxed/simple;
	bh=MZFOxTpWTX30Sul/xd08OAY7m5LBHhcZ8N+9X99cUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxN5LWwOUgq4Ysl1yuosuaJAuFwaXdLZ3/YhiHy9D7yqJKrpr16pZbHnlOI3lTbx6hH8iACJOUMTPDnTaIFSs/A2C01QUojjuf5HXTjQRw4qUOewnx2A3uEmlMXFzVGzEaXX/4W9ZVuKmsteoGtPF/j42PL/4dDhByjQuXIkDqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=dgrFviZi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749757825; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=niCZ7gfbCTphUt9F4A6BqJhyAWLYx6ZFwS619hLJe6PBl39fzz0Cx8vMltl3JFnMTsylPx4rmHxzSjlI6+i7JxXqUGT3s6Es/ezleTw1LiVQjojUFV2MChvno5MY8Cvp/2xtoIVUvXIUkrk6ZQaLkHxbgid9Eb84F9rtiiep3/w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749757825; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mU+CcqNywPoimgVbJRvOWx8a/xllDqeUM7RTijoC4cY=; 
	b=QslLP2IFvCv129jJG9S1czdWGSll5oQcKPTGbu69twy2y6tft074Tj9gl4VSLqgkHbZePSQXCS47CfPxgVRXhkhNwNcM8sjdLMyylkaGbgAbNTkJteWsZT0or3z04oq3pKdilJf94Uubjr2Ok5GHz0dv8po0Wsr3HlZiPRC3pWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749757824;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=mU+CcqNywPoimgVbJRvOWx8a/xllDqeUM7RTijoC4cY=;
	b=dgrFviZisw0pqrB+YqDeMyESyiRkmHgCVyEhMK+qA9s5JJEM1kHaX6FSiVjc6CAL
	ESUjzFUcC4kIRX5GaLHv+75hTR9fo3lR/+rESxFHOrnAIQiuvgMjh0P0wu1u/jZe70V
	f2+QqcSa+85I9n/Kg//f8lLHO3nJsdYBvCrZC82w=
Received: by mx.zohomail.com with SMTPS id 1749757823600263.75629300643163;
	Thu, 12 Jun 2025 12:50:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Date: Thu, 12 Jun 2025 21:50:12 +0200
Message-ID: <22744779.EfDdHjke4D@workhorse>
In-Reply-To: <20250612124415.3399e26b@kernel.org>
References:
 <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
 <20250612124415.3399e26b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 12 June 2025 21:44:15 Central European Summer Time Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 20:56:03 +0200 Nicolas Frattaroli wrote:
> > Hardware of various vendors, but very notably Rockchip, often uses
> > 32-bit registers where the upper 16-bit half of the register is a
> > write-enable mask for the lower half.
> 
> Please limit the spread of this weirdness to a rockchip or "hiword"
> specific header. To a normal reader of bitfield.h these macros will
> be equally confusing and useless.
> 

That is how this change started out, and then a different maintainer told
me that this is a commonly used thing (see: the sunplus patch), and
Rockchip just happens to have a lot of these with consistent naming.

I believe normal readers of bitfield.h will be much more confused by the
undocumented concatenating macro soup at the end, but maybe that's just
me.

Best regards,
Nicolas Frattaroli



