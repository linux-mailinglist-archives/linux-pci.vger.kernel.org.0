Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC546F2F58
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEAIoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjEAIoR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 04:44:17 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9910C0
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 01:44:15 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so18665157276.0
        for <linux-pci@vger.kernel.org>; Mon, 01 May 2023 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682930655; x=1685522655;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=IdyRQK59Xn4XNLv0SFRs0mWSKNVNq3L31VJ0C60rC9gQv/yXqOL/FhMkNkI5SQ3xeE
         zgthIZMyUaTe6eA2quBM0RQZy7gwS3W2xPNPd3Fs3YqsDhc1e3jrcp7wiLsizaU8RUwe
         UMy8pvS+AIJZgxzxdj7csZ9akMFFgW/d63SOHJcBtJ9uW7BAQBIed+eHSHQVcj6vDCMn
         hCXqWPTcgE9tK1/Qm05RVGMIn6On/JxDgXNNoR6JMi86qScefJ6EIEX5xuWhNVwRvKq9
         jH9oVWN6qMHEstKLe1LAXdsH5kUyr5JgnAm5hvpb58Uoi9y7jFqdSH/lPGkJRYSGptsO
         0NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682930655; x=1685522655;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=aV8ePjsbAX/PakrSHqSrImxWmrkRyxK0miGj25Pa55N545AIwmXs8AT1chxRTrkoQj
         1Q7d7Luv/UJ3IkPFB0rwY28Ef6ig3e9lYG3XgqDiC1CsXbKhqDWM+ojTYwkjnyRo1ayA
         MRNxugzXB2gR7cpSffooOUxmzrEPUzRG+0lOtVstUbe8JhGZ10yxreewRZUWZuCwb56j
         5kaDMLnHZsELWARhRSu9idmRo1lqkmXsOeJkiJoXl0TtIYH1B6BZw2dn7fXzNbPyB7bf
         10zqadk8kuPH4vqhpJB+2ohjjw7neO52zL9+y12VkBjzHGW+KklJkBpQo7XoIaFjaRcP
         nC5w==
X-Gm-Message-State: AC+VfDyygwChdHKQ0Nb0UUG641OvSAWW/ySYybsfLCegBrDKcafZvWd9
        NmqU0z8O9TGHCUYC6eY3vwb5ET7gU/w7AfQamWA=
X-Google-Smtp-Source: ACHHUZ667ALNpZkH8MtAX88qtAMXT/6mO1t2sVJVS9hUlR1lJUCe65PimbuKVKJCn9XIFw+C+KPGgrfYCIIogthlh8Y=
X-Received: by 2002:a0d:d4c6:0:b0:559:d78f:db64 with SMTP id
 w189-20020a0dd4c6000000b00559d78fdb64mr6890455ywd.3.1682930654580; Mon, 01
 May 2023 01:44:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4e0b:b0:34b:b5e2:a13a with HTTP; Mon, 1 May 2023
 01:44:14 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <getw24139@gmail.com>
Date:   Mon, 1 May 2023 01:44:14 -0700
Message-ID: <CAEoTnMuKqb7Xh=1jH5q14_4kW82ig4-Lt0dMHg5B__bEn2gzBQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4398]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [getw24139[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [getw24139[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
