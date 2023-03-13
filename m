Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F566B77A4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 13:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCMMgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCMMgR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 08:36:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFF2384C
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 05:36:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd5so14192757edb.7
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678710963;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mM4D/H21YxqRWkmTnoD2+rbp+XKo+/P1KeNC9uoVsMU=;
        b=ELaKrLJAWOHpZ31/Gs4cvz3RU7a5NAWe0uZ4oOuyyzAfnqTyoajHNof0yOk45CyM2j
         wjhbkh5Q+lFGrTdu6SvA9ECnz6+74F6CtnHdDkJ0tp5Q90lIh6dRJDY71o/ZdQL+rir/
         RmbBwlPTXETwJtEU7SCZMuyzg55Q3TpCsqYj8dhhdnvoyAz+pkYw/TRnzbBlLxEVOEBJ
         CsZHD7ciwmFnVKRip9BaOHilN1JzJY7ZqrQCCMac7o9LgVzBfBrR/2PyWYAvtfUlpBEL
         5qVU07+7TDTUpQ1LtfAOnbS0ZU7Y0RyD/eIMjILkALU7Q8FMOEDnDcdkayjcrXT4kI+3
         gBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710963;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM4D/H21YxqRWkmTnoD2+rbp+XKo+/P1KeNC9uoVsMU=;
        b=cBLKYQS2PWeSNlM4JMfV552yLkK3SyZV6gRBjjSdzIv9Ybf3HB7465SLYW/CWQ631E
         YMxiJEA/PwHGoCHfzWqfL8eoR+W4boWb5xFKU1F07IXkCQNnUboXtx4AVBTz2HlWQzXh
         WOzMbyGcoZ24KH2CRPKK9dk3JnQUaK28+sRUedStcEPz52eq42uqc3w7uZAyKRSirQxx
         PbkOpxH6Iky1gDT5A9lehe3VUYwKuOuKCzzMCk8iM6nrmBA6q3Dfe5bO3FPt9zEFT1oz
         +zzD19U1YBK1RGrES7/0CgViSCcPOxPnkfXR5PMeQS3cdDpTF4bSeqrXGl2s2Z0UvdDq
         b7zA==
X-Gm-Message-State: AO0yUKW2inGf8iKd18rp3laAc8Lp0WRJnypNA1RrRzrO7jMK+Zk53xEX
        dpyF+euzP+AT+n5ejzwr02It4vD34OVXcCumfwU=
X-Google-Smtp-Source: AK7set9cFXvspQmIcRvV95f+VS/38JZyVwV7OJBIYykVNXqAYNcouNlDz88eTLyL17uAZzSatUHnKjOJsvtTWa5WH5s=
X-Received: by 2002:a17:906:6dc1:b0:8b1:76b8:9834 with SMTP id
 j1-20020a1709066dc100b008b176b89834mr17487316ejt.5.1678710963335; Mon, 13 Mar
 2023 05:36:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:d64f:0:b0:1b0:e1fd:98e7 with HTTP; Mon, 13 Mar 2023
 05:36:02 -0700 (PDT)
Reply-To: andrewroger.usa@outlook.com
From:   Andrew Roger <barr.xaviergbesse.tg@gmail.com>
Date:   Mon, 13 Mar 2023 05:36:02 -0700
Message-ID: <CADK-NB0zTOGeYMprBcVdDaQFUmOKc-qm0Ks_4xo1epzi0Sn_vw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Please with honesty did you receive my last message i sent to you?
