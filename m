Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2405FC9D6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJLRWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLRWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 13:22:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCAB0B16
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 10:22:28 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-132af5e5543so20188088fac.8
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
        b=AE8z8KD6uwSVMiRp4ABm0Kn9UkMq8P+bk8+Y1ITmg3vl1hYmjp6k8LU6URk5HzGGQF
         2/fqw2HhcOa/gTcb1tS3SQgcP9XK2z4BjeVToHve1GXn4ay7pgmzQA+nKS017UcVgGKS
         Udydt9y4k+dIUSNMddvtmXX3tSMn7byJOqVUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
        b=V5UfhlZD/w06G6ThifYhySgqeU5TcHnNgQVpJKinRf/K3UIjwMURwPxzQGHRJ7aIfd
         UxjjfpJ1IGbeSDVpIWxhd5tbyhY17CziafAiNbgTZMeP+QIsaWfOUE/twSNkDnfgBsgc
         bY/o9GVGZZLb8oV8KmdsNoMm3i97b6D3d5gOPogj/u2Jf80HrGEgaGYB5catrTsJ8g3G
         Ojm1Omz5P6AwGDVni1OzKnOJK/KJ0vA7z/WKp9xPkOLh5Xe7+o8tUL2pgW+NTLwSo0FG
         3jWxy6ofdjptjSDDyy2ct2vwEpUpVfAj6aVAeWr8sQZJ0R5SaChK/ocEz5HuXglpd3Ke
         vOjA==
X-Gm-Message-State: ACrzQf0dJ+XpcCPnfk1cB2n+j7jz2ENc6E4Zj3rMyGxe3ZxDs7LYR92L
        aGy57o1nHZbbP4P+6hAEZPH4Oqd03mpXOg==
X-Google-Smtp-Source: AMsMyM4lCvXhNK2Rs1ZThmIldlW/UmP14C5qQ5Yikfiik+VFurizUIoXdLZBybXUlKXyx+SfImaldg==
X-Received: by 2002:a05:6870:d28c:b0:130:efc6:9790 with SMTP id d12-20020a056870d28c00b00130efc69790mr3208285oae.2.1665595346070;
        Wed, 12 Oct 2022 10:22:26 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id g187-20020acab6c4000000b0035468f2d410sm4705318oif.55.2022.10.12.10.22.24
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-132fb4fd495so20176275fac.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3072194oad.126.1665595344160; Wed, 12
 Oct 2022 10:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au> <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au> <20221012115023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221012115023-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 10:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: fixes, features
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        angus.chen@jaguarmicro.com, gavinl@nvidia.com, jasowang@redhat.com,
        lingshan.zhu@intel.com, wangdeming@inspur.com,
        xiujianfeng@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 12, 2022 at 8:51 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Are you sure?

MichaelE is right.

This is just bogus historical garbage:

> arch/arm/include/asm/irq.h:#ifndef NO_IRQ
> arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))

that I've tried to get rid of for years, but for some reason it just won't die.

NO_IRQ should be zero. Or rather, it shouldn't exist at all. It's a bogus thing.

You can see just how bogus it is from grepping for it - the users are
all completely and utterly confused, and all are entirely historical
brokenness.

The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does

        if (dev->irq) ...

which is why you will only find a few instances of NO_IRQ in the tree
in the first place.

The NO_IRQ thing is mainly actually defined by a few drivers that just
never got converted to the proper world order, and even then you can
see the confusion (ie some drivers use "-1", others use "0", and yet
others use "((unsigned int)(-1)".

                   Linus
