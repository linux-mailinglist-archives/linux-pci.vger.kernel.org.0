Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBD669C87
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfGOUTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 16:19:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38709 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOUTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 16:19:47 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so3959766ioa.5;
        Mon, 15 Jul 2019 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkjE725QSqZ4dkFuLoG+vA0yMkAoWN7O9RSUdzsebsc=;
        b=h8MO4MUVIlQqTnfR5Og+DaigKE2QgHB8OsqEZw8GjXFMzJ/FJQCV+1xWDxZ2LZRMzo
         2T1jGJBMnmVUK38ku38iUns/aLbXXSTtIHZom49OfBN/8dnw1dITnpC1OozlyJcY81WA
         BLthifxP3ltY85Zu8uJQ+h/quShsxKtyqlo8T2pOzIQa0sn46Ac66NZVMiwmecH7zLez
         Moh0xTGk/ZaFP711woaccognXfrXgd/9pov2cdIHEA9Wh5GsEFRBhCwNgguytGKVFYJ8
         klQsX0w5fpXTUHx7gmbpvAp1uZdr2y0Z8PS6MG2a0DPsArDmVPwqJHX0Csq2Z7h08mF/
         +Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkjE725QSqZ4dkFuLoG+vA0yMkAoWN7O9RSUdzsebsc=;
        b=agu2IlEDcK56PMqXIxdJxRzOPVYsDpO1AGX/rrXPQEhQ1CKZ8weSwu5tf2JDfAtKuC
         lOaRR2+JeHlXRcEuplwUXbKFkCyh9FR8zH70JexhNbh9vD1aHiUy1yBpFAki4COOHO5P
         G1m1pFZ22IzG0nhNEZ8NF2ZqREMbjFvK05nXby0XsWJ/uT2CktyNSz1FeDhqDy3oLHNB
         gJ96KZmlQV51PR1hjjo3fnB7eWbufcA4nTKijxvwiSd9e2NxOdmqH1g+Uo0s4cNEWO4k
         iaEfsccWylciI+YOEx7CXW+1F91a2jLO32WMJPKDJTCeGn6ct4m8s2/hs8KkuKF3n/Xi
         WGmA==
X-Gm-Message-State: APjAAAWjDnAiqadNuL5E7v+aBT08kPxP63OBTwwCvMDUJ+EYDPbGHSMt
        tAuA4azn13wmQdLI+Xa8V5I=
X-Google-Smtp-Source: APXvYqy2BPjk2wmAORUmSWSTU02Mv8tX0obRF21Uk45mkpTezjtN1swrS8vDTh6dSs3jRqMqxp5rQg==
X-Received: by 2002:a05:6638:52:: with SMTP id a18mr30286329jap.75.1563221986160;
        Mon, 15 Jul 2019 13:19:46 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id d25sm17710468iom.52.2019.07.15.13.19.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:19:45 -0700 (PDT)
Date:   Mon, 15 Jul 2019 14:19:44 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: Remove functions not
 called in include/linux/pci.h
Message-ID: <20190715201944.GA36316@JATN>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
 <20190715181312.31403-1-skunberg.kelsey@gmail.com>
 <alpine.DEB.2.21.1907152138120.2564@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907152138120.2564@felia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 09:42:47PM +0200, Lukas Bulwahn wrote:
> 
> 
> On Mon, 15 Jul 2019, Kelsey Skunberg wrote:
> 
> > Remove the following uncalled functions from include/linux/pci.h:
> > 
> >         pci_block_cfg_access()
> >         pci_block_cfg_access_in_atomic()
> >         pci_unblock_cfg_access()
> > 
> > Functions were added in patch fb51ccbf217c "PCI: Rework config space
> > blocking services", though no callers were added. Code continues to be
> > unused and should be removed.
> > 
> > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > ---
> > 
> 
> Nice finding. How did you discover this issue? Did you use a tool to find 
> this ununsed code or stumble over it during your code review?
>
Stumbled upon it while reviewing include/linux/pci.h to see what
could be moved to drivers/pci/pci.h.
 
> Also note that commits are referred to with this format:
> 
> commit <12-character sha prefix> ("<commit message>")
>
> So, you need to change patch to commit and include brackets around your
> quoted commit message.
> 
> Lukas

Thank you for letting me know and reviewing! I will update this now.

-Kelsey

> 
> > Changes since v1:
> >   - Fixed Signed-off-by line to show full name
> > 
> >  include/linux/pci.h | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index cf380544c700..3c9ba6133bea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1656,11 +1656,6 @@ static inline void pci_release_regions(struct pci_dev *dev) { }
> >  
> >  static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
> >  
> > -static inline void pci_block_cfg_access(struct pci_dev *dev) { }
> > -static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
> > -{ return 0; }
> > -static inline void pci_unblock_cfg_access(struct pci_dev *dev) { }
> > -
> >  static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
> >  { return NULL; }
> >  static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
> > 
