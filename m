Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF0672A0B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjARVM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 16:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjARVML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 16:12:11 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193365EC5
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 13:10:59 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id j1so18621uan.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 13:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TS776QSf+XZfy673cDJNFU1tHVWrzQdFJV93jLAyIM=;
        b=HmstFmURihK4+ylvnoptMna+I7kdByAYxYL9SZRp03eeNHWxSCbt+Dzs8guh6w4ZCr
         BR/BUG++M/5/+/nB7yLxokARzGRgb73TOUYOVyLd+Xj2/C8JR9LQTX7q1QkqIBxEMxix
         MLbF9r+A5EAhgk1/bymGKHYO1ISHfzfXWGlA62MX1y75LXD1GwIhZ16x8RDxo2p1XHvj
         WD9y7a515SD1I6pY22hsdzBgbpXV1GonSn8Ilxcr1nqh/ddeXgRw4x9Ovu64AMysCPHv
         U5/gAyFapRKvJBd6K0lZeoXCCAvR3o6HOqxY8zGZYxLnAig+pgbWJVuHt3wj/ApOrISv
         2aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TS776QSf+XZfy673cDJNFU1tHVWrzQdFJV93jLAyIM=;
        b=IsdZbh8PFE9sp5+vmrJvsbCgxaqbW5swpa2iKLCuoadeXEHEwzBVn+sWeL+BhN9pXA
         mPIpdUL5qT9ptnUMDsejaiw9zG7P3sdOdgI4H3Hzin/BvS9iWPkUebND0UOoiIm9p3tR
         bRQZCEWbLIy3lhUS9S5ORncPPIpj2H8Sgz/R0rPr9CL8135HU4H83fAA6IIlOhN2FCgp
         PWU+DrE9R9Z4+D4a6mCVYZNstApJVnIC2GvJf/YXxsDyn60qZjU+qb+uVuKe5u1St0yZ
         soQrHP+z2GLV7RgFOgweXMujW5i5P6+tQTewdx5SYQS2WsbIe9eoriLMfmqd/0tV4us9
         EBIw==
X-Gm-Message-State: AFqh2kpwgR4XUfprTriq5OBt4ai1Rm+wV8a7BdIpSwbz1djmlzDlHQ4C
        NCJeUDCthx/ntGRbqRu8hBKRW7qR3/FtYCpVpg==
X-Google-Smtp-Source: AMrXdXsgVEAig4M6cr6lsszD3k0ZOeUOPM/F6313bbvg4reKnY+uWSSHf3pAplM43DZyklWQ/uR64o/i3q60fSHi6G4=
X-Received: by 2002:ab0:26d3:0:b0:425:d41a:a2a2 with SMTP id
 b19-20020ab026d3000000b00425d41aa2a2mr1033982uap.10.1674076258901; Wed, 18
 Jan 2023 13:10:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:3d14:0:0:0:0:0 with HTTP; Wed, 18 Jan 2023 13:10:58
 -0800 (PST)
Reply-To: illuminatiinitiationcenter7@gmail.com
From:   Garry Lee <kalungipaul7@gmail.com>
Date:   Wed, 18 Jan 2023 13:10:58 -0800
Message-ID: <CAJqFtviHG3WcFpX4SPwfoBUi=HwvmNMatSQySjkg2Snn6Od81g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        UNDISC_FREEM,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME  NOW AND ACHIEVE ALL YOUR DREAMS? IF YES EMAIL US :
MAIL: illuminatiinitiationcenter7@gmail.com

YOUR FULL NAME:
PHONE NUMBER :
COUNTRY :
GENDER:
