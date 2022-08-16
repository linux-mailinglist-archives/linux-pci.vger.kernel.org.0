Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9183559655A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiHPWR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiHPWRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 18:17:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CB901B3
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 15:17:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z187so10512457pfb.12
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=x8S/E0PtG8sPm0KWAXrWqz0p4VFvR6HOroPcaO7G+0g=;
        b=PQZPGnkmcVJmDrzwsKCHAwq9rz9mheWDEXixV0dP60Di6iQR/xt3hIUTrr6gRyfG8a
         4ES5yPaT+3QJmSyuOikwMRYsnsmD1ZTrexxWs2AYFWvjLqADgXFE2NqiUHOf8lKYpYTI
         2bSwd+OUzjDYZ+hXWcDTU+l/Kw19XfCQroI5IuVvtCvMHZqDEYeHxWo0MGmhSgLlY+Wx
         2fv8CN9CUzEUpkpldCNtCsLSDMWg8Jkd4VETtuNzYQdJl4KzmJbzslbjKxnVW5OoSq8p
         k3BjEakAQE0AY5pGbnU1V8slfYBUWkE0vTkfaruaThYLJLrnqpjLWoFLmoVNZ/2dqyMD
         whCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=x8S/E0PtG8sPm0KWAXrWqz0p4VFvR6HOroPcaO7G+0g=;
        b=IJvCvaO6fE29HmJFyDJrmKWshgWvUEniRPmz/0mG6QQIg2cbKEG9+qFk3TTi9cfPwT
         9FhcXGaoVEg/JF2V63j2Cy0M9UpiqkB9IIUI/apipHXKK+Hcwl3uUDE+gClprCxJqnxc
         6xB8RKvgGnZlDpqGIQElLF/LvA1vGNTBlkTtrs7dWt6hDhm9FBRj9oYEIvsV/XkAqQo5
         Tb34B4O1YT22eXiawVzXvEswzIv1SB937iixXzY0UW6KARyAjbLXosFLKk8ntFYMFV2I
         dKgYusVydQGS7Z6Eqdsuez8fR+p1QDcS/ZKODzQZoAfVjIGGx503o7kCuogwerEqxo+x
         sNQg==
X-Gm-Message-State: ACgBeo2Sd+3V9cmw8LZg9rxnGlqNTEbab2dUsS9y54WSIsbBbHgqFIjM
        QSvjceXzKOb19R5Nla8ZXC0+ug==
X-Google-Smtp-Source: AA6agR46pneYPQRgITUM5bPRGS4+667SguLEnVClkb9qEnDOHs8epukpakvDd5snTJp24ycbhCquJA==
X-Received: by 2002:a05:6a00:4193:b0:535:2aea:ea55 with SMTP id ca19-20020a056a00419300b005352aeaea55mr5726810pfb.63.1660688255865;
        Tue, 16 Aug 2022 15:17:35 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7940c000000b00528f9597fb3sm8887970pfo.197.2022.08.16.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:17:35 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:17:31 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
Message-ID: <YvwXe1k6uRSTFuKR@google.com>
References: <20220811184001.2512121-1-willmcvicker@google.com>
 <YvwGvmWPrIQ557C+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvwGvmWPrIQ557C+@google.com>
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/16/2022, Matthias Kaehlcke wrote:
> On Thu, Aug 11, 2022 at 06:40:01PM +0000, Will McVicker wrote:
> > From: Sajid Dalvi <sdalvi@google.com>
> > 
> > Since the PCI spec requires a 10ms D3Hot delay (defined by
> > PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> > to 20ms, let's switch from msleep to usleep_range to improve the delay
> > accuracy.
> > 
> > This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
> > kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
> > the Exynos PCIe device was on average delaying for 19ms when the spec
> > requires 10ms. Switching from msleep to uslseep_delay therefore
> > decreases the resume time on a Pixel 6 on average by 9ms.
> > 
> > [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> > 
> > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  drivers/pci/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 95bc329e74c0..5ae5b3c4dc9b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
> >  		delay = pci_pm_d3hot_delay;
> >  
> >  	if (delay)
> > -		msleep(delay);
> > +		usleep_range(delay * USEC_PER_MSEC,
> > +			     (delay + 2) * USEC_PER_MSEC);
> 
> You could also use fsleep(), which ends up calling usleep_range()
> for (usecs > 10 && usecs <= 20000).

Thanks for the suggestion. I see fsleep() uses 2 * usec for the upper range
which I think is a bit much for this optimization. The documentation says
in the worse case an interrupt will be triggered for the upper bound, but
I'm not entirely sure how often that'd be. Thoughts?

--Will
