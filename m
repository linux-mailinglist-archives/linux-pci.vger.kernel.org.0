Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11CE8C2F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbfJ2Pxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 11:53:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43594 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390030AbfJ2Pxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 11:53:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so9870000pfb.10
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2019 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:from:to:cc:subject:date:message-id;
        bh=EBxJk3JXsdA+R4W4YPFDYdMMDX7vmrh7vQk3YBC5sxg=;
        b=Ts2a0AvG2ortW/Ah0XDI27aOxF3DEk8zQu9cf8ppEu16qhtLDkrhdO/2SBiZWLVC7q
         2TG7JfksOugoiynHQvih8wBDTgMAuktHsONJGsmnjuVbT20tr6r+uUxmDLM2GrXwmppk
         SNQplVIG02IZN6bhB7SOKKtkS/QE67vbYAURk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EBxJk3JXsdA+R4W4YPFDYdMMDX7vmrh7vQk3YBC5sxg=;
        b=bZfQEazoyn7vaIlFtkan6usQOf/77soMtaJmY0kkaK3xbvpiuw3FiGn0D/nip4TZsm
         Zv1BuWwcbvYsXxrhCIu66neD6KjOnqu7tzSn0yKYR4mxCV5vzLSY1Fe7AtjXx3NDtx/n
         Ops6ZEQwCll0N6tSIOg81SulSm8+qS02Ma1ZeUsfiyEyeRCAi/NG67wL3Fdfvj9LiX+f
         I11Sh/RrVKNQ/stIIadDjFzbwdMP2UDT5sJlylfaRwNdo2YWs6PKtLVFZqvJEafB6hF+
         rDYdMFP7DY5b2Bp+YMezw9/SfVB0OGPb/u+WPmus+1ypnsJ7y4n8FLVxRrI4qlYe1tvC
         agHQ==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAVIxjG7ml9vL+zcdclTuylfPxUHUUl5oBKczo9uhwGa9yiVAP9C
        KvlyLWTsqgyyRIsDBFVz6SBXiu5ZCi2Lsqh3an9upPo4yMU+f2I5O3OfsolSKZCGIycTxd2aFVy
        Xal785S8fjseTKkcApG1aSyRw
X-Google-Smtp-Source: APXvYqwMs/uToj2gnh2C/zXwbl+BGJ/qbW0BN08PA9mSwF5ctyBvrEoIRWV0pST885LW5G9NzSKMHw==
X-Received: by 2002:a17:90a:326b:: with SMTP id k98mr3965039pjb.50.1572364428028;
        Tue, 29 Oct 2019 08:53:48 -0700 (PDT)
Received: from localhost.localdomain ([210.18.155.100])
        by smtp.gmail.com with ESMTPSA id q42sm235766pja.16.2019.10.29.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:53:47 -0700 (PDT)
From:   m.karthikeyan@mobiveil.co.in
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     mingkai.hu@nxp.com, mark.rutland@arm.com, minghuan.lian@nxp.com,
        zhiqiang.hou@nxp.com, l.subrahmanya@mobiveil.co.in,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Subject: [PATCH] PCI: mobiveil: Modified the Device tree bindings interrupt-map example
Date:   Tue, 29 Oct 2019 21:23:42 +0530
Message-Id: <20191029155342.29342-1-m.karthikeyan@mobiveil.co.in>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>

Legacy IRQs Interrupt pins map 01h, 02h, 03h, and 04h while value of 00h
indicates Function uses no legacy interrupt Message

Signed-off-by: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
---
 .../devicetree/bindings/pci/mobiveil-pcie.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
index 64156993e05..b9dcb0ddc19 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -31,9 +31,14 @@ Required properties:
 - interrupts: The interrupt line of the PCIe controller
 		last cell of this field is set to 4 to
 		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
-- interrupt-map-mask,
-	interrupt-map: standard PCI properties to define the mapping of the
-	PCI interface to interrupt numbers.
+- interrupt-map-mask:
+		Its a 4-tuple like structure denoting phys.hi, phys.mid,
+		phys.low and interrupt-cell
+- interrupt-map: standard PCI properties to define the mapping of the
+		PCI interface to interrupt numbers. Here the first 4-tuple
+		are represented similar to interrupt-map-mask representation
+		while the next fields represents Interrupt controller phandle
+		and its #interrupt-cells fields
 - ranges: ranges for the PCI memory regions (I/O space region is not
 	supported by hardware)
 	Please refer to the standard PCI bus binding document for a more
@@ -63,10 +68,10 @@ Example:
 		#interrupt-cells = <1>;
 		interrupts = < 0 89 4 >;
 		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 0 &pci_express 0>,
-				<0 0 0 1 &pci_express 1>,
-				<0 0 0 2 &pci_express 2>,
-				<0 0 0 3 &pci_express 3>;
+		interrupt-map = <0 0 0 1 &pci_express 0>,
+				<0 0 0 2 &pci_express 1>,
+				<0 0 0 3 &pci_express 2>,
+				<0 0 0 4 &pci_express 3>;
 		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
 
 	};
-- 
2.17.1


-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
