Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27DA0934
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfH1SDA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 14:03:00 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:36882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbfH1SDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:03:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E2A85181D33FC;
        Wed, 28 Aug 2019 18:02:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:30029:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: loaf11_36e5c8fe5ba4d
X-Filterd-Recvd-Size: 2363
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 18:02:57 +0000 (UTC)
Message-ID: <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
Subject: Re: [PATCH v2] x86/PCI: Add missing log facility and move to use
 pr_ macros in pcbios.c
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:02:55 -0700
In-Reply-To: <20190828175120.22164-1-kw@linux.com>
References: <20190825182557.23260-1-kw@linux.com>
         <20190828175120.22164-1-kw@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-08-28 at 19:51 +0200, Krzysztof Wilczynski wrote:
> Add missing log facility where two instances of printk() that did not
> use any (so it would be using MESSAGE_LOGLEVEL_DEFAULT set in Kconfig)
> to make all the warnings in the arch/x86/pci/pcbios.c to be printed
> consistently at the same log facility.  Also resolve the following
> checkpatch.pl script warning:
> 
> WARNING: printk() should include KERN_<LEVEL> facility level
> 
> While adding the missing log facility move over to using pr_ macros
> over using printk(KERN_<level> ...) and DBG().
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Changes in v2:
>   Change wording and include checkpatch.pl script warning.
>   Leverage pr_fmt and remove "PCI: " prefix used throught.
>   Move to pr_debug() over using DBG() from arch/x86/include/asm/pci_x86.h.

You might also consider the checkpatch output for this patch.

arch/x86/pci/pcbios.c:116: WARNING: line over 80 characters
arch/x86/pci/pcbios.c:116: WARNING: Prefer using '"%s...", __func__' to using 'bios32_service', this function's name, in a string
arch/x86/pci/pcbios.c:119: WARNING: Prefer using '"%s...", __func__' to using 'bios32_service', this function's name, in a string
arch/x86/pci/pcbios.c:391: WARNING: line over 80 characters


