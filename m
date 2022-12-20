Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D8652051
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 13:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLTMVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 07:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiLTMVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 07:21:09 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9D192A3
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 04:21:04 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b9so12231683ljr.5
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 04:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leGyKEE6HxuefN20VFLstDPXqSDSxwW9HW3/3WDSeu8=;
        b=OKMMbj+k1nAhb2y2538itML8thuXHBqN+N50sa2+Ot4GRlDZ8UCzeuV04JF5BkraDm
         cLxlvSUPbHyLTOIniB9MbiSMiBtVkpYG/4dWXTIGt+3kMRt7FFpTGORtsKBuGlLBmHZH
         lpXkcB5GdlQnbx7vUW8e3lLaRnvEZn00q9/lHDRJfafKmyj6e0VYUz0UZDWq7IovPTRq
         k9m/X2RR6CuBwQwL2WW/8n4U++luGVYYB/Lh5NA5UUSQXRkaAj+f6xy4uo4Fgs8i2+oL
         c3+2Jp/drgSjfncKtST6kcPliI06V7RWKtKa9yrbAzdH8DhjSnTlnnJeI0JPg6Xaafm3
         F2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leGyKEE6HxuefN20VFLstDPXqSDSxwW9HW3/3WDSeu8=;
        b=04YuBE+kv2p3YPvgkU2TpDUz9I5rdWb4HYV34SeHGjCZFPxJVVUM49kWMFV6U8bt5g
         1WTW4NaEhSnx78Zjk9+a0iH+v66XGPe315mnkVXVl5IVz3oseue1xbWEmbggnlbBD77o
         rX44MNuG2TvCWVtPyI2aCAcUz2a6SNfPN0jDNtsrBmoHLj8bnKrlq8/WMywgEsa0l6bn
         yfcrZVawI+BsaliX0nnzkSm8O5EsBhmbZX8bwDyYTsNm9AeMI5F9BbthFzZSlhCDYG20
         8HbxDN29GI3YJZ8dqk+Frcw7vhWPYJXJ8t+d1Y7eWR9S7iQc96Dnz8bsS8X0hmTZTvxX
         vNfA==
X-Gm-Message-State: ANoB5pkQbKglvbGPzcPPUWU8Q1L8i7LaG3qhZPtsOuhtkHpAtdQ7oaK3
        l7Wk/ig61oFpfy6JilgQK9s/jNpv6oGFrO00qKU=
X-Google-Smtp-Source: AA0mqf6e1GCMNYSjbLNzTDGl5gCKxfEvyRdIPAhdkNKmOejgNufTEGrW3e1ErIwAEQgUHlqpxUoc1bf0LlRyM3h+Ev8=
X-Received: by 2002:a2e:a5c6:0:b0:277:22c3:afbb with SMTP id
 n6-20020a2ea5c6000000b0027722c3afbbmr26137071ljp.204.1671538863146; Tue, 20
 Dec 2022 04:21:03 -0800 (PST)
MIME-Version: 1.0
Sender: hassantamboura55@gmail.com
Received: by 2002:a05:6504:191b:b0:200:fe6f:9779 with HTTP; Tue, 20 Dec 2022
 04:21:02 -0800 (PST)
From:   Mrs Roselyn John Carlsen <roselyncqrlsen10@gmail.com>
Date:   Tue, 20 Dec 2022 13:21:02 +0100
X-Google-Sender-Auth: MM4N-tk5dchA8Hhi2zJwtdQ5Ivc
Message-ID: <CACRr12A=5Go2fpMFKGNrhjWPmp9XPnDH4ROHAH_sosyp4Qw5YQ@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:230 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8738]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hassantamboura55[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [roselyncqrlsen10[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dearest One,

It is my pleasure to communicate with you, I know that this
messagewill be a surprise to you my name is Mrs. Roselyn John Carlsen,
I am diagnosed with ovarian cancer

which my doctor have confirmed that Ihave only some weeks to live so I
have decided you handover the sum of($11,000.000 Million Dollars)
through I decided handover the

moneyin my account to you for help of the orphanage homes and the
needy once in my account to you for help of the orphanage homes and
the needy once

Please   kindly reply me here as soon as possible to enable me giveyou
more information but before handing over my bank to you please assure
me that you will only take

40%  of the money and share the restto the poor orphanage home and the
needy once, thank you am waiting to hear from you


Yours Sincerely,
Mrs, Roselyn John Carlsen.
