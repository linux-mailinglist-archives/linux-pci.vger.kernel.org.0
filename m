Return-Path: <linux-pci+bounces-19281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34564A01261
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 06:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDEF1884BE6
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1A1494D4;
	Sat,  4 Jan 2025 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQeMszXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216A146D55
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966836; cv=none; b=eINRpWs1LlklkuwqOXWudXUdUOnUtB1PjEpVEyOoJcySGBIZByU+wv/wLQCzUoIUNpRNFQWN6oanbYLhVTDpSQD9lnDNWoRmBh3FR5XoJARzC3+VDPPjrgc8fVgsrY42MR88yY5OfpmHyBNpZ6WsM8bNjZa5E4hE+NeSniyGzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966836; c=relaxed/simple;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dvn9k3H2RLgWO+FriwdAOvTakpTZu6IFYg3yZU9Dhul8ldKYVGX0GrV9gzb9CLnuq8n5aLm1/pZpYzu5eGbG1ajrfAW9dV+M2QGn4elwmMfazSZUxf377lXBAQAyoim6hD6uRwGsRXgMGUjtVDapmbbiC/cnETYq0lan0q1MMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQeMszXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8ACC4CEE1;
	Sat,  4 Jan 2025 05:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966836;
	bh=je5NcrKzqRp4TLcdE4FoMVzSwtY0YrZ9VBSF2cscEis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQeMszXBRzSMj91s9u4Qo9u3Fbue+yXE2NZ/E52WTFi4pMI9wUwinKUamldjVF9pd
	 SgLraV8vfK2LfdaDagFD0VizSVzwDPeSnYM1FKhSmq01II6I0vqdLRw88Jzf0zhzmM
	 O2ttNI/8a8m5f0WCJko7/t079J6zA0Cp+BD3FHTX6lsFgqQhx1fAiMTY8fUWDZMtUh
	 4BED8pdKRS695QMcXMOQpG6L7W7EUJgE4hJM9PFuIMBGsIXs/xyqc+0ZgsfrzyLcJ8
	 L4g+JLsGqnSKf4Y8IuBm5vYUA0qKc7zbrGwxPTTcVSqJzK0BkaeuFIDoZTS2FDBMbR
	 V2LY5SkM7BrVg==
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
Subject: [PATCH v9 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Sat,  4 Jan 2025 13:59:38 +0900
Message-ID: <20250104045951.157830-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
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


