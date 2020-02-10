Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9848158583
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBJW2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 17:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgBJW2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 17:28:37 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A587D208C4;
        Mon, 10 Feb 2020 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581373716;
        bh=3kKo2xynezEBRaUtdcZ2UHO8+tn7TobyLUuxmb4bjJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ssj43CkBPdci/1VYaJLUlpGvFVhg8KD9VNADOOk7VHMeyBYUvS4gNJN4NP0lw0Si5
         SvtV8oiER8060b7GAAKaOfhjzPEnSxeOoxtw3pci0wT/ZSg2j+wHFLpv3sw5ZHZKfZ
         590oIuuLoAlEof/hekK4pu3iLfy+Asgt6STmb0yI=
Date:   Mon, 10 Feb 2020 16:28:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: pcie: kernel log - BAR 15: no space for... BAR 15: failed to
 assign..
Message-ID: <20200210222834.GA74627@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+j9ukzVia8_V3FisLCpT2GsKbmhWtJpQudtWUJcSAki+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 09, 2020 at 07:59:41AM +0530, Muni Sekhar wrote:
> Hi all,
> 
> After rebooting the system following messages are seen in dmesg.
> Not sure if these indicate a problem. Can some one look at these and
> confirm if this is problem or can be ignored ?
> 
> Also any suggestions as to what would cause this?
> 
> [    1.084728] pci 0000:00:1c.0: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.084813] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.084890] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> [    1.084949] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> [    1.085037] pci 0000:00:1c.2: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.085108] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.085199] pci 0000:00:1c.3: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.085270] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.085343] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    1.085403] pci 0000:00:1c.2: BAR 13: assigned [io  0x2000-0x2fff]
> [    1.085470] pci 0000:00:1c.3: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.085540] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.085613] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> [    1.085672] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> [    1.085738] pci 0000:00:1c.2: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.085808] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.085884] pci 0000:00:1c.0: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [    1.085954] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [    1.086026] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    1.086083] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    1.086144] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]

The "no space" and "failed to assign" messages are all for bridge
windows (13 is the I/O window, 14 is the MMIO window, 15 is the MMIO
pref window).  I can't tell if you have any devices below these
bridges (lspci would show them).  If you don't have any devices below
these bridges, you can ignore the messages.

Bjorn
