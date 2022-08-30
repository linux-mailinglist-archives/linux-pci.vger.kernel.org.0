Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DDE5A6645
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiH3O1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH3O1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 10:27:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68855BFC44
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 07:27:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id se27so14797249ejb.8
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=VemgyqMjEaxGRFsa79+ERn9BrIYgjBTiK6GtMJc7m+8=;
        b=oprAzxf9avqlXrCJQ0JgDHuxZld2YaxDeqoVzglmdzrwIU1M0NiYgQzn3CkIICucg8
         Cue2m3U02fu5fsFeLwfPCp/Ywcft0ARYoj8S0/yvyjmCA8g0tZJXATkxLJnYwh+Vr4pw
         ECFBkbwKtlntSOXGYep+DH61ubeH3vwtFI1b935aTkxmyMHcKv5hWLSCVfs1A6JgTlka
         DTLlFOsU6Wvo1qoPznrdwKxYMHNoeKFjFe2/CRpLz26r3DipZzdzO9DBhUjWF3yVth5b
         Ku9H+oxHxnALLl0RLOldSSZY4zBo/mam7SECUTkQPFRCDgS5Ms64dp8ZKQLuFsd88Onr
         SA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VemgyqMjEaxGRFsa79+ERn9BrIYgjBTiK6GtMJc7m+8=;
        b=BYt+Z+0/AhSe/4hRRuq94yGbSHLq8ZY/xMyzN5Q1DSx1MvwVI6LDcQpsLBMGTZEffr
         XGcmJEV2df7oZGkY2SDV0B5yrnITxKOFU2CsYiM6/9CYYJ8oMgTSDl61WSN10orO6hEY
         BlJB8uwoAd9gZzEA+TGrTr7qCAGw551EP0uCjIJwuKpXAllg+CUzZamBYRgNsi44SAYW
         5HwkeKh/brA1dkvOqpV90F0egWPJftjhPFZzzG3FPnH9/vUKAJCTTB40g9zbdom+Oegv
         iltr4rCmkI+BlyPYwsgC3s5VTREbykSFd8TQRAoEnIwrQXazIAsyGKwjDqNW8bj3VSnE
         C7pA==
X-Gm-Message-State: ACgBeo12wni7vI7yX1miiRbhDN3ZevJx7xZj5C8C9G0UHLcXeGuk71ff
        LzVCA/gIm03Iq5x9hMxaPuUF8Cacmg7th09GFQvy2seZ3ToNqg==
X-Google-Smtp-Source: AA6agR4q8SxiZqoIhss14EwpJ/NN9gpPfTNuyssgZxyaMW70eLTbcsYXQkFYVi+qMDjVKVnJFweY7nFktJj58C+lXpU=
X-Received: by 2002:a17:906:ef90:b0:730:9af7:5702 with SMTP id
 ze16-20020a170906ef9000b007309af75702mr17729152ejb.107.1661869630485; Tue, 30
 Aug 2022 07:27:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a55:99c3:0:b0:1a4:4395:92e8 with HTTP; Tue, 30 Aug 2022
 07:27:09 -0700 (PDT)
Reply-To: mmaillingwan391@gmail.com
From:   "Mrs Helen Robert." <rmrshelen101@gmail.com>
Date:   Tue, 30 Aug 2022 15:27:09 +0100
Message-ID: <CANfGfccV=boOq5xHJ6fGV1H9cjmE0gTQs_o7ndO4LsztNyB--A@mail.gmail.com>
Subject: GOOD MORNING
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:635 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rmrshelen101[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mmaillingwan391[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rmrshelen101[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Dear Friend,

I warmly greet you

Please forgive me if my plea sounds a bit strange or embarrassing to
you I am 63 years old am suffering from protracted cancer of the
lungs which has also affected part of my brain cells due to
complications,from all indication my condition is really deteriorating
and it is quite obvious according to my doctors that i may not live
for the next few months,because my condition has gotten to a critical
and life threatening stage

Regards to my situation as well as the doctors report i have decided
to entrust my wealth and treasures to a trust worthy person Get back
to me if you can be trusted for more details

Sincerely Your's
Mrs. Helen Robert
