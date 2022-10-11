Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAB5FBA9A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJKSmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKSmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8B7F099;
        Tue, 11 Oct 2022 11:42:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a5so4056087qkl.6;
        Tue, 11 Oct 2022 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCgtbYVIAJSnrwzgTT+6krzz0XBjwFu3ksGJ8+hLnEE=;
        b=Rm4CGbFE3txxRA0rtW140MY/jxMXN8PWhRUtqQuR9VE6t7HjRP9Dc7F/iYdGlcAf0a
         Rj4IRjrrXfbpSpzAV0eYz3Cy0HWt+WqZnKRrQk7JuoU3msofuKT1YB9otMM5sSJpePMv
         rr8nWw5WL6qlGv7HiA1aQRKvkJMSwCxh4mafcIW1755EWN3SGhhKQzVpvcMpFe1rWTYr
         3nN6GqobP9rbHy5PU2fV2wHujPUpq+DP6e6m278aBkNsx/1ax+ttz0bp8ayfNNZJJomB
         CcJ7fRkOV9BcQ9L6UAWF3BP71hmqSr28PfFKJbq0JIyd3GIHGIsOgtrKEwOhSMuWcnl4
         QAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCgtbYVIAJSnrwzgTT+6krzz0XBjwFu3ksGJ8+hLnEE=;
        b=VUWFLoGW6mTdkNcwU7A3GlkHwemJFDL5DGGk1NPtcSSQweD8bjwGgflbGSfHza83Kr
         hLNy4jynWE9sQI2eMIHEotuxS7zIDdJ0AI7uft3X+CatSY44bp+/NCeJCamdPll1TyWB
         b/t7cZPbz1tyYIWBEtrTLlZS170NCANFM0G2TepDMbjCRcijw6RSLt9vw7leX40s3hOy
         NDN10R+HVsweCchj4mTysYpc1CWO44axX2b6GK47vh6mTa0dmEF/KHmafHu5OCQI+akt
         43wjbS1mP59/G1H1aZl7t8WcfiuyxlB0CTIWB+tX7kwHKbZGpU0sH8LF8RQsj+xU46jq
         vUtQ==
X-Gm-Message-State: ACrzQf0YRel2i4dJclgmxENlPsV7o6qRPtUXk9V8sAqLzZfoo4ubJU9s
        M4LAJZf4G4HCzQGmqOzq6IPu/8HGWhI=
X-Google-Smtp-Source: AMsMyM5PyxifjOpoUnhn3I10E/aoZtelQgb0QdNMyGnmAmwcZMOII5hKwxP6W5VdQCeRu6TYR/b3HA==
X-Received: by 2002:a05:620a:1505:b0:6e9:168f:76a5 with SMTP id i5-20020a05620a150500b006e9168f76a5mr8897130qkk.142.1665513733642;
        Tue, 11 Oct 2022 11:42:13 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:13 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/5] PCI: brcmstb: Add Multi-MSI and some improvements
Date:   Tue, 11 Oct 2022 14:42:05 -0400
Message-Id: <20221011184211.18128-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


v2 -- Commit "PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits"
      - s/read compeletion boudnary/Read Completion Boundary/ (Bjorn)

v1 -- original

Jim Quinlan (5):
  PCI: brcmstb: Enable Multi-MSI
  PCI: brcmstb: Wait for 100ms following PERST# deassert
  PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
  PCI: brcmstb: Functions needlessly specified as "inline"
  PCI: brcmstb: Set RCB_{MPS,64B}_MODE bits

 drivers/pci/controller/pcie-brcmstb.c | 85 +++++++++++++++------------
 1 file changed, 48 insertions(+), 37 deletions(-)


base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
-- 
2.17.1

