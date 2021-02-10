Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33703316031
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhBJHmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 02:42:04 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:57246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231520AbhBJHmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 02:42:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 81F6718010A5F;
        Wed, 10 Feb 2021 07:41:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:6743:7652:7903:9025:9108:10004:10400:10848:11232:11658:11854:11914:12043:12297:12438:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:13845:14181:14659:14721:14819:21080:21324:21611:21627:21889:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trip57_0a1601f2760e
X-Filterd-Recvd-Size: 2373
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 07:41:10 +0000 (UTC)
Message-ID: <715cfa18165f472420496de96a0a08837de2902d.camel@perches.com>
Subject: Re: [PATCH] Documentation: Replace lkml.org links with lore
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 09 Feb 2021 23:41:09 -0800
In-Reply-To: <202102092327.F6D8335A7@keescook>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
         <20200630180917.GA3455699@bjorn-Precision-5520>
         <20200630140417.3a2dba67@lwn.net>
         <77cdb7f32cfb087955bfc3600b86c40bed5d4104.camel@perches.com>
         <202102092327.F6D8335A7@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-02-09 at 23:28 -0800, Kees Cook wrote:
> On Sun, Jan 10, 2021 at 12:41:44PM -0800, Joe Perches wrote:
> > Replace the lkml.org links with lore to better use a single source
> > that's more likely to stay available long-term.
> 
> What's the best way to teach checkpatch about this? I couldn't find the
> right place to do it. (And more generally, can it also suggest https
> over http?)

Bjorn's patch:
https://lore.kernel.org/lkml/20201217235615.43328-1-helgaas@kernel.org/

And my comments:
https://lore.kernel.org/lkml/3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com/

