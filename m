Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4563C8E0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiK2UA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiK2UAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 15:00:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD2248FF
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 12:00:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z92so10827410ede.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=YjhyPJV2Lrw0TKTNTFpYGI4goEc+ehkf2J65ZOPzpVIutbScCbgPUbTq9lc5GBIZfW
         fTBPTrPCNi2AjwwagMNlCz3OywzJDMRWI6R5q3+MzAnGuc+uZyGBW6AxS3umwo0MauWl
         2q3LsX6br5mKAsacPEuFnL7YZiO5feWGp+7kgwIz+ueVZl7t40RLjw95C1i89x4TJPN3
         FwNtyttR9mJoXP8pOcI22mUnDKnLuEzjdaXiGfOpR95zKEsYUE+Ijq23b2TKHZmdXzLo
         AjkKDhVkfmCJiLbLuf24+KNLOFnFOETb95Lip40ad/+f+prpfVOZEk5+iH8RFLAr7j1q
         tdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=C8WrPZCprRPNJ4JXjmHF4X+Cz8A3M2J+aJVg65qYq4RNw0s6Jx+2DRmZB2lXq6inwB
         UtIwzfajbU6t0rhs1AQer53ktvO7pv3wWIytE6kQmLApt8z/C03emAlezV1ucVv7MrqN
         OjZzTdXD9O1A7Bcutik+089oRJIFNo8rhtCOm6mjDwBR3YnfgerTEdnfuH+td+XxLJFg
         KlPFMfxCmYOo5xsxMm7+y1DNCVjZu7SF8BjIbZH1vy2YfSPLJg8dQZbbBjT7wYlKorT5
         ITiZ7W3P1hK3/ehAhEnHRaY/kdjF40uOnK/bCESY/l7WCo56nOWhZfbOApmngxzeKyXx
         MsdQ==
X-Gm-Message-State: ANoB5pkGIt7asvJn3dQ8+8WGzLVzWKYbi7TF7lXUE6Y6NCgpvcma/xok
        Fa83e1M8S+UT/bjfxSNyEf5IIAxzK2pUyeoXV9I=
X-Google-Smtp-Source: AA0mqf52MyoXyyAAVs7Med6Ga76Rh8N1z1vxdboAGQs5LbIM9WG1/y2QgaM60QLK0hhXs2zVAoW2lW5uGupgaL5Q/VU=
X-Received: by 2002:aa7:c758:0:b0:469:b3fc:8d7c with SMTP id
 c24-20020aa7c758000000b00469b3fc8d7cmr39008452eds.393.1669752021897; Tue, 29
 Nov 2022 12:00:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:9f02:b0:7b2:71f8:d968 with HTTP; Tue, 29 Nov 2022
 12:00:21 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <kojofofone00@gmail.com>
Date:   Tue, 29 Nov 2022 20:00:21 +0000
Message-ID: <CA+5DqwAs01EC17wVAVNRN9ApjATJyKYtnjWBND+hHVk+ZqFiaQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
