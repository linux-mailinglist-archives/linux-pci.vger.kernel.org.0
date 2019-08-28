Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E55A09D0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1SnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:43:14 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:42354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbfH1SnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:43:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 128C5181D33FB;
        Wed, 28 Aug 2019 18:43:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2900:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:8828:10004:10400:10848:11232:11658:11914:12043:12296:12297:12663:12740:12760:12895:13069:13255:13311:13357:13439:14180:14659:14721:21063:21080:21433:21451:21627:21795:30003:30029:30051:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: turn77_73231392da913
X-Filterd-Recvd-Size: 2909
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 18:43:11 +0000 (UTC)
Message-ID: <082d21ef9effc015de671ff51d689dab740cea16.camel@perches.com>
Subject: Re: [PATCH v2] x86/PCI: Add missing log facility and move to use
 pr_ macros in pcbios.c
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Wilczynski <kswilczynski@gmail.com>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:43:09 -0700
In-Reply-To: <1567017627.3507.0@gmail.com>
References: <20190825182557.23260-1-kw@linux.com>
         <20190828175120.22164-1-kw@linux.com>
         <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
         <1567017627.3507.0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-08-28 at 20:40 +0200, Krzysztof Wilczynski wrote:
> Hello Joe,
> 
> Thank you for feedback.
> [...]
> > >    Move to pr_debug() over using DBG() from 
> > > arch/x86/include/asm/pci_x86.h.
> > 
> > You might also consider the checkpatch output for this patch.
> > 
> > arch/x86/pci/pcbios.c:116: WARNING: line over 80 characters
> > arch/x86/pci/pcbios.c:116: WARNING: Prefer using '"%s...", __func__' 
> > to using 'bios32_service', this function's name, in a string
> > arch/x86/pci/pcbios.c:119: WARNING: Prefer using '"%s...", __func__' 
> > to using 'bios32_service', this function's name, in a string
> > arch/x86/pci/pcbios.c:391: WARNING: line over 80 characters
> 
> Good point.
> 
> The lines over 80 characters wide would be taken care of when
> moving to using the pr_ macros as the line length will now be
> shorter contrary to when the e.g., printk(KERNEL_INFO ...),
> etc., was used.

Not really, those were the warnings checkpatch
emits on your actual patch.

> The other warnings I am going to address in v3.  I was thinking
> of replacing the following:
> 
> pr_warn("bios32_service(0x%lx): not present\n", service);
> 
> With something that looks like this:
> 
> pr_warn("BIOS32 Service(0x%lx): not present\n", service);
> 
> Using "bios32_service" name directly or even moving to __func__
> feels a lot like an implementation detail is exposed to the
> end user.  I am not sure how useful that could be.  Also,
> we are already using log lines starting with "BIOS32", thus
> it seemed like following them would be the most sensible
> choice, especially to keep messages consistent.
> 
> What do you think?

Fine with me, your patch, your choices.


