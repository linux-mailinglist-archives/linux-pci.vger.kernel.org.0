Return-Path: <linux-pci+bounces-18396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB49F130D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1212849B2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686F1684AE;
	Fri, 13 Dec 2024 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXYQ40dP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580815383D;
	Fri, 13 Dec 2024 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109005; cv=none; b=ZzRCksLoggP6Ko19WH9xJJcY4fOwIZ8z6oegFopLOTn+hk8PWsLlrkMLp5Hw5DQuWZLYzMAFq2295lKwYQ/x6sivpCmpc8Oo0I6aNdLWQCcVEgWJtnT1o+Oc5tmTxh40BUSCRDPrxOEjI5NY7k7Sh+D8F69S5gGH3U9tsAHkHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109005; c=relaxed/simple;
	bh=8KEzb6IwU9Zsq9NX0YHyF60938V4ePFI56eRmVCZqF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pSfRP3XjRiuZCbMDhvrXwaI7J7QH3kphVg01GNRTwfue704nJVYUrj1kZSn3x3Ke99yzoZZdobjjUse1ECjOoSxv7ts9khUnowAEJSAL0pYB1v1ZKa5BxFlc/YqiaXofwc8hKft5O5297L0DCZWbTE2V1Wosn9NdqxOq2QWW+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXYQ40dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EE4C4CED6;
	Fri, 13 Dec 2024 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734109005;
	bh=8KEzb6IwU9Zsq9NX0YHyF60938V4ePFI56eRmVCZqF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lXYQ40dPrglmLVfqQMtAB9SIi6Dlf22vF0PCDtZLbmzyi72xKe92tfkP/dKUaFUL5
	 y2cl38PBk7AOXJmsL4Wd+XiRtccxCMrZ/b2jK6FM9NGo90S7QA2BybnJNF82YuPf5p
	 9UQv5V8rqBmFlWOOeJVqZXC/YQzUBGswxFptXxEn9f4N7mpTQYWBukypbjXrhNavmG
	 58zQsNWVMY0xBqOFCZNCXjbNWivnspr0SLZKnpRP+0tsGom9UJsFoN+12+bD9k060o
	 6HGIB903JF07RLXvw3bERqQeRQkmdPts66qCT4Fh9FXCLHMKHLrQs8vB/BcXxH6WFv
	 idFy1cGoZTdXg==
Date: Fri, 13 Dec 2024 10:56:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, namcao@linutronix.de, ngn@ngn.tf,
	scott@spiteful.org
Subject: Re: [RESEND PATCH] PCI: remove already resolved TODO
Message-ID: <20241213165642.GA3417770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213151710.805485-1-trintaeoitogc@gmail.com>

On Fri, Dec 13, 2024 at 12:17:10PM -0300, Guilherme Giacomo Simoes wrote:
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > I see a test and call for .get_power() and .set_power(), but no actual
> > implementations, so I think they can be removed as well, can't they?
> > If so, I'll wait for that removal before applying this patch.
>
> You are right. Both only have a check if exist the {g|s}et_power(),
> then this is called.
>
> But, as you already said, seems that really don't have a
> implementations for both. So, I can work on remove this fields an
> tests this.  
> 
> In the cpci_hotplug.h we can create a `flags` field in
> `cpci_hp_controller_ops` struct, in addition of remove the
> {g|s}et_power(). In the cpci_hotplug_core.c that the
> cpci_hp_controller_ops struct is in use, maybe we can create a
> #define SLOT_ENABLED 0x00000001, and we can do `ops->flags |=
> ENABLED_SLOT` when we need enable the slot in the enable_slot()
> function and `ops->flags &= ~ENABLE_SLOT` in the disable_slot()
> function. In the get_power() function we only need return
> `ops->flags & SLOT_ENABLED`.  what do you think?

I don't quite see what you have in mind; a patch would make it clear.

But the cpci hotplug driver is basically dead.  I don't think it's
worth doing anything more than the most trivial cleanups to it.

Bjorn

