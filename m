Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FC6DE1A9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDKQ72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKQ7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:59:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B002D74;
        Tue, 11 Apr 2023 09:59:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h24so8612531plr.1;
        Tue, 11 Apr 2023 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232364; x=1683824364;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7qLDfiZbNO+Q2Yr81Hjhejq+oc1OaATNXiVCU+g8g4=;
        b=JS/RzfI7675sYkOuqnYKH1fRl0w7+oS00uH+1wDFmr1snSRx4XIKnKZMF9/SO/M2BC
         yTiSvUEiGJSJCFDq/sGr5PfowBK7VhwwJEOWftpZJP+0rifuAPVTeEWC0QprwlsbIgW9
         1ic/h9dmyzG8VkOduyEf56ZrTnPzOJjpAHi4XqSNL6hPKESb679+zZNyspVSqTEW03B9
         iXZclmHl6CzYW/Wo9Esju4AbwmXDP6aLR/o7NNYpnWIteOwV6CVaW5qtaqy65iG+zYaP
         WS9uwmwtRACjm0UdgVjGkd2Cl2YUQ3KerXN/slYKOLboWOD3x6emJ/e+DjaID3YtcDJ+
         OA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232364; x=1683824364;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7qLDfiZbNO+Q2Yr81Hjhejq+oc1OaATNXiVCU+g8g4=;
        b=YJ2oO9gwC5EltdA7TZ7ZgeUrhhsOYqJaZmyJPlErxzpj2TLV5P96YHjA95ZQ3z/Kgn
         0ExXR9eqQ7sAsePjfR4vIbOKMBd4s72B7wmHexQNslX6DgtNwTMAeS/9yFlXGi6Prm+D
         1R3Dqe3aNUkHTEZqVbo2iIqta2BEDCpqcatMY2nRwi+NVJkpNptLewGIh7MlbEhH3Zr/
         wFaHcSJPkL9o68LXkenO5MHK15IBJ8ew1SSFKf+BziUE6ykWspekZ6dr5HELQlZPd7cG
         cN1y7jWcMOefYrN2RX4TKbP82EI4TgThWj4a/KqoivhcpK8t4sbt5yBi7pl0QDvElTAj
         wGVQ==
X-Gm-Message-State: AAQBX9drRtXZSZhjb+8az57bzg9E8pLhxnwFr79tR8HFeLPU97nXfmJj
        bdoxI65rAGtV2crm8jI40SYqcHVjo00=
X-Google-Smtp-Source: AKy350Y3qpy1sqVEgMY+D7orFkH5D3UvFg7kbarVzV3LOMDgtwBx+RwlfKyAhGr3DiKmXYSvQUSHoA==
X-Received: by 2002:a05:6a20:8b0a:b0:d9:4c19:fe69 with SMTP id l10-20020a056a208b0a00b000d94c19fe69mr16983016pzh.25.1681232364198;
        Tue, 11 Apr 2023 09:59:24 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b0063989aab89fsm3484519pfo.23.2023.04.11.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:59:23 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
Date:   Tue, 11 Apr 2023 12:59:15 -0400
Message-Id: <20230411165919.23955-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
  PCI: brcmstb: CLKREQ# accomodations of downstream device
  PCI: brcmstb: Set PCIe transaction completion timeout
  blah blah

 drivers/pci/controller/pcie-brcmstb.c | 99 ++++++++++++++++++++++++---
 init/do_mounts.c                      | 16 ++++-
 2 files changed, 102 insertions(+), 13 deletions(-)


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
prerequisite-patch-id: 1258db336e778eb57d5cbea88834cd25aa1346ba
-- 
2.17.1

