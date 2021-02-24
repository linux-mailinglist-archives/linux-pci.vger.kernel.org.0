Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DBF324718
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 23:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBXWqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 17:46:44 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37764 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhBXWqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 17:46:44 -0500
Received: by mail-lj1-f175.google.com with SMTP id q14so4338138ljp.4
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2021 14:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEOeOF+dyL+70GRUxvvCG6gksJHyaUSPb9h5Wo2G58U=;
        b=ig+3ZvL8WUtCdkmSiBedxF2pkOClIsIGZjY/H90c5a/bddpPRqHD0AJ7UPj7DMBjpz
         /UgJvY67ZR5l2nOZaZpZjSf5L50MMrwUjv0QteOjeolvwTqe+1+GSK74ZN6U43oFEVzK
         H8R9u/tMj4bo8TioaY48hVMA4rEmw9M6saL/GPGCOFKndZ7SderMrSAqfqRegVq0MfDZ
         mW2ihzx+o5dwgDPoHgx1wEnF3tHmxgFi1bla5VpqoCLmJTL9iRfLjmlsOTlaT86qIEmh
         Kdmt8U9EbqZL63VXc8S0kXNGq/dcAetfVZxTbdPNyrYhP8FeVfXlMXi/ugIcxFuJyC70
         7qcg==
X-Gm-Message-State: AOAM5339JGLPnePzmc2efKFuCcU5hRo6a1Xkr2cCjKFFIhTcIBW93Whm
        TVp0kLxmjnMesYd1wd9y0qFzQe0IlAXflw==
X-Google-Smtp-Source: ABdhPJyEFJ/ds1+PxUzNKSx7F9AwR3WLm6uUMeK6/cOVmxhyAVpWM6aLitnu0MDCOTL6ruiNBJmVUA==
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr26835lju.460.1614206761780;
        Wed, 24 Feb 2021 14:46:01 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c11sm750739lfb.104.2021.02.24.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 14:46:01 -0800 (PST)
Date:   Wed, 24 Feb 2021 23:46:00 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <YDbXKHB31nz+tKjR@rocinante>
References: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
 <YCloAA+od1WIo7o3@rocinante>
 <20210215132220.GA32476@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215132220.GA32476@localhost.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Minwoo,

Sorry for a very late reply!

[...]
> > You might need to improve the subject a little - it should be brief but
> > still informative.
> > 
> > > __pci_set_mater() has debug log in there so that it would be better to
> > > take this function.  So take __pci_set_master() function rather than
> > > open coding it.  This patch didn't move __pci_set_master() to above to
> > > avoid churns.
> > [...]
> > 
> > It would be __pci_set_master() in the sentence above.  Also, perhaps
> > "use" would be better than "take".  Generally, this commit message might
> > need a little improvement to be more clear why are you do doing this.
> 
> Sure, if we consolidate bus master enable clear functions to a single
> one, it would be better to debug and tracing the kernel behaviors.
> 
> Let me describe this 'why' to the description.

Sounds great!  Thank you!

[...]
> > You could use pci_clear_master(), which we export and that internally
> > calls __pci_set_master(), so there would be no need to add any forward
> > declarations or to move anything around in the file.
> 
> Moving delcaration to above might be churn, and I agree with your point.

I am sure that when it makes sense, then probably folks would not
object, especially since "churn" can be subjective.

> > Having said that, there is a difference between do_pci_disable_device()
> > and how __pci_set_master() works - the latter sets the is_busmaster flag
> > accordingly on the given device whereas the former does not.  This might
> > be of some significance - not sure if we should or should not set this,
> > since the do_pci_disable_device() does not do that (perhaps it's on
> > purpose or due to some hisoric reasons).
> 
> Thanks for pointing out this.  I think the difference about
> `is_busmaster` flag looks like it should not be cleared in case of power
> suspend case:
> 
> 	# Suspend
> 	pci_pm_default_suspend()
> 		pci_disable_enabled_device()
> 
> 	# Resume
> 	pci_pm_reenable_device()
> 		pci_set_master()  <-- This is based on (is_busmaster)
> 
> 
> Please let me know if I'm missing here, and appreciate pointing that
> out.  Maybe I can post v2 patch with add an argument of whether
> `is_busmaster` shoud be set inside of the function or not to
> __pci_set_master()?
[...]

Nothing is ever simple, isn't it? :-)

We definitely need to make sure that PM can keep relying on the
is_busmaster flag to restore bus mastering to previous state after the
device would resume after being suspended.

If we add another boolean argument, then we would need to update the
__pci_set_master() only in two other places, aside of using it in the
do_pci_disable_device() function, as per (as of 5.11.1 kernel):

  File              Line Content
  drivers/pci/pci.c 4308 __pci_set_master(dev, true);
  drivers/pci/pci.c 4319 __pci_set_master(dev, false);

This is not all that terrible, provided that we _really_ do want to
change this function signature and then add another condition inside.

What do you think?  If you still like the idea, then send second version
over with all the other proposed changes.

Krzysztof
