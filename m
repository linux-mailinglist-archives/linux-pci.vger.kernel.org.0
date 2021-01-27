Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A5306693
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhA0VnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 16:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235800AbhA0Vdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 16:33:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BDF164DCD;
        Wed, 27 Jan 2021 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611783182;
        bh=VAN1+fqJVKIXO2NTpiYqBBYNJGEP2fh7JX5PuSchluY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uzpAKctksMZgR9G0N9XwV0GSwOLYNGfAp/HNmWbaqPd/RsMT9ExyklHRaEEQCs925
         8uwlpGyQUIho+WdGGuL6LeW+bRJ3fL2U+bl9bCnA561HtZhLAmU891fbndnD0t+RdW
         CFXukH2ckJEq3H6Ge65m77RLTAQL9zoaQCYPn1fIdLB54tIaqZEIO0+9/rxwoj1S6k
         JL3jJDYPg6N15jYZ39J7chv7o3Xvl39fapZB48IgOdywHu5v6gI4qECy4gEkgPRSJa
         iINyOaJYov9rrs7lWkICks1iQU37JOZ1X1VIijieJdln+wWuljaVodoh8TwMTYaS93
         A35d9cFvaor+A==
Date:   Wed, 27 Jan 2021 15:33:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc MERLIN <marc_nouveau@merlins.org>
Cc:     nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: 5.9.11 still hanging 2mn at each boot and looping on nvidia-gpu
 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
Message-ID: <20210127213300.GA3046575@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226111209.GA2498@merlins.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc, I appreciate your persistence on this.  I am frankly
surprised that you've put up with this so long.

On Sat, Dec 26, 2020 at 03:12:09AM -0800, Marc MERLIN wrote:
> This started with 5.5 and hasn't gotten better since then, despite
> some reports I tried to send.
> 
> As per my previous message:
> I have a Thinkpad P70 with hybrid graphics.
> 01:00.0 VGA compatible controller: NVIDIA Corporation GM107GLM [Quadro M600M] (rev a2)
> that one works fine, I can use i915 for the main screen, and nouveau to
> display on the external ports (external ports are only wired to nvidia
> chip, so it's impossible to use them without turning the nvidia chip
> on).
>  
> I now got a newer P73 also with the same hybrid graphics (setup as such
> in the bios). It runs fine with i915, and I don't need to use external
> display with nouveau for now (it almost works, but I only see the mouse
> cursor on the external screen, no window or anything else can get
> displayed, very weird).
> 01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)
>  
> 
> after boot, when it gets the right trigger (not sure which ones), it
> loops on this evern 2 seconds, mostly forever.
> 
> I'm not sure if it's nouveau's fault or the kernel's PCI PME's fault, or something else.

IIUC there are basically two problems:

  1) A 2 minute delay during boot
  2) Some sort of event every 2 seconds that kills your battery life

Your machine doesn't sound unusual, and I haven't seen a flood of
similar reports, so maybe there's something unusual about your config.
But I really don't have any guesses for either one.

It sounds like v5.5 worked fine and you first noticed the slow boot
problem in v5.8.  We *could* try to bisect it, but I know that's a lot
of work on your part.

Grasping for any ideas for the boot delay; could you boot with
"initcall_debug" and collect your "lsmod" output?  I notice async_tx
in some of your logs, but I have no idea what it is.  It's from
crypto, so possibly somewhat unusual?

Bjorn
