Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94A544CB52
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 22:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhKJV3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 16:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232242AbhKJV3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 16:29:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6810F61207;
        Wed, 10 Nov 2021 21:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636579609;
        bh=5HsCjc/h7vYUBqFoKIG/7ePtlJ6sSlx0sReGm9l6g4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ak01qITTsjYEywOWaIQFX8u3v8pCdIva+j5NLbv+wsS7Jb5sErFgj/l0schSzxjEk
         k0ohkmPbGbQLw65bYeKERsgWo7vzmqK0gFo8YdTSQmCjmbHLjrd671ut7E+WCKSXhV
         DiwmPYjlH1IuDRtIg6ICQRFcuLYlYCxNojxaHVprzWO4T2ps1Q6tThurzJu+k0mZ8l
         h4Xz3bWg0YULVgratKa83rJZRzMix93rbTx7kBWsWZnlgv90tOGgI5CqVTx7N6tcs4
         EAWg0B6hP6cMTW9Mi6Xa30qflMw7mCHPZjh9hT8j2K3X4oNaWtPZnPeqoDI2TeX6Xb
         bCu+bRjVuICfg==
Date:   Wed, 10 Nov 2021 15:26:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
Message-ID: <20211110212647.GA1262229@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP145pjO9zdGgutHP=of0H+L1=nSz097zf73i7ZYm2-NWuwHhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 01:42:29PM +0100, Robert Święcki wrote:
> Also, this might be unrelated, but the following happened around this
> patch (ie https://github.com/torvalds/linux/commit/0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4)
> 
> I sometimes run Win11 under qemu/kvm/vfio (gfx card), and it stopped
> booting (even with the latest patch for pci). Another Linux distro
> boots fine under the same qemu/kvm/vfio, but Win11 stops at the boot
> screen.
> 
> It worked well with 5.15.0 and a few PRs later - with the git tip it's
> not booting - and it works well with 5.15.0-rc7
> 
> Maybe related to pci/vfio changes, maybe not, just leaving it here for
> track record. I'll try to debug it a bit.

Hmm.  I have no idea how to debug a Win11 boot issue.  Unless there
are clues in the dmesg log or some qemu or kvm logs (if you find any
such logs, please put the complete logs somewhere), the only thing I
can think to do would be bisecting it.  "git bisect" between v5.15 and
0c5c62ddf88c looks like about 13 steps.

Bjorn
