Return-Path: <linux-pci+bounces-19034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153A9FC427
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51257A1815
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E5158553;
	Wed, 25 Dec 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1THOzaI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A2157E6B
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115443; cv=none; b=ibN5oth9giJOIOVQsw/A2HOCaJ5rNu7wIakobCVCYthZpb8ebZwjjQAe8QQAoj+RvIzdyfftuxfLXy1OlUAEnb/OR1l3ZtGdB05+/DHMftCoTfhiHDlpBJSJAewW6bNe8iAZtQ6jLkruDTd4WCg9boB4P/zLjSzo/tnZ9TZEXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115443; c=relaxed/simple;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHb/NXrf83yxt0rwJWi9URhTh8HExbHml4dV2+Aub2BBSvoP4vY3h6UJojPNffZ6F6W51KZ9ewF07j60Fm0jhtRqodUNcorxIy44mHMghy9OqcFJ8Y30tHiyb49mjpUn4Cc+7kdNs4WS2PBdmyWDE20zNva96qGO20E+Htr/OhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1THOzaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE8C4CEDE;
	Wed, 25 Dec 2024 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115443;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1THOzaIySgps4LDrsazXNQehNaGOg0tNBGKzc7eVS2fwDpn6rMn6Xt2uTCfAJZi8
	 CKJA9FcdiDDSK6LosnZemuMOrmX842Tu7dyU7MROVPajDnPMk4hpXfrtlCDNaYb8/Z
	 7ODIkvWpKUtJB+5S1RssR8BvqTdQ9fdD8IgjcBepqtKeCuV12fwz0hbJ1GVYjrT6xU
	 XRRn2hd7yqVbSnXybxRov/0RbObWJNdsZzmEuKoiH8Fws+pzQJkspSUp/Wp2xfukRR
	 XTS/dFXbKCl6fkC+o2i7H7uJeMRwISufDi1HZY4wrtI3P5BOWCjjdtvW4gH/m+tGzm
	 a2SeKPao2UJRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v8 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Wed, 25 Dec 2024 17:29:42 +0900
Message-ID: <20241225082956.96650-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a target driver to attach private data to a target controller by
adding the new field drvdata to struct nvmet_ctrl.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e68f1927339c..abcc1f3828b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -238,6 +238,8 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
 
+	void			*drvdata;
+
 	bool			reset_tbkas;
 
 	struct mutex		lock;
-- 
2.47.1


