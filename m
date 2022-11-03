Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D794F618970
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiKCUMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKCUMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 16:12:14 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C122205F2
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 13:12:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id bp12so335628ilb.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Nov 2022 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRqJLEoj2IQ/JF9LEX6H2ITW4FZJ568BdKfdiP8mFxQ=;
        b=Znngut9DM/YUKlXHKZjUQxeWAiORCTaIIgdaxTtfrwgbpv1QcRsIg1AaaTnSvJ4StG
         Ny7uj0RxHMIH8+qoC67u91gqq5e1zFX6mnpkpczFyH1oLo6+yqY+LHrFAYEImrdheGrx
         fnjINSF/p1LHLtTS5eqEQ2LF+Y5FtcV4SPuRxnZhLhsugY7Kv0sIz5C2ZWdVEvDh1Tdv
         UOaNtmt3uP44eJWci84fK9lMAMt0eCN+lkfbtd+D4opL0No3Ct6hrsxjrcup04orMpxV
         3/8KCymR5AljjklMjormg17D5zhQQHAZqiwuL6BmHURH2FVX07siNtu/k5HRAfJIXrvL
         mXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRqJLEoj2IQ/JF9LEX6H2ITW4FZJ568BdKfdiP8mFxQ=;
        b=zrBfQrJzUzDEywXZ5Cp7n1MMVm4FTwx/lb3D4i/mSGCzoJlGlptASwknXjZyTazUSK
         F6Wl0ITayo3OUNBhkht1/mBs0G0JToXA2oLKnI4OKNv8icwUtNHe0w28k6dvX35qe/Cs
         6K9HGvnKjf3B2U5sAmwYNjdGLsdhyk/X+36PBjTb7pg81WPOS3SOUpoPZekGFWEFe5aw
         UqejLN302zdb4V5BD9ugQwZzN6s+Dtftv4krziXPazLGH/oVxMpNdLOEZn+Txjzn16pv
         BK7DusQgq90uCR32TEtBfkMeD9PvaowvpjJJmBmQYQdOztzxJuPrUc/VCw5ZMeNkNzM2
         tdGA==
X-Gm-Message-State: ACrzQf1ZNtBir6fEYvrXXn/LmsbvRauybo3T6kYHMbiFKhFHBQUZEmuM
        4IPp283f6LibBW6c1lIhPRZYK7cdMDM8uWBNuOU=
X-Google-Smtp-Source: AMsMyM7z/0Yopq6nEVnLdTleFNxewkKlxCXty1BY53A9faef+OYLA5fAmRd2k59TCB9k/7Xstc8Gvgu31Jg1lZgExXU=
X-Received: by 2002:a92:c886:0:b0:300:cb13:7cce with SMTP id
 w6-20020a92c886000000b00300cb137ccemr6515000ilo.41.1667506332350; Thu, 03 Nov
 2022 13:12:12 -0700 (PDT)
MIME-Version: 1.0
Sender: robertwood0337@gmail.com
Received: by 2002:a92:c243:0:0:0:0:0 with HTTP; Thu, 3 Nov 2022 13:12:10 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Thu, 3 Nov 2022 08:12:10 -1200
X-Google-Sender-Auth: qlXr6Sb90zHlC58p4-MGM-TOdcM
Message-ID: <CAChgFCOJgYHJ8=ATMmxYuxy-vhb4asYhs3HOCeBm3itrU_LrFQ@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:144 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6057]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [robertwood0337[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
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
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00, Eleven
Million Dollars) my Doctor told me recently that I have serious
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

May God Bless you.

Mrs. Hannah Vandrad,
