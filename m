Return-Path: <linux-pci+bounces-13117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB8976C48
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15893285194
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5711B12F1;
	Thu, 12 Sep 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqmkcdBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBB1AD279;
	Thu, 12 Sep 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151869; cv=none; b=naAswUt9bUTjzyAPPCP4159AD8sL6wN8PuurlC7c1Dm6a2BY9wa8ORlOFEpV3P9/fxk+TxnNr/tAyueDoAbSn802yp3qGnF5kPVAh6FUDbC43Zk8aJgIHghtUpb5j8Hg7Rx8m86zUkJBJAwDbFOfuQZ4SrJsJVsxEx9jSYCn/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151869; c=relaxed/simple;
	bh=aaWSOI6MHJpLiPOnj5+JUWz8WRVEzc2V3HK4lxMCrXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HymfjYSMgQv5JK2IpheqPQImq2bU1UEJqwg5GdhXSAeSoyzIir0c7Usfr+P/iY91RKieuWy2ZJ7mEk4xa6Wm3kpVDWnHzD2YZQ/aFndzDz1BtlVGKDjz4sQ3MLQQCdk1SDJvFfqO12V3PlLARNqoNkeW7inGNB2WfWGjHcd26M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqmkcdBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63210C4CEC3;
	Thu, 12 Sep 2024 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726151869;
	bh=aaWSOI6MHJpLiPOnj5+JUWz8WRVEzc2V3HK4lxMCrXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqmkcdBva718XKuLTmddQooosXpq27yFyMFL567h3OryjxwVrDJOdtHm5QJaKCxcm
	 93KB1ZBPVPNnvAtgJDn1WHP9ywGz+muzfZorn2eHYEmO1kCCd7e1K6wRph5z9yE6Ve
	 GvjMTETF6ht/xp8V5qLMdt1aYPVSBmiDt0GE9/aNzg1JAMwFYoc1WNVHZC/aMTUbsG
	 RUj4a4KfesifilOHjhd81AGQhorbOiKV1m+Ri/V/X4egcafHZpHZ7/m+Lu0k2a5jER
	 XNFJMwDf8ZMPCYPcpNQFAgR16FubTNv5NRBuJo49G68/ghUhWQc6Znzxr8urVYRXF0
	 6y4w7XLpj3RoQ==
Date: Thu, 12 Sep 2024 15:37:40 +0100
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Subject: Re: [PATCH v5 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240912143740.GD24460@google.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
 <20240808154658.247873-4-herve.codina@bootlin.com>
 <20240903153839.GB6858@google.com>
 <20240903180116.717a499b@bootlin.com>
 <20240909095203.3d6effdb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909095203.3d6effdb@bootlin.com>

On Mon, 09 Sep 2024, Herve Codina wrote:

> Hi Lee, Arnd,
> 
> On Tue, 3 Sep 2024 18:01:16 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
> > Hi Lee,
> > 
> > On Tue, 3 Sep 2024 16:38:39 +0100
> > Lee Jones <lee@kernel.org> wrote:
> > 
> > > On Thu, 08 Aug 2024, Herve Codina wrote:
> > >   
> > > > From: Clément Léger <clement.leger@bootlin.com>
> > > > 
> > > > Syscon releasing is not supported.
> > > > Without release function, unbinding a driver that uses syscon whether
> > > > explicitly or due to a module removal left the used syscon in a in-use
> > > > state.
> > > > 
> > > > For instance a syscon_node_to_regmap() call from a consumer retrieves a
> > > > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > > > syscon instance and add it to the existing syscon list. No API is
> > > > available to release this syscon instance, remove it from the list and
> > > > free it when it is not used anymore.
> > > > 
> > > > Introduce reference counting in syscon in order to keep track of syscon
> > > > usage using syscon_{get,put}() and add a device managed version of
> > > > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > > > instance on the consumer removal.
> > > > 
> > > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  drivers/mfd/syscon.c       | 138 ++++++++++++++++++++++++++++++++++---
> > > >  include/linux/mfd/syscon.h |  16 +++++
> > > >  2 files changed, 144 insertions(+), 10 deletions(-)    
> > > 
> > > This doesn't look very popular.
> > > 
> > > What are the potential ramifications for existing users?
> > >   
> > 
> > Existing user don't use devm_syscon_regmap_lookup_by_phandle() nor
> > syscon_put_regmap().
> > 
> > So refcount is incremented but never decremented. syscon is never
> > released. Exactly the same as current implementation.
> > Nothing change for existing users.
> > 
> > Best regards,
> > Hervé
> 
> I hope I answered to Lee's question related to possible impacts on
> existing drivers.
> 
> Is there anything else that blocks this patch from being applied ?

Arnd usually takes care of Syscon reviews.

Perhaps he's out on vacation.

Let's wait a little longer, since it's too late for this cycle anyway.

-- 
Lee Jones [李琼斯]

