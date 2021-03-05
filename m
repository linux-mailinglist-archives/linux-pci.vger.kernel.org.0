Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC332E158
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 06:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCEFR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 00:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCEFRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 00:17:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A3C061574
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 21:17:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so778109plm.11
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 21:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uSrdnkV09lTxG+R7vQpH6L1VvRfYR70ruw7SEzHASnM=;
        b=ZaPVd5akbCMUMuPKO4M62UBbcP/k0UW2rylGFGwh3yE8fpTsH54uHtz3NGZmkhFlzC
         WnWfmVJ8zuDKzes6tRevN16C99ak2tr0LQSt5inf98u1aImf1krM8Ra6CdbTm5trjsrd
         qFbe8Cv2P2lkXnU0uNC/PIAtw+IOwlxp4JzA2QSmzmt4649Rx/tzQ+ubNUh/K8T51cIZ
         8NTyzfU9DM+FQKYhrJwVjJpJrj3Oi0E1OGsOcbU4H3wgYGTCaKh4Gq+lyqBCAc6iXZ9e
         Sk/RzRHQMYnbLFKKDPKENvYmNP/6gL4m/P0Y3dLiP3ctSXSop3uImMhwvnMGT1UjUCzF
         K8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uSrdnkV09lTxG+R7vQpH6L1VvRfYR70ruw7SEzHASnM=;
        b=KPJzz8638DlBj7RfysCk0SGePhU12sAqtjkLoHXfuxiHPhs8+0nuZ2y686OCVwWzFw
         g6TgwvjmcQLTa3NcEngNXaiD+IlxTukaq+Va6gmtxFeT+/rVM0fFrmh3LOCO04Xgm7RF
         CY7D8FXGgrAasn1dOL7BrB2lf+/etew4EcygE9br7V89E4wdPj3iGTyNwb+yrLd++AWi
         XYQ9DMD0884+C6iEBOCMST1tZDUaTZp5XZLNBsn66mmXcRuP6DqR8roPR9ij8eUA94T+
         WPQa+EzNqvwobMqahmccnuHMZe6mhskDNw1zBdz1ruiLJ7u7O/oHjWroFJutmzCrsb9k
         b39w==
X-Gm-Message-State: AOAM5330k4xagA4PL4QaD6bNaYPbvxfqpyc12X+iaV3dkewYSqV3TnQq
        88eIzbPhhwNiTbWedr8t3AiIzgtml/KDOw==
X-Google-Smtp-Source: ABdhPJwE1QSa6JvKxFSr8tuXNoaJxifu7iNzJaUB/YTefI+iwZYytL2LfQ0jOtkXg3HsAZXofpOLyw==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr8784615pjl.8.1614921468816;
        Thu, 04 Mar 2021 21:17:48 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id 21sm953310pfo.167.2021.03.04.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 21:17:48 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:17:46 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <20210305051746.GA4744@localhost.localdomain>
References: <20210304044013.GA15757@localhost.localdomain>
 <20210304121143.GA821086@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210304121143.GA821086@bjorn-Precision-5520>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-03-04 06:11:43, Bjorn Helgaas wrote:
> On Thu, Mar 04, 2021 at 01:40:13PM +0900, Minwoo Im wrote:
> > On 21-02-24 23:46:00, Krzysztof Wilczyński wrote:
> > > Hi Minwoo,
> > > 
> > > Sorry for a very late reply!
> > > 
> > > [...]
> > > > > You might need to improve the subject a little - it should be brief but
> > > > > still informative.
> > > > > 
> > > > > > __pci_set_mater() has debug log in there so that it would be better to
> > > > > > take this function.  So take __pci_set_master() function rather than
> > > > > > open coding it.  This patch didn't move __pci_set_master() to above to
> > > > > > avoid churns.
> > > > > [...]
> > > > > 
> > > > > It would be __pci_set_master() in the sentence above.  Also, perhaps
> > > > > "use" would be better than "take".  Generally, this commit message might
> > > > > need a little improvement to be more clear why are you do doing this.
> > > > 
> > > > Sure, if we consolidate bus master enable clear functions to a single
> > > > one, it would be better to debug and tracing the kernel behaviors.
> > > > 
> > > > Let me describe this 'why' to the description.
> > > 
> > > Sounds great!  Thank you!
> > > 
> > > [...]
> > > > > You could use pci_clear_master(), which we export and that internally
> > > > > calls __pci_set_master(), so there would be no need to add any forward
> > > > > declarations or to move anything around in the file.
> > > > 
> > > > Moving delcaration to above might be churn, and I agree with your point.
> > > 
> > > I am sure that when it makes sense, then probably folks would not
> > > object, especially since "churn" can be subjective.
> > > 
> > > > > Having said that, there is a difference between do_pci_disable_device()
> > > > > and how __pci_set_master() works - the latter sets the is_busmaster flag
> > > > > accordingly on the given device whereas the former does not.  This might
> > > > > be of some significance - not sure if we should or should not set this,
> > > > > since the do_pci_disable_device() does not do that (perhaps it's on
> > > > > purpose or due to some hisoric reasons).
> > > > 
> > > > Thanks for pointing out this.  I think the difference about
> > > > `is_busmaster` flag looks like it should not be cleared in case of power
> > > > suspend case:
> > > > 
> > > > 	# Suspend
> > > > 	pci_pm_default_suspend()
> > > > 		pci_disable_enabled_device()
> > > > 
> > > > 	# Resume
> > > > 	pci_pm_reenable_device()
> > > > 		pci_set_master()  <-- This is based on (is_busmaster)
> > > > 
> > > > 
> > > > Please let me know if I'm missing here, and appreciate pointing that
> > > > out.  Maybe I can post v2 patch with add an argument of whether
> > > > `is_busmaster` shoud be set inside of the function or not to
> > > > __pci_set_master()?
> > > [...]
> > > 
> > > Nothing is ever simple, isn't it? :-)
> > > 
> > > We definitely need to make sure that PM can keep relying on the
> > > is_busmaster flag to restore bus mastering to previous state after the
> > > device would resume after being suspended.
> > 
> > Yes,
> > 
> > > If we add another boolean argument, then we would need to update the
> > > __pci_set_master() only in two other places, aside of using it in the
> > > do_pci_disable_device() function, as per (as of 5.11.1 kernel):
> > 
> > I agree with this approach.  I can try it by adding another bool
> > argument to decide whether to update the is_busmaster flag or not inside
> > of the __pci_set_master.
> > 
> > > 
> > >   File              Line Content
> > >   drivers/pci/pci.c 4308 __pci_set_master(dev, true);
> > >   drivers/pci/pci.c 4319 __pci_set_master(dev, false);
> > > 
> > > This is not all that terrible, provided that we _really_ do want to
> > > change this function signature and then add another condition inside.
> > > 
> > > What do you think?  If you still like the idea, then send second version
> > > over with all the other proposed changes.
> > 
> > Let me prepare the next version of this patch. Thanks!
> 
> Can you clarify what the purpose of this patch is?  Is it to fix a
> defect, improve debug output, make the code cleaner, etc?
>
> The commit log really just describes *what* the patch does, and I'm
> looking for the *why*.

I should have described why this patch is introdcued.
do_pci_disable_device clears the Bus Master Enable bit just like what
__pci_set_master does which is kind of duplications.  Also,
__pci_set_master has debug print log which is useful for users to figure
out whether bus master is set or cleared.  This patch makes
do_pci_disable_device call __pci_set_master to take the debug log
advantages and make code cleaner by clearing duplicated codes.

> Bjorn
