Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602256210B8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 13:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKHMar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKHMaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 07:30:46 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F2412AA2
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 04:30:45 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id n18so10093396qvt.11
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=avxTG4r/jC6yWQnk9p7A88nTROiymC+fPSCQIc4d/pBWTNu7pC3a9BaZPI0IpzDXFJ
         4ZI95wIk4BOnSCfa7EN7yCncA4ghMXNMzrt0GKwDQLJQRHN1xAWs8pwEGI+qov6DLNDd
         AlDkq0+X4hWfxkeHgYHBZd7u3wepYWT7a9vcA3MjQ7UP4ENbTUaI29LHIp5TdH5DCUcT
         gBBkIbBgb7wEQuQSAvi/beAoNNJM7eFeWlwScMbMUdIFf60O7MiAuHykpLINOG+YDAD6
         wNQEU9QhziwHlOnI01VVYK914CwyyQFWbWIARihESvTQd2/8CulFFIOkSHSu6owfMAht
         LCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=ZmgOJexJeQU4jZjfpvWUP5MABbbxr9MZ2pY3tG1GI+Dspc7CsL9h/NrBju8ynKfPl7
         zk2Jcb4I2ocII+osbAhGqkOVIqs66lOr9f3BKHef3eKHjDrbflFXCSQ27DumXOBb8uPf
         HC8hhbloEDaMIli8ZS+0PEgdVzrxuVPv+ama76tEnZBBuuqaF173tPKKRPsv0HuZfV7I
         e6HHbFxAIhukFX4pAKeJl2R8AoUv8mm8wGladr7Brq8AdXUMRbwu+9JLiUMlMLqdTSTI
         /+v9r7hHfZgk3Ege2fcdbUCTYFGVSB8oX5HzkmtHutasBDAUcbc+7Sd4flhBbC/QC+g5
         PD5Q==
X-Gm-Message-State: ACrzQf0npme4r4hOVCnzlws6ovWjfN2VwjIuqWP8xSg3AnZWSMpLi3A/
        JscvpImCIBSs5akKI4OlqX0AaF4HlPVqCpGWyvwaHTN21o1GFA==
X-Google-Smtp-Source: AMsMyM4tFWIcasBN6H0uOfS3KfwEagHKpMXgvPFfTJtQp01/m+oy4bNKWgvj08uKMYwPImmRUQO1ph762CK7TQafZCw=
X-Received: by 2002:a05:6214:c41:b0:4bb:92b0:3873 with SMTP id
 r1-20020a0562140c4100b004bb92b03873mr50133618qvj.76.1667910644939; Tue, 08
 Nov 2022 04:30:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:2f8a:b0:4bb:6e86:8303 with HTTP; Tue, 8 Nov 2022
 04:30:44 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   Mr Abraham <mr.abraham2021@gmail.com>
Date:   Tue, 8 Nov 2022 12:30:44 +0000
Message-ID: <CAJ2UK+YQrU+m80Jr9F88pmyg95Ah3T7mpoMN7BzsFsC8cTqA6Q@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.abraham2021[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.abraham2021[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
