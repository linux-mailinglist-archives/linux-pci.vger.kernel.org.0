Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CB5FCE2B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJLWKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJLWKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 18:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488B44560
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665612514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1Csc5OKDLMm08qWQhJj0nFioDDfbxhqyYmrCk7iHHE=;
        b=KGFH2YlHvLrMbBRzhjzeIaDpOKpngMQcXphoNWQcmMq60SieZHdHr1X7o72DvGNIjY3bTm
        hLDc7PkCjBh/OyLDHZzLJlGn32jTWGnMoWoL3qqotXVSR9Lo/gjfXc40DVwO49isR1jgNf
        VBbu3nMX+Zhqt4Me7aqa+u4nfSL2udQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-hI43in_CNOqrZmzRe-vc3w-1; Wed, 12 Oct 2022 18:08:33 -0400
X-MC-Unique: hI43in_CNOqrZmzRe-vc3w-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so1810630wma.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Oct 2022 15:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Csc5OKDLMm08qWQhJj0nFioDDfbxhqyYmrCk7iHHE=;
        b=Hu1C5KGqurbUgX8XjCc9saCGCFw+0NYphnn8u9VKdmWagzZaKiPm7XR4Wj1NlfeXsl
         FHapQLBoa5rIrX/M1wEirPSZTp0x72osBZDIZO9exk3DgdEoP112gjKSHlRI/jKcv1w9
         NqdJJJNadMwjprAwfqJjl8AMWw5EjuRs9B2/DVmKKANIqvTJcVi6ueymgw46JMU7Gaxf
         ekxmcG7yvKAZuQm/CKS7O3XuzYay6WldI6lJkxh1lXV0NUadO5WU+6SFZbP5TN/bkbB3
         KwAk0GtjSy7g3+7vcDuMuYVHf5ND7W5NX6+e+c9iydN66eF1yYARH0OSt47G/28MRjx9
         NPvQ==
X-Gm-Message-State: ACrzQf1cJNuPQcQy7yTqiEHW3uGC3QH1wUnE8qZ68k5XZ56TYs+djTMk
        TCfhtfw3XrfhX1fZNZan76TToYvNyPJs9yoTD4B2JjCLcc94t3vyIvHMPYtsW7qmKiTD0J7pCmN
        KC3MAjNifo2cjFHi+WrYK
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id b12-20020adfd1cc000000b0022e637165admr19590799wrd.326.1665612512756;
        Wed, 12 Oct 2022 15:08:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Hfapj638ZSQQKBud2DiNS0QJza/l7oyJMq2zEMTl7MZoMYSzTy3MWiISMgB3bUUa2AIbrEw==
X-Received: by 2002:adf:d1cc:0:b0:22e:6371:65ad with SMTP id b12-20020adfd1cc000000b0022e637165admr19590785wrd.326.1665612512531;
        Wed, 12 Oct 2022 15:08:32 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003a5f4fccd4asm2812081wmq.35.2022.10.12.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:08:31 -0700 (PDT)
Date:   Wed, 12 Oct 2022 18:08:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        xiujianfeng@huawei.com, kvm@vger.kernel.org,
        alvaro.karsz@solid-run.com, Jason Wang <jasowang@redhat.com>,
        angus.chen@jaguarmicro.com, wangdeming@inspur.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, lingshan.zhu@intel.com,
        linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
Subject: Re: [GIT PULL] virtio: fixes, features
Message-ID: <20221012180806-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au>
 <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
 <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
 <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38893b2e-c7a1-4ad2-b691-7fbcbbeb310f@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 12, 2022 at 11:06:54PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 12, 2022, at 7:22 PM, Linus Torvalds wrote:
> >
> > The NO_IRQ thing is mainly actually defined by a few drivers that just
> > never got converted to the proper world order, and even then you can
> > see the confusion (ie some drivers use "-1", others use "0", and yet
> > others use "((unsigned int)(-1)".
> 
> The last time I looked at removing it for arch/arm/, one problem was
> that there were a number of platforms using IRQ 0 as a valid number.
> We have converted most of them in the meantime, leaving now only
> mach-rpc and mach-footbridge. For the other platforms, we just
> renumbered all interrupts to add one, but footbridge apparently
> relies on hardcoded ISA interrupts in device drivers. For rpc,
> it looks like IRQ 0 (printer) already wouldn't work, and it
> looks like there was never a driver referencing it either.


Do these two boxes even have pci?

> I see that openrisc and parisc also still define NO_IRQ to -1, but at
> least openrisc already relies on 0 being the invalid IRQ (from
> CONFIG_IRQ_DOMAIN), probably parisc as well.
> 
>      Arnd

