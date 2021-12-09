Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE846F52F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhLIUvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhLIUvJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:51:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2FEC061746;
        Thu,  9 Dec 2021 12:47:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so6155195pgi.6;
        Thu, 09 Dec 2021 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3BCZjabBpaAIhy/6/dvpqiIFsv9OZ2Dlq/cPMfvfYPw=;
        b=CMcVHJanORSPYyz0CWOTvRDZBvUiIwBsMg+fabzIkvGDw+DIyJloKZqyFFAg6gRB4S
         8qOJXBnJIUovdNSDy1HN/1mbfMopCGbOXYEUfUdKdGzdQEftp0EV/sNXg1wPdB7lEB0k
         xqQlCvy8HEV3x9gV9nXmpL9M/WAjNVTNKPEUp3spsD0uZBtvIxqu32pWKv9l1Igd7YZe
         LKospmBjB53aO050igjdTqFYRQEApBvb3NBSVnuq97//Uag+fGE8mgXMUF3Q+vbYB2SJ
         1CcnjTwNSt94qV72Hp20n92MjBC4WmaW1uGgkKBwF+Kw9xVLuDnlCxiNXXdggtcLVIcC
         bXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3BCZjabBpaAIhy/6/dvpqiIFsv9OZ2Dlq/cPMfvfYPw=;
        b=N0OmK6VdcnUjDunTHbixb0LAOegr4dlKrDIANnL+sorq9hrSR6kC3iJl86cgZ9P1De
         kCLX2R+cZzT+8ms2PyzFaiP2/SOzTdMRGS1otq7ZGi28J8svwqhU5ksqDmBieFz7Kr/1
         GNMD3rYaSZ0ADJlveMpxg++YbpzukLX1PwMjbIO2iDWmgAIKbHhbZrDjyGQyRrVXAeck
         CBhXxLEMvKPyPk2TQXa5g2+Ux2h4ylnudLgAOgIjSKwFa9Rf66eBzTYGFRemFBnDVNJV
         rHoliRMm4+sn8GZ67ttn3BjJhKuawHataXpK/tVno2OmeejSamFdFkiLZuA//VmfIVHX
         2otA==
X-Gm-Message-State: AOAM532QXHplCjJ2dpCT4h771RMcGTwwqSbNQbdHdG7hzESyQXl1IoAp
        9setw1wNU3onXzsSIEpY+2I7zMKncAE=
X-Google-Smtp-Source: ABdhPJyz8RPstz7msodzT4PP0Oi2E71Q6NvCHOhsCXzbkAW0QOP8aHRui29Uaju4Pg8ZvoIWULEMWw==
X-Received: by 2002:a05:6a00:2d1:b0:4af:437c:5f50 with SMTP id b17-20020a056a0002d100b004af437c5f50mr13915244pft.32.1639082854818;
        Thu, 09 Dec 2021 12:47:34 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id f185sm568370pfg.39.2021.12.09.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:47:34 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/4] dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs
Date:   Thu,  9 Dec 2021 15:47:22 -0500
Message-Id: <20211209204726.6676-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209204726.6676-1-jim2101024@gmail.com>
References: <20211209204726.6676-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom STB Arm and MIPs SOCs use the same PCIe controller
HW, although the MIPs version is older.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 1fe102743f82..043412e7735f 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -19,6 +19,8 @@ properties:
           - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
           - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7425-pcie # Broadcom 7425 MIPs
+          - brcm,bcm7435-pcie # Broadcom 7435 MIPs
 
   reg:
     maxItems: 1
-- 
2.17.1

