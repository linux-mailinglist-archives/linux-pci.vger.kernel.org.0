Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEF3DAB20
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG2Smp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhG2Smo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FE2D60F5C;
        Thu, 29 Jul 2021 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584161;
        bh=mNHkWhp2gqaE2pFLRywdLRuMHd0sK+JVy4ynGKzSyeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1WnQiq9AO8fA67p7v75JsVJH3Qm1q6C9/97s5CmDlePo0GMk+lTqir162qjn+6Zv
         E/NvfbaJvYEgs1kOQsP69QHRJml+JViMh4EoxfBW2CIY4tRo1zg6oHa2KABBhMmxQL
         /XU+JAVkCeUqqQveTZdpu4b4256asWoXbjCi0M5qsrRGBjNetYJLL52iQYFiczQgNY
         wmQ25/QfV8nRjC19+39HO9nqmhA/K2Otq+1vw2v0xSSNFo/Nys1bzaev/VRlgSqh7A
         pwF6TnwKVUIDwaHEdYI9vWCE8vAGjfLzYhfcA1ozeI1vA1NuIJrMvHk0ILjt43Hwcg
         8iKCeX785duMQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/6] PCI/VPD: Correct diagnostic for VPD read failure
Date:   Thu, 29 Jul 2021 13:42:29 -0500
Message-Id: <20210729184234.976924-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, when a VPD read failed, we warned about an "invalid large
VPD tag".  Warn about the VPD read failure instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 26bf7c877de5..7bfb8fc4251b 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -92,8 +92,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			    (tag == PCI_VPD_LTIN_RW_DATA)) {
 				if (pci_read_vpd(dev, off+1, 2,
 						 &header[1]) != 2) {
-					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
-						 tag, off + 1);
+					pci_warn(dev, "failed VPD read at offset %zu",
+						 off + 1);
 					return 0;
 				}
 				off += PCI_VPD_LRDT_TAG_SIZE +
-- 
2.25.1

