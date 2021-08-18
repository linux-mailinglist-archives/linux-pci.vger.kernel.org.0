Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6803F068B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbhHROXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 10:23:22 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:60681 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhHROXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 10:23:16 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 3d105b57;
        Wed, 18 Aug 2021 16:22:37 +0200 (CEST)
Date:   Wed, 18 Aug 2021 16:22:37 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, maz@kernel.org, alyssa@rosenzweig.io,
        linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, stan@corellium.com,
        kettenis@openbsd.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <092a2de3-6760-6398-e4de-2b24d30ac856@marcan.st> (message from
        Hector Martin on Wed, 18 Aug 2021 20:43:48 +0900)
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io> <87a6lj17d1.wl-maz@kernel.org>
 <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com> <092a2de3-6760-6398-e4de-2b24d30ac856@marcan.st>
Message-ID: <56140239180269fd@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Wed, 18 Aug 2021 20:43:48 +0900
> 
> On 15/08/2021 21.33, Sven Peter wrote:
> > The magic comes from the original Corellium driver. It first masks
> > everything except for the interrupts in the next line, then acks
> > the interrupts it keeps enabled and then probably wants to wait
> > for PORT_INT_LINK_UP (or any of the other interrupts which seem to
> > indicate various error conditions) to fire but instead polls for
> > PORT_LINKSTS_UP.
> 
> Let's not take any magic numbers from their drivers (or what macOS does, 
> for that matter) without making an attempt to understand what they do, 
> unless it becomes clear it's incomprehensible. This has already bit us 
> in the past (the SError disable thing).

The driver should really only unmask the interrupts it handles in its
interrupt handler.  We should know the meaning of those bits so using
the appropriate symbolic names shouldn't be too difficult.

Didn't delve into this yet since U-Boot doesn't do interrupts (so I
don't touch the port interrupt registers there) and on OpenBSD I only
implemented MSIs for now as all the integrated devices support MSIs
just fine.  I'll need to revisit this at some point to support the
Thunderbolt ports.
