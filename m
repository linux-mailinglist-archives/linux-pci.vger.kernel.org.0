Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421DD333D21
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCJM5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 07:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhCJM5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 07:57:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0478C061762
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 04:57:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l11so19837238wrp.7
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cTMvOE1aY9tYXdGR+TBQv9AHcsTzbR2H/zyw8rY1gFg=;
        b=voDChAePN3lGcrI+g15hdroCEK19w9WwMjBdiBbBV4/seg/y5UOOG69R6m8xrqITQl
         rCLhxWlbdBRREwbtvKGAqfhSVA1jSkWufntZUX87g3R+qI1yBCITczkoDxwLFH1zp/nL
         YAiCniEegwIQD/4zs/JCuIwO5JjV3w5IUifu6xT/tmRbmoMUPPxYZrn/GfkOY2vJiohH
         anofs2ni8L7kkhd8IYYYoCtg2CwgH24OUYtZZ5lwjwFmLydKlKiWLtwJ3aMkKCvc/NnH
         UHr3awiKzo/YSG6ZOn0kh64cs3RaZwulewChFglI7winAthP4vJG61RbR+rdP4xODIwQ
         4bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cTMvOE1aY9tYXdGR+TBQv9AHcsTzbR2H/zyw8rY1gFg=;
        b=LCeHmIkS1v6YdgJVbz/7vymRiFuZiNG1Hlrjkk/2GylXkEqLv1VCmIYbQwRI6TCFQu
         8O2bvoqxU5qVqEIZ9X4dzzxQIdvhAkcZ7PzvfXTZGCbh+AzMwvZmzRTFA+3n1qc2Q50e
         Ktu59bASGEupup0RA8EG9gk7wVUSzZXCBhXAWJoWe8AzGcbh8BlMwPg6frxlHPq7JGdx
         WmrKnjVx5cwlsaGfVOJwbqUEGqupA9w8xGuLngpywEFZkJKqUAKDpAt7WC3+pQvqVIfr
         2/k8SQwn9iqlvCetLsKQev6J5ue6UezAT6w3cFzo0HU9or0omOa7bwUYkbHekSWac0LK
         du0w==
X-Gm-Message-State: AOAM5320QBsI9/suqKOuc3SHbYgrscthP6BHIq2OxlfqqREfswiDV+1F
        gF8TIukSwLnzY3d1qdb+m31AVA==
X-Google-Smtp-Source: ABdhPJyv42ta79+HXX9BNbdmsCVAhY3y637uTADEZywR/B0pQOav2a1BH/4Zw/b8IUR9gERxOpmtbw==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr3503760wrr.88.1615381048726;
        Wed, 10 Mar 2021 04:57:28 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id l8sm30063213wrx.83.2021.03.10.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:57:28 -0800 (PST)
Date:   Wed, 10 Mar 2021 12:57:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.de>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>, hdegoede@redhat.com,
        henning.schild@siemens.com
Subject: Re: [PATCH v1 5/7] mfd: lpc_ich: Switch to generic pci_p2sb_bar()
Message-ID: <20210310125726.GO701493@dell>
References: <20210308122020.57071-1-andriy.shevchenko@linux.intel.com>
 <20210308122020.57071-6-andriy.shevchenko@linux.intel.com>
 <20210310103539.GF701493@dell>
 <YEi2DhLu+tpegdOR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEi2DhLu+tpegdOR@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Mar 2021, Andy Shevchenko wrote:

> On Wed, Mar 10, 2021 at 10:35:39AM +0000, Lee Jones wrote:
> > On Mon, 08 Mar 2021, Andy Shevchenko wrote:
> > 
> > > Instead of open coding pci_p2sb_bar() functionality we are going to
> > > use generic library for that. There one more user of it is coming.
> > > 
> > > Besides cleaning up it fixes a potential issue if, by some reason,
> > > SPI bar is 64-bit.
> > 
> > Probably worth cleaning up the English in both these sections.
> > 
> >  Instead of open coding pci_p2sb_bar() functionality we are going to
> >  use generic library. There is one more user en route.
> > 
> >  This is more than just a clean-up.  It also fixes a potential issue
> >  seen when SPI bar is 64-bit.
> 
> Thanks!
> 
> > Also worth briefly describing what that issue is I think.
> 
> Current code works if and only if the PCI BAR of the hidden device is inside 4G
> address space. In case firmware decides to go above 4G, we will get a wrong
> address.
> 
> Does it sound good enough?

Yes, that explains it, thanks.

> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/Kconfig   |  1 +
> > >  drivers/mfd/lpc_ich.c | 20 ++++++--------------
> > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > 
> > Code looks fine:
> > 
> > For my own reference (apply this as-is to your sign-off block):
> > 
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks for reviewing this series, can you have a look at the earlier sent [1]
> and [2]? First one has a regression fix.

Yes, thanks for the nudge.  These were not in my TODO list.

> [1]: https://lore.kernel.org/lkml/20210302135620.89958-1-andriy.shevchenko@linux.intel.com/T/#u
> [2]: https://lore.kernel.org/lkml/20210301144222.31290-1-andriy.shevchenko@linux.intel.com/T/#u
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
