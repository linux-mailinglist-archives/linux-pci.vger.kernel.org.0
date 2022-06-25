Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077DC55ABA4
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jun 2022 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiFYQ6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jun 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiFYQ6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jun 2022 12:58:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530EB13F81
        for <linux-pci@vger.kernel.org>; Sat, 25 Jun 2022 09:58:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x38so9664779ybd.9
        for <linux-pci@vger.kernel.org>; Sat, 25 Jun 2022 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=KsfZmfHwEoUmo32EMl8R69YgNYeOI+3gnbWXHLQpmoXfJBWazZKTgVlMJuiL1h8r9c
         +3L3Mu3UezUqsHfXqzFXj+KIuVf1S/iL+mCZ0ewJk0/xu7vxznCM8dEPsA4s/mjDnJOP
         WU3pSRheEyd4d4MVPFCjx4pMuOtgMfzI99V2phdQNVvNUcwi52nKzJFIsGxa8KOa4x1X
         iNmLahNWHPwqdkDJyDQVDgNVm2kkvzGyjlzkzXZb14d0FHTeScjwEATvn6JfpS2WaDZH
         cQhetDHCJGutUWT0DU3g/HlNgUC8EMCYGMhs/js2lbSZzb1DlbgQdb2VfLZxzyDgWhR8
         WmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=nR+l1sJ1lLOjPnujoFlq3ra79owLviz4AaB37Bw9+8FdsOSRZWhif2kCnrye9b3npx
         3Yb1UtUd/FI1+dKExXkbLi6BQN2zbt+NmG0xa4/XIOYOb8YygIph5f7+2PkQ9Flrrkf5
         fzeTxgQHFzBL5J9db5P069Xss4bV17FGWtQFpbN9wLeiE0R3jz9EL01VYMPCgToVeca5
         FCNvjlcKLUT9e081dTLr2uuOG7Ms7ECvcmzKOax+pGl/umZGVlv8LpHOgFooL+Ffv/2U
         /I9GkmedIWibeTbpsws3Wj7q/QqIOBfk7beXWqiPqNGy+cjsq94tBPxyuS5ZR/sYCB52
         AIrA==
X-Gm-Message-State: AJIora986ZMYdDc6SZl6GKDfm/3sztmlF2C+h5t/gcq216yiCXIaE9Jg
        1gVgRQetpjVmbZ1tazIfm4YR+kcWCSq55GFCJ50=
X-Google-Smtp-Source: AGRyM1t4wTpxKGcwNVCaVZnbM5aZf97IxU+FcBU2AdN1Io2kRH9xYgRB0v/75tswkfhAmJt8cJ9DDQjakCS+1LyPgj8=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr4985546ybc.227.1656176294259; Sat, 25
 Jun 2022 09:58:14 -0700 (PDT)
MIME-Version: 1.0
Sender: asakigbosamson@gmail.com
Received: by 2002:a05:7000:5344:0:0:0:0 with HTTP; Sat, 25 Jun 2022 09:58:13
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sat, 25 Jun 2022 09:58:13 -0700
X-Google-Sender-Auth: Sfpbn_G015D7mKjMaBF3Q7lMlAU
Message-ID: <CAG+Fjb=LLh6OoDcB2zqcKhHrko+KBLnMLG12veWzO0GTdrVO=w@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings dear


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god's mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00,)
my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you,

 Mrs.Hannah Vandrad.
