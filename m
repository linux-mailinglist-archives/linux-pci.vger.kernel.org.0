Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C4597605
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiHQSuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiHQSuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 14:50:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6F4454A
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 11:50:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 12so12718363pga.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=JCiW2UZcAZp+jdIF9OVHZYBtvGc1ao00tuPBG0gIYjE=;
        b=MMY8eO3uZxzYnjHuwH7ZPMaNwyCDixA7Iq+8FSMlqE1bQboqipsMF0Bcyrk2xt6HD2
         L8QYIZTttoaPUipfCpebh67StfwmA7ncgPvgj43vXiABIGK41rVJAWYdhZOT4ZqruKT7
         kxsWqIXi3Ww7k1VlMFZzMYBKzekFV3Ft53ENSSZ/5YRmQaAprONhPpjwefLtMVV7dFkK
         M4DzvikgGxDtwmgAnnNEVbktDw793njBeKzz3eWWrixVx/Gb6chXENDwb4b6mguSCuOa
         d2EgCNBs1o4rjt3v0eZG3vXdqrBH0cikteSQD1xaqLVXJFIyl9CEKrYPbk+MOfxZaHg7
         V00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JCiW2UZcAZp+jdIF9OVHZYBtvGc1ao00tuPBG0gIYjE=;
        b=K9EBxkkEoJQI+7ZNsc3fDrwLL9j2m0qDLvSuqemFDedNZ5lLhMAagmbAM3Q92zb5LW
         eux6BMAye52HBpRijPawqDqubdKyhZAqV+xTqk7ZedzH9oIfW8m+2kGIhHaYyRfuTXhu
         fxKcSmqaGPn5SkgSeQX13Uf49Q8ruoigIGJmmiljd4ZSpPG+8I17q5xUlKW+QO7YkM7l
         SvsebkLJJGbDYsQAQs61WRuPuYxLiQpwDp0BGhP/Eq9u7w7IBXcaoNjui94y+lF9ZHwv
         OKdaYdblecCeMLKnSAAtKb4fA0A95Cp3oN80qA0vAfOPvF5e7DAfYU9H+w89M80oK6af
         m/qw==
X-Gm-Message-State: ACgBeo3Z9Z2ZN/94Xaens24qtWf0jXQQbLnh7FDz12xbKpzXParS/Z+x
        zINsqO7KvBsj3aitniNrZzY89A==
X-Google-Smtp-Source: AA6agR4sTPh+eoAxg5EvQHj6gmMkgSIgmN620UeNM3RPMlVNLMZXT6f6P7eANdT9FYWfzMMhR+OUmw==
X-Received: by 2002:a63:8049:0:b0:41b:e8db:d916 with SMTP id j70-20020a638049000000b0041be8dbd916mr22292499pgd.40.1660762220845;
        Wed, 17 Aug 2022 11:50:20 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b0017269cc60d7sm242542plx.214.2022.08.17.11.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:50:20 -0700 (PDT)
Date:   Wed, 17 Aug 2022 18:50:06 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
Message-ID: <Yv04Xi9dWp4dIc5q@google.com>
References: <20220811184001.2512121-1-willmcvicker@google.com>
 <YvwGvmWPrIQ557C+@google.com>
 <YvwXe1k6uRSTFuKR@google.com>
 <YvwvOyB38aCGitpk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvwvOyB38aCGitpk@google.com>
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/16/2022, Matthias Kaehlcke wrote:
> On Tue, Aug 16, 2022 at 10:17:31PM +0000, William McVicker wrote:
> > On 08/16/2022, Matthias Kaehlcke wrote:
> > > On Thu, Aug 11, 2022 at 06:40:01PM +0000, Will McVicker wrote:
> > > > From: Sajid Dalvi <sdalvi@google.com>
> > > > 
> > > > Since the PCI spec requires a 10ms D3Hot delay (defined by
> > > > PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> > > > to 20ms, let's switch from msleep to usleep_range to improve the delay
> > > > accuracy.
> > > > 
> > > > This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
> > > > kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
> > > > the Exynos PCIe device was on average delaying for 19ms when the spec
> > > > requires 10ms. Switching from msleep to uslseep_delay therefore
> > > > decreases the resume time on a Pixel 6 on average by 9ms.
> > > > 
> > > > [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> > > > 
> > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > > ---
> > > >  drivers/pci/pci.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 95bc329e74c0..5ae5b3c4dc9b 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
> > > >  		delay = pci_pm_d3hot_delay;
> > > >  
> > > >  	if (delay)
> > > > -		msleep(delay);
> > > > +		usleep_range(delay * USEC_PER_MSEC,
> > > > +			     (delay + 2) * USEC_PER_MSEC);
> > > 
> > > You could also use fsleep(), which ends up calling usleep_range()
> > > for (usecs > 10 && usecs <= 20000).
> > 
> > Thanks for the suggestion. I see fsleep() uses 2 * usec for the upper range
> > which I think is a bit much for this optimization. The documentation says
> > in the worse case an interrupt will be triggered for the upper bound, but
> > I'm not entirely sure how often that'd be. Thoughts?
> 
> Ah, I misread 'delay + 2' in your patch as 'delay * 2', which would result in
> the same. Agreed, in the spirit of your optimization it probably doesn't make
> sense to use fsleep().
> 
> The range of 2us is really narroy, you could consider making it something
> like 10 or 20% of 'delay'.

The delay is actually 2ms which is 20% of the default 10ms delay. I took
a look at the PCI quirks again and see delays of 0s, 20ms, and 120ms. Due
to the 120ms delay for Intel, let me add a check to use msleep() when delay
is greather than 20ms. For <20ms, I'll use usleep_range with a 20-25% upper
bound.

Thanks,
Will
