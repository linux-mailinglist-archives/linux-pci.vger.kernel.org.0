Return-Path: <linux-pci+bounces-14207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678A998DEF
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C3DB33303
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1E1CFEAA;
	Thu, 10 Oct 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnyZa2lh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DC1CFEA4;
	Thu, 10 Oct 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577684; cv=none; b=uACfoGQy+7HpNCIfjsS70dk6MTmCwvb05/m/wj0oHAg/S6RM+79uPARpPswN3l4N2mKzPpPNx3jg3LThxRMZgMWB8V8IDY2IqjNUV5WN7HKpqBbynXuhxsJs7isl1340C5IolaAHJUOK93fF49BFZQ9rjXz5i2tt21nB/MQMaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577684; c=relaxed/simple;
	bh=i/2LnrN4yP+bxZ9J7WuZQGaKftbkT7m60p1loGmwWys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fU7xdQle1oA6tV9eZlvdqTzZQ3PnvMSRTVE9N2tonJiQdrI3LmgVRU/f12RG4PyciQQ/tCfrTY1JD3yNnWvEsSddvn42INqLVOYJhO/8qoweNEIYISx2dvktpabJlbU2HGlUj6IVIiSi+jpdUOiQjzMZkpSJkuJiOOciyebiP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnyZa2lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7468C4CEDA;
	Thu, 10 Oct 2024 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577683;
	bh=i/2LnrN4yP+bxZ9J7WuZQGaKftbkT7m60p1loGmwWys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TnyZa2lhzwpfJr3o+a29S3uAvWNrJCFd22o5zDmO4A+fJjETM7CmKgWypUJznwIoM
	 2tD0s+sq6K3ndfMR1oiPESwYCcRxC3XRefVsI6prnH8RQlbEw8aTx4aD6u/khxaCiL
	 FxbGlKufnAI37b6UFQWGhTf+qmaA+uk+fDaDmV5J/btijdzIrUd/wiToYo9g00SM8K
	 pCr+YnFDiUnjAbIK1uaNSzGumh4Aay/qNEHpvIqDKGcigHrW2quVJf63btU+/aBBb2
	 FxLs9atkXUhiJm6G+XnMMK7ChO/ci28yKajYeBHA2iKOi1CiMKKS31OYZAeFAxjQVI
	 gAz6L9sigGZ8Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:18 -0500
Subject: [PATCH 5/7] of: Constify of_changeset_entry function arguments
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-5-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

__of_changeset_entry_invert() and __of_changeset_entry_revert() don't
modify struct of_changeset_entry arguments, so they can be const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/dynamic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 110104a936d9..d45a8df61380 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -536,7 +536,7 @@ static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 	kfree(ce);
 }
 
-static void __of_changeset_entry_invert(struct of_changeset_entry *ce,
+static void __of_changeset_entry_invert(const struct of_changeset_entry *ce,
 					  struct of_changeset_entry *rce)
 {
 	memcpy(rce, ce, sizeof(*rce));
@@ -636,7 +636,7 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 	return 0;
 }
 
-static inline int __of_changeset_entry_revert(struct of_changeset_entry *ce)
+static inline int __of_changeset_entry_revert(const struct of_changeset_entry *ce)
 {
 	struct of_changeset_entry ce_inverted;
 

-- 
2.45.2


