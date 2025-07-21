Return-Path: <linux-pci+bounces-32664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29065B0C7BC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5E7A287D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDC2DFA25;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJW6a4s1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED4DDBC;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112217; cv=none; b=qVZNGbX4oEWRPhKlGWPTjf2uzAlMj9qLSG3oEfgrTspV8DMBlqo8GCY5tJuUlo0FUqlvckJU1riuA0o345wVl4/siSMxZovfsfiHkl5Mg6Km0FhpVYXLJ0f2RM+QvoNqwWA4Qt0D7tYZUlqNCDRpx1K+0rkLdlONIRT3stzMMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112217; c=relaxed/simple;
	bh=NyfC6eKa4Ljazxpe6Tq7U85iunAK2tAH9AMpKX5rfjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCoOeAbrsGbPlyf6NaPGU9Vl4UXcm1HzmZl2Xg3ndRp6sM/R2ZWC0mlLzWfjoHQSl25nSyIiztsCtOuGVbzhVm7vDIHU3NVbqMu3NxS2k7hp0ufEHESGVnVbAuHo2omIdtvbC/TqsOSfjJVdN7NFFrI2X6z4nJojavNDWPqJ9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJW6a4s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6766C4AF0B;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112216;
	bh=NyfC6eKa4Ljazxpe6Tq7U85iunAK2tAH9AMpKX5rfjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJW6a4s1pR1Hzwr0Z3PepYH7odBo0NsP7GMG1Zvj8c/OHobX5cbDnnJ+O7o+pqF6a
	 rGVdoQ7wKGEcofqsxgo2I+gITQD7yzSJm3O8gJfNTBXExloTcy3KqoJyeQBJ4BVIye
	 p3s6fwDeA4sZJK+luULwhbqJC0RvArHCUHZWZLtSoy53jVNXBVaCazo6QQUMw8VJYB
	 p5HiNUbGsCci/Qbn9Mp9D6P8NH31+cGkWFht+cT9bAYIg3ij875zzejKfZtomr7K8+
	 4Pb1ehTkmWanWIGQq5zZPFezdqpIM9UwqA9hRlgu87/XSPa3wknM/a5s4iQOQq8dYc
	 6WRsMQAebIAkA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1udsZK-000000002Fk-1Sw3;
	Mon, 21 Jul 2025 17:36:46 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] PCI/pwrctrl: Fix device leak at device stop
Date: Mon, 21 Jul 2025 17:36:09 +0200
Message-ID: <20250721153609.8611-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250721153609.8611-1-johan+linaro@kernel.org>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the pwrctrl device taken by
of_find_device_by_node() when stopping a PCI device.

Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
Cc: stable@vger.kernel.org	# 6.13
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/remove.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498..16f21edbc29d 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -31,6 +31,8 @@ static void pci_pwrctrl_unregister(struct device *dev)
 		return;
 
 	of_device_unregister(pdev);
+	put_device(&pdev->dev);
+
 	of_node_clear_flag(np, OF_POPULATED);
 }
 
-- 
2.49.1


