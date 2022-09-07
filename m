Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3430B5AF8D8
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIGAH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIGAHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 20:07:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1945C9350D
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 17:07:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jm11so12801436plb.13
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rh1S7QUmN9msoqxI7fEuUgQGRHwthEWICM05M3Wc2aQ=;
        b=r8Mf6Sqiq08D2xmr3VMEf6Fo6zCarWl1mXQXHKzP96Q077bnWiaFRP8QeDaVwmEvc7
         6EL95xuZqp6FcqJqGTtNXdaDwJoUBICVw3PZrIgsO43iNMZTnnsGNf3ETRN2aEZBj82y
         CXPV5AR/3dK+S0LMLQiCuTKHeWSzCM4nRDBAP+oeuIrHcv3gof/UEUH7edtzwHmRhUd+
         v3K/GgE1VDgT55UhxpRKoxicP7UzoJr84BkIxtOROUYEvsCglp56Vx8fyoa9mdirVPEJ
         vMc+9zcOqUuw0Rer5G+CTcCGCKCA3IcmZfFPkW9IF2x25+5n/EtX2Ih7Q+RGw7Sjhh1B
         IX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rh1S7QUmN9msoqxI7fEuUgQGRHwthEWICM05M3Wc2aQ=;
        b=tkM+LVv9jUdeyI7Xi4YMqje4e7rZu81npMpqOiqWi85S4R+j+ERiq3HR05Ak0wjEMC
         uaTCJ1Yv+KnodaU/3io2hB8fRIYZEOKyxS6cvSlSONlrNEsYkGaAPdKdvNKRXJH4p6MB
         OTh3YE8+O7mk88vOrgnw0O9U0zWyjp5+PiD8jdh3nEOa06VskDXYrSH7ofLgxLjowpL3
         7SesA4Cw14r/inBy//yq2B3viMxtKyiWiW+DYVbzk1fKspNx9BOz2HeRMZYmRP4IHyHC
         bL07ptxoxXQDgeHA5b0VYoQmrwp/fii80v3hCVdZhA57Yz+cZDxIZXH8LrZ5UQFRG+ML
         bT8Q==
X-Gm-Message-State: ACgBeo2kqq9VLuHCf5fEp/B2nRbfHqm/TGE1wg655X7l6BBFkhPKCDB7
        WFbMkNv78667xMMwrmDwglq1Tw==
X-Google-Smtp-Source: AA6agR5jgHStYz/eMHO539QRRnmuJXwgKGRimNvRgmfcAP6PfnrO/RUq4IWvaqCx7ILOoE9XSzYXhw==
X-Received: by 2002:a17:90b:14d2:b0:1fb:acff:998 with SMTP id jz18-20020a17090b14d200b001fbacff0998mr1007403pjb.70.1662509228243;
        Tue, 06 Sep 2022 17:07:08 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78f34000000b00537b8aa0a46sm11201922pfr.96.2022.09.06.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 17:07:07 -0700 (PDT)
Date:   Wed, 7 Sep 2022 00:07:03 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <Yxfgp9DgYc3XU602@google.com>
References: <20220817230821.47048-1-willmcvicker@google.com>
 <20220902221340.GA379310@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902221340.GA379310@bhelgaas>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/02/2022, Bjorn Helgaas wrote:
> On Wed, Aug 17, 2022 at 11:08:21PM +0000, Will McVicker wrote:
> > From: Sajid Dalvi <sdalvi@google.com>
> > 
> > Since the PCI spec requires a 10ms D3Hot delay (defined by
> > PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> > to 120ms, let's add support for both usleep_range and msleep based on
> > the delay time to improve the delay accuracy.
> > 
> > This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
> > in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
> > 10ms delay for the Exynos PCIe device was on average delaying for 19ms
> > when the spec requires 10ms. Switching from msleep to uslseep_range
> > therefore decreases the resume time on a Pixel 6 on average by 9ms.
> 
> Add the "PCIe r6.0, sec 5.9" spec reference for the 10ms delay for
> transitions to or from D3hot.
> 
> s/D3Hot/D3hot/ to match other usage (at least in Linux; the spec does
> use "D3Hot")
> 
> s/uslseep_range/usleep_range/
> 
> Add "()" after function names.

Thanks for the suggestions! I'll update these in the next patchset.

> 
> In the subject, "Switch ... to *also* use usleep_range": what does the
> "also" mean?  It sounds like it's referring to some other place where
> we also use usleep_range()?

I was intending to mean usleep_range() will be used when the the delay <=20 ms,
else msleep() will be used. If we drop msleep() altogether as suggested in your
comments below, then I can change this to be: "Switch D3hot delay to use
usleep_range."

> 
> > [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> > 
> > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  drivers/pci/pci.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > v3:
> >  * Use DIV_ROUND_CLOSEST instead of bit manipulation.
> >  * Minor refactor to use max() where relavant.
> > 
> > v2:
> >  * Update to use 20-25% upper bound
> >  * Update to use usleep_range() for <=20ms, else use msleep()
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 95bc329e74c0..cfa8386314f2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -66,13 +66,19 @@ struct pci_pme_device {
> >  
> >  static void pci_dev_d3_sleep(struct pci_dev *dev)
> >  {
> > -	unsigned int delay = dev->d3hot_delay;
> > +	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> >  
> > -	if (delay < pci_pm_d3hot_delay)
> > -		delay = pci_pm_d3hot_delay;
> > +	if (delay_ms) {
> > +		if (delay_ms <= 20) {
> > +			/* Use a 20% upper bound with 1ms minimum */
> > +			unsigned int upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U);
> >  
> > -	if (delay)
> > -		msleep(delay);
> > +			usleep_range(delay_ms * USEC_PER_MSEC,
> > +				     (delay_ms + upper) * USEC_PER_MSEC);
> > +		} else {
> > +			msleep(delay_ms);
> 
> I hate the fact that we have to check for those ancient Intel chips at
> all, but having to read through the usleep_range() vs msleep() thing
> is just painful.  
> 
> fsleep() would be much simpler, but I am sympathetic that the fsleep()
> range of 10-20ms probably wouldn't get the benefit you want.
> 
> I wish Documentation/timers/timers-howto.rst included a reason why we
> should use msleep() instead of usleep_range() for longer sleeps.  Is
> there a reason not to do this:

I'm not familiar with the reasons behind these two beside what the
documentation states. I don't know what happens when you use usleep_range()
with a delay >20ms.

> 
>    static void pci_dev_d3_sleep(struct pci_dev *dev)
>    {
>         unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>         unsigned int upper;
> 
>         if (delay_ms) {
>                 /* 20% upper bound, 1ms minimum */
>                 upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U)
>                 usleep_range(delay_ms * USEC_PER_MSEC,
>                              (delay_ms + upper) * USEC_PER_MSEC);
>         }
>    }
> 
> Since the Intel quirk is for 120ms, a 20% upper bound would make the
> range 120-144ms.  Would that be a problem?  Those chips are ancient;
> the list is untouched since it was added in 2006.  The point of
> usleep_range() is to allow the scheduler to coalesce the wakeup with
> other events, so it seems unlikely we'd ever wait the whole 144ms.  I
> vote for optimizing the readability over sleep/resume time for
> already-broken chips.

I'm totally fine with this, but I don't really know what the impact would be to
those old Intel chips.

> 
> Bjorn

Thanks,
Will
