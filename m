Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2703201A2B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgFSSSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 14:18:53 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:33684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729580AbgFSSSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2020 14:18:52 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 14:18:52 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 925128112757
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2020 18:09:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DE1461313C2;
        Fri, 19 Jun 2020 18:09:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3876:3877:4321:5007:6114:6642:10004:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30046:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: song67_620abc226e1b
X-Filterd-Recvd-Size: 1591
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 18:09:08 +0000 (UTC)
Message-ID: <a70251985203280662cd0db2de05a9a0b1c5de7d.camel@perches.com>
Subject: Re: [PATCH] pci: pcie: AER: Fix logging of Correctable errors
From:   Joe Perches <joe@perches.com>
To:     Sinan Kaya <okaya@kernel.org>, Matt Jolly <Kangie@footclan.ninja>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 11:09:07 -0700
In-Reply-To: <d611dabd-b943-8492-a29e-0b7fb1980de8@kernel.org>
References: <20200618155511.16009-1-Kangie@footclan.ninja>
         <d611dabd-b943-8492-a29e-0b7fb1980de8@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-06-19 at 13:17 -0400, Sinan Kaya wrote:
> On 6/18/2020 11:55 AM, Matt Jolly wrote:
> 
> > +		pci_warn(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> > +			dev->vendor, dev->device,
> > +			info->status, info->mask);
> > +	} else {
> 
> <snip>
> 
> > +		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> > +			dev->vendor, dev->device,
> > +			info->status, info->mask);
> 
> Function pointers for pci_warn vs. pci_err ?

Not really possible as both are function-like macros.


