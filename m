Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C032D2AC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhCDMMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 07:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240310AbhCDMMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 07:12:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33A82601FC;
        Thu,  4 Mar 2021 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614859905;
        bh=vQ8RnpXMyqA61QBx4SeK5jkq5GWFtLLQnjzD5WHRFUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WGv7sU7rfZzH64peIaO7rg4Jhprp4fTHooeeqwB7MvvIbDCUFUqLsssKcEzAy2asf
         IQA0W6YCSRtjZ9fpiQ1rO0ljPzvEbzwmnSagvPT8lqh/jIv5woXp/OUGNo5TG+Gwnl
         JBZv2FZ2uA6y/nLQRB37PPqy+RyWBL0UoQptqjj+6AP+9qSW/ehe3UUegF0j9PMCKZ
         deaGQuOfONy+bnMcLK1aesg9XDpmH46WUSNzTv9HvImlelofdJbNKAtu2bRjVzTRre
         aNAdPybW7uGjkVudBrKzPyiWWndXlGHA0sw/Ymrwh60xOPccCFgWzXX6hc80Vi0ASD
         00dLbga6mns8g==
Date:   Thu, 4 Mar 2021 06:11:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <20210304121143.GA821086@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304044013.GA15757@localhost.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 04, 2021 at 01:40:13PM +0900, Minwoo Im wrote:
> On 21-02-24 23:46:00, Krzysztof Wilczyński wrote:
> > Hi Minwoo,
> > 
> > Sorry for a very late reply!
> > 
> > [...]
> > > > You might need to improve the subject a little - it should be brief but
> > > > still informative.
> > > > 
> > > > > __pci_set_mater() has debug log in there so that it would be better to
> > > > > take this function.  So take __pci_set_master() function rather than
> > > > > open coding it.  This patch didn't move __pci_set_master() to above to
> > > > > avoid churns.
> > > > [...]
> > > > 
> > > > It would be __pci_set_master() in the sentence above.  Also, perhaps
> > > > "use" would be better than "take".  Generally, this commit message might
> > > > need a little improvement to be more clear why are you do doing this.
> > > 
> > > Sure, if we consolidate bus master enable clear functions to a single
> > > one, it would be better to debug and tracing the kernel behaviors.
> > > 
> > > Let me describe this 'why' to the description.
> > 
> > Sounds great!  Thank you!
> > 
> > [...]
> > > > You could use pci_clear_master(), which we export and that internally
> > > > calls __pci_set_master(), so there would be no need to add any forward
> > > > declarations or to move anything around in the file.
> > > 
> > > Moving delcaration to above might be churn, and I agree with your point.
> > 
> > I am sure that when it makes sense, then probably folks would not
> > object, especially since "churn" can be subjective.
> > 
> > > > Having said that, there is a difference between do_pci_disable_device()
> > > > and how __pci_set_master() works - the latter sets the is_busmaster flag
> > > > accordingly on the given device whereas the former does not.  This might
> > > > be of some significance - not sure if we should or should not set this,
> > > > since the do_pci_disable_device() does not do that (perhaps it's on
> > > > purpose or due to some hisoric reasons).
> > > 
> > > Thanks for pointing out this.  I think the difference about
> > > `is_busmaster` flag looks like it should not be cleared in case of power
> > > suspend case:
> > > 
> > > 	# Suspend
> > > 	pci_pm_default_suspend()
> > > 		pci_disable_enabled_device()
> > > 
> > > 	# Resume
> > > 	pci_pm_reenable_device()
> > > 		pci_set_master()  <-- This is based on (is_busmaster)
> > > 
> > > 
> > > Please let me know if I'm missing here, and appreciate pointing that
> > > out.  Maybe I can post v2 patch with add an argument of whether
> > > `is_busmaster` shoud be set inside of the function or not to
> > > __pci_set_master()?
> > [...]
> > 
> > Nothing is ever simple, isn't it? :-)
> > 
> > We definitely need to make sure that PM can keep relying on the
> > is_busmaster flag to restore bus mastering to previous state after the
> > device would resume after being suspended.
> 
> Yes,
> 
> > If we add another boolean argument, then we would need to update the
> > __pci_set_master() only in two other places, aside of using it in the
> > do_pci_disable_device() function, as per (as of 5.11.1 kernel):
> 
> I agree with this approach.  I can try it by adding another bool
> argument to decide whether to update the is_busmaster flag or not inside
> of the __pci_set_master.
> 
> > 
> >   File              Line Content
> >   drivers/pci/pci.c 4308 __pci_set_master(dev, true);
> >   drivers/pci/pci.c 4319 __pci_set_master(dev, false);
> > 
> > This is not all that terrible, provided that we _really_ do want to
> > change this function signature and then add another condition inside.
> > 
> > What do you think?  If you still like the idea, then send second version
> > over with all the other proposed changes.
> 
> Let me prepare the next version of this patch. Thanks!

Can you clarify what the purpose of this patch is?  Is it to fix a
defect, improve debug output, make the code cleaner, etc?

The commit log really just describes *what* the patch does, and I'm
looking for the *why*.

Bjorn
