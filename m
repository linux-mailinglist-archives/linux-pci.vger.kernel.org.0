Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006D83C168D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhGHPxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 11:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGHPxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B24461607;
        Thu,  8 Jul 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625759423;
        bh=sEi0ifqdSJujS+O4xXc7C5cCdEC25XeRG+JKalDhaK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqLhpcw3/FU1yNCS5TZA89EgZ5TbU2WnUem4g+yvVSIo3/5pEOe6JkZxf7yNQNwJL
         mxeNzBPssr2y4BlcCvqiVsRokl1lpIDTbck5b79/gEvT2ydM6qy//FSULLDO7hPDtt
         2rWcM7X2dD0Y9SXWjgf7hqekrGoro6Afar4nKFbW1kiK9P9U69B0frmao7kkUcLIb4
         fCLyhaWboCTa0PmT/dU3B/qVmB6gCzIAf+jde0661+mwWy96U2asFz9u2M372pxg26
         wPIdmgMPjWoeWeZBruNb2y9oDnd+Yg2zMovFcTIZADk4dlSMYImISmHdfCzLDdZ09N
         S3ilQrNS8QXwg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m1WI4-008VV9-GR; Thu, 08 Jul 2021 17:50:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH RFC 3/7] bindings: kirin-pcie.txt: fix compatible string
Date:   Thu,  8 Jul 2021 17:50:10 +0200
Message-Id: <a0311a01873a7ad2cd9293edfd1e5ffb439010b6.1625758732.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625758732.git.mchehab+huawei@kernel.org>
References: <cover.1625758732.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin driver doesn't declare a hisilicon,kirin-pcie.
Also, remove the useless comment after the description, as other
compat will be supported by the same driver in the future.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/pci/kirin-pcie.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 6bbe43818ad5..71cac2b74002 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -9,7 +9,7 @@ Additional properties are described here:
 
 Required properties
 - compatible:
-	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
+	"hisilicon,kirin960-pcie"
 - reg: Should contain rc_dbi, apb, phy, config registers location and length.
 - reg-names: Must include the following entries:
   "dbi": controller configuration registers;
@@ -23,7 +23,7 @@ Optional properties:
 Example based on kirin960:
 
 	pcie@f4000000 {
-		compatible = "hisilicon,kirin-pcie";
+		compatible = "hisilicon,kirin960-pcie";
 		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
 		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
 		reg-names = "dbi","apb","phy", "config";
-- 
2.31.1

