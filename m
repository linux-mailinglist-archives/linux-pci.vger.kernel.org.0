Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D84BEAB5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 20:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiBUSUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 13:20:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiBUSSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 13:18:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA40E018
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 10:09:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g39so20126438lfv.10
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 10:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LoM4XEodrBVaABJSgjKFlKlwjoO4sP/v/3gpJ+8s9Gs=;
        b=BsZudA/Z+FbYHkcLhFKfwFZVa1k5UksvWo7ObSz5YZGLwhezT2jcCKHST1HZhTeS+g
         4PB/9YfxF9BtBH1hGVaJ/8mDEo4y+9N31hwX6QRC5vTo4fwTezgTAwJIIMEoC2/WIYGE
         rjhfEbVGPKmuSv0XNyBFPWk6OtIRG26+QJc0Ozbhfsj7H5gGSD3j74SEio9Um548ChxM
         vumWQ3WV+SH1wfmLPYHvngynlYyEjTrm2lpu8/0Q4yKk2zmOR2sl+xrzv3S8xziT1bEd
         MDhWl15HvWUBcIjP6MEqZHnh6d6dmMEYNeLHn4h53YkZ5/eY3iDYIxzy9/0FirWaTRIl
         vxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LoM4XEodrBVaABJSgjKFlKlwjoO4sP/v/3gpJ+8s9Gs=;
        b=6mnP8ZUVfdAVjIJnKuWstLu7K1uQ9mLZgmNBV3G7eFzgm6nKeSWSEA+8UM4GWZgPQB
         yOGCOSPHNsGVyyDAi9ui6xYJl8ULEAjPnzPy3r8zf35JAl3Cq6qCwF0bA4v0Kk+HJRjI
         Ijq+bL12Mw2ZeaO7XaGKwR8ic9UJzB7KJ4ls5vCI7ihKu1iWbK80Bt9Wpnv1Kc6Lt2th
         q+PNL0dIFevnDLhhBUbmcHf9DgDAisEbUDQxud3xR8yVztI4lVzG4pvSEBZ1cDBbCC4O
         i6uvTntMd8OM88U+KsrRg9hfdZJpS1AZW6skvSEUDjXtcMkRNZvBlw0BB9oFXaVfLn0V
         xhgA==
X-Gm-Message-State: AOAM532cq1/OwEHepq/vaPcLq8ORXWNESLXhW1cCwicI8EWkrCZtauwB
        Xjc/kh8Rtw/vK1oS0OeFUPiUIJ3Ad1mRfXGkqcM=
X-Google-Smtp-Source: ABdhPJyIK4uossY5s7oquUYvBzAt7yw0gyrbtTPYxErb1vd6SSXStgPdvirWmU5VUCoE/Zk7p7YDeZ+LngnEJAfHCEI=
X-Received: by 2002:a19:5e0b:0:b0:443:db6b:32ce with SMTP id
 s11-20020a195e0b000000b00443db6b32cemr6541293lfb.274.1645466994104; Mon, 21
 Feb 2022 10:09:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:1198:0:0:0:0 with HTTP; Mon, 21 Feb 2022 10:09:53
 -0800 (PST)
Reply-To: gisabelanv@gmail.com
From:   Isabel Guerrero <kpangoalbert1@gmail.com>
Date:   Mon, 21 Feb 2022 18:09:53 +0000
Message-ID: <CADK-VnvftR2mnJ0Yo3kd+vjFbw20Mc75di=mYkVU2setcZwj8A@mail.gmail.com>
Subject: URGENT CONTACT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12c listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0656]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kpangoalbert1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kpangoalbert1[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, I=E2=80=99ve not yet received your response to my previous mail.
