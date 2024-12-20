Return-Path: <linux-pci+bounces-18834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA279F8AC1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 04:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37889188BBF9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 03:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBE4CB5B;
	Fri, 20 Dec 2024 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXGa/oqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA22594B5
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666869; cv=none; b=Hl+8dnNhtoaGZpggEn1FuvtFQJJK3jMeRPWYHfvbdeRLtIPc8nX5uIrocH093RvQwnkfRPkqnp7v/u/8pPlG2dkYobgN5XCHGRXMtvCTDdF4Zib6NMl7+8Hu+UwUTO+G2cmSBq4XpOx0oPMsndVe9vjYKxlDsY/Zi6TrqtVtIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666869; c=relaxed/simple;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtHxAg13ZJvSm6H42Z6rQhqHn/74TncAQBGWS0OcLrj+awVfwedRBQ5QwqMirs7QUtzAnSG6v0bAbsRM5ad1Uxq/JHpKbbaBoCt2gAkn0+UpBSBd4hJ+j+VsrWqBHsTNRPxb2EXahDwhF/o7JuHC5AELMGwpASZ2XbeXBQxjE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXGa/oqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C918C4CEDF;
	Fri, 20 Dec 2024 03:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666868;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXGa/oqAVlJNvw+wwOBSNvZEVLg2X5SzZqYEa13O4W3eS3odHbh+BL84Uh+5nkw7k
	 32NASswD4orbzxQ8slLk/MD5IhCf1ZIB9xUtkbk6b3a4yIfNT4kmt+89JnJiMgag67
	 zwVOISyxXqT5TqTuGeqf2opyN3DCMcOq9P8VcqPWwn3xOaMeu2466Wr6ddH0b9i8yy
	 O92KgdsBpwpftCOuE1tfJ0A8dCN3zHT82BJVi2gcDFfezyUYOADm2f8QEq5uTV/xV/
	 mEeSRL7AfXSHJtq/of1aMPfBQxv6ActpMXRUlQofyFBQ1vkgkOQjxKhLNKOgIqnCpZ
	 YhylIJIRYNHMg==
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
Subject: [PATCH v6 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Fri, 20 Dec 2024 12:54:28 +0900
Message-ID: <20241220035441.600193-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
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


