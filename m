Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4947DC8C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbhLWBLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbhLWBLO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC2C06173F;
        Wed, 22 Dec 2021 17:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F49B61D92;
        Thu, 23 Dec 2021 01:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619B6C36AE5;
        Thu, 23 Dec 2021 01:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221873;
        bh=yGisiihGA/0OfiY28lJ4w5wj7xm0xhnIxa3qRAa2Or0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nh7C33QdMOtYnnjcLl+Y2Lp4VQGd0KokjCLyM241tdCQV9G7v2jYT7viPYs82LtE4
         5bUHLojVXLleeOG9QadcLshFK3EPoMa3/mVb2olLZxD+eMo/3izvtRQXfs9R9lI9Eb
         LX7bEEkmjFHm6TmJWXqyQgeIqa8KxmFd2S/bfCrkBdPLL5wSEXXYzLf3jnfWx9waV1
         JLupjK4rhNymbkWWUZVQjkdie3e2bdApEfBJJI7VXZapqZjZlkCB1gnyZqgc9Ewbm+
         OA+zwZw/TjPE/6p3TutKLCP039AZMub9wBt8W3WqNqQsAOhaFLqIH1tMEx1Rdqgmjx
         T/pHQw66mV1Vg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-arm-kernel@axis.com
Subject: [PATCH v2 02/23] PCI: artpec6: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:33 -0600
Message-Id: <20211223011054.1227810-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The artpec6 driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-arm-kernel@axis.com
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index c91fc1954432..2f15441770e1 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -380,17 +380,15 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct artpec6_pcie *artpec6_pcie;
 	int ret;
-	const struct of_device_id *match;
 	const struct artpec_pcie_of_data *data;
 	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 val;
 
-	match = of_match_device(artpec6_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct artpec_pcie_of_data *)match->data;
 	variant = (enum artpec_pcie_variants)data->variant;
 	mode = (enum dw_pcie_device_mode)data->mode;
 
-- 
2.25.1

