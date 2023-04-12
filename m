Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9B6DF082
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDLJdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjDLJdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 05:33:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF77DA9
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:33:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54ee12aa4b5so112230427b3.4
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681291989; x=1683883989;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUEkD81ojAds4Zbt5kdoDqBVeA2aOp3S2+5CR5jfNJs=;
        b=DM0QOTk2wYCqz3CiJNGNZrGp8o0o4Ui4qViyqZYxfRc9Cix1hqTq4kNpB0Dhr37ob9
         rStNLbVmQM0oreQgl+ewhGDKjiCjE2v5WPleG+6BV5R1IM2YHhH4AfL5HgtCpt+cCzuQ
         1j5fEJKDS5EMa4FPzGDmQ1OHJsVf5c82kWG/QXpn7Jn4y4kBh/BH4PnUI2tGf9UhIwuz
         K2J4nDMdP1lm19xw7oChbvXOnXEaL7WryqwR3GHehz6HJFHHpd6gp/eOcbvw4oTT/n16
         bp35eqFz1iksSsEed9kMxs1GWOooQ2Rd+uHhODGWEI8gsAujMPwIJSZ7nV2c7HUdYgMk
         IFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291989; x=1683883989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUEkD81ojAds4Zbt5kdoDqBVeA2aOp3S2+5CR5jfNJs=;
        b=T3NQgcMvBKZAMZelaZ+pVflF96nNpTFOBff47AfhEUY6QosPnSGRbSS+jrUHIy59k5
         pzTRAUd/L3S+yzFcfFsGcPaexl0Wkzt9ZVOC6oamHEfDUjME2tMCjN2sjGWqgyUai185
         foXFE29K6WmLSQMVEbCSH+ZTUk2Fts7llF7/CPKmNsQJQhEWZBUlYS4Qs8iwlL7smHVN
         q6/aYNYV/sx1trlTQCyY+8ZO2BNIDH9ZVvXO5mYEVZKVboNL+f1EnmzNijcNgRuNuptX
         3zrW5h/YaNfexrUlT+1OWed8nOag98WHFJIqrf/ep+bvRdI/rSPOkE/wZkl/SaTg4m/v
         FneA==
X-Gm-Message-State: AAQBX9cSJWjuxCB7dga35tS9rGConICo1vWgpkiiDqRBsbSdfT23LX05
        lyz0dSVva+LO0NYi33vmInzss07PBmYkvuvDOQ==
X-Google-Smtp-Source: AKy350YMRADQ4bQahWtEEaUMYPNIWk6Jx6KX5bKpJVjl9llDASRjTvlbEO5YAe8EjFpf6Zv4qQEFXnpl3gC/Q3WZTQ==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:73c2:0:b0:b8f:3e29:fb9a with SMTP
 id o185-20020a2573c2000000b00b8f3e29fb9amr739634ybc.6.1681291989240; Wed, 12
 Apr 2023 02:33:09 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:02:55 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412093301.3656266-1-ajayagarwal@google.com>
Subject: [PATCH 0/3] ASPM: aspm_disable/default/support state handling fixes
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

