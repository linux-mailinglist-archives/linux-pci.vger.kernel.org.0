Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD455F281
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 02:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiF2AsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 20:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiF2AsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 20:48:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3DDA5
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 17:48:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k14so12585717plh.4
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UaR1NefD75n+13si808lphUXo4PHuRX3UDYDNilXuoM=;
        b=gGplD12ZEKRYW4jBL8Xs57G17SrfzXNQnHceG6HgSCIdwenkiKsH3MNIBewfG2KCwn
         o2V9Qr+U/IMTtpJq7w1HI8qFacklJaVmszAMnqblzZIN9B34l4b8nejvfY5o55e27pum
         U2WIS+hr9fFDT7dN5dha/i6gckpmv+EP0B7KZv64XJN5kPR85OVvgI9jduBjNN8e2tHR
         UsjftP58X4nNyAh8v+QZpGihWuXP+OT9DOh74NvuoYaloPoHDnedtS6hMQohyokv+Nh1
         PN+BabD1Ie9fKkzZs7zb73vqkeylyNPMjvbZxAe68IUYYZQx1PwnG29TbuOz5HrtiCIQ
         WV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=UaR1NefD75n+13si808lphUXo4PHuRX3UDYDNilXuoM=;
        b=3aqUDneEuJ4iiVQR7/lmQbM18vAm5KB775ocOmIcSqRwEvBqYeisLlJ3gsge2FX9WH
         1EU142NRtbuqiFGA6ZrqU9fD0PGw+mREUGwU4QsuCqJ2sYyG9uv0ulcmmFfa/rscBwpi
         pZX/0xGSv+2eHXZdnSRSfeKOY/h0nP6UXjcQpjq5OCxYY0IR/2k+uiMsljD/wlhSEgli
         Kncr/R/L/qnGpKd5cde0ROEYF6G9WIOa1NDx3prrn8xVpC5jB/jbqqrte1zbZe/kCLoL
         pl+2LhOB/M4osMMJBfUpdVmSoL+iLjd4K/o2srrrZ0x64n/C1ufSdTK30SR3WxP0DWSW
         ydAQ==
X-Gm-Message-State: AJIora9KDqdfpiZJodolZgZgaoWGG6DpmOEZQllGT3tGzHefc3t6wPKW
        t+cVDbqtn6pQqc5/76YpoYSnp4N2KntcJsKtn08=
X-Google-Smtp-Source: AGRyM1ue1oty47I2RCpB18vCvbxDwRco8AAxWAQzKgw4eg52fmLcsYHWsgicpT3gDDmF3Mu0i9wXVC9HrNw9GmyDsvI=
X-Received: by 2002:a17:90b:388c:b0:1ec:d278:7aa4 with SMTP id
 mu12-20020a17090b388c00b001ecd2787aa4mr2677927pjb.176.1656463686683; Tue, 28
 Jun 2022 17:48:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:e193:b0:83:f687:f339 with HTTP; Tue, 28 Jun 2022
 17:48:06 -0700 (PDT)
Reply-To: christopher@groningenbank.com
From:   Christopher Wright <yachicof1234@gmail.com>
Date:   Wed, 29 Jun 2022 02:48:06 +0200
Message-ID: <CACo5k8eLPLTJCqDt8E7b1s=edbyyRp+N4hpDzTG6nFURQV+3sQ@mail.gmail.com>
Subject: Re: Christopher Wright
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,T_SHARE_50_50,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7118]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yachicof1234[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yachicof1234[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_SHARE_50_50 Share the money 50/50
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=20
Hello, my name is Christopher Wright, Audit Accounting Officer of
Groningen Bank, Groningen, The Netherlands. I got your information
when I was searching for an oversea partner among other names, I ask
for your pardon if my approach is offensive as I never mean't to
invade your privacy through this means, and also i believe this is the
best and secured means I can pass my message across to you in a clear
terms. I have sent you this proposal before now; I do hope this will
get to you in good health.

As the Audit Accounting Officer of the bank, I have access to lots of
documents because I handle some of the bank's sensitive files. In the
course of the last year 2021 business report, I discovered that my
branch in which I am the Audit Accounting Officer made =E2=82=AC5.500.000.
(Five Million Five Hundred Thousand Euro) from some past government
contractors in which my head office is not aware of and will never be
aware of. I have placed this funds on what we call an escrow call
account with no beneficiary.

As an officer of this bank I cannot be directly connected to this
money, since i am still working with the bank. so my aim of contacting
you is to assist me receive this money in your bank account and get
50% of the total funds as commission. There are practically no risks
involved, it will be a bank-to-bank transfer, and all I need from you
is to stand claim as the Original depositor of these funds who made
the deposit with my branch so that my head office can order the
transfer to your designated bank account.

When the fund has been transferred into your bank account, I will come
to your country to share the fund. The fund will be shared 50% for me
and 50% for you.

I await your response.

Yours Faithfully,
Christopher Wright
Audit Accounting Officer
Groningen Bank
christopher@groningenbank.com
