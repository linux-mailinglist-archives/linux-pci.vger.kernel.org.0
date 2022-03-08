Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE974D16A2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiCHLwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Mar 2022 06:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiCHLwD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 06:52:03 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66B2E0BD
        for <linux-pci@vger.kernel.org>; Tue,  8 Mar 2022 03:51:07 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id g39so31700693lfv.10
        for <linux-pci@vger.kernel.org>; Tue, 08 Mar 2022 03:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=VsKXeyq/2GS92/Xx57CmizwltP2JbQChS2ubW8vafRE=;
        b=UQatQXllnLooh0o0cLiJjjkwLWZoPBA5wA0boIdEUqhk8lUco3EFwzdeG6xZfwYvGs
         LLCucjlHIdpAqHiIWtNyaTeiZGyJcfk2bvnznqRJYkP/spMTROORH5fW9iQEOtynSsot
         eFJxjQ9XL8cDiKv6SnrAQR5s4TmQe9O6sA/recRCJ+gLspjQYIdJcnqeJ1x5PzsE03FP
         giYOD3kH3ooxj0gRQtEg0qXUjce2QuJ603wrfMRO+evNuDFPSodx+jOt2rSbvZUfFt+1
         2YWYOhAJQPfDOS+Mrr2PyP9PsHZTuHVREc26Mo5oZApG41eNWmBx8j0/6PxHT5yrDKWs
         xCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=VsKXeyq/2GS92/Xx57CmizwltP2JbQChS2ubW8vafRE=;
        b=pjH+6ZkLQYYRwyd4LEMTBTbATitqr9Rtwrlc7Suko/Wpjgl4LqlF3UMNB26ThqBN17
         LDBF3rFZkoX2xtvzGRFRQZA4rFNt0RYAwMGaxyss1LDYw9rofkXJJVF/fErGoyrUK487
         d+0FwE6nonEtnb/JWF6jYAwCL/6Kxqql2gPJpEit6ceTCzyr2BSgJCISYVZ7sVDOm3HX
         notsgXlRZRGb+vHDlSEGXgB57cewLfn1X+8+OLfxObSel2ykv749IsD5rUz7JUvD4dVW
         H+13yC8qvuuYK9njUPey2+S2Aa35LKFK32VV0gUvPT62gjsYvOnHanMmrA8ubd7EHd1d
         3/0Q==
X-Gm-Message-State: AOAM530V+2g5QgtD7Yyd8n0u/hXkxgvE0v7AdmSBtrK572GA51Zfslgl
        5CamBKzf5aSbeMjPsD7h2JEi9zGgmM+6843pvsU=
X-Google-Smtp-Source: ABdhPJy+uzJhI+XQ2dBJ8pdbFFxeZUHOPZqGVMp3TCMa67AHGHz9vy5PoJK/HYWy5OO7lrwRq9tzJJEbYqv5d0m6Ma4=
X-Received: by 2002:ac2:57d4:0:b0:448:2cba:6c86 with SMTP id
 k20-20020ac257d4000000b004482cba6c86mr7438883lfo.201.1646740265448; Tue, 08
 Mar 2022 03:51:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: f.k.fleckenstein01@gmail.com
Sender: mr.pichetkhemthong070@gmail.com
Received: by 2002:a05:6504:1063:0:0:0:0 with HTTP; Tue, 8 Mar 2022 03:51:04
 -0800 (PST)
From:   "Mr. Ken. Fleckenstein" <f.k.fleckenstein01@gmail.com>
Date:   Tue, 8 Mar 2022 03:51:04 -0800
X-Google-Sender-Auth: klqJ9hA-1Kqbhd0vPp3XEvlBbBI
Message-ID: <CAA9Tq_owhV2=Dhpsxq+uG0DzUV6T=vYFosRfEDWJYKTBUV_vTQ@mail.gmail.com>
Subject: Attention.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_ATM_CARD,MONEY_FORM_SHORT,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,NA_DOLLARS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_FRAUD_PHISH,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello

Nations (UN), European Union (EU) and FBI.We have been able to track
down some scam artist in various parts of African countries which
includes (Nigeria, Ghana and Senegal with cote d'ivoire, Cotonou,
Republic of Benin ) and they are all in Government custody now, they
will appear at International Criminal Court (ICC) soon for
Justice.During the course of investigation, they were able to recover
some funds from these scam artists and IMF organization have ordered
the funds recovered to be shared among the 100 Lucky people listed
around the World as a compensation. This notice is been directed to
you because your email address was found in one of the scam Artists
file and computer hard-disk while the investigation, maybe you have
been scammed, You are therefore being compensated with sum of
$6.5million US Dollars valid into an (ATM Card Number 506119102227).

Even if you are now dealing with this nonofficial directors of the
bank or any department always requesting money from you, You should
STOP your communication with them and forward the details so that we
will help and recover your fund peacefully and legal. Since your email
address is among the lucky beneficiaries who will receive a
compensation funds, we have arranged your payment to be paid to you
through ATM VISA CARD and deliver to your postal address with the Pin
Numbers as to enable you withdrawal maximum of $4,000 on each
withdrawal from any Bank ATM Machine of your choice, until all the
funds are exhausted.


The package is coming from Ouagadougou Burkina Faso.don't forget to
reconfirm your following information.
1. Your Full Name:
2. Address Where You want us to Send Your ATM Card
3. Cell/Mobile Number
4. Copy of your passport


Yours in Services
Mr. Ken. Fleckenstein.
MINISTERE DES FINANCES
ET DE L'ECONOMIE(M.F.E)
BURKINA FASO.
