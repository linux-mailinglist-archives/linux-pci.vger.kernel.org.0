Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E85A5CF5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiH3HcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiH3HcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DC6BCC0
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661844724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOVt4IExjzgPDgf7VEi0MGTcB1ysxhPeqK70kuHJ9WU=;
        b=Z0RhLBBVHTw/Q5lAqB/4Cem3961adus69y0eJixyLNE5m9sQ7GXSO5MgogHYT6/HPBUCdU
        UZ1pLcirPJ8P0yp2vPMDssSqvKfSP/IaZiRc+6DePcdGXnZo6g26smm340VFN4IaMYCiPO
        HN9zRQTbjXYW7prBKXPO4l0B9FLGKKA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-4DtVMB_bMmuWsV3Tr8uA6g-1; Tue, 30 Aug 2022 03:31:57 -0400
X-MC-Unique: 4DtVMB_bMmuWsV3Tr8uA6g-1
Received: by mail-ej1-f72.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so3450252ejc.8
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=OOVt4IExjzgPDgf7VEi0MGTcB1ysxhPeqK70kuHJ9WU=;
        b=cFeEvv8AZ9NcEa3XvK6QT0oVdrei0dCv4d7JGEIQ6uJA8VznY+OYJ5sBf9n0JkQwKJ
         cnoQwmFaGcggl/eFFlFa8Has/CK1D3yYeiE2LRjlIM1hsebR74suSKpDkmC39sfSP6P8
         qHhqF2jAQ+iiwh5xDvVgMxfwXxEhy1rCmmvTWgHNAGKB9vC1ROG5LUhHFPA2IZ/A8nfH
         dTJxrpovIAfNXQtw1bE5WalOKC2hFpawW3zCnIN2sAhGqS1jx6nlENVecQJpjZIQ9I3x
         bCbioOODGl6XvKKI9UciPzgOKhZxDBMxd4WGiP/N4byOyJMeiNiLk/IFKyFE3154tjoT
         63lA==
X-Gm-Message-State: ACgBeo124BdCPuiZvJYxHTE6hmKEJI+stbux+emYPWCn907/kNJWcp0b
        JNTiwI5c0AMiD/hxgdzvDjE0CES3XxLgKGwLDnYWrq71k9M1sLSTJBVAf4NEj4YR2kDbopM5nML
        U2jO2TS1O+UYO/XRvWeYx
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id z3-20020a05640240c300b00442d79848admr19117004edb.154.1661844716130;
        Tue, 30 Aug 2022 00:31:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5geuesvzHhVoqBxInKeA8loMmBCSHKoxr3j6EnwNKzcho7wEaeR3bBW9svuet4LzxXa/fI2w==
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id z3-20020a05640240c300b00442d79848admr19116988edb.154.1661844715957;
        Tue, 30 Aug 2022 00:31:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b00731745a7e62sm5367557ejg.28.2022.08.30.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:31:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 1/3] PCI: Move
 PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to
 pci_ids.h
In-Reply-To: <20220829171508.GA8481@bhelgaas>
References: <20220829171508.GA8481@bhelgaas>
Date:   Tue, 30 Aug 2022 09:31:54 +0200
Message-ID: <875yiauqz9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Sat, Aug 27, 2022 at 03:03:43PM +0200, Vitaly Kuznetsov wrote:
>> There are already three places in kernel which define PCI_VENDOR_ID_MICROSOFT
>> and two for PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these
>> from core Vmbus code. Move the defines where they belong.
>
> It's a minor annoyance that the above is 81 characters long when "git
> log" adds its 4-character indent, so it wraps in a default terminal.
>
> It'd be nice if we could settle on a conventional spelling of "Vmbus",
> too.  "Vmbus" looks to be in the minority:
>
>   $ git grep Vmbus | wc -l; git grep VMbus | wc -l; git grep VMBus | wc -l
>   4
>   82
>   62
>
> FWIW, one published microsoft.com doc uses "VMBus":
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/hyper-v-architecture

Makes sense,

Wei,

assuming there are no other concerns about these patches, would you be
able to tweak the commit message here when queueing or would you like me
to send v4 instead? 

Thanks!

-- 
Vitaly

