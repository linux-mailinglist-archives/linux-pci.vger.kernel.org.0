Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B597617DC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjGYL7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjGYL7q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B21BE6
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690286324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKY2MPeb4smYu5MumkdrZH64DY2ngZB1voGt9dh+JFo=;
        b=P/E5MJzJpuwl8dFY4PplaHyEgYZmGXDXrH9yjyKl/bC3nlkqU92P1O9J96ozLRcIAlBczt
        hyn0Nwc3HvfxHHFv89I70/9eU94zJwaoxSmjqMndUYQ4wxanZkwQJpSFKs6HxgHGjKk0qK
        szNx1ksYtTzz4jwyZd4rmQKxIYozSg8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-2XbsTez4MZ2CED6ClvQxIQ-1; Tue, 25 Jul 2023 07:58:43 -0400
X-MC-Unique: 2XbsTez4MZ2CED6ClvQxIQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a348facbbso320096966b.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 04:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690286322; x=1690891122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKY2MPeb4smYu5MumkdrZH64DY2ngZB1voGt9dh+JFo=;
        b=l4pKEm0v7W3PbigjPR8ECXTvnuUs+DwHG1qqKvfnogcBH1JbNBEMj9xvOF0xY1pn20
         SAarVaY8w2XBKwpRttpImLPzSHB4kO/zkgmehdc80sTfCXZ/t+/4iI/SleM3qKTPJU4O
         Ohs7I81/s5mJofSbEnrjNIA9Ydln3aooPnGCGTekbC66ZoxG3GfdodYfH5SYMpEeRD8s
         jC4dG3nZxlwafmok0/pjcQ8UM4kejyFQaKFsRltHSPf32VSpqz2xhwG2KApvaEi1FImq
         khTCguqQiAOrhFKm/e05k/nSe+4xfpNq+usu0MoqHtQ8GxDW1801XOYbjTjTZFfv0hfC
         RzCw==
X-Gm-Message-State: ABy/qLbdizFTESe3M1IZGKBHcws97QH/IpMc5smQHhinKYQCSHS4Lywk
        Mds46dtODbZ1i9sdYmbpfb69od19ZgnQmjCh6MJT/1QAtgFBcMDTBaQkdg/7w/jzjAf/Ap5nZeT
        yggChaaVEMq/3tD0+5q+D
X-Received: by 2002:a17:907:2bd7:b0:94e:4489:f24d with SMTP id gv23-20020a1709072bd700b0094e4489f24dmr13455007ejc.61.1690286322745;
        Tue, 25 Jul 2023 04:58:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8XjFaubLjf5xjlqvjWeOHrAsSfNf1ItjGgd+HwNMXv4SAHImD2/nVnuly/gLkvw5uOJLVtw==
X-Received: by 2002:a17:907:2bd7:b0:94e:4489:f24d with SMTP id gv23-20020a1709072bd700b0094e4489f24dmr13454996ejc.61.1690286322505;
        Tue, 25 Jul 2023 04:58:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id pk4-20020a170906d7a400b00993004239a4sm8086695ejb.215.2023.07.25.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:58:41 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:58:40 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] hack to debug acpiphp crash
Message-ID: <20230725135840.1edbbf61@imammedo.users.ipa.redhat.com>
In-Reply-To: <d1333a63-c6b8-fe9a-24ce-05d2198323c2@gmail.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230724135902.2217991-1-imammedo@redhat.com>
        <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
        <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
        <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
        <d1333a63-c6b8-fe9a-24ce-05d2198323c2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jul 2023 07:45:08 -0400
Woody Suwalski <terraluna977@gmail.com> wrote:

> Igor Mammedov wrote:
> > On Tue, 25 Jul 2023 10:06:44 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >  
> >> PS:
> >> What happens is that on resume firmware (likely EC),
> >> issues ACPI bus check on root ports which (bus check) is
> >> wired to acpiphp module (though pciehp module was initialized
> >> at boot to manage root ports), it's likely firmware bug.
> >>
> >> I'd guess the intent behind this was to check if PCIe devices
> >> were hotplugged while laptop has been asleep, and for
> >> some reason they didn't use native PCIe hotplug to handle that.
> >> However looking at laptop specs you can't hotplug PCIe
> >> devices via external ports. Given how old laptop is
> >> it isn't going to be fixed, so we would need a workaround
> >> or fixup DSDT to skip buscheck.
> >>
> >> The options I see is to keep old kernel as for such case,
> >> or bail out early from bus check/enable_slot since root port
> >> is managed by pciehp module (and let it handle hotplug).  
> > scratch all of above out (it's wrong). Looking at DSDT
> > firmware sends Notify(rpxx, 2 /* Wake */) event. Which
> > according to spec needs to be handed down to the native
> > device driver.
> >
> >  
> I agree that this laptop is a tricky one. I had to adjust my kernel 
> config NOHZ just to make it suspend to ram, otherwise it was waking back 
> right after going to sleep (and the same nohz kernel worked on all my 
> other machines)...

Blaming laptop is likely red herring in this case after some more reading.
Anyways I've just sent a new round of patches to test.

