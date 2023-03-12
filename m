Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD76B658F
	for <lists+linux-pci@lfdr.de>; Sun, 12 Mar 2023 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCLLg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Mar 2023 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCLLg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Mar 2023 07:36:29 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500B3432C
        for <linux-pci@vger.kernel.org>; Sun, 12 Mar 2023 04:35:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5432166otv.0
        for <linux-pci@vger.kernel.org>; Sun, 12 Mar 2023 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678620955;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjcDtI1pwVRGAPewN/AuluWv6QfCVbMYyve36OMm9hg=;
        b=DZ8UYMYu2A2XNCP2bQxf5x8jGFANuCSbG53PLbpCzLLhHfYAjDjJOygzlkKDqeBQSL
         ri+T67xJAD67wejY4f+/oQZHNCc7/xCmdRW1qkOm0kcSSxZ05i4mCzsFMiKQaaQDdF5w
         E9wR8VscaC4E/rgpz7E3UaYkxJdUGr3hYWNYNPwFjfefTsKHDnCY26O4m3QoX01W3DaB
         vZ6zVqJ2gjMhl4pYQH92/lr/jMmLdp9r8MkFaLSMrxztAHoFIptHyP2etDleFWbHV/FW
         b3EAAZmhzGdWHUHzVpb1hjv0LXt0eGXzBhGRWunfUR+tpfp2mAWwj1EasyTmvEV4/uAq
         B6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620955;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjcDtI1pwVRGAPewN/AuluWv6QfCVbMYyve36OMm9hg=;
        b=MBNXtcx/J4nCNJ0EjIPx4Su3kxX0PoHaeUvyh/E2WAMGwYPQVV3aH62E+OrCVKVSrh
         fboKCBcHUvHxTVaxC3Rw1pq6991wcYmppk8OxQHMsoAn5t3xvznsZw5mabInsOUqwSj4
         ondGTbLzy37KjSdOXv23rmnDgMH6Bt0WfkSN3mN4dZ1KQYtlqoOuCJiIUDQJc0FHw+zD
         /Ry3CsC2X5WqqDo+QBr+CrVQPPgiqoO9GYskvvP5or56w+B0NBxpUfu0zKIXl6Q1VVEA
         P1HHSgdDDKiejdMQt66aiYaOLUNtoqsT9hkBY7oXTfQBShl3yELPf0tGzvZ6RqxJt1+x
         RsDA==
X-Gm-Message-State: AO0yUKWAsbuNsU2GO29IbJF8mn69gbHUPEIsEpgFJM3KiJ81N1qLPGjx
        JTmN8FzxOUPL/x/BufwnbHGFz0jbHkSg4NXpn7g=
X-Google-Smtp-Source: AK7set91gtUee3OP+0Fcx5HjxJkbSvih8i57U/TQLXUvmuRm97QnX5Z1OWr6uP/6Cqjabwfo9i5h/6OmwObkRMrWQWQ=
X-Received: by 2002:a05:6830:6210:b0:690:eb8c:bae0 with SMTP id
 cd16-20020a056830621000b00690eb8cbae0mr10565257otb.6.1678620954820; Sun, 12
 Mar 2023 04:35:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: eng.kelly103@gmail.com
Sender: peterfuller301@gmail.com
Received: by 2002:a05:6359:4b93:b0:f6:58a2:343a with HTTP; Sun, 12 Mar 2023
 04:35:54 -0700 (PDT)
From:   "Eng. Kelly Williams" <eng.kelly103@gmail.com>
Date:   Sun, 12 Mar 2023 04:35:54 -0700
X-Google-Sender-Auth: -ioJQZJCqGsjjqCveOdz9GmkL2M
Message-ID: <CACzHKnfmjCO71FRb0-7Xmzg9ctL99taC5wz-JBksbM-dL1d21Q@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:332 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9997]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9997]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [peterfuller301[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [peterfuller301[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [eng.kelly103[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 RISK_FREE No risk!
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello


My name is Eng. Kelly Williams I work with Texas oil and gas
Association USA. I need your honest cooperation to partner with me to
invest in your company or in any other viable business opportunity in
your country under mutual interest benefits. Our partnership will be
absolutely risk free, please I will also like to know the laws as it
concerns foreign investors like me.

I look forward to your cordial response



My Regards
Eng. Kelly Williams
