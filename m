Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60084279DED
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 06:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0EZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 00:25:50 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:60954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbgI0EZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 00:25:50 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 00:25:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 1C49018009059
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2020 04:16:37 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C0D3C181D330D;
        Sun, 27 Sep 2020 04:16:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3871:4321:5007:10004:10400:10848:11026:11658:11914:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30045:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cart93_150a0df27176
X-Filterd-Recvd-Size: 1792
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 04:16:33 +0000 (UTC)
Message-ID: <5e22dba6543b4fc09c5c18c839eab42bd31b18f6.camel@perches.com>
Subject: Re: [PATCH 4/5 V2] PCI: only return true when dev io state is
 really changed
From:   Joe Perches <joe@perches.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com
Date:   Sat, 26 Sep 2020 21:16:32 -0700
In-Reply-To: <20200927032829.11321-5-haifeng.zhao@intel.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
         <20200927032829.11321-5-haifeng.zhao@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2020-09-26 at 23:28 -0400, Ethan Zhao wrote:
> simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
[]
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
[]
> @@ -362,35 +362,11 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  	bool changed = false;
[]
> +	if (dev->error_state == new)
> +		return changed;
> +
> +	dev->error_state = new;
> +	changed = true;
>  	return changed;
>  }

This would be simpler removing the unnecessary
changed automatic

...

	if (dev->error_state == new)
		return false;

	dev->error_state = new;

	return true;
}


