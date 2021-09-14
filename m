Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3740A21F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 02:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhINAkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 20:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhINAkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 20:40:22 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5471C061762;
        Mon, 13 Sep 2021 17:39:05 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mPwTX-00016m-DZ; Mon, 13 Sep 2021 20:39:03 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 2106A5600F9; Mon, 13 Sep 2021 20:39:03 -0400 (EDT)
Date:   Mon, 13 Sep 2021 20:39:03 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210914003903.GA18550@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210913141818.GA27911@codemonkey.org.uk>
 <20210913234608.GA1381155@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913234608.GA1381155@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 06:46:08PM -0500, Bjorn Helgaas wrote:
 > On Mon, Sep 13, 2021 at 10:18:18AM -0400, Dave Jones wrote:
 > > On Sun, Sep 12, 2021 at 04:58:27PM -0700, Linus Torvalds wrote:
 > >  > So 5.15 isn't shaping up to be a particularly large release, at least
 > >  > in number of commits. At only just over 10k non-merge commits, this is
 > >  > in fact the smallest rc1 we have had in the 5.x series. We're usually
 > >  > hovering in the 12-14k commit range.
 > > 
 > > This release takes over two minutes longer to boot on one my
 > > machines than 5.14.  The time just seems to be unaccounted for, even
 > > with initcall_debug
 > 
 > Sorry for the inconvenience of this, and thank you very much for doing
 > the bisection to track it down.
 > 
 > We *could* revert 7bac54497c3e, but it'd be messy because a bunch of
 > follow-up stuff depends on it.
 > 
 > I propose something like the patch below.  Would you mind trying it
 > out?

This also fixes the problem for me.

	Dave
