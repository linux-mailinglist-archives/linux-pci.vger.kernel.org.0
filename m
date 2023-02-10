Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC06691B94
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 10:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjBJJha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 04:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjBJJh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 04:37:28 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904C3754C;
        Fri, 10 Feb 2023 01:37:27 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id cz14so3942599oib.12;
        Fri, 10 Feb 2023 01:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhBKLc8M9hV3t5uIfo5QFAwuXf0QmrmGOwQu6l1qMrs=;
        b=KHWJ46IEVS2ZdTQy8gh3CYozLmL/kVC+EMT9ZGlD8/f3jtIe/ZasihjMyJ877fk8D3
         BEAZ1tcL4tdfnnWYKWU6ZTbBJhTRDJfkg2JWFK0yslqv6+ySscy0+OoTzjplIgqixLkw
         gQiKnFIVUIBB10Drs7ap3/B0nz3CSuusfaZx1/qbGudJz22cSkt5hp7uAne+ITEExyAU
         3+0Oj2aJUoyeQFCoYqT0bmrWSm41PTFpaGSy0NLZjqbpoR6KrsnZRf42EWnXkS2OCldG
         GVcr0n2HG23Mq8VMsUIpFxAla3rr2egtMK/pETUaKNnyMrHOlr5961llVEMR4SoNMtfN
         a5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhBKLc8M9hV3t5uIfo5QFAwuXf0QmrmGOwQu6l1qMrs=;
        b=zrLnDPrMcFtpT15wOUmbNbwcEarCA8pMLq7qwicaGcPJD/HXg15I3+i3BgVXHfRTgr
         gCrXW6whhMSo131zKAyXLQtT6Q0nJZn4cKjA+88xyWoycyFdU92OMCZwpYVuzdRJljyG
         Mnu1Jjnf2saO891hhvVOdDGGgluC7GmQ2P9cJ3wvcEBzCUOjn/0vJ1adk50nfZNlYbUf
         lbvkmw7RD6Cg9C1c4lFb4HLVpAK/mdVYaxW0GASzvg7xmlev7lVcdQDwJWzuMWamjPRj
         /WieGILsHBe/KJNSo1BS/KUt1/94G3eiYDRTvairZK5yfCP2+Z+vXaVJ+1Ic0W6OwHV1
         ChyA==
X-Gm-Message-State: AO0yUKWvYxqV4LS/MaPEKtuYj7ZLgeaxzzshMWAalAXiijldfoV/J+8o
        2zkISmkvRJQSzBAhUycV5IyXFExS+e3s9AMtyvk=
X-Google-Smtp-Source: AK7set+DCQK83BpY1/Jft8PErcps7VMJup7n6mQ/Fa6LXEPnjKm7+vydoF5p4PZxB8VJMvaykJmEuPETQseKoCulf5g=
X-Received: by 2002:aca:34c5:0:b0:378:7ba4:b869 with SMTP id
 b188-20020aca34c5000000b003787ba4b869mr951767oia.286.1676021846648; Fri, 10
 Feb 2023 01:37:26 -0800 (PST)
MIME-Version: 1.0
References: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
In-Reply-To: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 10 Feb 2023 10:37:15 +0100
Message-ID: <CAH9NwWefkrqmOCJ4zgvfsTfSQLKWqwcpWwnijFYFT4o_sr+EAg@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] Generate device tree node for pci devices
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all

> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. Second, it allows reuse of a OF
> compatible driver -- often used in SoC platforms -- in a PCI host based
> system.
>

I have tested this patch series on a FPGA connected via PCIe. I would love
to see this patch series hit mainline soon.

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
