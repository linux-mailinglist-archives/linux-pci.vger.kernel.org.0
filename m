Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3733A19037
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEISbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 14:31:41 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:48919 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726632AbfEISbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 14:31:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6492A180A8136;
        Thu,  9 May 2019 18:31:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:2900:2904:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3874:4250:4321:4605:5007:6119:7875:9040:10004:10400:10848:11026:11232:11473:11658:11914:12114:12296:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30029:30054:30060:30070:30090:30091,0,RBL:172.58.22.140:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: cable42_65347f630c056
X-Filterd-Recvd-Size: 2443
Received: from XPS-9350 (unknown [172.58.22.140])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 May 2019 18:31:35 +0000 (UTC)
Message-ID: <69ff0a66d8c68f9e1adc8308847541e9566fe23e.camel@perches.com>
Subject: Re: [PATCH 02/10] PCI/PME: Replace dev_printk(KERN_DEBUG) with
 dev_info()
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 09 May 2019 11:31:04 -0700
In-Reply-To: <CAHp75Ve9-659N5N=f7pPb-9amvbGbi+zWxL9p-BnYocvXJPwZg@mail.gmail.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
         <20190509141456.223614-3-helgaas@kernel.org>
         <CAHp75Ve9-659N5N=f7pPb-9amvbGbi+zWxL9p-BnYocvXJPwZg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-05-09 at 20:35 +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
> > consistent with other logging.
> > 
> > These could be converted to dev_dbg(), but that depends on
> > CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
> > *always* be in the dmesg log.
> > 
> > Also, use dev_fmt() to add the service name.  Example output change:
> > 
> >   - pcieport 0000:80:10.0: Signaling PME with IRQ ...
> >   + pcieport 0000:80:10.0: PME: Signaling with IRQ ...
> > +               pci_info(port, "interrupt generated for non-existent device %02x:%02x.%d\n",
> 
> Can we be slightly more consistent here, i.e. start from Capital letter?
> 
> > +                        busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
> > +               pci_info(port, "Spurious native interrupt!\n");
> > +       pci_info(port, "Signaling with IRQ %d\n", srv->irq);

Why change the logging level?
Why not use #define DEBUG and use pci_dbg ?


