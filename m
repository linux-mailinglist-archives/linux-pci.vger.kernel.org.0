Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C95E8277
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiIWTVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 15:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTVL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 15:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FBD98DF
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663960869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Yj/ZAqjA+/RHw5qnu+GevzdgeS7Xz97sKGpsBg1Mk4=;
        b=FAsdk8Qe4yR9KbP1DlmtkRQ9JZoDt5xy7ablkxMu0KnzjDMmSQ3Ncol2GrV0UoDlyaSIze
        X8ya8EmqKub+doGmuDY4Mn9rZC4DPPzD5hW+vHU6QrUFUNxppdvEj5us/NbcVOx3hGVTME
        FKjaXO8arwo3R6fi2eN4fAjieK98pgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-nqXB25_KPAGlPbNBYcY1EQ-1; Fri, 23 Sep 2022 15:21:08 -0400
X-MC-Unique: nqXB25_KPAGlPbNBYcY1EQ-1
Received: by mail-wm1-f71.google.com with SMTP id p36-20020a05600c1da400b003b4faefa2b9so507589wms.6
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 12:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7Yj/ZAqjA+/RHw5qnu+GevzdgeS7Xz97sKGpsBg1Mk4=;
        b=sNb6aifqM9zRMET01ARot19f2hXqlvA/m/CBr3CnK2YnJzXz8H+TCdszGadU1oaGOC
         FtLUIY5LBqqbj8HLFBq0tfc6LT6GdMiumwpmfNGZBoNtsUP6D0vt3Y9XSyvekuzPtpbd
         OLOeSKtLKe2sbWUKDPOi8Hz2Ki98FpQZhK46yvxVSHxcmb1qLUtW6jQsEH12gNtsVvr5
         FkBNS9WahP5UOzUtwu2akm7lGNizSGTPjyGRAiHc3hWn0s9VAb31NgQdCHNt47/+QOUw
         xILS12WoCwbBbSw+VM1uMoSzDwN2McDsDZmbDcLnWbyM6VzCgHIVXnUPYOar0KODThc5
         j/2Q==
X-Gm-Message-State: ACrzQf07f97nxYIDUOksraF2cJW0SEVROtmhb4F6MCqPImkh47mTMQhq
        BJCABLImJxfAmzk5SWqwuyoIL6ZmYKYdhDV7FfCaPnfgafFj1UmeSQCesQv36Y2xp+ovWKaZxy4
        swJyP2noFf7oQ7R/eJICV
X-Received: by 2002:a05:6000:15c5:b0:22a:49c2:4c58 with SMTP id y5-20020a05600015c500b0022a49c24c58mr6108384wry.362.1663960866864;
        Fri, 23 Sep 2022 12:21:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7TystGwraB8NYFCS06+agOxlctI2lnfAdhNWWQXYvwpf0J3keF7P6ULw41yJFpInrmdZypAw==
X-Received: by 2002:a05:6000:15c5:b0:22a:49c2:4c58 with SMTP id y5-20020a05600015c500b0022a49c24c58mr6108374wry.362.1663960866697;
        Fri, 23 Sep 2022 12:21:06 -0700 (PDT)
Received: from ghalat-laptop.redhat.com ([195.136.121.138])
        by smtp.googlemail.com with ESMTPSA id g14-20020a05600c4ece00b003b477532e66sm14987025wmq.2.2022.09.23.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:21:06 -0700 (PDT)
From:   Grzegorz Halat <ghalat@redhat.com>
To:     stefan.buehler@tik.uni-stuttgart.de, sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, kar.hin.ong@ni.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mingo@redhat.com, sassmann@kpanic.de,
        tglx@linutronix.de, x86@kernel.org,
        Grzegorz Halat <ghalat@redhat.com>
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
Date:   Fri, 23 Sep 2022 21:20:30 +0200
Message-Id: <20220923192030.162412-1-ghalat@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
References: <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Sep 16 2020 at 12:12, Stefan Bühler wrote:
> this quirk breaks our serial ports PCIe card (i.e. we don't see any
> output from the connected devices; no idea whether anything we send
> reaches them):

I have the same problem, also with a PCI serial adapter from Oxford Semiconductor.
I've bisected the kernel and it was introduced in b88bf6c3b6ff.
When the system is booted with "pci=noioapicquirk" then the PCI card works fine.
The CPU is Intel Xeon E5-2680 v3 @ 2.50GHz.

Sean, do you have any news about this issue?

Grzegorz

