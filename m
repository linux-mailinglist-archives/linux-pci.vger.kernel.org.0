Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD24789CD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 12:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhLQLYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 06:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhLQLYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Dec 2021 06:24:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE88C061574;
        Fri, 17 Dec 2021 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MFyEYw8hfFZry89fBZPaaRJJpXELjngNud4Pkg3znpQ=; b=eKEr6OVnOAIoflEt+d1zh70Cc+
        lZU+Fzb/XGJnPwsLo9f/efqJ6oXSzcXlNPzZwaGK49nvcIEamfabqIC9IMLZ6gQEDf2B6HuEIJHFP
        Nx6zNV1BrtJLbTNAtWXoq3jKBqaPo8YO6PjJ+ZVl7itfgrtyrzBpR0sV9LEff1oJNB3Y=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myBLI-000742-0D; Fri, 17 Dec 2021 12:24:04 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     john@phrozen.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/14] dt-bindings: PCI: Add support for Airoha EN7532
Date:   Fri, 17 Dec 2021 12:23:39 +0100
Message-Id: <20211217112345.14029-10-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217112345.14029-1-nbd@nbd.name>
References: <20211217112345.14029-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: John Crispin <john@phrozen.org>

EN7532 is an ARM based platform SoC integrating the same PCIe IP as
MT7622, add a binding for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 57ae73462272..684227522267 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -7,6 +7,7 @@ Required properties:
 	"mediatek,mt7622-pcie"
 	"mediatek,mt7623-pcie"
 	"mediatek,mt7629-pcie"
+	"airoha,en7523-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the root ports.
 - reg-names: Names of the above areas to use during resource lookup.
-- 
2.34.1

