Return-Path: <linux-pci+bounces-14204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9078C998D60
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03031C2279F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5391CEEA5;
	Thu, 10 Oct 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKk6SwPR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E01CDFD3;
	Thu, 10 Oct 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577681; cv=none; b=jmegN9xYubkxsi4Ip+np0/4yO0B8HyMcoPdtOTiEwu3Rv5QwZpZcb5c0ar+RAQCGhGHAyqSREVbcizf2FZvdArN2eALcf7BEszypdEkHXML/LDjht5PYK6dRWWQFIhJ6X4xqu5zyQy0Qb/ZZBq8XY87rAWd/e1JsVI9KXOYhPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577681; c=relaxed/simple;
	bh=ghSAtZiukwCoDW22DY23XZzRIv3trZU3J6sfrQTkYAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXYNEYPHWtRMsJ9DhjDgSP/1Ro5sn+4BwZQLkuT+3ivWohhMBKVPUAGv5G+o8lOmryNxg8hyopps/VjAtfXL74l7YlKH9U0JOvZjvJjuMB/6gfR75MR9Y559GkHTB9V7mAyupyGem+OmMExuF7Bq65cIiBY+nSSMk8TYB+IT748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKk6SwPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB57C4CECF;
	Thu, 10 Oct 2024 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577680;
	bh=ghSAtZiukwCoDW22DY23XZzRIv3trZU3J6sfrQTkYAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aKk6SwPRlCpsYMqIEEdqpoTWC3WrsMAryC6/oh1rz9OW2D+ptRgofSLdJ8B+dxrrU
	 64/GBWCAWija0SmAURseI/wFWeb+TeRThhe+D1XziSTS6PPaYkyotIipPW+eH+c9VO
	 bbCMOw9mOCkPL/X192TcHchtwRF5JxBge2naWv9+f8pc6LC/HnAUdcYJmIz6XA8cQd
	 AeVaAjEQqeESE4elfxa4iz6c+8J4CUOSt8LIjg2aiTaK09yHrrsbOpsgvvX+GsSUP6
	 digBILv2QSva7SwYE6VHJdfQMRmQTojPfTO5VBwlK52nDk9cCp9chvNAIyo6LggQQB
	 JJfTPXvWdd48w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:15 -0500
Subject: [PATCH 2/7] logic_pio: Constify fwnode_handle
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-2-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

The fwnode_handle passed into find_io_range_by_fwnode() and
logic_pio_trans_hwaddr() are not modified, so make them const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Please ack and I'll take with the rest of the series.
---
 include/linux/logic_pio.h | 6 +++---
 lib/logic_pio.c           | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index babf4e3c28ba..8f1a9408302f 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -17,7 +17,7 @@ enum {
 
 struct logic_pio_hwaddr {
 	struct list_head list;
-	struct fwnode_handle *fwnode;
+	const struct fwnode_handle *fwnode;
 	resource_size_t hw_start;
 	resource_size_t io_start;
 	resource_size_t size; /* range size populated */
@@ -110,8 +110,8 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
 #endif /* CONFIG_INDIRECT_PIO */
 #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
 
-struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
-unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+struct logic_pio_hwaddr *find_io_range_by_fwnode(const struct fwnode_handle *fwnode);
+unsigned long logic_pio_trans_hwaddr(const struct fwnode_handle *fwnode,
 			resource_size_t hw_addr, resource_size_t size);
 int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
 void logic_pio_unregister_range(struct logic_pio_hwaddr *range);
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 2ea564a40064..e29496a38d06 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -122,7 +122,7 @@ void logic_pio_unregister_range(struct logic_pio_hwaddr *range)
  *
  * Traverse the io_range_list to find the registered node for @fwnode.
  */
-struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
+struct logic_pio_hwaddr *find_io_range_by_fwnode(const struct fwnode_handle *fwnode)
 {
 	struct logic_pio_hwaddr *range, *found_range = NULL;
 
@@ -186,7 +186,7 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
  *
  * Returns Logical PIO value if successful, ~0UL otherwise
  */
-unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+unsigned long logic_pio_trans_hwaddr(const struct fwnode_handle *fwnode,
 				     resource_size_t addr, resource_size_t size)
 {
 	struct logic_pio_hwaddr *range;

-- 
2.45.2


