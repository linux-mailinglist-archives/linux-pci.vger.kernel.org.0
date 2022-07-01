Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1D563117
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiGAKNq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiGAKNp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 06:13:45 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ACA74340
        for <linux-pci@vger.kernel.org>; Fri,  1 Jul 2022 03:13:43 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-2ef5380669cso18614487b3.9
        for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2022 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=jc9gdMoaVyMdn2YJ8TGD4DyU8BGVsno1wLmvRcr2UavKHBClKTu8+gVDn5M5yFujUw
         R2ijLTgXmeLmPLaKyzfbgHU3e8AXRYqNhNjjuUP9RvKLjPmPcwNXqItmNvkABPBp5iUY
         Zw7fG+CZK3/1p5XxjFlACaowALfzIkGfraDMkJ1l/0BZE4huaircz41BrP3Omh5ss7Qm
         WbgHyP2wyGfzlmarTPP7xV3O67bS0tKtnU1bLQ+xowUkWONB7J+wLjwvY6ckiPj48Qqx
         5w9A6fqVHNPsswdABw53vlPSUlg11qc8kM2yQKg1BSPrjhUmayvP//IE8XlLmX+FfboT
         EUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zkRKKkHvNmeWqvRVOQLK4rfH21duyawXjkMEAhn/9YU=;
        b=0YEOUO43zGHHdIzIsFIhLUvZf/fqu5Dwn4bXyhESQ2U+CecwheI5KI9fAj6q7l0mNN
         Vf9G8ivBbkSvzVmhIfhX+jakeS0MxChfhuFEANYJZSV3MTV4CVFE3EstsqfpxthuD1in
         VF0T2mVawnHvbuylJJrFq2nTJKX3+iy22xMvIlkZtpDJDCNnHDHA9JYaHFVr8+ysIqeL
         PhBmpKY5Wmz0tx6z2IOElta8R3jT3CFT9Ak4Vdqhi1bujLZmjDKwpedQ63GDXEXrh3bu
         IfI7rTmW1CdNybXXTdR1jZ28GEQ/wyz9v0zbtt2Er56aWrGW+99z+tcprD5DnrvSaGPj
         DMzA==
X-Gm-Message-State: AJIora9KamGcmmsHuutU8chHR8KkuQxzMjymEKt+oXaoUk6umD8sd3dd
        LeGY8ql/mNrkQLHvEfv4VX5sbA5MAwTr+BzhArk=
X-Google-Smtp-Source: AGRyM1ufp0bUl+jOYYov+0Zuomx2Ux+d3Pk0S60JFRp6EfGOyTXtX3+RYzPNzSf68K9WfN+iapa6HfdFG9z3v1AzVJE=
X-Received: by 2002:a81:74d7:0:b0:317:7463:d852 with SMTP id
 p206-20020a8174d7000000b003177463d852mr15641908ywc.385.1656670422593; Fri, 01
 Jul 2022 03:13:42 -0700 (PDT)
MIME-Version: 1.0
Sender: samsonka22@gmail.com
Received: by 2002:a05:7000:9993:0:0:0:0 with HTTP; Fri, 1 Jul 2022 03:13:42
 -0700 (PDT)
From:   HANAH VANDRAD <h.vandrad@gmail.com>
Date:   Fri, 1 Jul 2022 03:13:42 -0700
X-Google-Sender-Auth: 0LPyUJdOGIOEMhl_BgWvTe2Dz3Q
Message-ID: <CAKY8iZrONJE44s7SqojBdusvvmVunMSQBiOpOPbQF7nhpWd5Xw@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsonka22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
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
