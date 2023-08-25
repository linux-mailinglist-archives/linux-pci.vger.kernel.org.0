Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FCD788296
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 10:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjHYIpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbjHYIpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 04:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E901FFD
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692953005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCP2Xqg2OKBHB7tOPm2sgvbABZBA3Of3A/9A5xghgpE=;
        b=U7/fevyiUWSc/8VuKZ6EdR4+TBdZ/Q0qfVC+HgPYPf94qK2Yh7OYWoD9ni3lqDqLiAdi6s
        Yrf3yL6oZrIdPIreNR71YGr1Nfn+JjujGfdDySXOZK3mbYduTSLdWtojJE7s9e4w26xMkr
        HHglevMhqt2NqUWsNWm7ihR7oMIGMwI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-oSO4fmh6OgqP43O1gm9zwA-1; Fri, 25 Aug 2023 04:43:23 -0400
X-MC-Unique: oSO4fmh6OgqP43O1gm9zwA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9ef9b1920so683468a34.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Aug 2023 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692953002; x=1693557802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCP2Xqg2OKBHB7tOPm2sgvbABZBA3Of3A/9A5xghgpE=;
        b=kT4C2mZYGBi2FwJeXFKDPO6OL3vzlSMBUU/qaUzpSokpYl4ABIaJF9vwIaf422i8zF
         cZTnZgxIw37oh5+2/vh0YE3I6xG/b3Av0aOYt5nUaZvJn8a8rSK2b5FBN2dobX1HW4eO
         vxGDfX//KnNfjxAw5oaLzXnlfzTlZJoogzU+scn/hDFXbk+c4bJMSdXpvM1D+KkXeMmO
         wcz2vHMIAkhMxK+z9nfju6XEs9E5elO9XOCIDF47uMeZRGWxVi7oykCtktBitCEvYt5H
         KfNknboIDt4RmswPf/yxSEiya6A7qMsP1G3QYGE2g7jAB9kxpFsAtAijxrq6sQYpiJHo
         g/xQ==
X-Gm-Message-State: AOJu0YyfGCjjAV8v7L20UhjJ4OVRAiJ3OvBvRMOG+teXZn9wtsxGvzRP
        UfduHMcDnDx5IsBqOVMgaoRrouoad0yM+73JUr/sO/7UgZtgmGdCUZdsn1J4U8krnHjvou69wa+
        eE8FUTvws5vvrG7UUy4ncBGLSq6+qZ5T7JTUK3YqN+2KJCQ==
X-Received: by 2002:a05:6870:d1ca:b0:1c8:39a6:77a9 with SMTP id b10-20020a056870d1ca00b001c839a677a9mr2329016oac.31.1692953002302;
        Fri, 25 Aug 2023 01:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Z/kiU7ATmiquWx9l1gQfwBTS3mrikpiiF2jq2BCklQjFyUDEiDnWhj/JdW/QWLIfyvO23NoK11yKVsyDc2E=
X-Received: by 2002:a05:6870:d1ca:b0:1c8:39a6:77a9 with SMTP id
 b10-20020a056870d1ca00b001c839a677a9mr2329007oac.31.1692953002103; Fri, 25
 Aug 2023 01:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com> <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com> <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com> <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com>
 <20230823090525.GT3465@black.fi.intel.com> <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
 <20230824114300.GU3465@black.fi.intel.com>
In-Reply-To: <20230824114300.GU3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Fri, 25 Aug 2023 10:42:55 +0200
Message-ID: <CA+cBOTej22hWEFvMOnFfKy16tuzS_+S7kccPPYXNoGVbYMoEdA@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 1:43=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> One thing I noticed, probably has nothing to do with this, but you have
> the "security level" set to "secure". Now this is fine and actually
> recommended but I wonder if anything changes if you switch that
> temporarily to "user"? What is happening here is that once the system
> enters S3 the Thunderbolt driver tells the firmware to save the
> connected device list, and then once it exits S3 it is expected to
> re-connect the PCIe tunnels of the devices on that list but this is not
> happening and that's why the dock "dissappears" during resume.

That was a great suggestion. After switching to the user security
level, the resume delay is gone, and my dock devices seem to be
working almost immediately after resume! The dmesg for that is here:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1985262

I've done tens of cycles and haven't found any race conditions, unlike
with the TB assist mode. (Only once, my USB mouse wasn't working at
all, but that's something that occasionally happens on most docks I've
worked with and seems to be some different issue).

I'm sorry I haven't found this earlier myself. I did try switching
these options, but I bundled it together with enabling the TB assist
mode, which has quirks, so I didn't realize switching just this one
option might have an impact.

> In any case we can conclude that the commit in question has nothing to
> do with the issue. This is completely Thunderbolt related problem.

Considering the information above, does this appear to be a solely
dock-related issue (bugged firmware), or does it make sense to follow
up on this in some different kernel list? I have to say I'm completely
OK with running the laptop using the "user" TB security level, but if
you think I should follow up somewhere to get the "secure" level fixed
(or some workaround applied, etc), I can.

Thanks a lot for all your help debugging this, Mika and Bjorn.

