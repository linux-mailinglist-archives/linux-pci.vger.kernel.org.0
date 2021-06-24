Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55F83B34C1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFXRaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 13:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXRa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 13:30:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD8C061574;
        Thu, 24 Jun 2021 10:28:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so5303176pgn.4;
        Thu, 24 Jun 2021 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aaw37jAPjEH9fknpMLD7D8CrB6Ci5AT0QfUiiI7nv3E=;
        b=MUyWN+8oUn3IVQSjpzrM78+p0DxwevxQKw5Ltf4e0r7NZLDQgEQwCzYlhg6yhqvFJj
         kvxw19QQXlIOudNc+uKRr14Pi1P+QMIGY2fvpzmxFSYR+kF0CfXYlsbgpi5hl3KmpM0O
         /8vJ9gPB/kN1utHjyR1/q3XlMphmYBBnDk4JR0N9azV90Rt+w+1rEMqh1/VBb3qObEf2
         TU0cXmk3atCsFRa1YdFq8sEbaOotefHlPvKUAxG8kgWCIwkyqWHwjj8bprnmllTVCyE9
         n/tevZNhq+MZ68p34tuwvlnYaKMOvRrxr6GtSiwVAB1fHowjgNkDqxOY1QfCGOziPaLK
         gZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aaw37jAPjEH9fknpMLD7D8CrB6Ci5AT0QfUiiI7nv3E=;
        b=G7U3kQB2lp1kja3BUj30yZjybiQoXzpoRNhbreEORRyxlsPG0+qmwzwXI0XjF9pUmu
         M3K5wGkqXCCFxI+sesAzZvt+dsJiyShW2hDULWFkNfRkuHx8M9f45nktXU3AyV52c/JH
         /0t46r/T3nE/MFDiNIHwhhdXu5qJqbHxe8XSIHULjdIDt/9x8dKH8WsV9AaCFa5noaYJ
         LfmBb0Phs+658mDerBKBjOcMHREqgfG496GEiVkQkcTJ6aj8wfLAkJedre0I2vSN2AZ+
         L/B3a0VyTBtcGZlvJ2dzbZpTIaLxYwTXybee077yv/sWe24MKhFYMdfIfXbn7bGA1EH6
         qfmg==
X-Gm-Message-State: AOAM533uwrvnc6C5Gqh6bVhUo7cuqGrB40EFhKj0odb7Kyp+WbmhgK6H
        l/l6vFJMzcaOnpOKvC1aMCo=
X-Google-Smtp-Source: ABdhPJw1sqp/qIfwIsG1YDSTrgE/MCafjTjUt58wM/NRG6zeHymFMwDXSLDDJrl/WrBwk1WkXAUPWA==
X-Received: by 2002:a62:1782:0:b029:2f7:dcbe:c292 with SMTP id 124-20020a6217820000b02902f7dcbec292mr6254221pfx.63.1624555689138;
        Thu, 24 Jun 2021 10:28:09 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id y21sm3091075pgc.93.2021.06.24.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:28:08 -0700 (PDT)
Date:   Thu, 24 Jun 2021 22:58:06 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210624172806.ay6dak2wdtv3nruj@archlinux>
References: <20210624151242.ybew2z5rseuusj7v@archlinux>
 <20210624165601.GA3535644@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624165601.GA3535644@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/24 11:56AM, Bjorn Helgaas wrote:
> On Thu, Jun 24, 2021 at 08:42:42PM +0530, Amey Narkhede wrote:
> > On 21/06/24 07:15AM, Bjorn Helgaas wrote:
> > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > Add reset_method sysfs attribute to enable user to
> > > > query and set user preferred device reset methods and
> > > > their ordering.
> > >
> > > > +		Writing the name or comma separated list of names of any of
> > > > +		the device supported reset methods to this file will set the
> > > > +		reset methods and their ordering to be used when resetting
> > > > +		the device.
> > >
> > > > +	while ((name = strsep(&options, ",")) != NULL) {
> > > > +		if (sysfs_streq(name, ""))
> > > > +			continue;
> > > > +
> > > > +		name = strim(name);
> > > > +
> > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > > > +			if (reset_methods[i] &&
> > > > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > > > +				reset_methods[i] = prio--;
> > > > +				break;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		if (i == PCI_RESET_METHODS_NUM) {
> > > > +			kfree(options);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > >
> > > Asking again since we didn't get this clarified before.  The above
> > > tells me that "reset_methods" allows the user to control the
> > > *order* in which we try reset methods.
> > >
> > > Consider the following two uses:
> > >
> > >   (1) # echo bus,flr > reset_methods
> > >
> > >   (2) # echo flr,bus > reset_methods
> > >
> > > Do these have the same effect or not?
> > >
> > They have different effect.
>
> I asked about this because Shanker's idea [1] of using two bitmaps
> only keeps track of which resets are *enabled*.  It does not keep
> track of the *ordering*.  Since you want to control the ordering, I
> think we need more state than just the supported/enabled bitmaps.
>
> > > If "reset_methods" allows control over the order, I expect them to
> > > be different: (1) would try a bus reset and, if the bus reset
> > > failed, an FLR, while (2) would try an FLR and, if the FLR failed,
> > > a bus reset.
> >
> > Exactly you are right.
> >
> > Now the point I was presenting was with new encoding we have to
> > write list of *all of the supported reset methods* in order for
> > example, in above example flr,bus or bus,flr. We can't just write
> > 'flr' or 'bus' then switch back to writing flr,bus/bus,flr (these
> > have different effect as mentioned earlier).
>
> It sounds like you're saying this sequence can't work:
>
>   # echo flr > reset_methods
# dev->reset_methods = [3, 0, 0, ..]
>   # echo bus,flr > reset_methods
# to get dev->reset_methods = [6, 3, 0, ...]
we'll need to probe reset methods here.
>
> But I'm afraid you'll have to walk me through the reasons why this
> can't be made to work.
I wrote incomplete description. It can work but we'll need to probe
everytime which involves reading different capabilities(PCI_CAP_ID_AF,
PCI_PM_CTRL etc) from device. With current encoding we just have to
probe at the begining.
>
> > Basically with new encoding an user can't write subset of reset
> > methods they have to write list of *all* supported methods
> > everytime.
>
> Why does the user have to write all supported methods?  Is that to
> preserve the fact that "cat reset_methods" always shows all the
> supported methods so the user knows what's available?
>
> I'm wondering why we can't do something like this (pidgin code):
>
>   if (option == "default") {
>     pci_init_reset_methods(dev);
>     return;
>   }
>
>   n = 0;
>   foreach method in option {
>     i = lookup_reset_method(method);
>     if (pci_reset_methods[i].reset_fn(dev, PROBE) == 0)
Repeatedly calling probe might have some impact as it involves reading
device registers as explained earlier.
>       dev->reset_methods[n++] = i;           # method i supported
>   }
>   dev->reset_methods[n++] = 0;               # end of supported methods
>
> If we did something like the above, the user could always find the
> list of all methods supported by a device by doing this:
>
>   # echo default > reset_methods
>   # cat reset_methods
>
This is one solution for current problem with new encoding.
> Yes, this does call the "probe" methods several times.  I don't think
> that's necessarily a problem.
I thought this would be a problem because of your earlier suggestion
of caching flr capability to avoid probing multiple times. In this case
we'll need to read different device registers multiple times. With
current encoding we don't have to do that multiple times.

Thanks,
Amey
>
> Bjorn
>
> [1] https://lore.kernel.org/r/1fb0a184-908c-5f98-ef6d-74edc602c2e0@nvidia.com
