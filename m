Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05550565C20
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDQad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiGDQac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 12:30:32 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD126376
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 09:30:31 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10c0052da61so3036425fac.12
        for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2022 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1vXSAvnvwdRE1mv8U6aYKMjf6TxQAWjPVRxVTPQpxFQ=;
        b=i8MLV6ZMUL8HmZtPg+jaPUL70WSbqAHy2819oq6rDQFBdg+el6j04AmQR1/qzrt6Kc
         WoIvn+gxMtO1GT4Ff2IKYDasjGJ+7W0sWLfAeSI6GmLjdDAEJLmN0F0Rvuee/J5SrbOg
         q2JISXC4qc/pf3MMNUVEkqoR7bYETn1eCS2UFd8VjANYHg13iz7jYb+lRshaw4EJuMTn
         +B/FKY87xua5+zpQsqn1bzDe0u2UiUyJ6a3B9d/bQkaECLSFioMwAlhL7xvkBuvOCvhq
         bqEvn+FBDJZQd16wUK9KLLZgTtbSxLDDoCe5WF9/RKM1X9LOL2fojmHlBKXknE2PjcC8
         mMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=1vXSAvnvwdRE1mv8U6aYKMjf6TxQAWjPVRxVTPQpxFQ=;
        b=jSbhEPrbzYhXKNI88MIbZC0T1oZjjgDS14OCA80GzDJKqUFklrLFC3BuTxwcNoGgyi
         1Yj3fTFhFLK3kvr+v3CWpTbL/YjrIuzupJYKWd74tM70AFEIf6HFQZxv7Eh2Ysc0UaoS
         D/1Ecy/chSul/9QBp8k2+bdkjOfp3G1lNYFXAGs5wtacE+x26EwPxlGfPvOf+aXS81/i
         sjKvkzds76ZIHuIAX/YxnhNqer5jQj7IqqTpFM+rQd6/7TrMPFZpTpsHSq1vO88hZHdq
         yEHRrPaMDr2tUNQJjHYubE4ndL7IimJGw9lh2zZQTPupktRwD2p2hYZe0tpRfwBXywht
         MIGA==
X-Gm-Message-State: AJIora/i48uykqHndCxq91TNkixDASEdVgCJh2VRzEJdacTeSJbm/q+O
        RrtM3u7QIlnEFL87mBGfQo00wKJ3Wf3umvf2NJM=
X-Google-Smtp-Source: AGRyM1vkBCScNR4UjJfCXjC35/z8cef5aMdmlvnXMF6bhC7lsY5xtjyay56YeHxIXqMVvakshY1Js7tzpb2i5gYeQMc=
X-Received: by 2002:a05:6870:9a14:b0:101:c1fc:57a4 with SMTP id
 fo20-20020a0568709a1400b00101c1fc57a4mr18802049oab.263.1656952230523; Mon, 04
 Jul 2022 09:30:30 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem00@gmail.com
Received: by 2002:a8a:7d9:0:0:0:0:0 with HTTP; Mon, 4 Jul 2022 09:30:29 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Mon, 4 Jul 2022 09:30:29 -0700
X-Google-Sender-Auth: SKg76osXYFPBGsBPkqZiKaUY7qE
Message-ID: <CALrB==4jBX__NE8OPVTRLzxhjxbCfgMudXianq=MBALe93ZCkA@mail.gmail.com>
Subject: Greetings my dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimahazem00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings my dear



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

May God Bless you,


 Mrs. Hannah Vandrad.
