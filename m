Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590854C53A7
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 05:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBZERa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 23:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZERa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 23:17:30 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304252067C1;
        Fri, 25 Feb 2022 20:16:56 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id j201so2535439vke.11;
        Fri, 25 Feb 2022 20:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlz5lW5Mjko+FKIXQXxAuW16NWPm12e+1Hy+bd7Mx6w=;
        b=Uz9h9hvX43DtDQmuumxT1Zmmcx6xPCLXQ0hmqAZG5NLgfVyndIWnNP1/SfAPRnbcpw
         dTuD2S8v+nr2w7o6Ix6PXbohV1T2AWwMgAC6skWx1FBY5GQEYkOOqdJV7X1+wYjYb96n
         rgv22li1xTHhPWPCIG94PsRbitLlWM9qUHMbFC8+BHNahcBVdqafZZp/8UyawM3lV2as
         hLym20TFC6z6w31JKSWnlFnuYMSPMqiMpen38UcqcS0FwNj12zNwwjLL7wDx3L1Ix5vF
         L/xqEvSCs3V5LQ55MA+anIcwETlcs87JAdfoGkCV5dD+97145ZpYNGPcV4ng36oxbQ0u
         hOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlz5lW5Mjko+FKIXQXxAuW16NWPm12e+1Hy+bd7Mx6w=;
        b=P4iq6mE+3fynk0S8QM36vdlPBKXHLaKsxOLB6egJbXxrtrZyjN0HByk4Gis36B3Wuu
         2hKl8rOeq1lkSLdUDmaZHINRIR5QfYUeT3IP5Wg2GFDiX8E9/DaTqjaUhcsSF6dYnagy
         O0dDYZdFytwb5phKiCFdBtRYQAIh827UthFxQ/xv6AKr6XUQ5Fd+dGt30G7t+1v70KUA
         xdtThnmgKZIv7f6fDItzDGCYSLsL0KgWXSmEdVbtYWubkt6eHMwfc5sHXb1svEX94K2s
         12AP4bpvqwFBIF1SzCNHZJQe1j8HfmUj12/gYs3dAjzSPFz+fKHMFbEqHnRCID82lHOD
         sEzg==
X-Gm-Message-State: AOAM532AOwaxjG89/bClZ//PYkGDAbOLX8LZZCq0i97V3Fp52PVw+xTa
        f6fEJOdUzw3dWN8mRcz6GQRAmQXqcWm36KkV6F0=
X-Google-Smtp-Source: ABdhPJwYRO82iUobOAIaLCi1t7YVNRWIVT3kqXeye6le29zqLubyWdpBRMZMQPg0JqJxvRtmaAESk1aLCAiVVR1/JEc=
X-Received: by 2002:a05:6122:1898:b0:32d:5227:d967 with SMTP id
 bi24-20020a056122189800b0032d5227d967mr4755411vkb.38.1645849015106; Fri, 25
 Feb 2022 20:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20220223051545.572235-1-yusisamerican@gmail.com> <20220225181927.GA368545@bhelgaas>
In-Reply-To: <20220225181927.GA368545@bhelgaas>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Fri, 25 Feb 2022 20:16:44 -0800
Message-ID: <CAJoG2+-XfTNcu+C92B=b6k_Wa54E=fTQhh1DXK0-fuUuWmvwUA@mail.gmail.com>
Subject: Re: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h" KPI
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        tiwai@suse.com, perex@perex.cz, alex.bou9@gmail.com,
        mporter@kernel.crashing.org, logang@deltatee.com,
        kurt.schwemmer@microsemi.com, Bjorn Helgaas <bhelgaas@google.com>,
        kw@linux.com, robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-dma-compat.h is included by pci.h so files that depend on it don't
(usually)include it The patch removed function calls to it and replaced them
with dma-mapping calls since that's what it wraps.

As I failed english in school I don't understand half of what you
said, that said
the link to "More tips" was helpful.
