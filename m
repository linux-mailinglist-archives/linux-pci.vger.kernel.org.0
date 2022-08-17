Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3862597717
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 21:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiHQTwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHQTwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 15:52:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F69AA50CD
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 12:52:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2818246pjk.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qhDBBfRO8hshZLFsK/uN7QtbS7YCbu9/Q4DaGouyGb8=;
        b=n6upwd6duwkOC0jSOXuwf5JBpXBb8ll7yr6SdtxFciplGgVA/yFbH0HAsgv5hDNd9S
         cRFT24b7Mx5gINdTvNpUPA+RFB3zngQAqQK/JT0MP3w4/SlwLbB+Ty3exe0ErwiM79LW
         jUKEmSJj0fX2h8bFZ0pyGQifuR556tlBlyYb2nPKKcYkf+6uw3aKhaCGBHHpuqDS+8Nm
         trAsNl8VFt0PehDytRl4SnuxPJOUjVmp+9f+ITzCCA1Lpj23tWt+ZQe+S5vYQ5vSK0O9
         MqL34ejozL0N9X8+Kh2J9GW3m9F5eMWwrPvayJWF6csphqnZf3nR+0uBAjv3MLk70etY
         7YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qhDBBfRO8hshZLFsK/uN7QtbS7YCbu9/Q4DaGouyGb8=;
        b=4O5CJcf07xqgtBC9YM9BSYU96SUv12HOSLP3V/2Nef3za1qpMNCe+Em2bE9ShN4Vg0
         1YMJu10+BPeqXIev1TN0np8vt/E8NQTxrBWQSnoY1u3bYy5ki8Nw+fQlAA2Eoo7Fq373
         SAZvVg3H1N2ZJ7KTIhUVOxscFNWDcZuyV+M+5nWlttJAHmiDa9OBlcr7uKqbk5T2g5Vd
         mJVLB6dFhDuNRKJC7inIDF1fW6Q8yG2JjTtw8YVhnCgMtB4iNsgKi9K6MKQS2AFAAdkb
         sp7rfz788eojHByBEMqpQs7erbEAo52YuiiiFbtljs7lbZy1AjJ4cSiAizeAo2GjeFkL
         Lqaw==
X-Gm-Message-State: ACgBeo0ons318xieqk1Ybk2MGvFYquiwdi0blNju3PFhfCqMZ1eSR8PD
        qZ3FibXzRTF1jAWRCU8OQhK7Zw==
X-Google-Smtp-Source: AA6agR5kUtRc0Yrbc6y6cu7vFg9kh+gXbtv0CS56ZJ50rd4TF93PlLmJdr8HaHa5hHD4VfE/qwyuAA==
X-Received: by 2002:a17:902:da89:b0:170:a235:5993 with SMTP id j9-20020a170902da8900b00170a2355993mr27084691plx.94.1660765940791;
        Wed, 17 Aug 2022 12:52:20 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b0052e23a5ab74sm10921123pfk.59.2022.08.17.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:52:20 -0700 (PDT)
Date:   Wed, 17 Aug 2022 19:52:16 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <Yv1G8A5Ut9trpK/L@google.com>
References: <20220817185202.1689955-1-willmcvicker@google.com>
 <Yv1BSfkd6WUh2SFp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv1BSfkd6WUh2SFp@google.com>
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

On 08/17/2022, Matthias Kaehlcke wrote:
> Hi Will,
> 
> On Wed, Aug 17, 2022 at 06:52:02PM +0000, Will McVicker wrote:
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
> > 
> > [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> > 
> > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  drivers/pci/pci.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 95bc329e74c0..97a042ca9032 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -63,16 +63,26 @@ struct pci_pme_device {
> >  };
> >  
> >  #define PME_TIMEOUT 1000 /* How long between PME checks */
> > +#define MAX(a, b) ((a) >= (b) ? (a) : (b))
> 
> no need to define this macro, you can use max() from
> include/linux/minmax.h instead.
> 
> >  
> >  static void pci_dev_d3_sleep(struct pci_dev *dev)
> >  {
> > -	unsigned int delay = dev->d3hot_delay;
> > +	unsigned int delay_ms = dev->d3hot_delay;
> >  
> > -	if (delay < pci_pm_d3hot_delay)
> > -		delay = pci_pm_d3hot_delay;
> > +	if (delay_ms < pci_pm_d3hot_delay)
> > +		delay_ms = pci_pm_d3hot_delay;
> 
> nit: since you are already touching this code you could change it to:
> 
> 	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> 
> >  
> > -	if (delay)
> > -		msleep(delay);
> > +	if (delay_ms) {
> > +		if (delay_ms <= 20) {
> > +			/* Use a 20-25% upper bound with 1ms minimum */
> > +			unsigned int upper = MAX((delay_ms >> 3) << 1, 1);
> 
> Not sure this optimization of using bit shifts instead of the clearer do_div()
> is really needed here. pci_dev_d3_sleep() is not a super hot code path IIUC.
> 
> > +
> > +			usleep_range(delay_ms * USEC_PER_MSEC,
> > +				     (delay_ms + upper) * USEC_PER_MSEC);
> > +		} else {
> > +			msleep(delay_ms);
> > +		}
> > +	}
> >  }
> >  
> >  bool pci_reset_supported(struct pci_dev *dev)
> > 
> > base-commit: 274a2eebf80c60246f9edd6ef8e9a095ad121264
> > -- 
> > 2.37.1.595.g718a3a8f04-goog
> > 

Thanks for the suggestions! I'll update those in the next patchset.

--Will
