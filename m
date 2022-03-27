Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4764E875F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Mar 2022 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiC0LV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiC0LV4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 07:21:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5844160F;
        Sun, 27 Mar 2022 04:20:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so16463385wrg.12;
        Sun, 27 Mar 2022 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RFPU4SiawogZ2MjqHPjWzT6m+hP2k2R3CxDG56MFDvE=;
        b=RgcLwipE0QmbDRdKGZOy87lxJra2ItY6/h2raxFB5wlqut+SKkZH5hpkmwsAaSEMp/
         Ayp6l3YYBMbFn44qaRglC5vgkwvDdvHsTmuY7hs6STzbStSyUaw7+wXnOrKfsQujzJpy
         e8uc28VNIMiUwMLbrkKGSdzBUmzniV6a1XY8lmKmRaK6cq29H3ZOrzIL2W1jvCgLgPl2
         RoRJXUMcB2lG+Mu/HVmpCb8c69v90Iqed1eo1FlPRO/rfsq0Pz3NsFvwpDyateYqcdag
         Djf9zfn06kH8FLHaG6FJtUWgMTpLEmNQl4EaSuki9mDZQBGhCSwV8AnEQHJHQnQxsDYt
         Jyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RFPU4SiawogZ2MjqHPjWzT6m+hP2k2R3CxDG56MFDvE=;
        b=BVPFKuwU1JrSP3kJt7hZSfD/yPqYHF/3gRoSlD5mZdjA/viFsmPe1Au8log9/uxMIL
         8PmpWqgT90XZQInzw472SzeLNxDM/LSNLz2bHNL0gdSIAkAjIvQlLcX5SQArKIjekcQ5
         CLJ86hv4XsT1b2ZOdXAQTteeCuj+gBA1yo5b1braImRgsK5uf6a3hxviI3qD7yaulLBD
         De2CR4K+og+3e42Nzls2IhsKH0w4Kwdfwmw4WcfJ2GBudlp/JDX7TnQzPozrNhm02Itf
         cJZqoDYra3ndbhJkIseBwbJeaGxnup/VfOAeuTaOHvDifh93WZkJQvAOc8fHVuFbl7Zv
         4Zmw==
X-Gm-Message-State: AOAM530Okd+jSmRuqv4kaD+iFYy5Kn1WCfSZxbAVkdRDPfYf1V3aurzn
        UCe+rkCRIItbfRc+K+XPs9zh99wiQGwl3Q==
X-Google-Smtp-Source: ABdhPJw8FnANQ6ebLWG4DdHpBFucUahO6Ob7bMongbBO+OSFOaAnR4qgDJ/4CLYV9LwkPgYpGdkLZQ==
X-Received: by 2002:a5d:64a2:0:b0:205:8ab3:4fdc with SMTP id m2-20020a5d64a2000000b002058ab34fdcmr17072162wrp.168.1648380015278;
        Sun, 27 Mar 2022 04:20:15 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id f13-20020a05600c4e8d00b0038c949ef0d5sm10030117wmq.8.2022.03.27.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 04:20:14 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V2 0/1] Intel Sky Lake-E host root ports check. 
Date:   Sun, 27 Mar 2022 14:20:10 +0300
Message-Id: <20220327112011.3350-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in v2:

Change comment and description based on Logan Gunthorpe comments.

Shlomo Pongratz (1):
  Intel Sky Lake-E host root ports check.

 drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
2.17.1

