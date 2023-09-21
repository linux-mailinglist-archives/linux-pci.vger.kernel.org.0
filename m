Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB967A9B2A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjIUSy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjIUSym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:54:42 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B94EDBC8
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 11:45:01 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-565e395e7a6so779159a12.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 11:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321901; x=1695926701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGtS4NhD3YUFYf7ixWDh9ThIDZkfalnhMm0AW1GmKmc=;
        b=qAv50ydcTZN1Tywej23MCgld+shbPm2Vaw7VKWHO1F0olxwiJaR4927hYQMrlZx3Uq
         FQ/BfH7xzPYMyEpTh21JI/jR2lEr2w9y9acq2U08CLh1fOgbAIwdKCFSRHdI+gxdUGW0
         7YAMZi1Tu8Wkk4asbIPfclFs7SOlAObF4i4FdVIo35e0yZVxBEbftDXOHK/zvLuj9yj3
         A1GV38z6UxG4W31Nh5yHfH2ZpJToDGXkVgK/+Nrkll/GH9xRbz3i2upmRnP1MT2cCjAF
         W7GLerQxhtUjGQ1RKn7cH2nNyr5myGIdVtMREp2WSBuMR6TxBOcTwKqXZNDzi43dYAPI
         KVqg==
X-Gm-Message-State: AOJu0YzoHiLBQBlQwyLrwzJkf6S39MueqOCjMHaUm9uAYkwwCTWqVqKr
        p/91NPfcUayltTH2cFenjTI=
X-Google-Smtp-Source: AGHT+IH/yMpk5unv1GJnIcNlkO/RSvDoc/nRu9Enatq8uAEn//dOWunS8B8HpQOHNoZAk8G4wNwLHQ==
X-Received: by 2002:a17:90a:f297:b0:274:e8e0:1503 with SMTP id fs23-20020a17090af29700b00274e8e01503mr6506058pjb.16.1695321900844;
        Thu, 21 Sep 2023 11:45:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a1a1a00b00276fc32c0dasm1123080pjk.4.2023.09.21.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:45:00 -0700 (PDT)
Date:   Fri, 22 Sep 2023 03:44:58 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: Make Bjorn's life easier (and grease the path of your patch)
Message-ID: <20230921184458.GA3964991@rocinante>
References: <20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com>
 <20230921151401.GA25512@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921151401.GA25512@wunner.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > This is a list of things I look at when reviewing patches.
> [...]
> > Write the changelog:
> [...]
> >   - Order tags as suggested by Ingo [1] (extended):
> > 
> >       Fixes:
> >       Link:
> >       Reported-by:
> >       Tested-by:
> >       Signed-off-by: (author)
> >       Signed-off-by: (chain)
> >       Reviewed-by:
> >       Acked-by:
> >       Cc: stable@vger.kernel.org	# 3.4+
> >       Cc: (other)
> 
> I've used your message from 2017 [1] as a reference on how to order tags
> but today discovered that checkpatch.pl has a new rule which is sort of
> at odds with your preferred style:

I think, it's time for a resend and a refresh of this message. :)

>   WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>   #38: 
>   Reported-by: Chad Schroeder <CSchroeder@sonifi.com>
>   Tested-by: Chad Schroeder <CSchroeder@sonifi.com>
> 
>   total: 0 errors, 1 warnings, 15 lines checked
> 
> I'm not sure where to insert the Closes tag, checkpatch wants it immediately
> after the Reported-by, but since Closes is like Link, I'd assume that you'd
> prefer it to precede the Reported-by.

This is what I have settled with:

  Fixes:
  Closes:
  Suggested-by:
  Link:
  Reported-by:
  Tested-by:
  Co-developed-by: (co-author)
  Signed-off-by: (co-author)
  Signed-off-by: (author)
  Signed-off-by: (chain)
  Reviewed-by:
  Acked-by:
  Cc: stable@vger.kernel.org	# (version)
  Cc: (other)

The above is a combination of Bjorn's take on Ingo's original suggestion
that incorporates elements from the official kernel documentation[1].

1. https://www.kernel.org/doc/html/latest/process/submitting-patches.html

	Krzysztof
