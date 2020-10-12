Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4338028C47A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgJLWD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 18:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgJLWD2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 18:03:28 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFAB2074F;
        Mon, 12 Oct 2020 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602540207;
        bh=Kx9hqJT+lWZx8bfUCcU0kLaDrcmL3KSNc330gGz7jug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VOa7aWnYvs8p4CWXcLmbokyUagcJffbsSznjOnmtf9/YxI7TrIEYqeLXv2P/RTEaQ
         XBLQUpC/hGFvQ2z1uCBR7Vzd2aoYateSKeW5MMaqKZilDOiRyhkm4BnejGbJ0LRXlB
         vOH1iZGAeky1RFB+4qEh4YS9TXT6tPY34m4Kq1Jk=
Date:   Mon, 12 Oct 2020 17:03:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Alex G." <mr.nuke.me@gmail.com>, linux-pci@vger.kernel.org,
        "Bolen, Austin" <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: spammy dmesg about fluctuating pcie bandwidth on 5.9
Message-ID: <20201012220325.GA3752081@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qa4NQCj8w-Apd2TnbtMjbox0jA6T347Bf_wEkJrzSz0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 05:17:53PM +0200, Jason A. Donenfeld wrote:
> Interestingly, some of the time that I run that lspci command, the
> dmesg line is provoked. That sort of makes sense, since lspci is
> communicating over the bus to gather all that info. I ran the command
> a few times and stored the output, if you want to look at their diffs.
> See attached.

The dmesg logs from your initial report:

  pcieport 0000:04:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)

are almost certainly seeing ~0 responses to config reads of 04:00.0.
That would happen if 04:00.0 were powered off or if the bridge leading
to it (00:1b.4) were in Downstream Port Containment mode.  00:1b.4
does support DPC, but none of the lspci logs you attached show DPC
being triggered.  If it were, you should see some indication in dmesg
as well, e.g., the "containment event, status:%#06x source:%#06x\n"
message from dpc_process_error().

If you can collect the complete dmesg log, especially after you get
the bandwidth notification spam, it might have a clue.

Just to re-confirm: this happens with v5.8 but not with v5.9?  (v5.9
had not been released at your initial report, so I assume you meant
v5.9-rc8 or something?)

If you can bisect, that would be the easiest way to identify the
problem.

Bjorn
