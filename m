Return-Path: <linux-pci+bounces-42434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28AC9A031
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 05:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37893341CE0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 04:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB01D618E;
	Tue,  2 Dec 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jidPZhjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3951A23A6
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649951; cv=none; b=hjMc4l+2UsXIoUZ6TfyuHdQTxz74yxpHZWAEjtIaZYL3d9tz4p/OBw3qPzCYdlXv8GMV4pyu1vYafqYuLRs32JFta4sgkF6PIwtR4fjRx8h+rgmqKeJP2bVYI6RdoZwIWLlXVhycbaRQ1gMi+LOZmDPnecxnRvyhWdhe95NWbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649951; c=relaxed/simple;
	bh=fnoLEdxqwk2w7+g1UWlzLz7HEmrVv8IH+0ya1uPQhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnAfy3YbDnZfWXl2H084cr0+rFPJA3TjPYe4AAPXTIjZe247jrj8FnMHR1bDTz4mDkpcYRBmTebaMBwqaqan3HmVWiSzHWTRwqEGjsrMlaX+LEmZ7FehWgr3NhU97hNmBWT12s70SOOi6AeatLitKSzPsdlc7c9UlB3I/8ynQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jidPZhjJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764649940; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jGkj6NFksDpvWGpqhjCyE0Qem4BVgh8t+fkQb++jWuU=;
	b=jidPZhjJ5cSaPFbGxkwDeWb5JA3dmgpyJnHbWPqEWdlypCB9iXavhOxnOAvz0PlcfdZvUNuQPo0dewxRooyICLppVUaZog0jV0Lh7FKfO1EuD4gHkG4RKuDRlmLL5/GV69vJiLZCvQTUcVII+UsP1yeMj8Cnp8LEq7/eYpZ79po=
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0WtuzBCn_1764649927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Dec 2025 12:32:19 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH v4 0/1] PCI: Fix PCIe SBR dev/link wait error
Date: Tue,  2 Dec 2025 12:32:06 +0800
Message-ID: <20251202043207.3924714-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <d285f1b6-8758-efd3-da0e-6448033519fc@linux.intel.com>
References: <d285f1b6-8758-efd3-da0e-6448033519fc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to patch v2 and v3, the process of recursively waiting for all links,
switches, and ep devices to recover in the SBR, add restores 64 bytes of
switch configuration space to enable the switch to forward probe requests normally.

Guanghui Feng (1):
  PCI: Fix PCIe SBR dev/link wait error

 drivers/pci/pci.c | 143 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 103 insertions(+), 40 deletions(-)

-- 
2.32.0.3.gf3a3e56d6


