Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B25917AC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Aug 2022 01:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiHLXzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHLXzD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 19:55:03 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580966A5D
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 16:55:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e205so3505643ybb.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bLYym+odgwpeMFEmoqhG8B5fPLIFcCkrvxdH9rfX5Zs=;
        b=cIB+N9SLj46PFP0BruIvmlALxQc65JJRFAatZOB4CG/kzZ7UV7GwHsM0W0lxs6PNhY
         TxFJGsAqouPVGMODYR2lV6WW7s4F+Gya2Vbm12qsmtEI4OqzW74uw0zOoRFowqzKs1jI
         AaMxnqkyLfkhhcujJneCJ860l3D8UMn+hZwLB6WwivqUd5aSgVJDDsYQYUaa2Vu3Y9Ta
         /iKXCo9PujQ5eC7/P3Em7zq6XoSlGQDnG6bEqZtr2fwNQ4C6URfOmOitwTm43EG/LesS
         58mb26NTVY+u1NBvDcVnud2NuTw1AjwpGZ7J7mjEa5r7mggac5G8WK0PSSdbJo5nlSoj
         qFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bLYym+odgwpeMFEmoqhG8B5fPLIFcCkrvxdH9rfX5Zs=;
        b=Isi7XYpf5MPpnouk15ilJQLgNE14qHhV0hE0KOpXoWroL2x8MB/jqntBGcChWD1OaF
         DBnevq7l19PGEqvgqTizGIBeG/rOArmfXIavULVQwPZ8hSyspqxoW515ctJhsfUmn63G
         8ghWtblkzbeP+Y6QyzWhHNFczRvIQxP6OafiFW4W5hRAYl6lE+eGDfIvQN+VSG7XR5OD
         zYWRAJgs5DHNZodxgzicMLqmK0L15yiWy9cJBJRQMFOpGPsjWY+YUFBSgKLqvMCk457g
         LWfQzfzHkVSuQ4P3i6mUYx8v2vXyOAo8lHsWIhJr8skDivPA8A8g0lgfx3Llcr72hWQS
         qnbQ==
X-Gm-Message-State: ACgBeo0/YHYghg0T/A/3Z4mF313T+XMxkqYVrQsgSa9UzhbyuViD8S+/
        ZaJ/94dXwcVJwVz9njjDgv7RAeLa+wvdfTfNbK/enQ==
X-Google-Smtp-Source: AA6agR7By7pr6dtco57EwxJaAqWzVc8fkjbB5JVPyrYeu66yWySpSHhjwVyqm88zTSJYzWqMd3r8KjybpgN/ilA/kCU=
X-Received: by 2002:a05:6902:2cb:b0:684:aebe:49ab with SMTP id
 w11-20020a05690202cb00b00684aebe49abmr2011800ybh.242.1660348501605; Fri, 12
 Aug 2022 16:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <62eed399.170a0220.2503a.1c64@mx.google.com> <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc> <YvEEidOZ62igUYrR@sirena.org.uk>
In-Reply-To: <YvEEidOZ62igUYrR@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 12 Aug 2022 16:54:25 -0700
Message-ID: <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on kontron-pitx-imx8m
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 8, 2022 at 5:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Aug 08, 2022 at 02:35:38PM +0200, Michael Walle wrote:
> > Am 2022-08-08 14:22, schrieb Mark Brown:
> > > On Sat, Aug 06, 2022 at 01:48:25PM -0700, KernelCI bot wrote:
>
> > > The KernelCI bisection bot found that 5a46079a96451 "PM: domains: Delete
> > > usage of driver_deferred_probe_check_state()" triggered a failure to
> > > probe the PCI controller or attached ethernet on kontron-pitx-imx8m.
> > > There's no obvious errors in the boot log when things fail, we simply
> > > don't see any of the announcements from the PCI controller probe like we
> > > do on a working boot:
>
> > I guess that is the same as:
> > https://lore.kernel.org/lkml/Yr3vEDDulZj1Dplv@sirena.org.uk/

Yeah, that series caused a bunch of breakages. So I sent a revert
series and then started working on the proper fix. I sent out the
proper fix a few days ago. Can anyone give this a shot?

[1-] https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

Mark,

While you are here, I'm working towards patches on top of [1] where
fw_devlink will tie the sync_state() callback to each regulator. Also,
i realized that if you can convert the regulator_class to a
regulator_bus, we could remove a lot of the "find the supply for this
regulator when it's registered" code and let device links handle it.
Let me know if that's something you'd be okay with. It would change
the sysfs path for /sys/class/regulator and moves it to
/sys/bus/regulator, but not sure if that's considered an ABI breakage
(sysfs paths change all the time).

-Saravana

>
> Looks plausible, yes.
