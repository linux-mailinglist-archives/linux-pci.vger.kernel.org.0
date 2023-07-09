Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556B74C13F
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjGIGQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjGIGQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 02:16:44 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BE1BB
        for <linux-pci@vger.kernel.org>; Sat,  8 Jul 2023 23:16:43 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5701e8f2b79so42754197b3.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Jul 2023 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688883402; x=1691475402;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=Bp5MLvKPSk5zMbAC/lttAdgyhC6wqBrx20Zr6vebn+/0U+fjSDRgD/l9Z5tUmJ67TZ
         vtzfcWzCq9eFkMP1wm+iNthhOOTdTMAUfemY994pc1Vcsk4/nHlq8vIM1LCGXMdPOrUB
         U21MpugVWLPMpmOSYigcx5pHCVVItOA+ZqUaxPGgfysELso1+wGqj5Wnp62wcEm71XOm
         jOBl38WhtzxvBwD6cak1rDdOdkhOBhT4JC7yK2jyZ/IDmbDwPOivr0BGiSqOgEtQettM
         pmH+KLXC9g90nw9aDDvE8KlonfY/glvE4j5x+XvvndwhZJNCtombGtVRls7GTt5eWP3J
         39bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688883402; x=1691475402;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=R8RyeyRdmUA4BzpambqPEGY/GBNZqNbcl7FieB5vyx8FtZHBLlEodzGMkPUe8RobHq
         vXuwhFoW/45LJ9sx2dvTBSdHedIOe1fbexhtK2wlr1LQTWfIX+8QowrqC1fgtXJumbcT
         e5HF835avNFllv9NWorPcMmlYhnILAeIRcajCv1tCqaJQvwEa/i5izHcYhqU3SjSk69h
         hxFWVoZaORrnybU00o+iQ6LKbR0X/aalg5r0zH6LQ5a9zvCX9A/v34Sm7Mq7Kn2GrgHa
         A3T8Sqz6SZC9CzLoKCApBV3U8Om1mDuclwVAj9qp/XWxa77lhWhNJlh5T0GCdcRcs/j9
         O82Q==
X-Gm-Message-State: ABy/qLY49XvGRL3V02+paloFaY3eOg2z1KRIdtYAnpXoG5fCJDX68L06
        hdAW4XYWX5tkw2vOjiC7YQ+pVTRWlfpw1XHjLIk=
X-Google-Smtp-Source: APBJJlHDyeGMLRJh1TqEFXuQL5gNHvL979NAqymoRu2852sJo5Wc5PVm71x+nJyUxH/c+0ShKcWO/9pWFC+1aec0z8Q=
X-Received: by 2002:a81:5f83:0:b0:576:b52d:4946 with SMTP id
 t125-20020a815f83000000b00576b52d4946mr9750194ywb.30.1688883402409; Sat, 08
 Jul 2023 23:16:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:6211:b0:35e:b32a:1b89 with HTTP; Sat, 8 Jul 2023
 23:16:40 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulibalynina15@gmail.com>
Date:   Sun, 9 Jul 2023 06:16:40 +0000
Message-ID: <CA+8Vp3Va6YuVNky0j3E1UYrYwr56aeg2aKtMxvgOUsLM-3zVTw@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
