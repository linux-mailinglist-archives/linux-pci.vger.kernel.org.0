Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AB3F30DD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbhHTQEs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 12:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhHTQC3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 12:02:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA7061279;
        Fri, 20 Aug 2021 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629475311;
        bh=Yz4EIOxD0zxgcfNz/zM6CTVGtACZ7WoqmNizOWQhqmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2vbrT3jkKY17nmu1ZEqsEwl+1Ef2ir5VNEID6wyODHcHbzaaC+Wrarse1UbKD6d4
         T7mZJG4yuJbsSx23h295fh9QfLslzywaIvf9F6YWWcfROUzybb04Hl6yxPXR4bPjVq
         h7qgddTEQ7h5CKzWqeXi7JU+88LPdLztIiyC1Hnhupv+iQNzFfK0G3BiLNscaVIkJx
         mOK0e+XtVZ5DUnIn1LfBBrpTY0qT61iN5oOMGo6XQijbxavtkGE0Pn1TqLcQcvffWW
         1J4f8GKvKXN11WQTcv23uKmtQxF0sZXxweWtRQ3haYOBnfVNs3tJjTvwXvXby+zV5u
         VS/HiZlDXZyyw==
Received: by pali.im (Postfix)
        id 80CBFB8A; Fri, 20 Aug 2021 18:01:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port property
Date:   Fri, 20 Aug 2021 18:00:21 +0200
Message-Id: <20210820160023.3243-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820160023.3243-1-pali@kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This property specifies slot power limit in mW unit. It is form-factor and
board specific value and must be initialized by hardware.

Some PCIe controllers delegates this work to software to allow hardware
flexibility and therefore this property basically specifies what should
host bridge programs into PCIe Slot Capabilities registers.

Property needs to be specified in mW unit, and not in special format
defined by Slot Capabilities (which encodes scaling factor or different
unit). Host drivers should convert value from mW unit to their format.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..e67d5db21514 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -32,6 +32,12 @@ driver implementation may support the following properties:
    root port to downstream device and host bridge drivers can do programming
    which depends on CLKREQ signal existence. For example, programming root port
    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
+- slot-power-limit:
+   If present this property specifies slot power limit in mW unit. Host drivers
+   can parse this slot power limit and use it for programming Root Port or host
+   bridge, or for composing and sending PCIe Set_Slot_Power_Limit message
+   through the Root Port or host bridge when transitioning PCIe link from a
+   non-DL_Up Status to a DL_Up Status.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.20.1

