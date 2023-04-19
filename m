Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA06E7FEB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDSQ5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDSQ5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 12:57:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190326B6;
        Wed, 19 Apr 2023 09:57:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b78b344d5so87471b3a.1;
        Wed, 19 Apr 2023 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681923459; x=1684515459;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCtFefQeoNlfcoEaEZAtfKtoKxYMSHC3CSKmZgcOSYY=;
        b=CISPAvDnz44p1E4NVvkVGKQ2U1ZN8hvAZUGGR6ykOnHKv4talSoE+HHLPF4kC9nyAJ
         ImjW2cweJx+KnI0x3DlBZgsav/0bnGkyCYw7Zr/iFEzbcgMW08t6pji6Ew1Jr2wiaqxH
         o4ErSGdtZyYEGQZNlA8OneNaTdeJ2OKqbOVqBrYQD6aWuqhRGyMMoqfUqqDQgZcpGfoc
         zYjpnGoWx8KkK1A54T2POoN7GWWoe4fSY9hiJ2FjzC3D9tytrrYUNwtpCJGMkuocVVtF
         7E44b7FBwgnCG7KuDzr0E4iQ6ay9jWGP3G2uDTyln3545sf0tCFrjoLlTApD3Q8srCjV
         5FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923459; x=1684515459;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCtFefQeoNlfcoEaEZAtfKtoKxYMSHC3CSKmZgcOSYY=;
        b=JocFuSJA2dyk/VlMkYyidENGlgs7vWUl1ZHmT2X9XRtXz9+HWk46tpBt25iospnVN1
         6sukZh8slsoQBSJau3iJNhIdOMf8TFPooHMvpE6mRtj+ppMD+yaNy5Ylx99J6vai6Bs8
         oB2qvBGAHvvYRsrbEaeDQPW7ZSpxb4KMfLlGyIhVEiFOaswFDPGmSuwc+rqB0PBo2WHA
         Nhw4l4okDq5wCa1ZZBiTjS4B8Th54YKH30gEZTCxAlzbDAi7YB/q4oszXFxF/hTMtHfo
         H/xK8ImoMCiK2hLsZrU7fyoFYu30KFgwRFYYNXb8Yfv30JNdeTfjKwqzWoSu4BB29hv6
         xn8w==
X-Gm-Message-State: AAQBX9cA8aQzeZ7LVMlOEG/72YCv8thxVQmOzcrPYZinCmxGLJn4kh7l
        W66cxmLmsKtTAYBhJJE+ARMIQiIzfI8=
X-Google-Smtp-Source: AKy350ZGiV1roeE6EXbCUPcXgtMlWq4nQ5ww9YqB7/shYYN8ncqJukgXHGd7WH1ATrkwPuE2I13LSg==
X-Received: by 2002:a05:6a00:1814:b0:63b:7ab1:6c5c with SMTP id y20-20020a056a00181400b0063b7ab16c5cmr5199964pfa.18.1681923459286;
        Wed, 19 Apr 2023 09:57:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b005abc30d9445sm11188135pfe.180.2023.04.19.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:57:38 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v3 0/3] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
Date:   Wed, 19 Apr 2023 12:57:17 -0400
Message-Id: <20230419165721.29533-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note: (a) With this series, all downstream devices should work w/o DT changes.
          Only if the user desires L1SS savings and has an L1SS-capable
          device is a DT change required (brcm,enable-l1ss).
      (b) No code changes between V2->V3 except to remove a dev_info()
          and change the string of another dev_info().

v3 -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)
   -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
   -- Put binding names in DT commit Subject (Bjorn)
   -- Add a verb to a commit's subject line (Bjorn)
   -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
   -- Rewrote commit msgs and comments refering panics if L1SS
      is enabled/disabled; the code snippet that unadvertises L1SS
      eliminates the panic scenario. (Bjorn)

v2 -- Changed binding property 'brcm,completion-timeout-msec' to
      'brcm,completion-timeout-us'.  (StefanW for standard suffix).
   -- Warn when clamping timeout value, and include clamped
      region in message. Also add min and max in YAML. (StefanW)
   -- Qualify description of "brcm,completion-timeout-us" so that
      it refers to PCIe transactions. (StefanW)
   -- Remvove mention of Linux specifics in binding description. (StefanW)
   -- s/clkreq#/CLKREQ#/g (Bjorn)
   -- Refactor completion-timeout-us code to compare max and min to
      value given by the property (as opposed to the computed value).

v1 -- The current driver assumes the downstream devices can
      provide CLKREQ# for ASPM.  These commits accomodate devices
      w/ or w/o clkreq# and also handle L1SS-capable devices.

   -- The Raspian Linux folks have already been using a PCIe RC
      property "brcm,enable-l1ss".  These commits use the same
      property, in a backward-compatible manner, and the implementaion
      adds more detail and also automatically identifies devices w/o
      a clkreq# signal, i.e. most devices plugged into an RPi CM4
      IO board.

Jim Quinlan (3):
  dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us}
    props
  PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
    device
  PCI: brcmstb: Set PCIe transaction completion timeout

 .../bindings/pci/brcm,stb-pcie.yaml           | 16 +++
 drivers/pci/controller/pcie-brcmstb.c         | 99 +++++++++++++++++--
 2 files changed, 105 insertions(+), 10 deletions(-)


base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
prerequisite-patch-id: f38de8681d8746126d60b3430eaf218d2dd169cd
prerequisite-patch-id: 23e13189f200358976abf5bf3600973a20cf386c
prerequisite-patch-id: edfbe6ea39ed6a4937e2cec3bb8ee0e60091546d
prerequisite-patch-id: c87dd155e8506a2a277726c47d85bf3fa83727d5
prerequisite-patch-id: 579841e1dc179517506a7a7c42e0e651b3bc3649
prerequisite-patch-id: b5b079998ea451821edffd7c52cd3d89d06046a1
prerequisite-patch-id: b51b3918e554e279b2ace1f68ed6b4176f8ccc24
prerequisite-patch-id: 333e5188fb27d0ed010f5359e83e539172a67690
prerequisite-patch-id: bb107ee7b4811a9719508ea667cad2466933dec0
-- 
2.17.1

