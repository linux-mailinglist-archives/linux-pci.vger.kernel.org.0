Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3E5FF18E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Oct 2022 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiJNPlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Oct 2022 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiJNPk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2022 11:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF3180263
        for <linux-pci@vger.kernel.org>; Fri, 14 Oct 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665762039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2W9qXSAyW3i3z7Il6mhVOG/mGDmVLEb8HCxR9KXZkzI=;
        b=LvBuevDO6wUGS+4j1Yu36moxFu30udlMsGRzlWbh7WJwcV3tMja8Q+IPfpjplbZ4JDfxMR
        wr4JD5+cv9GVVY7Ytsoe3PuvgYqLFjFEoN7vCgGgg6JbHjK9cZ/I0zJiip1IzG6aqg2Pl/
        60j9kDAu4D8Au9dv4EKsS5VO8qHCh78=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-0mjcIP8rNIuhoGAxtFK5dA-1; Fri, 14 Oct 2022 11:40:38 -0400
X-MC-Unique: 0mjcIP8rNIuhoGAxtFK5dA-1
Received: by mail-yb1-f197.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so4602997ybf.5
        for <linux-pci@vger.kernel.org>; Fri, 14 Oct 2022 08:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2W9qXSAyW3i3z7Il6mhVOG/mGDmVLEb8HCxR9KXZkzI=;
        b=EtM9jCAI7NFA5cNgi7gLCOqIkGxlbWwIrq9zI3lojrmJcoSL2hzcFcr4v148MFyRrd
         B4pfszerVhsU/qZJYJj7Hs334eiaSuBgn11ma8f8ILnXtNZiBnCBalhpU7mmkpZ4pzRg
         1t969ZKF7bMBCyZU0vLxQutkVLQxNDMuhpI2bbViEkoDiNNGInAqqzTAAWU+N1NMZyd1
         AbWQifvzTzIS6NyIWTNjpkYkzJPR14MtSWAUGHkc4LaulW9y0UF7iKpJ+m1P+iAWP8Ok
         VbGlG2jERO2ax8w3w5sc/ncGb5APMXmF2CTH/8bFKe2c94s8FxFXQTy9kpesVIRv0eB0
         w7VQ==
X-Gm-Message-State: ACrzQf3DaObdJB64iVnsygChyhekIyOA4t9u4LjoYHl6SsbJ9bax1wFP
        MPYPmPzkCyQnqZCRHAD4ysGByuvsjqtWNuDLs0sJ8+o+lyrPiGGWaJDVtEWSdtdLZTI1RK14CuL
        q5eCYdkz1z74pSCHng6EQYzkgYwezVhm1JxZP
X-Received: by 2002:a81:6355:0:b0:349:ec95:9b4f with SMTP id x82-20020a816355000000b00349ec959b4fmr5036473ywb.117.1665762037692;
        Fri, 14 Oct 2022 08:40:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wszgLE/baFAJoUPz1LarjMEkEV3m1qgdC/X7WKQPSa6LlHcRXR7rjrhLRD2E/3EYszUQaBzzIxlp0PXuApOw=
X-Received: by 2002:a81:6355:0:b0:349:ec95:9b4f with SMTP id
 x82-20020a816355000000b00349ec959b4fmr5036433ywb.117.1665762037480; Fri, 14
 Oct 2022 08:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221013184028.129486-1-leobras@redhat.com> <20221013184028.129486-3-leobras@redhat.com>
 <Y0kejqowLYqHIS43@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0kejqowLYqHIS43@hirez.programming.kicks-ass.net>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 14 Oct 2022 12:40:26 -0300
Message-ID: <CAJ6HWG4ip+8unQ9DqZ6vk9OVV8g5jhV7EwJxDQ576xyibjQuMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] sched/isolation: Improve documentation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 14, 2022 at 6:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 13, 2022 at 03:40:27PM -0300, Leonardo Bras wrote:
>
> > +/* Kernel parameters like nohz_full and isolcpus allow passing cpu numbers
> > + * for disabling housekeeping types.
> > + *
> > + * The functions bellow work the opposite way, by referencing which cpus
> > + * are able to perform the housekeeping type in parameter.
> > + */
>
> So checkpatch should have bitten your head off for this drug-indiced
> comment style :-)

Oh, my bad on this one, I will fix that now.

>
> https://lore.kernel.org/all/CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/
>

Any comments in the text? Is that correct?

Thanks for the feedback!

Best regards,
Leo

