Return-Path: <linux-pci+bounces-33673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C4B1F8AC
	for <lists+linux-pci@lfdr.de>; Sun, 10 Aug 2025 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761773A9135
	for <lists+linux-pci@lfdr.de>; Sun, 10 Aug 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C422B8D5;
	Sun, 10 Aug 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVImt05V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B022A7F2
	for <linux-pci@vger.kernel.org>; Sun, 10 Aug 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808728; cv=none; b=GEvNkDDHmLHmpJWjeJ23lA8fwPR7+Fg1AuCGpheic8TFiU95MSO2K308ObKLY2kHig5oKdJ9hfvDVHZWi1MAQqR1HMktyfYu/hid24wM5uo9VSosesP+rOwWEw6OtAmuHhr9BRtSNloIjBC7RO3otzGkMyf6jkOjzZ+u8ltXOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808728; c=relaxed/simple;
	bh=JEFSYNM7Y3cB7Kk5gCRir/3SMbdsyLwqgAcmWKnuKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1iyD++Z+ZLw21OUA7K7MQKIH61PPaRfAbH2FhuP8hUfEB6PZx/0AF17qsv6eJMG8tyAR5g48SEiN8NRmzDU2RfhyRlht6vw3uQpFp774YCWrwHTkZ6s8EqCfBpnJXtBJDy1g8IZLD03g2clUleZS1Zx/Gi5tg4OmxRAn5lhiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVImt05V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC392C4CEEB;
	Sun, 10 Aug 2025 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754808728;
	bh=JEFSYNM7Y3cB7Kk5gCRir/3SMbdsyLwqgAcmWKnuKrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVImt05VxdOtXZYlfUqpZsEOAqTb+9SmkM0L0YWEmFpCrJoOGqrbh+hHW5iYjlLRP
	 wRghUCaUPloR9AFGSCgaeW0KJCdsPf4jVXbZMI9C+3pK2JNmsZSlLm11PMcf3WjTPd
	 iBrlgE/vI+AqhRDWXciCjw4jfc9Ku1k2RIPzctag=
Date: Sun, 10 Aug 2025 08:52:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Martin <dmanlfc@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org
Subject: Re: PCI probe.c typo
Message-ID: <2025081053-expectant-observant-6268@gregkh>
References: <CAOyTmd1iX=gf2Y-gabinirnH5RMRYaSw4Vcy7ZDra6OH3F1TyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOyTmd1iX=gf2Y-gabinirnH5RMRYaSw4Vcy7ZDra6OH3F1TyA@mail.gmail.com>

On Sun, Aug 10, 2025 at 11:10:00AM +1000, Daniel Martin wrote:
> Bjorn,
> 
> FYI this recent 6.15.9 commit -
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.15.9&id=9249a8e34de3d44cfee7c8f9ad499be7ea95b5e4
> 
> Unfortunately it has a typo `CONFIG_PCI_PWRCTRL` instead of
> `CONFIG_PCI_PWRCTL`.
> This causes the power supply check & device creation to fail on Arm boards.
> Hence certain wifi devices fail to init.

Can you send a patch to fix this up please?

thanks,

greg k-h

