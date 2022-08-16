Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51D596631
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 01:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiHPX6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiHPX6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 19:58:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204B923E6
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 16:58:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d71so10619992pgc.13
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zcVcSBUYWoFWjcfEXcoAiD7y86Ff1CMvGHRV3ofuKE8=;
        b=oYPogaVIhlWq1V0gz8+5Wzm9ZHEqqbefaHWf0sUHjVAvzPfG6cop6Y0bujJ1uZ3po/
         bRT28HyO5U2+6gQFUx6IqHO+ONhxGemJoEO18KdVHOvNDbC8FLzEwf74Ax8Msep2JYgX
         oTOeFv2cGB9mBZ2jDO2kW5CWBcjj0l+0s6ffk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zcVcSBUYWoFWjcfEXcoAiD7y86Ff1CMvGHRV3ofuKE8=;
        b=QV0oeykBtZXYYwpd3UnToiufm6sy59TNFq7JL+sQN6GbJI17SE9cHyYUipoJawZkVf
         aeEVwd3L7h2A/XjJOSYktL/3zR0pFT3dEcGpVfFIkmJHuKUuPuwyFq+SVKpUsMjNsi5L
         2J10xC02rPaYXHrx1EufS1UUwc6+me+GzstWO1ERkyE1E0m8p+9WLXvG+1QcO3jkouLy
         fp+xZU3nXQDkwDhRiwKOFYWgYYAGRb0rVE24p22o8yCpt1uCVpW+usTuMhRM468uikSc
         GJlvINSNXXXYbUmMaBNS2zkGE/UhbgFNftiXby5aDTihqP+jefhDgQazQpY3SGflN3ip
         pIRQ==
X-Gm-Message-State: ACgBeo3i2ZDOFpqvpxAykuzcDd8N5TiKbMt4uRIQuHhBR/YRGlDwZz8m
        ZF/HPRC3Rd915iSu9BVSN9L77A==
X-Google-Smtp-Source: AA6agR5vBDpmlJG43ZGfk02juh52ek5LdtdS1/UQe4X2qPAuGW1mGzkq1W3VmRCCtO8GuSQCOtl3Aw==
X-Received: by 2002:aa7:96d5:0:b0:52e:e2a:9c79 with SMTP id h21-20020aa796d5000000b0052e0e2a9c79mr23395515pfq.55.1660694333888;
        Tue, 16 Aug 2022 16:58:53 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f730:6f91:6154:bee4])
        by smtp.gmail.com with UTF8SMTPSA id l7-20020a170903120700b001709e3c750dsm9712094plh.194.2022.08.16.16.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 16:58:53 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:58:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     William McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI/PM: Switch D3Hot delay to use usleep_range
Message-ID: <YvwvOyB38aCGitpk@google.com>
References: <20220811184001.2512121-1-willmcvicker@google.com>
 <YvwGvmWPrIQ557C+@google.com>
 <YvwXe1k6uRSTFuKR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvwXe1k6uRSTFuKR@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 10:17:31PM +0000, William McVicker wrote:
> On 08/16/2022, Matthias Kaehlcke wrote:
> > On Thu, Aug 11, 2022 at 06:40:01PM +0000, Will McVicker wrote:
> > > From: Sajid Dalvi <sdalvi@google.com>
> > > 
> > > Since the PCI spec requires a 10ms D3Hot delay (defined by
> > > PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> > > to 20ms, let's switch from msleep to usleep_range to improve the delay
> > > accuracy.
> > > 
> > > This patch came from Sajid Dalvi <sdalvi@google.com> in the Pixel 6
> > > kernel tree [1]. Testing on a Pixel 6, found that the 10ms delay for
> > > the Exynos PCIe device was on average delaying for 19ms when the spec
> > > requires 10ms. Switching from msleep to uslseep_delay therefore
> > > decreases the resume time on a Pixel 6 on average by 9ms.
> > > 
> > > [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> > > 
> > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > ---
> > >  drivers/pci/pci.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 95bc329e74c0..5ae5b3c4dc9b 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -72,7 +72,8 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
> > >  		delay = pci_pm_d3hot_delay;
> > >  
> > >  	if (delay)
> > > -		msleep(delay);
> > > +		usleep_range(delay * USEC_PER_MSEC,
> > > +			     (delay + 2) * USEC_PER_MSEC);
> > 
> > You could also use fsleep(), which ends up calling usleep_range()
> > for (usecs > 10 && usecs <= 20000).
> 
> Thanks for the suggestion. I see fsleep() uses 2 * usec for the upper range
> which I think is a bit much for this optimization. The documentation says
> in the worse case an interrupt will be triggered for the upper bound, but
> I'm not entirely sure how often that'd be. Thoughts?

Ah, I misread 'delay + 2' in your patch as 'delay * 2', which would result in
the same. Agreed, in the spirit of your optimization it probably doesn't make
sense to use fsleep().

The range of 2us is really narroy, you could consider making it something
like 10 or 20% of 'delay'.
