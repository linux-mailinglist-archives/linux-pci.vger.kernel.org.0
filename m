Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B80440EEF
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJaPJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 11:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhJaPJm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 11:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19A160234;
        Sun, 31 Oct 2021 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635692830;
        bh=ql/X/2+8Hkm6EWf0l7VhroUTIs/nYfkWm+Y9KW/UZ2w=;
        h=From:To:Cc:Subject:Date:From;
        b=YRIufha4qnlWgLSEdLDjx7PjLjb+K//idLz9AO2d3aVPFJ7139PZSj+kW512GQgQx
         vMvpLGojPDeKQcz/cNSYYLQOUMrtDkiOg8djM7F7jBoK8merIwFaiqA2rF2xwKBJ7/
         L/2hArUysYSGA2DVheQnD6NOEa23iInPiUGTeppEN72SPRyvL8ybhM7UmWWtwTzcnN
         UNOzIfQmo3kd0C5gmZmj+de5Yvh2eGMJjxrh4xVqWEjTXE7DVNYYmwmEEdytMityMA
         wDRRdJBILCviuZg/Q7mN33AhQi4KyMaibj392h0HGrUX/wgrUozSHYlS6LxFEFwhpa
         yI2X/IYoitQcA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH dt + pci 1/2] dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
Date:   Sun, 31 Oct 2021 16:07:05 +0100
Message-Id: <20211031150706.27873-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

This property specifies slot power limit in mW unit. It is a form-factor
and board specific value and must be initialized by hardware.

Some PCIe controllers delegate this work to software to allow hardware
flexibility and therefore this property basically specifies what should
host bridge program into PCIe Slot Capabilities registers.

The property needs to be specified in mW unit instead of the special format
defined by Slot Capabilities (which encodes scaling factor or different
unit). Host drivers should convert the value from mW to needed format.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..7296d599c5ac 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -32,6 +32,12 @@ driver implementation may support the following properties:
    root port to downstream device and host bridge drivers can do programming
    which depends on CLKREQ signal existence. For example, programming root port
    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
+- slot-power-limit-miliwatt:
+   If present, this property specifies slot power limit in milliwatts. Host
+   drivers can parse this property and use it for programming Root Port or host
+   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
+   through the Root Port or host bridge when transitioning PCIe link from a
+   non-DL_Up Status to a DL_Up Status.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.32.0

