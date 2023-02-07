Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A068DFCD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 19:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjBGSUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 13:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjBGSUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 13:20:09 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530513BDA5
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 10:19:14 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id i38so8327967vkd.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 10:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=KJpWdKDmQ0EvTyXEiofYl2pk8JosygTObpMPkDQIJc4Z+XExRlglvQDc4xhI67cK6B
         FVc+9oGztfpKNXu+khtK9fyvx9dv0BPhxvS4PemhSHK7fbUktNtncSgUMk6UuC68QyHJ
         cVpQPaGE/+pHXn1qYLQZ/kLDqK32CQyJUUyAtMGRogl3/5+Oqd7v69kMfpVgwdUPEYok
         ApfPfX/a4yqoi2EI+oq6Aln4+dM0NlgapbG92GAiiDyx9ynwSPEcCi/SwGU+ZSR2G2n1
         9DbuD8VG2EQaAwc5RnmiF+fEufx66CGGu19f6PUJJqeMb46oesjR6je827kx2IbnBE+S
         lMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=vTnRdU78W3V8Favhzv6xW6qA2ETyC86sHh+umEdC6xl4K0rxg4cF5WHP1b74QKWTT3
         rHocICEz6Jw9JYmcGrf88EgXjerdNf8mNa0BGosyXd+sxMcMi9qQTC7UUiP2zmqUdaXH
         mtdPPvO7EKUUr8ZbpFQpMZtXwxk29BhlCj3jmeuiQGomYnYFKFAfjz9HgwXW885YgcWQ
         ZGATx0ij/z/BNv3YhK/xnGTMZoLc/YOnCRXgJp8wT2YzzJpHN3rOR3guV6GI5DZZ1tXu
         XQG0nYfUot+EUo385XMWxoe2y7PZ5m3D0UGCVU9dKtmmOmAi3WrEqYRRh+tYSLOA7qUK
         4dmw==
X-Gm-Message-State: AO0yUKXtn28Pm3P1HY64gX5gGYIHElA6nRDky0B84oNJj6GwcyM5fNJ8
        2ehZp+z3AXyqXEJLay0Zqui5/Z4onF508RFVn/c=
X-Google-Smtp-Source: AK7set8f1Rk3y9u4nOIzL8AD+y2iIRLMu1j/3H1dIUDaxZKQi+l5FXfhRaxMmHyVFr3tm2qH/fx2bohtv2BcZWnoBVU=
X-Received: by 2002:a1f:9cc5:0:b0:3ea:12bf:9582 with SMTP id
 f188-20020a1f9cc5000000b003ea12bf9582mr693883vke.2.1675793930777; Tue, 07 Feb
 2023 10:18:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6102:119:b0:3f0:3a3f:5d6c with HTTP; Tue, 7 Feb 2023
 10:18:50 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidbraddy01@gmail.com>
Date:   Tue, 7 Feb 2023 19:18:50 +0100
Message-ID: <CAHGOU4Mube2MUJ6xsszFD+B=4UfqPU3+7h-EhXKK=d6jU=LrNg@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidbraddy01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidbraddy01[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
Regard, Mr.Abraham,
