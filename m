Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26B5620EA1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiKHLVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 06:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiKHLVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 06:21:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FAE49B69
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 03:21:09 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n85so11377066yba.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Nov 2022 03:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=GUxI4j6deoOLvskfcxOAacPXYy0iC2fNeb+ijy+BQHkJEFNnhgkcEJzDjh+nzWEPv8
         d9wknxZUE/0e+iv/PlaR5UlPzhWCO2j1GIEamPhm/JkeXmxSGY007nkEliCRNFZF9yJo
         qlanCExK/GpgMfA5/riloseNZ+fFUvFHdD4h6tBF9Vf9toKh8QVVTX/2lq1WpHir/t7r
         t5x318icOhiaYhK98x8oPzSGiq/VQ4yMTqcPPS5KL3PLZDr1F/OT43qs/D8i9+ZIDA7a
         JBAm7U0O8fujxztoQ/c+B9NFAGEHsb1UhFIx3MUIv2KM9SQs8V3DpMnnTN2LmHMBNNa0
         SvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=EqtfrtehG58dJV1ebeuPdTIdc0Je3bWggGsjFT5ucD06migRoH+pujM6+EqfN2kDnc
         9d2/xt+3SHGMhOT66CI5s4ecLpsVCB5RbWqtefW9VlRbokh0P+oIH0ccO/5Y9ae9w3P4
         nzUGj48G6S+oVRT9WXzyJXp4AXBE83ap0n94NMZ464mLsi5tzwLJfNADXP063kPT0iI/
         5NWWXlGEPCZllnF5h/bRdzuGLlHYmnatq1YGoLiTtkZ/wkx/4skCQu5e4jUTD2x8krZ1
         IknCd2YviuXX3/wzj8gnNM76AYBhWzwCqZzCq/J6pNMQbLyGzKOOZx0xqXyy6hoPK/Vo
         EkxQ==
X-Gm-Message-State: ACrzQf1LmSsg8WKGhVpFut6EWnnWk1oiPbDcXdirFgzGlEVC4nRY8HLo
        WgXZE1MihjqdofHY5PXp8BXtane1wM9uHeAu0vk=
X-Google-Smtp-Source: AMsMyM53Tuy1uMOgbaJOsr203CIke0n/6WpB5PRBf/ygJRv8n7QNRICVqEs2RpX9yk7uFRy90cpsnSHrl1RE3OoXY0k=
X-Received: by 2002:a25:be03:0:b0:6d2:5835:301f with SMTP id
 h3-20020a25be03000000b006d25835301fmr758388ybk.336.1667906468325; Tue, 08 Nov
 2022 03:21:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a38a:b0:313:c983:1d7e with HTTP; Tue, 8 Nov 2022
 03:21:07 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik2@gmail.com>
Date:   Tue, 8 Nov 2022 03:21:07 -0800
Message-ID: <CAC9COZfcn4Z4pvY7wMShb0=-8JKT9cj0t-+kbiiyfHMnsKe+ZA@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik2[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hi

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

If you are interested for more details.....

Sincerely,
Kairi Andrew
