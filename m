Return-Path: <linux-pci+bounces-18425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65299F1CEA
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D4188E23A
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A745023;
	Sat, 14 Dec 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsZImcU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45927450
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156447; cv=none; b=NJV7eVmjyNFsUYJAVITt8G0ggWHpoFqDMWmrMQRIpMbTRnRXbyIc0XLShBjLGt6OWCG2NbW72+S5XlIFuRdHoGdDTArBxkEiAnKdMlASUhho62KRPHBkVsAKYt2YBnJ0xD+INM65kHZFzn2PO9LdkyajdusSoDHdwsf+Cw3d/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156447; c=relaxed/simple;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBKRJQzrSFjgS72Px7KDfY1sC4HYnnfRrYen0CX3XdD/9LcQhRXKjJ7oFotkLO1sr9GISKUbHzFO8gAl6Pu5QsrLgugAR0NxwjgwH0yaNUN0GDKmrqdWZa79vXrJLHcw6mWICTKUGbHyivXYLQm4Rbd2GEQcuNz40t1+XaXQLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsZImcU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A997EC4CED6;
	Sat, 14 Dec 2024 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156447;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsZImcU2CZCw/VhAjBlCqwBqvEYgFjBIXuN4GBggYoqrdTCHLZbOQs5knUniih1Py
	 S6B+hLqdQxp+3L3XF8Nmv1fLZ2cOgvvTNTNd8VzsIrqwcZuyeShJ5Q9Gligyo9zM1A
	 u9Y+0nFFvZd9w3Gj73HU58nHcGGB46asGHl/qTIdW2bPNfg3H92i5RMKX1rxsFmmLr
	 bBGU8Rt+JxISydJzIhAKGKPx89er1iE99gzdqYXvmZOOwPRlFHwoCDHYuiOdutdQYg
	 y+BvMb/Uo1cttMtKFyEwGHqkfLrlMWw/3Cjd/qcC8ycg/Vlvv3pwHEWCj/be6exPJe
	 lToFu+M8Bme1Q==
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
Subject: [PATCH v5 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Sat, 14 Dec 2024 15:06:42 +0900
Message-ID: <20241214060655.166325-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
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


