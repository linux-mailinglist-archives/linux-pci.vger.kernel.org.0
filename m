Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7352FF039
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbhAUQY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:24:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733007AbhAUQYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:24:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E504E23A22;
        Thu, 21 Jan 2021 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611246212;
        bh=vbZk+5NiV+voE7vyxbI+E68xQ2e7BmZr+LUw9f1ff78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODBtjb4Chxkm3+oELVFLjOhpiuaUfxuZzk25iisCJctLhez6n1hPE5FlUqy4qiXTO
         YExdAaHRQT49V51naGIPP3zv/YxQuSKpU6ehzbOKGcyddtjErffJ+7lMONDjJc5UYv
         oSaSoJMnzPSHT0X9ILJI1U3MOkKM+XPToUDBWxXyjx9U41lOxyu+SA/oQZH05wm2pW
         JPkkELiOTUlkiGh3+gi2cUXkOZ/q7ZE0Ad31Oy1N9qjP4r6iYRY2NMMMzj/3ChPUeV
         jTkCItxCQNqMSDK9z4oG/mxOzeJv5jv+8/Th6YvOFqYi1+vYyoARQZ9ZLMuLE8FQyF
         ZDnB/qzqymt8w==
Received: by wens.tw (Postfix, from userid 1000)
        id 7C0DD5F839; Fri, 22 Jan 2021 00:23:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
Date:   Fri, 22 Jan 2021 00:23:19 +0800
Message-Id: <20210121162321.4538-3-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121162321.4538-1-wens@kernel.org>
References: <20210121162321.4538-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The NanoPi M4B is a minor revision of the original M4.

The differences against the original Nanopi M4 that are common with the
other M4V2 revision include:

  - microphone header removed
  - power button added
  - recovery button added

Additional changes specific to the M4B:

  - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
    USB 2.0 ports
  - ADB toggle switch added; this changes the top USB 3.0 host port to
    a peripheral port
  - Type-C port no longer supports data or PD
  - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
    but only 1T1R (down from 2T2R) for WiFi

Add a compatible string for the new board revision.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 8a2dd9f1cff2..c3036f95c7bc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -132,6 +132,7 @@ properties:
           - enum:
               - friendlyarm,nanopc-t4
               - friendlyarm,nanopi-m4
+              - friendlyarm,nanopi-m4b
               - friendlyarm,nanopi-neo4
           - const: rockchip,rk3399
 
-- 
2.29.2

