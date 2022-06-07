Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA153F714
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiFGHXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 03:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237605AbiFGHXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 03:23:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7B17ABE
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 00:23:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id v1so22646816ejg.13
        for <linux-pci@vger.kernel.org>; Tue, 07 Jun 2022 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=PsMyBKpPIW4M4oi5s8BlbY9lVTnMTX9E6ccsbCJU1RL+goYnA2LIRs3wKhCOAVI3xw
         zjcMqyNEDJz+Db8kLcyq/kTHinzL1SXzDFzL/ad0QL2vJla5iOj1tnhAcarnJ+DKgb0v
         DN3F5yiofw6wpneYSq0A/eRc1swG0phEI/uGBgFlvq6jYC/yQmdEMZwJkbRdw3pu5gT8
         n99IB/6FV0H73nwQHEQ9L6u/n5Y7CvaMUDJxK3Z+8G5R2GejNynydkgr/UT0ukGSTxoP
         DzXExcc+VEFm9F7E8z8jgIHU3JWId1DtqsBylQVKVwxQ86g1XY6G0NTjeOQ4U15/RtmY
         03Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=XPR2e1bMKiA2gX1DWrz259ICFIib6Pz0yCVPS/ZEHI+Wu+YehMb/VvouxvaDJd+BA7
         NcUWL8z5Gm1RW8u2Rb7CD1t+ALHaj46GKn+z83Lz87S5aSNaGlj3s3ZftqpVzcbnI1aV
         gNfEiL8eN1Zl9azXzhyU2c65P3QSGyPccd9r+4uLS1dYPNX2Gvb3iWd9kfX5QhuO4kHD
         clCdU7Ku7avEzFstkqnnJGm5pdBEaAdB4Dow8MN6uF0D9EsE9qYUFfsvZSGnSoPVfQ5z
         /8uwnWJXIuLkIDfSN1Zxb9E6W+a+Y1Dy8cSANauWD+kSvqMsR7xAzphrJwqP7Fv0C+vg
         ykVg==
X-Gm-Message-State: AOAM531yx39SYDxGNT1KU5CKJdTLW4vGvxsyEePQRi6jZwc3ZYtjWLEQ
        SwsThaA9pH1mAWqEGjcDGdHvvUqg0Usk90qRo6s=
X-Google-Smtp-Source: ABdhPJz4k4UttdGgiLGpvxO9vryGrYVFDIkV+sv9ov2iF+siXqkWY9e6VzPU2dq2m3rnXaDECUfNIEHF2jvRW7Bf9gY=
X-Received: by 2002:a17:907:1250:b0:711:d0bc:2370 with SMTP id
 wc16-20020a170907125000b00711d0bc2370mr7663637ejb.454.1654586578888; Tue, 07
 Jun 2022 00:22:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:26c8:0:0:0:0 with HTTP; Tue, 7 Jun 2022 00:22:58
 -0700 (PDT)
Reply-To: andyhalford22@gmail.com
From:   Andy Halford <fameyemrf@gmail.com>
Date:   Tue, 7 Jun 2022 00:22:58 -0700
Message-ID: <CAATdNavjCypNM5LXmQmsnwmeQeG9Z8E4ZdU2cotunP-+47s0DA@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fameyemrf[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [andyhalford22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello Sir



  I am Andy Halford from London, UK. Nice to meet you. Sorry for the
inconvenience it's because of the time difference. I contacted you
specifically regarding an important piece of information I intend
sharing with you that will be of interest to you. Having gone through
an intelligent methodical search, I decided to specifically contact
you hoping that you will find this information useful. Kindly confirm
I got the correct email by replying via same email to ensure I don't
send the information to the wrong person.



REGARDS
Andy Halford
