Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637AB6DD8FC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDKLLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjDKLLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:11:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CCF40E9
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:10:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c1e4b7e63so131608387b3.20
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681211449;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUEkD81ojAds4Zbt5kdoDqBVeA2aOp3S2+5CR5jfNJs=;
        b=p+2zffdHp5PHZRdjYspWcOwDR+ownuPLWIywCbi73ViYunTJESTWSWtELKUqMypLuS
         v0xBmSXBDYs2sGnC0g9ron425zSN0rQpJpW0fbSkh6RiBRivmgrKhUr1A24O3licJYVH
         KofbeygqZB+2Tesu91Cly0DQaisWAVuy4uTuEVWoxKQomXuFAB/EUjPDUvu5pcdvnd7m
         tCv9f32nRL31dASflRNoEvaC+ax2VxAYyj6NeNaomLwkpg7thfItm731jydws/YRDMjf
         fg9O7aiJk+kbA9FwvjWA8B9MlXdzdF8Qspbay2T/0D1nmmDJ3BUGPDp72HYpKoN+S1u/
         uFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUEkD81ojAds4Zbt5kdoDqBVeA2aOp3S2+5CR5jfNJs=;
        b=GpPUwO/5yqBUHmcNUr6szJ3odso++tU+hmf7s6/WfHkMLDs10/Kr2o3IajEFLRi97s
         eSxOSZ/b+W9SbJKXk9m5UudcesgpT381Ms1xKVbDgAcnTnqpVcZoSF1tNnvTelPCvtK4
         HtpEOGzONCrb7eBY18FnDzZjtQaE76TYHitjwnogDa5mMpeuCxl6aLqToF67QGyvdEgr
         9OXHwzvh3Fya5HSPS2nZ6hIb6JQwX8Rxqa4Ovdw28Yy473bbPu3Y3FRE4gRw0G30Y4AT
         1+MPvTDOyPkuvB75s2AvQnscfdPhzQ0v79zZ6VTSpjh6DMA+ZHICA8AnsWalKcKs1XwO
         O7ew==
X-Gm-Message-State: AAQBX9eyY0yhss5pVioBMOniSIkxLibKrXUUEl0br0rLhL2jgg0sAxU6
        iH9Qm9ZtlpiJrK1+rA8qdd5kz4WBmXpae4kjDA==
X-Google-Smtp-Source: AKy350a3RWg8sbpfeQVcp0OVXk75DpHLaRT9JRoK54rEF266D1pxlSpF2nOJ2UUCH8w4BhgTCVcFXnGbmuLg2Cuvyg==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:cbd1:0:b0:b8c:473b:30df with SMTP
 id b200-20020a25cbd1000000b00b8c473b30dfmr1283312ybg.2.1681211448970; Tue, 11
 Apr 2023 04:10:48 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:40:31 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411111034.1473044-1-ajayagarwal@google.com>
Subject: [PATCH 0/3] ASPM: aspm_disable/default/support state handling fixes
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On going through the aspm driver, I found some potential bugs in
the way the aspm_disable, aspm_default and aspm_support states
are being handled by the driver.

I intend to fix these bugs.

Ajay Agarwal (3):
  PCI/ASPM: Disable ASPM_STATE_L1 only when class driver disables L1
    ASPM
  PCI/ASPM: Set ASPM_STATE_L1 when class driver enables L1ss
  PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check

 drivers/pci/pcie/aspm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.40.0.577.gac1e443424-goog

