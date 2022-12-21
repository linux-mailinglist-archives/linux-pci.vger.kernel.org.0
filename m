Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97138652D24
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 08:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLUHFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 02:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLUHFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 02:05:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351CF2A
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 23:05:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w20so8076318ply.12
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sa/I/7gVZaIQy7B1ZRMHInqzdjhXIObW4yJN5eIb0s=;
        b=O6PraZUESnwbOholnhjgplj9xv51g9sGEVY8NhsjgGTLrtwdyLSpcy0hoDX94TLpOM
         ZLtIi5w3Xaw+kDPdXAKAd4uQybBVnl3NhdP8baIsgh0xxPJfwH316rvbIt08yN+SVFBc
         Em1QxCO/rC8nBxgI+dOUE46YXMb7IexbUy0+CdTSC1EIy+Rv9S3Q5xnA2NxRxIS+klwG
         smbNQkEXEYHiNtF4LRNDHBJ8rnVk0NROrkfDiFiCYNOEm+UYFZ/xMn/WjDCm9Ah2p9ZB
         1vUHjeklLjFEGi/8nFgo7OJpH6ClxYT9lmQPOdmyfvJZ2XywtGy7VcDizXeYQvsoHt4H
         aaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Sa/I/7gVZaIQy7B1ZRMHInqzdjhXIObW4yJN5eIb0s=;
        b=NzFoS3HWMgF5Oiuxtv78SDvHLQ7M4rDplCHMugtqG7NDikSlzyAPJHXdK2/+WbdBNh
         um/HBZ/CFeOYY1dy0UXwBwY1AyuVjJUoRx3oOdvYum1ehZpjljB1qCOcnZ/42562gYG8
         zsVz3I0QfBulJRZj5SkCWZpbAXwXnbCzudlBJyhjce3AzeNeXGEPJHy4XwWVks3tF2Va
         3qINx6ffAHr2RuHMBDzHViSZD1IYEnDvoWsyaK4t4yJUWZdr7OoIkFhwK4zlXxSPrOo6
         woOJXmodWQ83t0GGPWJmq/KG2SaY4Mrqjqz4iVfj6scBK4MTH2roRIjrvD1x8SEnYz1c
         qifQ==
X-Gm-Message-State: AFqh2krzloA+cYzVFkKbaBFnvicSE+KRjO1itN1PtJfdNsW5qLQoJvo9
        P60VuG33T0FOpq6ZIvtAlKBkDfkP3uz6nPKZiuVveQ==
X-Google-Smtp-Source: AMrXdXvI2GJq84khAIseirWSINYK4M29Z94nEO5s+eBoaKJPpgioRv51ok/p+Qy7fV6OS5HQxAg+rm39/gGG8ulXdnk=
X-Received: by 2002:a17:90b:8b:b0:219:19c1:1ae7 with SMTP id
 bb11-20020a17090b008b00b0021919c11ae7mr79160pjb.13.1671606345295; Tue, 20 Dec
 2022 23:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com> <20221221013907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221013907-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Wed, 21 Dec 2022 09:05:08 +0200
Message-ID: <CAJs=3_BuiRj2ZGQM7wVfpUgGNMR_24jv3h0fv+swBk54Gmr6uw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Please post a follow-up ASAP. I can squash myself if I rebase.
>
> Thanks!

Sure, I'll do it now
