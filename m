Return-Path: <linux-pci+bounces-31717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE35AFD572
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11E5421794
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661F2E7F34;
	Tue,  8 Jul 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV4bEwXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB02E7F07;
	Tue,  8 Jul 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996053; cv=none; b=DRxJ0+7xmUejBe6CXJcwCadYkqSHjZhoBzxilnL/gaB6Ee8etxTw/2f8anQXQKbRkS5TUa1ot/4r2T7fBLVtja9PQxu8UiR7nlTxkxNjp6jNLi5d64F5rS9pqtFNopseXpac9XmmAKeaFY4IgU6UpQ/OnkGPqVGH5n5z2P6C8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996053; c=relaxed/simple;
	bh=k98cYHJAeNwc/m55APAuSnpJZEiaO0Z2w/xQyAaUaQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oc7DQpcIWPBH/qbIWR0n/iBqrbPCnMeRNJfALBP9HmsTOv6gc63HwXtQthuGhF7AoXx7rratdZeL3eiApmROa1VaAIavrmDjg+OvD3BCEHHRS4FsXLjO9HjV2SMhnWA2mru/l8QXf7Eya74zw7sG3PwKfmNoAnPFRcIN6HpJqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV4bEwXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07334C4CEF9;
	Tue,  8 Jul 2025 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996053;
	bh=k98cYHJAeNwc/m55APAuSnpJZEiaO0Z2w/xQyAaUaQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IV4bEwXAd6QJ9CTtBJgb/ii1pxuW6HZTrwYYMCijBt7Ysj8qoqFDRF7YUlNqZdeqb
	 S392K0a3iUUf0fjSdZ4eZJQxRgbHt86LJLl8rKCBDKRXkD5osgbROfDZRT+BCjBC6M
	 iBlOzcV9lZ8WwcRZyAfmagRmaN1Z/VkIt02dIHdEvZSREfD5tCIvCokY1nOtbD5gVI
	 jFGuFL6NRzHtu8wXDlAPfowCBGj7TB1ph5mq0DYeMeQtVVHvg4CZmD5bxK5pInLC7h
	 U3v0uIC0JfRoQReLHaoUA4ktriybfCEv3ZXOYYfQ9jsfVZzzt4lurEizyt26Aeotz9
	 QzxyLMZxNLSdw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCp-00Dqhw-6n;
	Tue, 08 Jul 2025 18:34:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 13/13] cpu/hotplug: Remove unused cpuhp_state CPUHP_PCI_XGENE_DEAD
Date: Tue,  8 Jul 2025 18:34:04 +0100
Message-Id: <20250708173404.1278635-14-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that the XGene MSI driver has been mostly rewritten and doesn't
use the CPU hotplug infrastructure, CPUHP_PCI_XGENE_DEAD is unused.

Remove it to reduce the size of cpuhp_hp_states[].

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/cpuhotplug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index df366ee15456b..eaca70eb6136b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -90,7 +90,6 @@ enum cpuhp_state {
 	CPUHP_RADIX_DEAD,
 	CPUHP_PAGE_ALLOC,
 	CPUHP_NET_DEV_DEAD,
-	CPUHP_PCI_XGENE_DEAD,
 	CPUHP_IOMMU_IOVA_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
-- 
2.39.2


