Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277B878509
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfG2Gha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 02:37:30 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:49365 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbfG2Gha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 02:37:30 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 02:37:29 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 0DBBC18019A13;
        Mon, 29 Jul 2019 06:31:25 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AC68383777ED;
        Mon, 29 Jul 2019 06:31:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3873:4250:4321:5007:6742:7875:7904:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12296:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21627:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: star39_8018288ec7e4b
X-Filterd-Recvd-Size: 3529
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Jul 2019 06:31:20 +0000 (UTC)
Message-ID: <b0deb4e6b12ea1f943855440a3cc99a6e47d0717.camel@perches.com>
Subject: Re: [EXTERNAL][PATCH 1/5] PCI: Convert pci_resource_to_user to a
 weak function
From:   Joe Perches <joe@perches.com>
To:     Paul Burton <paul.burton@mips.com>,
        Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Jul 2019 23:31:18 -0700
In-Reply-To: <20190728224953.kezztdozc6k24ya3@pburton-laptop>
References: <20190728202213.15550-1-efremov@linux.com>
         <20190728202213.15550-2-efremov@linux.com>
         <20190728224953.kezztdozc6k24ya3@pburton-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-07-28 at 22:49 +0000, Paul Burton wrote:
> Hi Denis,
> 
> On Sun, Jul 28, 2019 at 11:22:09PM +0300, Denis Efremov wrote:
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9e700d9f9f28..1a19d0151b0a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1870,25 +1870,13 @@ static inline const char *pci_name(const struct pci_dev *pdev)
> >  	return dev_name(&pdev->dev);
> >  }
> >  
> > -
> >  /*
> >   * Some archs don't want to expose struct resource to userland as-is
> >   * in sysfs and /proc
> >   */
> > -#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
> > -void pci_resource_to_user(const struct pci_dev *dev, int bar,
> > -			  const struct resource *rsrc,
> > -			  resource_size_t *start, resource_size_t *end);
> > -#else
> > -static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
> > -		const struct resource *rsrc, resource_size_t *start,
> > -		resource_size_t *end)
> > -{
> > -	*start = rsrc->start;
> > -	*end = rsrc->end;
> > -}
> > -#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
> > -
> > +void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
> > +				 const struct resource *rsrc,
> > +				 resource_size_t *start, resource_size_t *end);
> >  
> >  /*
> >   * The world is not perfect and supplies us with broken PCI devices.
> 
> This is wrong - using __weak on the declaration in a header will cause
> the weak attribute to be applied to all implementations too (presuming
> the C files containing the implementations include the header). You then
> get whichever impleentation the linker chooses, which isn't necessarily
> the one you wanted.
> 
> checkpatch.pl should produce an error about this - see the
> WEAK_DECLARATION error introduced in commit 619a908aa334 ("checkpatch:
> add error on use of attribute((weak)) or __weak declarations").

Unfortunately, checkpatch is pretty stupid and only emits
this on single line declarations.


