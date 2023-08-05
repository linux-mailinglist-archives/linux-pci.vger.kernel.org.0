Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8314770E8A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHEHnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEHnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 03:43:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B04ED0
        for <linux-pci@vger.kernel.org>; Sat,  5 Aug 2023 00:43:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so25518465e9.2
        for <linux-pci@vger.kernel.org>; Sat, 05 Aug 2023 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691221401; x=1691826201;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=H6MquAaP6/HmkEokFI9YGQzP/w2mxoVQVHOlwZZiq4P2moVqB0l542greR0hKk1x2L
         CN4gDDhaPLuFGYAUV/fGZPWI5n+2njUxJLEADeTgmTZNC2MvfbzNcFQ6Lc7PAb0Q+ata
         dc87Y3MdQi9fqnvV5ZMgfsfHP45COU5ta8paBekrt8xcZEqfX16cGKP5+qF2qRYCDcN3
         b0Uofobes4PxSKOhrILB6qWsOnk5baNMdbW9j39OFUrGGHcH96x7niST1BL8avUJ1CRG
         Ol5kSm7BPk2eiFY1OetXYoLKMm5k67kHGhCVsawcbVvLz+Y8VLrOuXBOcesK9UML+0ar
         ecug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691221401; x=1691826201;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyaf0OHfvWgaqfRiwRufcy49gz6rXRNyNLf1qH0Ffk0=;
        b=dztDlINnKYnA2f59/H173eYvSn1vTb03JDZd+hHxdksFwlahnvj67QNPqmuWOOYHbz
         jhcuZ7unAn9TagPxLYYt85yuCss9b0RutpKK4y+tSs6kp6s8b5EtmUbILLz9rgtGV5bV
         wUkAXa9p3O4C90uXG8vGaUFgPYteO0C5ee1lGWMYkz2Y7r0BZ39KYFqb+RQi4Ghld+y/
         NI7Vi2XmdccRrUxXMkoQZPhk3JlmTshRuAbvJ/uIRanoFR38BpEPp9MxKUxYfDjEwYUV
         PnH1JvsCmXbeMEs4WkuyYJAMuKrt6pToxerlu/JJlCYjo0hpefK5ONfTsuVQESzsRT8Z
         UqhQ==
X-Gm-Message-State: AOJu0YySXhj6/utfQCRv6FxDzEUSI7g8VljxlHRuxEV8+bC8OljETofF
        xGlFmh0An1oDrWcV1H8+BDeDtrB014RniMjpj5o=
X-Google-Smtp-Source: AGHT+IH/VlnyPMsWJwsj/SdjFUaBPgKWlvvrmxm2mX1JQ9jJHFM4HrzV5fWlfvkX8mxOZPAPXC//FiS+Fm7a7sUGFTw=
X-Received: by 2002:a7b:c4c8:0:b0:3fc:4:a5b5 with SMTP id g8-20020a7bc4c8000000b003fc0004a5b5mr2862333wmk.29.1691221400743;
 Sat, 05 Aug 2023 00:43:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ed43:0:b0:314:eb3:bbfe with HTTP; Sat, 5 Aug 2023
 00:43:20 -0700 (PDT)
Reply-To: bintu37999@gmail.com
From:   BINTU FELICIA <felicia974@gmail.com>
Date:   Sat, 5 Aug 2023 08:43:20 +0100
Message-ID: <CAOKX9wO1QZYF_keq_AUa+5KoWbaVT+i_iZfa=CLMttSoLxPG-A@mail.gmail.com>
Subject: HELLO...,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

How are you today? I hope you are fine. My name is Miss
Bintu Felicia . l am single looking for honest and nice
person whom i can partner with . I don't care about
your color, ethnicity, Status or Sex. Upon your reply to
this mail I will tell you more about myself and send you
more of my picture .I am sending you this beautiful mail
with a wish for much happiness
