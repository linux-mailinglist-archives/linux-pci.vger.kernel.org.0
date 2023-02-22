Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036C169F4FB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 13:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjBVM6q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 07:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjBVM6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 07:58:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C33B3C1
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 04:58:39 -0800 (PST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 430D63F71C
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677070715;
        bh=iMk87gysA4eaHAIflp61kjRjI9XPCsP7SLQze3YejXk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=C1jhWBMGF5pE/muRM0z1xm1k8EGu91Z46LGaRJq45irwnJwoBgfMYU0iVT5NKVAXO
         Cz4YOLkHl9voEI5K6eiPG1WuUzhvGD883lGPGxzmLrQrFN5cAYLl2npd7Lqhx4Zj20
         Ivmf9LwAi7WOenqQZke3T6imHwcJBlB49eGvYbzUufiQ1H6nmZH86d8mJlVDRxwryh
         FWdSxCXGwAIYGoAS3UwuaeLAOtQhcEK5SZXsg9FDxEUT3JmBg9w3qyZcTYqQ79u/xW
         rAeLFT/230xJwB+FUscnpqOhNweXLVvtbqo63oe/OPntCA/n3nKyAyAPD/QMfrSZQY
         FT4pe7uVVy1JQ==
Received: by mail-pg1-f200.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso1449448pgg.21
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 04:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMk87gysA4eaHAIflp61kjRjI9XPCsP7SLQze3YejXk=;
        b=0TQGTKKi+EJoYVLcXpJSiAiauGYj9ViRejjqJ9CttfffPE6c7kJdnsXaM5llr+B021
         JBlebgZKT/9QLyhSShLXeHyphN4aUYJEVcB9zs1fg33bNj0Svv3TbQ7jRbsuNqvdupcI
         saHHRjuvDwfC2oVE36tD/GV3Bej72f/kA2e+pSm/jQ3PPPLUrct+oMOs4c7J/TlWIUzd
         xBI91stN5AsY013k3HOhKRagE96tOqCN+xdAYmimuKeudDBdI3ycM+jmbdgO3SzePG+k
         z2ytdnQaaWuxg6E28Rnx+ESxLciDqwusp9soLGMQJ35RDJWWEN3MWbR0e3A8LmgTgqT7
         t4Sg==
X-Gm-Message-State: AO0yUKXqKM40xm0FOaCY8cPLx/8X5MTUY68Ujuw2PMWPLVZs5kMFpfOJ
        OTYc+d38IWbfjptYMybOzQDQr+tXU5vG3yom1eQ3Vv+65JafbjHQ0orEtetIDWlLnnYOWgg1Qhv
        kzn5Ft6Z21Smqti8UB050s8A6HVGO1ljJI7PmpIjXWd0IaBdpDR8zXQ==
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id so7-20020a17090b1f8700b0023718922548mr1308262pjb.44.1677070712473;
        Wed, 22 Feb 2023 04:58:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8t7GH+/5kt3d+6jt2bifRD+Qrs2oMsHfDIkP9dJPLZIOBlT5vzRFzw/4YigtGXfjFuxQ9kqWRbXfqAHuTtwBU=
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id
 so7-20020a17090b1f8700b0023718922548mr1308255pjb.44.1677070712173; Wed, 22
 Feb 2023 04:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221023849.1906728-1-kai.heng.feng@canonical.com> <c21a3f74-871c-8726-f078-b4c2c3414ebd@gmail.com>
In-Reply-To: <c21a3f74-871c-8726-f078-b4c2c3414ebd@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 22 Feb 2023 20:58:20 +0800
Message-ID: <CAAd53p5k5BrdHz6oAuviymdYNRJ_NGxDs_TAe2M=0W6xj2o5KA@mail.gmail.com>
Subject: Re: [PATCH v8 RESEND 0/6] r8169: Enable ASPM for recent 1.0/2.5Gbps
 Realtek NICs
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd@realtek.com, bhelgaas@google.com, koba.ko@canonical.com,
        acelan.kao@canonical.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        rafael.j.wysocki@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 21, 2023 at 7:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.02.2023 03:38, Kai-Heng Feng wrote:
> > The series is to enable ASPM on more r8169 supported devices, if
> > available.
> >
> > The latest Realtek vendor driver and its Windows driver implements a
> > feature called "dynamic ASPM" which can improve performance on it's
> > ethernet NICs.
> >
> > We have "dynamic ASPM" mechanism in Ubuntu 22.04 LTS kernel for quite a
> > while, and AFAIK it hasn't introduced any regression so far.
> >
> > A very similar issue was observed on Realtek wireless NIC, and it was
> > resolved by disabling ASPM during NAPI poll. So in v8, we use the same
> > approach, which is more straightforward, instead of toggling ASPM based
> > on packet count.
> >
> > v7:
> > https://lore.kernel.org/netdev/20211016075442.650311-1-kai.heng.feng@canonical.com/
> >
> > v6:
> > https://lore.kernel.org/netdev/20211007161552.272771-1-kai.heng.feng@canonical.com/
> >
> > v5:
> > https://lore.kernel.org/netdev/20210916154417.664323-1-kai.heng.feng@canonical.com/
> >
> > v4:
> > https://lore.kernel.org/netdev/20210827171452.217123-1-kai.heng.feng@canonical.com/
> >
> > v3:
> > https://lore.kernel.org/netdev/20210819054542.608745-1-kai.heng.feng@canonical.com/
> >
> > v2:
> > https://lore.kernel.org/netdev/20210812155341.817031-1-kai.heng.feng@canonical.com/
> >
> > v1:
> > https://lore.kernel.org/netdev/20210803152823.515849-1-kai.heng.feng@canonical.com/
> >
> > Kai-Heng Feng (6):
> >   r8169: Disable ASPM L1.1 on 8168h
> >   Revert "PCI/ASPM: Unexport pcie_aspm_support_enabled()"
> >   PCI/ASPM: Add pcie_aspm_capable() helper
> >   r8169: Consider chip-specific ASPM can be enabled on more cases
> >   r8169: Use mutex to guard config register locking
> >   r8169: Disable ASPM while doing NAPI poll
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 48 ++++++++++++++++++-----
> >  drivers/pci/pcie/aspm.c                   | 12 ++++++
> >  include/linux/pci.h                       |  2 +
> >  3 files changed, 53 insertions(+), 9 deletions(-)
> >
>
> Note that net-next is closed during merge window.
> Formal aspect: Your patches miss the net/net-next annotation.

Will do in next revision.

> The title of the series may be an old one. Actually most ASPM
> states are enabled, you add to disable ASPM temporarily.

Right.
Most hardwares I have access to don't grant OS ASPM control, so
tp->aspm_manageable is not enabled.
Will make it more clearer.

Kai-Heng
