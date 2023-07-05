Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD767484B9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjGENPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGENPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 09:15:50 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524D1700;
        Wed,  5 Jul 2023 06:15:49 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1b078b34df5so6630092fac.2;
        Wed, 05 Jul 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688562948; x=1691154948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFwQ+UpqPFkF/GIrr+0M5oyzafXA3IP7DayYsL51ako=;
        b=Ts0Zuo2uT8DPjeTLFWKzjgwcz+Bjn5MAvX7HgVi+/nKxrzkamd+bl/m7MfM5Q5/5xc
         LFs8H5ykB0G+mnw5Vky5ejlIZEnvsX0iqmxY6l4iscqy3IYIt0gjP0BBPkofullBmA8l
         JafFPATMIPu1jmFhAGFrTV7J8za/luhuJ9/wCvv0bhM5+sh9bS5IkcONGlpDL88ggD+G
         hGPBphC+OjzCqMviKi4Hr7bmGRvr+2PG2Tdc4FBHpqJCC6kqT5fvbv/nAX0BZQoyCixI
         NC3eABMm3b+qZlFqUpQcBwV+bhjRYM5VDQJYrMKen0EkMAAUUPohOzs2KVOpXD0jsF7x
         YprA==
X-Gm-Message-State: ABy/qLZoEG3fH1Wu4CEmJLVEtHsYcxfI4lkAk3MgnELpQKUCkYCQuAwC
        u7RQSq44I2DI+rOx6xhvjt7+EyIWkONmmgsl
X-Google-Smtp-Source: ACHHUZ4YenNu0+NiMF+QiLQn4e/V6fpX7oEi0iJIGqvgB4oGGR5KrDoPmVYFC8SX+8XMuvirKS5svw==
X-Received: by 2002:a05:6871:8784:b0:1b0:2d25:f5a8 with SMTP id td4-20020a056871878400b001b02d25f5a8mr19046588oab.1.1688562948390;
        Wed, 05 Jul 2023 06:15:48 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090aab0c00b0025edb720cc1sm1434923pjq.22.2023.07.05.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:15:47 -0700 (PDT)
Date:   Wed, 5 Jul 2023 22:15:46 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: rcar-ep: Include linux/pci-epf.h instead of
 linux/pci-epc.h
Message-ID: <20230705131546.GA333066@rocinante>
References: <20230705104824.174396-1-alistair@alistair23.me>
 <7536d9a3-4738-2bc2-e33e-d93347893865@kernel.org>
 <20230705114443.GA3555378@rocinante>
 <CAKmqyKMD99cDwfyY8BJ0_ExB+VXytT3VdeENwuw5ZyqAKq3X0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMD99cDwfyY8BJ0_ExB+VXytT3VdeENwuw5ZyqAKq3X0w@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > > > pci-epc.h doesn't define the members of the pci_epf_header struct, so
> > > > trying to access them results in errors like this:
> > > >
> > > >     error: invalid use of undefined type 'struct pci_epf_header'
> > > >       167 |                 val = hdr->vendorid;
> > > >
> > > > Instead let's include pci-epf.h which not only defines the
> > > > pci_epf_header but also includes pci-epc.h.
> >
> > [...]
> > > It is odd that the the build bot did not detect this...
> >
> > This is a bit of a surprise to me too, especially since none of the usual
> > bots pick this up, and I can't seem to find such a failure in the nightly
> > CI logs either.
> >
> > Alistair, how did you stumble into this issue?  Also, which version or
> > a tree would that be?
> 
> I was building the kernel with this defconfig [1] inside OpenEmbedded.
> It was the 6.4-rc7 kernel, specifically this one [2].
> 
> 1: https://github.com/damien-lemoal/buildroot/blob/rockpro64_ep_v23/board/pine64/rockpro64_ep/linux.config
> 2: https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v23

Thank you!  Much appreciated.

So, the vanilla kernel does not have headers arranged like this custom tree
that Damien maintains for his own needs, per:

  - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-epc.h
  - https://elixir.bootlin.com/linux/v6.4-rc7/source/include/linux/pci-epf.h

I suppose, there are some changes that break it for you, for example:

  https://github.com/damien-lemoal/linux/commit/c7aa8ddd76a141b975a097532050a76c6a58c436

So, I cannot take this patch as it would break vanilla kernel for us. :)

Try building using vanilla kernel, and see if that helps.

	Krzysztof
