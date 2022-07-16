Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A20576FE1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiGPPau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 11:30:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C3B1EAE1
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 08:30:48 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 75so13268720ybf.4
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3qF4MeJBnDiw8ry4p0CwZ2aa7S+PVcycR5JZNtbnQ3A=;
        b=c+gBh/xMnAg+Qr+0ZC7DOucFxYgXZAS7xRt7Sh2IlmYpHF/xsirxW+V3uZ1yuNZzrm
         yKmxM1f7MyqFeRIc2Iy6ZPLR0m0PBxUBgHcG/ofrdp2q/oCDre5+7H1NXuGYOJbR0D8J
         P43yh+Z3YkdWLGx1IJos4QwRPKkSP9nGeEZYf8EGptKO7P39kNH7HLLZz8gsoVg5GSoG
         HfDnJHqCT3CWFw9qipbDY4PcjMY6EePN1UQWl93uK/sg3LDqNAEqSzfQqTPzeT44TxUr
         7TkhXFkkjCGdgDq9PkP9nRPYz93QMpTeTPimD1zlUfaxdptYtVmWLlW0xgh6Na6AkW/B
         AUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=3qF4MeJBnDiw8ry4p0CwZ2aa7S+PVcycR5JZNtbnQ3A=;
        b=d1ZfRNbi4Mqku98toJcTA6dMXqbLY9CW43uVE0XUVltosB/Z8eKowNX1t76ufiggIr
         bi3sNG7Kw4dVWc35lgGZFqgwbGQzA/esP/azCoM6GpRxc2oSQ3DcwZQ4M0tkEk8b4TU8
         PfefZOY4nZuz8YB4Yoi3pZt88ZjqXyd72oR2ZFHgBf5ADN7G4SSETUvgJYBGxTQHU/eB
         ReFcTmjyqr5yroykpQlZR1J3c0/WBuN7N9QCFkYfJqtIV60Z3FL9e/+5K3bQF6/pHWaI
         +Vi/Jh206hLkxTtl3sTnE2b7sJ3rwPzJ+ooD8PgjK9GJfD+3Kc5Za1P9JPSR+HqQL2vt
         IztA==
X-Gm-Message-State: AJIora94spJ08ngtCSxxqNJR3q0tkn7zA2QGLuLu/0db6McLDPdnPMFw
        SKK1S6ZbsUCbGwxcQEf2W+7aCoGBIIE5OyQCAXs=
X-Google-Smtp-Source: AGRyM1tGztY/nArxR1gUN19rMMMCbAM6A4Qjg4/ZnurRJJKA3PaM6aQHF57HANhTNZnM2aXDLI4wYVqwFRXVP4JYaWI=
X-Received: by 2002:a25:6ad4:0:b0:66e:6b7c:7c5c with SMTP id
 f203-20020a256ad4000000b0066e6b7c7c5cmr19233833ybc.234.1657985447029; Sat, 16
 Jul 2022 08:30:47 -0700 (PDT)
MIME-Version: 1.0
Sender: drfranksaxxxx2@gmail.com
Received: by 2002:a05:7108:1f90:0:0:0:0 with HTTP; Sat, 16 Jul 2022 08:30:46
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Sat, 16 Jul 2022 08:30:46 -0700
X-Google-Sender-Auth: aEeFJRXSV77ol61_ZNS0c4oXlk4
Message-ID: <CAGnkwZ6roxWwB2dAsxvZbA4TsMsgBf_dVATeeOJP+4Ja_qTkgQ@mail.gmail.com>
Subject: Greetings My dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drfranksaxxxx2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings My dear,


   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am in
a very critical health condition in which I sleep every night without
knowing if I may be alive to seethe next day. I am Mrs.Hannah Vandrad,
a widow suffering from a long time illness. I have some funds I
inherited from my late husband, the sum of($11,000,000.00,)
 my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my
stroke sickness. Having known my condition, I decided to donate this
fund to a good person that will utilize it the way I am going to
instruct herein. I need a very honest and God fearing person who can
claim this money and use it for Charity works, for orphanages and gives
justice and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be n=
amed
after my late husband if possible and to promote the word of god and
the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an
ungodly manner. That's why I'm taking this decision. I'm not afraid of
death, so I know where I'm going. I accept this decision because I do
not have any child who will inherit this money after I die. Please I
want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. May the grace, peace,
love and the truth in the Word of god be with you and all those that
you love and  care for.

I am waiting for your reply.

May God Bless you,

 Mrs. Hannah Vandrad.
