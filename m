Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F564DDF96
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiCRRHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiCRRHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 13:07:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DA30DC5E
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:06:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gb19so7913646pjb.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzGHDc4jmvyaPA0GygXIehDClBDWZrYMlE/AHHQovoA=;
        b=yOivhIhspXFEWDE5XNzqhuJtUgWaRJ7q4ayfxwTYjODHFyEP59t1/F2ab4rLqpLYyZ
         rI0pbM0f18QmByMVCkcT6AsYTzmhCY+z/wEzbw85MM5iKUVjTT7UL54b4iqpsJScCRpt
         m671nknYMvypTZ12Dp8HkBCsntigNarCfbA76MOxAOtm8TVb5G95wzV2mbuXLHF04mRR
         u/pJWaBkM8oMdcJeBNSmCnEEMUFFH+hqUF/OG22Nyv3Pc56zRPDNAXcXv15L5tb76cYL
         xB3SzYoXUbh2cwP0S5oC19+URZSur8dzGuR8/sSfhN75KD4SpVjbHNzPTfVMwnPFiMeb
         b3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzGHDc4jmvyaPA0GygXIehDClBDWZrYMlE/AHHQovoA=;
        b=LHnMiDJtaFB7vcPvyjXve49Z4iPQvu1Xd6xFrD+uYWRNCenFjJSXEnkLR9XAdQuJaQ
         +4do4ca+Ti5L0anLSbE5pCy3irzvcNxgtfVyw+aTIIpz3ZQ5O41iEii+cdvnOR94DD+J
         9n89SYHBEwMOeR+KA9guneNsEZFJUvQC/DYMCHyMpeZkDVD+2YZg9IZ7jgsM3BDTNIfP
         woTukxU1KoOK05IMz9Gu+RWTJVJuJF/wzPcAzdBtAhQ5oxW0cOB5ehtFwg2UEBg9M75y
         TXkTttZWdN+YvqbrmNSsdBNWa2cXgHaquhAOVu3GBTDEhvDc5EW1Lgav2zz9EtCO60w7
         Qbew==
X-Gm-Message-State: AOAM5301JRtFch/X+wiq/+Zkua9GAkZk8TzFz4weJddNTaLYTq8TLTxY
        eRxAWXPvTBiyfwFZ0MA9crUC8i4lrvDFmSQV8p4MGA==
X-Google-Smtp-Source: ABdhPJzBqD7O+Zl9hJpsItx9yEohNLWVK7GF8a7jyffxbDtZDo3pAbJuby3G5q9DxBIuiPaVdSp+4iI0gb1d5W+LXIY=
X-Received: by 2002:a17:903:32d2:b0:153:9c6a:5750 with SMTP id
 i18-20020a17090332d200b001539c6a5750mr441965plr.34.1647623179654; Fri, 18 Mar
 2022 10:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740404348.3912056.9598057996803947688.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317102530.00007a79@Huawei.com>
In-Reply-To: <20220317102530.00007a79@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 10:06:09 -0700
Message-ID: <CAPcyv4jiwaX9N6DddKOYi6o6bvxiOd70dLVSfB0T+N8Tb918yQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] cxl/core/regs: Make cxl_map_{component,
 device}_regs() device generic
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 3:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Mar 2022 21:14:03 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > There is no need to carry the barno and the block offset through the
> > stack, just convert them to a resource base immediately.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Other that this involving paths where we try to carry on after a broken
> device is detected which I'd be far from confident are correct or regularly
> tested, the patch looks fine.

cxl_test covers some of these cases, but otherwise the failed state
should be equivalent to the state after "cxl disable-memdev $memX"

> Particular case that bothers me is undersized bars. Before this patch
> those were (I think) an error that would fail probe.  Are they still after
> this patch?

Yes, that check just moves to cxl_decode_regblock() directly.

>
> Assuming that part is fine.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.
