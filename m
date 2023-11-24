Return-Path: <linux-pci+bounces-149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF97F6ADC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 04:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A6E1C209EA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Nov 2023 03:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247081A;
	Fri, 24 Nov 2023 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAKFB6sZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023271391
	for <linux-pci@vger.kernel.org>; Fri, 24 Nov 2023 03:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FF1C433C7;
	Fri, 24 Nov 2023 03:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700796338;
	bh=jeTU4K2I7ARc1FA1utG2cQpIpJDY3NHv/3ZhfOa/pHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hAKFB6sZW6UAYMzfQ/gCq9HNX9Kq5YO164okAczV9YpTvhmHmAhkYr1JfedzOSNKG
	 e4BXdjzh15YZAaunnXzID8BFhbOiJhoCP0oYvBuBRcCxLRZpmgbOBfmv9QuuIUfql2
	 URHISnp+iHjVJizEEQzfqJpx2SjmnsRgopBSiLvCTJVLRBUGh8SDsSZVrBKDFySVZ1
	 V6pVpZaQdbv5270qr1OFz1RWVuBQWx04sT3HEc3sMiHeqITwj91gYMo06sWqcKD2JL
	 MAEIql8quOS5JLM2tZP0jZjTMtRoSGuY4qkpPS5PmV2gGXuO6ClvT91K9Xz7VaGHCS
	 122N4M9KB18jQ==
Date: Thu, 23 Nov 2023 21:25:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Will Deacon <will@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de, linux-pci@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH] PCI: host-generic: Convert to platform remove callback
 returning void
Message-ID: <20231124032535.GA351419@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123171236.tksz4lhpj5jbwfxm@pengutronix.de>

[+to lkp]

On Thu, Nov 23, 2023 at 06:12:36PM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 20, 2023 at 03:56:18PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > On Fri, 20 Oct 2023 11:21:07 +0200, Uwe Kleine-König wrote:
> > > The .remove() callback for a platform driver returns an int which makes
> > > many driver authors wrongly assume it's possible to do error handling by
> > > returning an error code.  However the value returned is (mostly) ignored
> > > and this typically results in resource leaks. To improve here there is a
> > > quest to make the remove callback return void. In the first step of this
> > > quest all drivers are converted to .remove_new() which already returns
> > > void.
> > > 
> > > [...]
> > 
> > Applied to "enumeration" for v6.8, thanks!
> > 
> > [1/1] PCI: host-generic: Convert to platform remove callback returning void
> >       commit: d9dcdb4531fe39ce48919ef8c2c9369ee49f3ad2
> 
> Thanks! This branch isn't included in next. Is this on purpose?

To reduce the workload of the folks maintaining "next", I wait for the
0-day bot to build test a branch before merging it into the PCI "next"
branch.

That usually takes a couple days after I push a branch to the
kernel.org repo.  I have these branches that are currently waiting to
be put into next:

  ecam            pushed 11/20     bot response 11/22
  resource        pushed 11/20     no bot response yet
  enumeration     pushed 11/20     no bot response yet
  p2pdma          pushed 11/20     no bot response yet
  switchtec       pushed 11/22     no bot response yet

Not sure if the 0-day bot is slower than usual right now, but I cc'd
the LKP folks in case something is wrong.

Bjorn

