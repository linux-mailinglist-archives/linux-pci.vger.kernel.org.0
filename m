Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462094C2035
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 00:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbiBWXpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 18:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiBWXps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 18:45:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC35C379
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 15:45:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so675830ejc.9
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zI3YMoABJRyR+odt0AbJrQOCfTLDDuwNt2ksIU5nkFY=;
        b=JJCvVvmZddjxXHlZ2aM9A9nLqvQrKtA/AUHWVQo/dfZ9hFB9q3KrKZeFgFN601sLzL
         kK8i1m/qgCl8A7C3zPBCmA6xOkShzep0vW5uajL+/fvr9+/5IaLXEPxQ4F87aUZ+zAgX
         741xXNPC2s2vvJbBh9SLasdtnXLSwrvppqgd3XRcj3TwRGK+xENcEjFYTWvlchum8ccF
         jmUwa5vGMmX9WIGRkincOmT8kvkEU+OkaKwomg0Eb7nAcZN/IXd++J0p/i13jcU5OUQE
         2q9lyHUpx13wanoaINjc7ZL5v6l80HTPlsusA3KkHoUOoCTJ45mdQtzsJOStsEM0unLX
         O9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zI3YMoABJRyR+odt0AbJrQOCfTLDDuwNt2ksIU5nkFY=;
        b=DLLDNOD3Z0DI+FPW4SpzmBWiTO/qXO7TdLRJWiFA6tVPn3P0hEbTWwtKVXmedO7PAQ
         xT+yox0i4Rycz0WhLLg3glKNmIf03Y4l6eOOOWty91Wk6ofR2YnlwQ8Zol3MYMv0R3UT
         3JtMXuFjBP2L1WmR4UWKuU1PLMrMIdeo14ei31IlLcPcT5dLpWkLIz1Z6RQdvrBmqEIP
         BYhhzetScL512S4KmpD0GbGfJEz+HltX66HVxTjtocTU4P+jB0yqj7ntWTZLbHFyfrGD
         2nRMsbGbBQAkAMvWoALOmwyMJ8UGv97NvEQ0jTFCrBkv7wf0sSPtLNdlf/sN/29WgnZD
         AM9A==
X-Gm-Message-State: AOAM533Kr19gmzimQYZdVTYt4eBMmoUHxUiebFmXCy4MWOTyTr+HUtn0
        nWnmC5SDgn0loAFxqtCCCp3jDHcRkzPVmAzMr1E=
X-Google-Smtp-Source: ABdhPJw6gCeAEQjtdGajxeh1VEbU8JfbJREyrXd88EMr6zeV4gR7rXiCRWlr4RxD8jl0RdXxNLM6cvUFxP9xhPfZvsQ=
X-Received: by 2002:a17:906:c314:b0:6ce:6f9:dd9c with SMTP id
 s20-20020a170906c31400b006ce06f9dd9cmr64977ejz.311.1645659918599; Wed, 23 Feb
 2022 15:45:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:141a:0:0:0:0 with HTTP; Wed, 23 Feb 2022 15:45:18
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <drivanrobert81@gmail.com>
Date:   Wed, 23 Feb 2022 15:45:18 -0800
Message-ID: <CAJp5pinGhtn15csQmPDaE-4X8UxuVQNB+39P9CwnL1zaTR-1wg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Please with honesty did you receive my message i sent to you?
