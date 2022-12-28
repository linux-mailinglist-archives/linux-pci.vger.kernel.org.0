Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C85657456
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiL1Iw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1Iw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 03:52:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B82120
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 00:52:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kw15so36916663ejc.10
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJ058JRM7D+mqwq/vtQFBuL2rBPdsvIRLlRah8/kU5U=;
        b=PWYpTBdAbvD0Gzhl+2CLotED9HxWnsIfcIkAuDEGILEaZa/yynfBY1TinmqKFBxOGT
         Mz5CGdEaD/hoCusiwh9J3HVpjFmPEjNTs22vFCog8jL3FhaUEpXI7gy+wl2q44OTSmjS
         SHw9abEQMj+P/CGNrh4y0CW7XAtCbFOT7NYaXS7rmzBEwIXXDKPEoWEu5e4j1crmuPla
         g6A36Q9Jl5x9uZDfW6MBbv5sNjNj+ivSoJhgfcyFrjKemhGFZCc12uyx+0wVJpXpeI5d
         yvhi1Fw8cA4Qj4zECSUOP5RJsv3+u26SoXO2hXJuvNGtoit3l87v3GvRl0qIpVNn5np7
         Pf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJ058JRM7D+mqwq/vtQFBuL2rBPdsvIRLlRah8/kU5U=;
        b=6LoXvmw7fZoIm+orSAlTJrtUc/nJjKM3fc2JMLDriYRN+ZjQICQZxw8jam/Ef0Lqpi
         uTbyHVl9qAHr8HEzF3b2h9Q8hKVe986P7R6CLZ9kMJEtXOGPnjeBZd01Ch86hRQLQQOm
         ggX7p7MUlpC87YHN1Dg0Q3rTtopTETYnPt9Ni05WZeE6nFiS5LR2oD802jv2WnxbbTw/
         Uwfgn9UobzXY2h+4yILJzcwXqIzPrI0xX9hCALMjdBhUbAWrI4MLU7C2vah0x7HbtgOO
         DFDibYpBuJIYwsLQy8GPKNZgw6lNHHZfCb97cgA/ZxKDhCcs0OOPehM8VSueervZd+8H
         09Lw==
X-Gm-Message-State: AFqh2krwcBf++tjrtmCamPv/x4J4sA4cNv38IThBIC/rKlnnjYwgTazT
        X9VGX3Laqw2Ww1IyEBa+CKE1DO2WNFq385e4ncpbtlMZ7UGBEQ==
X-Google-Smtp-Source: AMrXdXtcWjkj8yZsgRvSTMeYRfbiJJ67XaD9HKNA3kSlXB6lWUhRq4hMJS+W/Lp9ThXSMtGvhtf6fIi96zLkUNbhd10=
X-Received: by 2002:a17:906:5dd0:b0:7ff:7876:a703 with SMTP id
 p16-20020a1709065dd000b007ff7876a703mr3159627ejv.103.1672217574574; Wed, 28
 Dec 2022 00:52:54 -0800 (PST)
MIME-Version: 1.0
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Wed, 28 Dec 2022 09:52:43 +0100
Message-ID: <CAOkhzLXfc9rrcXw3iwe-yjVQXNBURZJrT7+24r6gi1kamdJ9fg@mail.gmail.com>
Subject: PCI bridge to bus boot hang at enumeration; works on v6.0, stops
 working at v6.1-rc1 upto v6.2.-rc1
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello there

1. Happy holidays ;)
2. Please see: https://bugzilla.kernel.org/show_bug.cgi?id=216859

With Kernel 6.1-rc1 the enumeration process stopped working for me,
see attachments.

The enumeration works fine with Kernel 6.0 and below.

Same problem still exists with v6.1. and v6.2.-rc1

Please see attachments.

Best
Zeno
