Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FC2B76C9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 08:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgKRHRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 02:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgKRHRg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 02:17:36 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC3E2467D;
        Wed, 18 Nov 2020 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605683855;
        bh=q0JIDRhJdDz77Yyth8UbeOSGaE5MbbRHj8XZKD8tXFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZw1+P6X2B5zX/qz2dggYW0PIEOQHKQh6EncGn90uPS3Vp6T91KuRtHdujYQdoN7z
         8kmEtUF28L2+jo48we+gE/hjtz1w1tG+Rrxx9cOUZpBcGo5qXpTe4mL7bIcrBHMABv
         /SdjglvbibQ/U5caweKqFEJ2wxkF7i3hqbvW3lpE=
Received: by wens.tw (Postfix, from userid 1000)
        id 894AD5FD69; Wed, 18 Nov 2020 15:17:31 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi M4B
Date:   Wed, 18 Nov 2020 15:17:22 +0800
Message-Id: <20201118071724.4866-3-wens@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201118071724.4866-1-wens@kernel.org>
References: <20201118071724.4866-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 37fd456170d2..1c0ec57ba860 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -126,6 +126,7 @@ properties:
           - enum:
               - friendlyarm,nanopc-t4
               - friendlyarm,nanopi-m4
+              - friendlyarm,nanopi-m4b
               - friendlyarm,nanopi-neo4
           - const: rockchip,rk3399
 
-- 
2.29.1

