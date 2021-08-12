Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1023EA32F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhHLK4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhHLK4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 06:56:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C9C061765;
        Thu, 12 Aug 2021 03:55:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e19so6748921pla.10;
        Thu, 12 Aug 2021 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eq9Xh1F7xdY3qhY4IzprUVHF5yW7bLehYY5/rO8uEeA=;
        b=GJOkBGonE+ybwwOlKpANl+y0qg5PXXeou55G7E5sGB25X97XoOQ54LoA0xAFS2XrFC
         kY2LA0BtFa1QII2X6O8kmiuleMpLKt7ZG+ABldp3wLqx7gDKO+IOg+TwxZ5fz9zm2GU/
         rpGNu1dVjC115xDXeTe3zAKYLpHiySWQod3s4pcIBxvaeoq/DB7rjcgVcDhsFAuFk4UA
         ix0yacAO1vOLUllzUvR4aRHLEgW9bFxzz6tYtqRrEpQXizwYkW+/uw+ygQvsC6W7Mkd6
         ACo1KAebCYYIcgxHraY6s1qTf8mhVDcroXpkRvK2EwWTNJzdYPXYVcEbtbYxlge/7dsJ
         LdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eq9Xh1F7xdY3qhY4IzprUVHF5yW7bLehYY5/rO8uEeA=;
        b=rDzlDexZZbX9Kag22EzlCuFPgpjNaF2/Ivo6B2Wl7kQTyZyu+zcoNUGob4jSFbL9at
         tEcT9g4ao6fjVfwm26hCAPsqCwM8pn+DD2B91Y+b8bStQQ7tx7Of91j007PKjS5fHdJg
         kwaQJ/q1pvq3OwaIjtPJSeh2dJsXTEasDTcb230iB0ua2wP2fHG3j7f/qr3SOuxwmcrQ
         3A0HPZtkkbkhREc9ugr9Wctb1KM1bAlqNwByIkqkkjj4wgBIBFI2clICLVRaTREEJflG
         DrPdzbvk3fw5oshyPNQ/zPS7KwlKMOmi07YlCzcgCVnth7V3LkY9DoIMPeCZyiyCADbv
         R36Q==
X-Gm-Message-State: AOAM531/9iMYIKtNP0knIDGPJRofGpu54HernopKOz0laPymxxGKPxAG
        npTFi/IX0ddPUCVRjNColnwgFUa+Ze/Xs4fL5hA=
X-Google-Smtp-Source: ABdhPJyb+lVLZvTwmpYzxubeLGi3KVZEZfje3QngJArxyahIJNOVk58p4KTNvs4FIxI9O7eornU8xA==
X-Received: by 2002:a17:902:bf48:b0:12d:8409:48ca with SMTP id u8-20020a170902bf4800b0012d840948camr680721pls.9.1628765749254;
        Thu, 12 Aug 2021 03:55:49 -0700 (PDT)
Received: from uver-laptop ([2405:201:6006:a148:da50:248a:1651:e22d])
        by smtp.gmail.com with ESMTPSA id j5sm3219757pgg.41.2021.08.12.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:55:48 -0700 (PDT)
Date:   Thu, 12 Aug 2021 16:25:37 +0530
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] PCI: Remove duplicate #ifdef in pci_try_set_mwi()
Message-ID: <20210812105537.GA9541@uver-laptop>
References: <20210811234601.341947-1-utkarshverma294@gmail.com>
 <YRTEcd0S2/2XlL7p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRTEcd0S2/2XlL7p@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 08:49:21AM +0200, Greg KH wrote:
> On Thu, Aug 12, 2021 at 05:16:01AM +0530, Utkarsh Verma wrote:
> > Remove the unnecessary #ifdef PCI_DISABLE_MWI, because pci_set_mwi()
> > performs the same check.
> > 
> > Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> > ---
> >  drivers/pci/pci.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index aacf575c15cf..7d4c7c294ef2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4456,11 +4456,7 @@ EXPORT_SYMBOL(pcim_set_mwi);
> >   */
> >  int pci_try_set_mwi(struct pci_dev *dev)
> >  {
> > -#ifdef PCI_DISABLE_MWI
> > -	return 0;
> > -#else
> >  	return pci_set_mwi(dev);
> > -#endif
> >  }
> >  EXPORT_SYMBOL(pci_try_set_mwi);
> 
> If this is the case, why do we even need pci_try_set_mwi()?  Why not
> just replace it with calls to pci_set_mwi() and then delete this one?

The only difference between the pci_set_mwi() and pci_try_set_mwi() is
that, pci_set_mwi() is declared as __must_check which forces return
value checking.

The reason why pci_try_set_mwi() was introduced in the first place was
because it gives the drivers both options:
(1) most of the drivers don't require checking the return value, and
they can safely ignore the errors values returned if any, so
pci_try_set_mwi() can be used.
(2) But for some of the drivers it is nice to check the return values,
and generate proper warnings for error handling. By using the
pci_set_mwi(), we force the driver for proper error checking.

So both the functions are similar but have different purposes, and it
seems a more appropriate design.
The whole argument about adding this function:
https://lore.kernel.org/linux-ide/20070404213704.224128ec.randy.dunlap@oracle.com/

Also earlier there was a patch that removed the pci_try_set_mwi() and
__must_check attribute from pci_set_mwi(), just like you wanted,
https://lore.kernel.org/linux-pci/4d535d35-6c8c-2bd8-812b-2b53194ce0ec@gmail.com/
But it was not accepted because Bjorn wasn't convinced and he also gave
the above argument and that we should not break something in the name of
cleaning it up.

But it is safe to only remove the duplicate #ifdef block inside the
pci_try_set_mwi().


Best Regards,
Utkarsh Verma
