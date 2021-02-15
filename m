Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7657E31BA3E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 14:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBONXS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 08:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhBONXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2021 08:23:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2DC061574
        for <linux-pci@vger.kernel.org>; Mon, 15 Feb 2021 05:22:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so4156031pfj.12
        for <linux-pci@vger.kernel.org>; Mon, 15 Feb 2021 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cVa4UWhNLS0JD5TjgxGrob0bVVV3HO6nh5aceAXkKRs=;
        b=YzLH+JnwqSpKFPWzMFDwQCjyQWFbkEaot2ssFQKnzqQF0W8BKYDQHQ6H2GqMiMlf5w
         +RhGi58Ud9WFHdzsM3DKQlEQL7dxCeFh/dQcaKWgxdxaHljF3FMmFMGY+YqcLfmcZFG8
         X91FjcznMNxr91a0Ff1YYjRdfTSFVajR79FUr0u17Ca9mR4rEOXDAXOeBKjVkUyEJ8tc
         SZvLBb/2EOQ9P5ADHRoXlpclG3JSuifYHPbZmEIpR3ahj3B5iWkLx3RWUHllNGCnrecl
         ilLy3K5uPCl+K78Pyl1trzlmL+/DgwqxsfwxMGF3r13k4Vkoa++SOH9lcj5QBUEosFZh
         5eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cVa4UWhNLS0JD5TjgxGrob0bVVV3HO6nh5aceAXkKRs=;
        b=Eg+p4QJApBBVa/oLsr7A5bfHOqIP4nL9gDDlFBFSMPvjzSYdta8WWpFBIaOSd25Ulc
         uwaKB9VcZK5jnbhcFykAHxgnSR1TdSIW8Khh5KoxMBvMxW3NNJ8Y5Z6IyBvpT3GrbqlC
         uM3eHyXIKyO9YXYS9j/wg3jNlWTWMyIiVYSUIKDa2cuqFOR0ZXty1oEeq1nfl3/RT16t
         LnWcxTNM56J5NSQfRM33VAYBbiGoy9PFEv/ToCpwkd/LgNL/KN2CETqcE9z9dXOAzQR7
         JhaBaT1d/XgKi38Xmx+LW3FNtbFWvdDRw0Z+hodB7MwvvoTLfZnTY37KwO6uI+R8LW78
         CSPA==
X-Gm-Message-State: AOAM532EJlO8yg+gDDZI9GH1C7J7rlwZpHnF3bMCD7fGmha0mU5er+4J
        VHAe+fJ2Fg2DQreRWd92Ay0=
X-Google-Smtp-Source: ABdhPJznEU0O9DwVmiO7QF+h0LYsQJF/xCr7/NoXxPifsmdFfKT9e43DYvRG+UD7Z6JLP5xAvGsQIw==
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id h22-20020a62b4160000b02901e4fb5a55bbmr14911469pfn.80.1613395342589;
        Mon, 15 Feb 2021 05:22:22 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id m23sm17008270pgv.14.2021.02.15.05.22.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 05:22:22 -0800 (PST)
Date:   Mon, 15 Feb 2021 22:22:20 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <20210215132220.GA32476@localhost.localdomain>
References: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
 <YCloAA+od1WIo7o3@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCloAA+od1WIo7o3@rocinante>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-14 19:12:16, Krzysztof Wilczyński wrote:
> Hi Minwoo,
> 
> Thank you for sending the patch over!
> 
> You might need to improve the subject a little - it should be brief but
> still informative.
> 
> > __pci_set_mater() has debug log in there so that it would be better to
> > take this function.  So take __pci_set_master() function rather than
> > open coding it.  This patch didn't move __pci_set_master() to above to
> > avoid churns.
> [...]
> 
> It would be __pci_set_master() int he sentence above.  Also, perhaps
> "use" would be better than "take".  Generally, this commit message might
> need a little improvement to be more clear why are you do doing this.

Sure, if we consolidate bus master enable clear functions to a single
one, it would be better to debug and tracing the kernel behaviors.

Let me describe this 'why' to the description.

> 
> [...]
> > +static void __pci_set_master(struct pci_dev *dev, bool enable);
> >  static void do_pci_disable_device(struct pci_dev *dev)
> >  {
> > -	u16 pci_command;
> > -
> > -	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> > -	if (pci_command & PCI_COMMAND_MASTER) {
> > -		pci_command &= ~PCI_COMMAND_MASTER;
> > -		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> > -	}
> > +	__pci_set_master(dev, false);
> >  
> >  	pcibios_disable_device(dev);
> >  }
> 
> You could use pci_clear_master(), which we export and that internally
> calls __pci_set_master(), so there would be no need to add any forward
> declarations or to move anything around in the file.

Moving delcaration to above might be churn, and I agree with your point.

> Having said that, there is a difference between do_pci_disable_device()
> and how __pci_set_master() works - the latter sets the is_busmaster flag
> accordingly on the given device whereas the former does not.  This might
> be of some significance - not sure if we should or should not set this,
> since the do_pci_disable_device() does not do that (perhaps it's on
> purpose or due to some hisoric reasons).

Thanks for pointing out this.  I think the difference about
`is_busmaster` flag looks like it should not be cleared in case of power
suspend case:

	# Suspend
	pci_pm_default_suspend()
		pci_disable_enabled_device()

	# Resume
	pci_pm_reenable_device()
		pci_set_master()  <-- This is based on (is_busmaster)


Please let me know if I'm missing here, and appreciate pointing that
out.  Maybe I can post v2 patch with add an argument of whether
`is_busmaster` shoud be set inside of the function or not to
__pci_set_master()?  pci_clear_master() has already been exported so
that adding an argument here might be a churn :)

Thanks!

> Krzysztof
