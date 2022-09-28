Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DF5EE4E0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiI1TOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiI1TOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 15:14:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A89DF93
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 12:14:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so15401255ljp.5
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=FE+riTp5HuP+zQk7DQYPjB3eGpA/zj0hqF/gO+Y6LXU=;
        b=GsgVbAi8raSTEdWFkflMXq95msz0N4/OcaW3QBqrZSD3D3x7uKPvFhXDRhibJ+KI0m
         3VSQhFMURA8a9LILoSKBjMhkhGqSlVJDcnNsvZf4XL3/nitiUiZiaRweW7UW4Cauwak8
         /Uwk+IFYU0rSlF8f4TZEumJbZK0PU/I75mUl8J925uCZb9gADmAn5osCiAS9Ab3FctAu
         44EPDsOnpXSRBjt+lpTphb+DNEUIlrSXOMqM2SWc6gdoFEUoKzmYuZqbjAxS78ZwRHpk
         wuTPJeiU3lZdMYvkJzsCglsbY7GLdJfYpsuwV1h7PB+IQqyzzKrw+7Mtz6xT19DXuxmk
         iIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FE+riTp5HuP+zQk7DQYPjB3eGpA/zj0hqF/gO+Y6LXU=;
        b=hIsRgok4GVeiqZ5n5J2/DGiqJlmaFj6+BIRpeGzQ+YG+3517MlvXFS1YVdStWnfCGv
         3zamN46P8IqD9SKfyufA2ryNON4owRq0EkuFiMTbDTx6XnU2zjBhV0OKXqnhaAnKMsFx
         SZXvaMuHaJRlFXV2ea9cHM90XRpSFUrT9jnfz1SgCIpoMHPYVHiM+CgngH2fbQj8cUnI
         9RgHArokLsABArfGG3ig8EEepwCHeyNBALO8YWiPPsiJcjfy/bhJYuX0yFGmypFolSGf
         6RB0/vQiuBtoEU97eREA7sUmC0JQrEPImpWp1jcMYsK91V3AFtTw7g3rz6SnpXMruC9T
         SQDg==
X-Gm-Message-State: ACrzQf2GCyMh/sFGcHvSUUHXzKgm9E6NGoWRej89y3sZI+toWxiHRTfn
        A7N2bKTGcN6ZssJTByuUUcU73xSaK37fZCnvj+o=
X-Google-Smtp-Source: AMsMyM7M4kkfrzafutvfD//nXr7u6yO3ZYpBttT0WDbCU5OD55Dy7nXrCvmcGfdS5/AfJizKfIiCmUAsK/ot3Pi4bSo=
X-Received: by 2002:a2e:7a15:0:b0:26c:6543:e4a9 with SMTP id
 v21-20020a2e7a15000000b0026c6543e4a9mr11788446ljc.204.1664390759597; Wed, 28
 Sep 2022 11:45:59 -0700 (PDT)
MIME-Version: 1.0
Sender: samsonmba0331@gmail.com
Received: by 2002:ab3:1e44:0:b0:1e8:a58:7405 with HTTP; Wed, 28 Sep 2022
 11:45:58 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Wed, 28 Sep 2022 06:45:58 -1200
X-Google-Sender-Auth: XJPtPNz7ogE8i_gsjNIW7AV4L0U
Message-ID: <CAH-h-AxodA4vX668R6ZKbRyBgOqXFZL_fuXm3zyBnfXbnZ_bpQ@mail.gmail.com>
Subject: Greetings My dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6010]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [h.vandrad[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsonmba0331[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
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
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to seethe next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of($11,000,000.00, Eleven
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
