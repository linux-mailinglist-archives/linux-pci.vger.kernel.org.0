Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6A535213
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiEZQag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiEZQag (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 12:30:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB79BAD0
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 09:30:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q92-20020a17090a17e500b001e0817e77f6so4835922pja.5
        for <linux-pci@vger.kernel.org>; Thu, 26 May 2022 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=hft3pFQ744fSdTwXHt92bZsNzbWCW8EWdxZRGP0yF3I=;
        b=S3SVBC2ysXlMtAljWuti2+MJ2SbWfff+KOU4HhGqrzi0RbdMyzXzMmvBn7gb3HgKQr
         BMtoEZ7mWkm59aNJ1EqcWVCSyrSoTJSVX0lvCeCGLJKVQSJgonY4yoxlq+5Xq345bF/L
         Rm0iSs9O1MO0X+0rD2iCVSJq0sslpYlZEje2oxFWQaAmJupGbOyEq9E5TYTx6hKZkZ8x
         HNaFpVxPwlDjASbhajUejKlHBIaIJkYURunTeT89GaFbILAPmKygbXCA3epFnjiw0R4P
         jDou3CC8X02jKmxLCE00UmoiWqETaoHzhteSKTQylmwqrPoMkT7FTRF31zQ4IzSlQdWJ
         sXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=hft3pFQ744fSdTwXHt92bZsNzbWCW8EWdxZRGP0yF3I=;
        b=kIFQC+Ro147c2G6UMrjFeoMO9RyNGdkki035sM6jIrhwQVR875z4mJdb8E/uLcNlyE
         afgHJqOTgUkp9JE+UbBWcauZzmuqyVt64kqO2V3uxANNWH3YpT26lhu1gMsj9VkxhBte
         9qdzJuqCuzPm7V+d8cLRFYQFTUBJzmckzyeryh5IrShqHGU3aNrHnkd9lNgZlFBMLKJ3
         hpsh803RuVZs2dfQch1OsdtM8GstfJU/gWYDDC4dTSkLkoFo9/fzY8US01iHqmC+HEC8
         vHLpeYwrxilG0UbVXJZMapJaz5b3liYMxZClIVI6PX6vAgXgqe2hy8M3qFgCFEgn95TX
         5hcg==
X-Gm-Message-State: AOAM532zvDuWRjl8U5ZHjSAXUIXenKoVGLrA4Adk619tDuVpw6NGOJYi
        RrDcFhLDySCQSJrtv5jwodx4HV40CYiFuMjAwBc=
X-Google-Smtp-Source: ABdhPJyarPV38Il+LphIisoxEIdJDNN6+UOc8dXR3pLQ3pJMsa0NMLiUGNPoKSZueOimkwk2d/06o7i2O7Uhy9ve1Nw=
X-Received: by 2002:a17:90b:4ace:b0:1df:cb33:5e7e with SMTP id
 mh14-20020a17090b4ace00b001dfcb335e7emr3415455pjb.5.1653582634792; Thu, 26
 May 2022 09:30:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mr.a.manga99@gmail.com
Sender: mrsannahbruun605@gmail.com
Received: by 2002:a17:90b:4a10:0:0:0:0 with HTTP; Thu, 26 May 2022 09:30:34
 -0700 (PDT)
From:   "Mr. Amos Manga" <mr.a.manga99@gmail.com>
Date:   Thu, 26 May 2022 09:30:34 -0700
X-Google-Sender-Auth: relk0xRbkWGB1Z0LR5py3McFfLg
Message-ID: <CAEyYVPH-h98Wpcds+gW4-cdKwfKsBLJYPMK4Atc_tNRcqrY0zQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FORM_SHORT,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good day,

I know this means of communication may not be morally right to you as
a person but I also have had a great thought about it and I have come
to conclusion which I am about to share with you.

I am a banker; I hope you will cooperate with me as a partner in a
project of transferring an abandoned fund of late customer of the bank
worth $18,000,000 (Eighteen Million Dollars only).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright for you so that we can enter into an agreement before
we start processing for the transfer of the funds. If you are
satisfied with this proposal, please provide the below details for the
Mutual Confidentiality Agreement

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,

Mr.Amos Manga.
