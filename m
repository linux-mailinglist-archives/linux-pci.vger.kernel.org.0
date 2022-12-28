Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AE6573D1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 09:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiL1IQP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Dec 2022 03:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1IQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2022 03:16:14 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B02AED
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 00:16:12 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h10so10621191qvq.7
        for <linux-pci@vger.kernel.org>; Wed, 28 Dec 2022 00:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+AexItR+I648G4QSKn8d0qt+rpO3t/AnHrW9fmVULc=;
        b=YF8yyjy97Vra2gPRcyjM8MaOKQ5YmXdfaXEQJ5lCAJoWtl5x5U0UyYMN3TGL7/TloB
         CdWcdcv6LX3abUk9IEXcVUofWbAOVUl7GwXI/BNRphV4SwqfB72Ko3wOcawTiHjK5c9K
         CTQfdKddLrD92s5v9qo5r20RtKQxQ02rj9ugFJJVD8lGtMtMnswGaCxsnWwUtM7d7yz6
         xlmIAdxxpz6A8Slp5BH8w6u1lxoVeKw7aGeZbjO57V09igpDRpp5Fw3IeKoLE4SZuNzh
         RYTIQZrJUIOD1wkNJRz0TYYKohATnibdG8hbt1bl57LrSTW8f1BuELiZx2KIOglEvE//
         x0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+AexItR+I648G4QSKn8d0qt+rpO3t/AnHrW9fmVULc=;
        b=3oGjoAmJ46SRDciDtRcGbzrXARCqiXmaXdBr+p4UvHrVEQRrD7dqSZVSEFBcBUl2v1
         Q2ArXjYHzH/2xNKK+x+EFHCnD/SDwac53mg4jSkiFAjdCHbvuM5I8vDhXmxBjUuQgDVw
         9s4O77+mwmoBzgdfrb8oy2DM6BheaFRbxZ0KLjHQj6ldLAdyMJf+xGdpKMXTbMg4Xmv1
         2QB+fk00XhTHU1xFEadD+WYT1Pb2/xn6sA5Cq7DzaKivER3qGj64uUkPk0RQTQAShTvV
         hWzdvqmx2iFyYPKuVKlqdplFd9MoNu8LveewWZk9jQdRphqAKFLKac1EGtOwU+90egs5
         EHXg==
X-Gm-Message-State: AFqh2krQwFPpPSW3kP5XH43IqPrFqfzel21hebUpZ+mjSdqCLCucQ28D
        rq+z9Mq88537SRQf2OaMxdfn1he+Ri+kP9BQxJ70Uvsqltc=
X-Google-Smtp-Source: AMrXdXvzeC2Z/8nBtWsfMFGRNJoZPTsBQMBfpsF852BvnhSH1ZKMbFvg5HyB8Rg4HwovKOKVhar0Oxba/OdxM/uFopo=
X-Received: by 2002:a05:6214:2f8b:b0:52c:4ccc:5f7f with SMTP id
 ob11-20020a0562142f8b00b0052c4ccc5f7fmr1316236qvb.27.1672215371010; Wed, 28
 Dec 2022 00:16:11 -0800 (PST)
Received: from 52669349336 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Dec 2022 00:16:10 -0800
Received: from 52669349336 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Dec 2022 00:16:09 -0800
MIME-Version: 1.0
Sender: swastik <nk15374nk@gmail.com>
From:   swastik <nk15374nk@gmail.com>
Date:   Wed, 28 Dec 2022 00:16:10 -0800
X-Google-Sender-Auth: JDLL4tDmeouaXLu3tn2LCrse510
Message-ID: <CAE6MXDsCPqP_UXPaADV562As9W4wFrV3XxVuH2O7AwYGUdezPg@mail.gmail.com>
Subject: BEST WISHES AND MESSAGES BLOG
To:     Linux-Pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HELLO,
         I HAVE STARTED MY BLOG BEST WISHES AND MESSAGES. IN THIS BLOG YOU
WILL FIND GOOD MORNING WISHES, BIRTHDAY WISHES , FATHER'S DAY
WISHES.FRIENDSHIP WISHES AND SO ON. IF YOU LIKE THIS BLOG PLEASE SHARE
AND SUBSCRIBE THIS BLOG.
 WEB SITE ADDRESS IS  https://greetingsandwishes123.blogspot.com/

THANKS AND REGARD
SWASTIK
