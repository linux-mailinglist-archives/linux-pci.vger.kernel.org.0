Return-Path: <linux-pci+bounces-5571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5F895C76
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B541F2527C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9615CD67;
	Tue,  2 Apr 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr18FGWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF115CD56;
	Tue,  2 Apr 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085966; cv=none; b=SEu12x4IkgTcaIWNLyo6NyodxTGXDS0mNt00oaARjYCfaXQQF8Jur8P3THTjHNZMXtvIaw6pw28TdFodyJlQJKlUW2IH48pu52OyKEAajMAo8FW+7Z+euVFj7T84CjxbfLtCZuzhbJWGb7+6ZFlpHYmThB8kitz4LA14gCVcpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085966; c=relaxed/simple;
	bh=Y3sQe52k1yICnNk6VsdMH27lecC3GY2DlpewVQmBUI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfJOjZ7ew6uC6EON7yevdJCEP2dAhtOC3hZFwEHRZMTevSqnGizaGTVpQGLzJh63gz65h2J2h3Xxm8b47q4/QJhYbYVqh8W2dkKXBn13ejmVKFqddIbX+JePDTTvgKSrU7do3vggDDvdgqwwjzvDT5V7iOSBrmwUjZcdXJ7ngW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr18FGWj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221a9e5484aso3768413fac.0;
        Tue, 02 Apr 2024 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085964; x=1712690764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u509fpdTL3x8h0sKnxRrMd2Q/Sm/IRVlvPpLmK46sCY=;
        b=Tr18FGWjEOEZS6x+L5oiytweebci5kfquabcQS/5Lrl7kK8s8OHbQ/5p6XFor88Tzv
         u/JLvY//oCZ0uASc7bSdWzf76QIx8gxlEO67r/bJGOWpDNOu3d1p91sSYW3KtZCobnVC
         7RqtPOd2wGMJy960XutmRNy7ak4aIH5U6w1K5JpCQacU4rpxX1TIdYdijYd/qbEh0h0z
         prZ/2JTqF3kXlB/iyzTZxlQtPYJ+rWybzNMKUeUQmcbd0TYVyXmbb5sZfDMngcdiqbp0
         9YS9u0QUTaT6/RRlYM+Z7cCP+GHAK0pZTrDugX0hGe/atdJb9lQbNaWdPuaAw63VPuEb
         wNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085964; x=1712690764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u509fpdTL3x8h0sKnxRrMd2Q/Sm/IRVlvPpLmK46sCY=;
        b=hOe41AOo16w79Z+TVYhR2XPvVRyXb7jsiV5NaZB8bjtJED/g7/jx1dqPY5xg4xzQ7Q
         rzuB2pFw8WrkBhISEOIrknkPcWXIvbPZ39WyydaWZUFZyeOzNSlacpAN5LoZ39Iyp4AL
         7WO4rtV2OZHoGKZtOIGYsyKWH9COHPkGmzlYjS6O9XWl+e3ZfXNTwnsGM5AEOUqZp4bH
         Os7ucodUp8r29lFRnHGTE8Moi0qhNjpFaJLJJRetMTJ0OO/5riK+82Z4+9tKsE4kaLhP
         4tV/Py9Ni16q3Er/oaWUVDmJxJTTd+uBBsGgvhrUsWWTh8nThi44l7o4zGRnsPRuK6Ao
         n9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiGy/KRyylaooJEc7OXAPzNQKSdf7PHSZ3/ds8NGIQOIiC/baamZl4K0dJ202JCjgZqyOn9LD8L6tonU8JOxhf8cZMfDuED2ax4EEznOJZOL5PM3U8eKbsmDU2x37J/tvp1hz3l0GS8lCy2qO14RoDTxNMYlLhgNCvh5HQS1Psn2gFxQGISA==
X-Gm-Message-State: AOJu0Yz5WdmPEYMXXS9ZhFjCYqoS6LI4gyfZslgPN/77C46sk9tWGAut
	1azDgCgnXYrlT+hWhzh2L0EBHyIelmqcBKgJslpp+41tz9NLuJRo
X-Google-Smtp-Source: AGHT+IGXiX0R+pjBUbuLZzc0JHffXaS4BXKCPOLEoUc822a2Ltjo0ljUMsaoACrgDM5sNkY1dTpe7w==
X-Received: by 2002:a05:6871:1d5:b0:22e:7de8:c745 with SMTP id q21-20020a05687101d500b0022e7de8c745mr791919oad.56.1712085964262;
        Tue, 02 Apr 2024 12:26:04 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:26:03 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] PCI: qcom: Add support for IPQ9574
Date: Tue,  2 Apr 2024 14:25:52 -0500
Message-Id: <20240402192555.1955204-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the PCIe on IPQ9574. The main difference from ipq6018
is that the "iface" clock is not necessarry. Add a special case in
qcom_pcie_get_resources_2_9_0() to handle this.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..10560d6d6336 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
+	int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
 
-	res->clks[0].id = "iface";
+	res->clks[0].id = "rchng";
 	res->clks[1].id = "axi_m";
 	res->clks[2].id = "axi_s";
 	res->clks[3].id = "axi_bridge";
-	res->clks[4].id = "rchng";
 
-	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
+		res->clks[4].id = "iface";
+		num_clks++;
+	}
+
+	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
 	if (ret < 0)
 		return ret;
 
@@ -1664,6 +1668,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.40.1


