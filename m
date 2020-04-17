Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024571AE0EF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgDQPVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 11:21:45 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:41826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgDQPVp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 11:21:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 03417100E7B42;
        Fri, 17 Apr 2020 15:21:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3870:3876:4250:4321:5007:6119:7809:10004:10400:10848:11232:11657:11658:11914:12043:12048:12297:12555:12740:12760:12895:13019:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: rat66_8345024049b55
X-Filterd-Recvd-Size: 2028
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 15:21:41 +0000 (UTC)
Message-ID: <ee72cdce1c487f7d0fd089f59fb92422ef2d9396.camel@perches.com>
Subject: Re: [PATCH v3 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI
 J721E SoC PCIe
From:   Joe Perches <joe@perches.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 08:19:29 -0700
In-Reply-To: <20200417125753.13021-15-kishon@ti.com>
References: <20200417125753.13021-1-kishon@ti.com>
         <20200417125753.13021-15-kishon@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-04-17 at 18:27 +0530, Kishon Vijay Abraham I wrote:
> Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12968,13 +12968,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>  F:	drivers/pci/controller/dwc/*designware*
>  
> -PCI DRIVER FOR TI DRA7XX
> +PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>  L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
>  F:	drivers/pci/controller/dwc/pci-dra7xx.c
> +F:	drivers/pci/controller/cadence/pci-j721e.c

Please keep file patterns in alphabetic order by
moving this new cadence line up one line above dwc.



