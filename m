Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A24C05E8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 01:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiBWA1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 19:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBWA1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 19:27:03 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23693E12
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 16:26:32 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id v28so14754325ljv.9
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 16:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Niu8BsR9isXU2Kkmnz56yc6lMiREQRBSltPoKUcabxc=;
        b=jhnDwTDW0FR/ROUhsuc0Yuc3i7tDnAcCCgW/rgGkmSYsWSxlgrurjzZhBRDR6HpLqT
         dXKvIc79ldPBsDfqhWM+K0/avNd/ibh5vzIBMUHNbwnRrUcakobk3+0RJCgWwTTPFMIg
         WATVDNOIe+ENbQXxBe1m+RSBZdMB4VwThXn96bRawGRDXB2BGs/4pBVHrvKDtkTuVQcY
         h4t0bk325DmvejhK8thqRs0ZOQIiTVqmd4V+bXwyeZMmdHjtsSPAgaz6VVXwQIxo4Hon
         KFm/UZqGsPXNUA1TNkXOc5IW6+fI2BwQsitRWwfFrILkbSZg62KybUf5ZOhHKVzHVjrF
         cjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Niu8BsR9isXU2Kkmnz56yc6lMiREQRBSltPoKUcabxc=;
        b=cRtqTCYLr2YrOgIgkHnY4sfLAttPRklXtmFjQWg6e0c/xSKYGqowggBL/mUMG5pT3v
         IdJQvp025NYSPBnSa2ojVwhi7eE2OTxtrZGcIi0FGfNjr2eoFoolNgRwx3XaxFaToYn/
         884hb577NAYK7wB1X4OSTbHcal8qiOR/rxryr2peEGbXmpwrR6KVUrZSkK0dlxL4OcQt
         cGKbI2biofU6/KFc927rOKavjVhLi5of+p+dDLCQOOxJuK1NJScryCxmd1q0CbiqOlHS
         jYM8Jn0L0NhC3YJyi4yHdd18RA/Py6/xf+J7wyOsLCs44flZVlY2R5x6JtwZb/GjcYlL
         HASw==
X-Gm-Message-State: AOAM5311wLbZgVKqBF1Wy5+GRCYceRon+qr7VcQh6YfRZ11l3EMel1E9
        lx4gOCm7R1PDO1xhpms69lvEfzOPeJFgbvm7Uas=
X-Google-Smtp-Source: ABdhPJyKF6zoDUuH3v62lwmk0PGWYANLrjvMu0p+zQ4FD/H+JZlqGS6fF114MUIiBCq98wcngqkkLbJ9ULGhsfF0d2g=
X-Received: by 2002:a2e:9ecd:0:b0:246:4907:d837 with SMTP id
 h13-20020a2e9ecd000000b002464907d837mr4588633ljk.174.1645575990302; Tue, 22
 Feb 2022 16:26:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c08f:0:b0:19a:cecf:350 with HTTP; Tue, 22 Feb 2022
 16:26:29 -0800 (PST)
Reply-To: emmaludwigk14@gmail.com
From:   Emma Ludwig <feouziyaplisono@gmail.com>
Date:   Wed, 23 Feb 2022 00:26:29 +0000
Message-ID: <CANiBEGUEhuXFG5jVnP_KCMPz0zdSPVdareZzC+gHhCx=RTe-7Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello .
My name is Emma Ludwig .  Can you find time to respond to me now?
Please something came up and i really want to discuss with you urgent
and important.
kind Regard
Emma
