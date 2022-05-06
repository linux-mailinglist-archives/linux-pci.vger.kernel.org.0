Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3166151D051
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 06:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377741AbiEFEcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 00:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiEFEcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 00:32:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2038E
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 21:29:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l16so6421935oil.6
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 21:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=M1A/zitHYNWdVUddyzmi279LNiaY1wuHPO4WSwRZuKazMfUwWgWYHCDAgiaphsRHF/
         9pYz2CImnbbq+bp/OLm65hXDJkFnS4tNhqEhMMhnrQtzhJyicItE+sdOqQSQ9pZ4eiOJ
         hbcfN+zB6tAiorjE0VO5A7cFuYJvplkqZJWS4AMoP8tGqlAFV5hKrlD1NWat/fRVwZLw
         cPF+ErJMQL7aEvvWLBTToKcBNrAG10sid31/1GdpgvomQ3x0Zn31vtxOMqyumjoSbhJG
         s+LahjuUxDt9w2RJsJwugatX8aF1te1tGHuP5X2Xr8As7Gn3wyPB3lMWHyEuqPivtFTZ
         Qljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=LErhZ5vm20WQu73m1GlVoxs1F3ze/4Pckx19IVKm5PIQwJflO46vbMjlTqIZBCAyHE
         Cs9RkGgS5x+D1dMaJWPrbls3FvpeVgJfv6+4q5LmHtEgCkqqsMSFxk4oNdUcndzpZEXS
         J1NhlA9febTMPZ715cy3U2MjGig13j11v/bLT1MTDP6Mv5d4MQ6IoY6pH6D9JSrBVHTK
         sAmcOg0CphHtiKdMMW5F6JYSP0JyVfDfrDZYEqbuU3ubYrzedqdK+NILXDDfl1j7Hb3C
         +Gyf8mVrTBWKl5ix11VlNdakZqzR9QviIfBbWW5sUd2qTYcEl8UwjIa5mox5I0C2fCGm
         JM+g==
X-Gm-Message-State: AOAM532/Fpx/TTO8d3fmIlU5hIbPSo+VK2sVPDOJ4SG6hIUiVNWEOoA/
        ewkAhnlJ1grBMT5+1dQDrwqiqIiLn4/W3Aj0VnI=
X-Google-Smtp-Source: ABdhPJxhwsGGrKvAOGV9wWwjODcbLyaemV42EiuNoy5NOZxpVHIYMq/U5LcTd+YrtVR1WEn90X7iDeHqIzMdroPdS0c=
X-Received: by 2002:aca:5d0a:0:b0:326:2fed:bd95 with SMTP id
 r10-20020aca5d0a000000b003262fedbd95mr3938703oib.97.1651811345017; Thu, 05
 May 2022 21:29:05 -0700 (PDT)
MIME-Version: 1.0
Sender: mrssabahibrahim007@gmail.com
Received: by 2002:a05:6850:a58f:b0:2ed:2476:bca6 with HTTP; Thu, 5 May 2022
 21:29:04 -0700 (PDT)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Thu, 5 May 2022 21:29:04 -0700
X-Google-Sender-Auth: 3wwt5hZyNBK6JU9IvXEEXSYaj5M
Message-ID: <CAP2EcM+V5VQUHBdTh_jDGCHydB=n0N=91+A2TK-OkRBp2iKgKQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply
this message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
