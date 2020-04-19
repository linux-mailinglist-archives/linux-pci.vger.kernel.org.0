Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD31AFC10
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSQib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 12:38:31 -0400
Received: from smtprelay0088.hostedemail.com ([216.40.44.88]:51650 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgDSQib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 12:38:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E2A595836;
        Sun, 19 Apr 2020 16:38:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3874:4250:4321:5007:6737:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bone84_2ca91b5f55455
X-Filterd-Recvd-Size: 2304
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Apr 2020 16:38:26 +0000 (UTC)
Message-ID: <975f3a73bb272b8276687af609cd7e592d6ba9ac.camel@perches.com>
Subject: Re: [PATCH v8 8/8] MAINTAINERS: Add file patterns for rcar PCI
 device tree bindings
From:   Joe Perches <joe@perches.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Date:   Sun, 19 Apr 2020 09:36:11 -0700
In-Reply-To: <1587302823-4435-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <1587302823-4435-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2020-04-19 at 14:27 +0100, Lad Prabhakar wrote:
> Add file pattern entry for rcar PCI devicetree binding, so that when
> people run ./scripts/get_maintainer.pl the rcar PCI maintainers could also
> be listed.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12933,6 +12933,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-renesas-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/*rcar*
> +F:	Documentation/devicetree/bindings/pci/*rcar*

MAINTAINERS was recently sorted for consistency.

Please move this new line above drivers/ to keep alphabetic ordering.


