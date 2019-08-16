Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447FF8F8A4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHPByt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 21:54:49 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:57239 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfHPByt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 21:54:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E40F28368F04;
        Fri, 16 Aug 2019 01:54:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2693:2828:2895:2898:2899:2900:2924:2926:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3871:3872:4321:4605:5007:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:21810:30045:30046:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: rat37_46c176f4ee23b
X-Filterd-Recvd-Size: 2840
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Aug 2019 01:54:46 +0000 (UTC)
Message-ID: <11b7c586136241512668b23656cbc2e088920117.camel@perches.com>
Subject: Re: [PATCH v6 1/9] PCI/ERR: Update error status after reset_link()
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Date:   Thu, 15 Aug 2019 18:54:44 -0700
In-Reply-To: <20190815221629.GI253360@google.com>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <6be594215ae2ea0935d949537bfb84ff9e656a36.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <20190815221629.GI253360@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-08-15 at 17:16 -0500, Bjorn Helgaas wrote:
> On Fri, Jul 26, 2019 at 02:43:11PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> > reset_link() to recover from fatal errors. But, if the reset is
> > successful there is no need to continue the rest of the error recovery
> > checks. Also, during fatal error recovery, if the initial value of error
> > status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> > even after successful recovery (using reset_link()) pcie_do_recovery()
> > will report the recovery result as failure. So update the status of
> > error after reset_link().
[]
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
[]
> > @@ -204,9 +204,13 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> >  	else
> >  		pci_walk_bus(bus, report_normal_detected, &status);
> >  
> > -	if (state == pci_channel_io_frozen &&
> > -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> > -		goto failed;
> > +	if (state == pci_channel_io_frozen) {
> > +		status = reset_link(dev, service);
> > +		if (status != PCI_ERS_RESULT_RECOVERED)
> > +			goto failed;
> > +		else
> > +			goto done;
> 
> This will be easier to read without the negation, i.e.,
> 
>                 if (status == PCI_ERS_RESULT_RECOVERED)
>                         goto done;
>                 else
>                         goto failed;

bikeshed: I think it'd be easier to read without the else

		status = reset_link(dev, service);
		if (status != PCI_ERS_RESULT_RECOVERED)
			goto failed;

		goto done;

