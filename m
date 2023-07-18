Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B79757AF8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGRLyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGRLyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 07:54:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4CD18E
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 04:54:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b9cdef8619so34644065ad.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681276; x=1692273276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qAbXWHOXyFDKHVxruYWm3jD0eZO0+0Z+8kud6jIU9tk=;
        b=AFcXpzXFi26zgMPCAx6DdEqgI+b/QNahrDEJ8N1zyzF4Bv1kONYqLBMCN5F7o7UlwM
         CKLm3LCVercKZITgQ9JCJUKwtchpt2hDl0Sy7MjTXqd2CelbngPXruyl2rusIYWqDNiY
         llKXIHFYkjTbxU4jnS5YZXER6rwcHN3PxjU7eHN0kx8lnL5s0s4JiLvRRT2SL3moyAge
         BIGADE7Xe/e3eFZQWEIb0zz486oCWUOLBQTW/TJ6TUdx7VT9JUcT34+Xz5yj1V+yjFzT
         rfH/+Eb6sDpwk85JyVfu5uBHFbmreY/lR0WOkzXUjihjkSIIneqePGYWOBdGaGoDNy6x
         zmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681276; x=1692273276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAbXWHOXyFDKHVxruYWm3jD0eZO0+0Z+8kud6jIU9tk=;
        b=laVCjCduY7A3UQHgTc4zoeqF7Qnx2cxY64xQazC5K0WsvNnaOgYOwGEzycvmhxk5wp
         sJYMsgPQVtI5u1XcqPlng+qEjRie+EoutYbDTM4nRSsgBSNDmGM5Zve9HW88wspeXBeJ
         IOfhOTwvVaW1r2Gx9X2E8EYBcRvHdNUJYIasQX2VhJsMPM5OMd6pefox8IFksdE510ua
         xad0ld2DA7tUbCGhpXEWxfh5vUnrCTwBALQTMRwnqWgTxGtuEmYJdQNyFtFPsDRcYsRa
         HQG8cm1dGXmfd4rWcbXkr9c0/JRbJn8dm+DOS9AHY/5i3IakzK7ezJa9BzFkNKKnepE7
         QTaQ==
X-Gm-Message-State: ABy/qLbMr9GcIHRTyrb2j2CW2HLYj1965w92R7uVpfyfwABPyKSaTK7w
        SH5Pj8J//NgzjPBc0nVsfMQ2
X-Google-Smtp-Source: APBJJlEUcXTVWiyujmSqtqJfXDTAjfoEPqdfe9RmlKXcdfA+hAJ0riwkDqbYxbJ6t3mYiT9J2QowIw==
X-Received: by 2002:a17:902:f693:b0:1ae:6cf0:94eb with SMTP id l19-20020a170902f69300b001ae6cf094ebmr2190077plg.5.1689681276519;
        Tue, 18 Jul 2023 04:54:36 -0700 (PDT)
Received: from thinkpad ([117.217.187.33])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902db0f00b001b02bd00c61sm1654451plx.237.2023.07.18.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:54:36 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:24:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718115430.GE4771@thinkpad>
References: <20230717220317.q7hgtpppvruxiapx@pali>
 <20230718111952.GA475778@bhelgaas>
 <20230718115052.GD4771@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718115052.GD4771@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 05:21:01PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 18, 2023 at 06:19:52AM -0500, Bjorn Helgaas wrote:
> > [+cc Radu]
> > 
> > On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > > Hello, I have just one question. What do you want to do with pci-mvebu
> > > driver? It is already marked as broken for 3 kernel releases and I do
> > > not see any progress from anybody (and you rejected my fixes). How long
> > > do you want it to have marked as broken?
> > 
> > I don't think "depends on BROKEN" necessarily means that we plan to
> > remove the driver.  I think it just means that it's currently broken,
> > but we hope to fix it eventually.
> > 
> > I think the problem here is the regular vs chained interrupt handlers,
> > right?  Radu has been looking at that recently, too, so maybe we can
> > have another go at it.
> > 
> 
> We (Linaro and Redhat) had a discussion a while ago on this topic and I just got
> pointed to Radu's series. So yes, we should instead work on that direction
> instead of driver hacks which brings maintainers disagreement.
> 

FYI: These are the two series/patches that I got pointed to:

https://lore.kernel.org/all/20230530214550.864894-1-rrendec@redhat.com/
https://lore.kernel.org/lkml/20230629183019.1992819-1-rrendec@redhat.com/

- Mani

> - Mani
> 
> > Bjorn
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
