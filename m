Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF1AC9C
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELOWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 10:22:18 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:59433 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfELOWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 10:22:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 86C44182CF666;
        Sun, 12 May 2019 14:22:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3871:3872:4250:4321:5007:6119:6120:7514:7809:8957:10004:10400:10848:11232:11658:11914:12043:12114:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21433:21451:21619:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: skin28_8819c53057e61
X-Filterd-Recvd-Size: 1760
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 May 2019 14:22:15 +0000 (UTC)
Message-ID: <d00c1c42689e08df0ce7cd8b2c796eee5b9f5642.camel@perches.com>
Subject: Re: [PATCH v4 07/12] Documentation: PCI: convert
 pci-error-recovery.txt to reST
From:   Joe Perches <joe@perches.com>
To:     Changbin Du <changbin.du@gmail.com>, bhelgaas@google.com,
        corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org
Date:   Sun, 12 May 2019 07:22:13 -0700
In-Reply-To: <20190512125009.32079-8-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
         <20190512125009.32079-8-changbin.du@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-05-12 at 20:50 +0800, Changbin Du wrote:
> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -12100,7 +12100,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
>  M:	Oliver O'Halloran <oohall@gmail.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> -F:	Documentation/PCI/pci-error-recovery.txt
> +F:	Documentation/PCI/pci-error-recovery.rst
>  F:	drivers/pci/pcie/aer.c
>  F:	drivers/pci/pcie/dpc.c
>  F:	drivers/pci/pcie/err.c

There is another section to update as well:

PCI ERROR RECOVERY
M:	Linas Vepstas <linasvepstas@gmail.com>
L:	linux-pci@vger.kernel.org
S:	Supported
F:	Documentation/PCI/pci-error-recovery.txt


