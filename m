Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63C964B2A9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiLMJtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 04:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLMJtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 04:49:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD9F5D
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 01:49:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 79so1040921pgf.11
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F28/EdyRvefoVHyGfMio1JFWTkHmrhy+T6OdTBNf+8U=;
        b=2Uep2WiDct1n2ETNSZj0mBuhTSpvFpVPRUBReK2DjCLZHUFr72+q3QYqh9ydX+TiSJ
         vUrN+KsDe53917F1iFN7RQruLZedT73dpnauAJWUMpXobkrYL2KMApfWrgTy19ANibLw
         w2xtSA1rPzfWhluqDM2/745lBtBkDStGs5tT6YuqZC5biJ8mgJUcAusMtfjmmeK2dHFG
         y3/628cfch1txfsH2El3YAuQ2eTbCdsPHwQnAjab9RQQ9KSEf1b6W5+uJ3pL07lOodTX
         WJCFxx2zHCdmCEbZPB1ygfaWwVUCTWHVul45KRiobV9uXui0cf7N9UvcBKdlHBhejcYC
         DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F28/EdyRvefoVHyGfMio1JFWTkHmrhy+T6OdTBNf+8U=;
        b=B7/TNtkCoPE7Ly3/EyfJ15Gfjd+mLTVkK8gU90rlPnO0X1aAlcsB58s+eRCf6OVaTp
         PrXpdgdsvaKCW23BsTuV88OlqmJ3lWJszoKDrlIfbgSAbm6jugXAhdE2rmoPKi/W+Mnf
         JaikfxzPMob12X93K4ptUKf5EzidFLI+QjOGE4Ryie+X7k/az9B1OI3p+PgNfx3T/9sy
         B4K2Fn4WBYupruZWBQPSjjbtytA3Jli0YobrBg0rZSrxMCg8rOimKrB8fkVDbZ+PgyUA
         QBRoQhp+QufgoOzRnXgA7eVLSvY9/Skw48rjhNin95a4efxrglStdbB2CM0d+GubDIUH
         16cw==
X-Gm-Message-State: ANoB5plnQ7UrIX1vcvkeJ/OvdryV3Hh13CK4+4h+N3fnU0DDtxMfVZfQ
        NgozA64PifGK4EuOjXaBdBjIv6Ph0ecgujDfuRdcgA==
X-Google-Smtp-Source: AA0mqf7VihVI8WU1ugZdKx4ZbS/fKwXwCKuGRtGhFMBOldsKaYGCZUPKQKF7xukz+wKXkksXcdyyfPKnaL6qJki1Lns=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr6763995pfv.77.1670924978132; Tue, 13 Dec
 2022 01:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20221213094402.3623277-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221213094402.3623277-1-alvaro.karsz@solid-run.com>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 13 Dec 2022 11:49:01 +0200
Message-ID: <CAJs=3_DVnbHoPfETF=X5sf=kYnWPTaLZ-KicNF3PkXSr22eRmg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v5] virtio: vdpa: new SolidNET DPU driver.
To:     virtualization@lists.linux-foundation.org
Cc:     linux-pci@vger.kernel.org, linux@roeck-us.net,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +               SNET_WRN(pdev, "Can't start HWMON, CONFIG_HWMON is not enabled\n");

I'm really sorry, but SNET_WRN should be SNET_WARN.
I will fix it

Alvaro
