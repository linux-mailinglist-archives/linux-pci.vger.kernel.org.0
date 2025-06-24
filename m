Return-Path: <linux-pci+bounces-30480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2334AE5F00
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76B51BC0948
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B64253950;
	Tue, 24 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7NHIj4W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A1248F59
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753315; cv=none; b=fW49pY7ZpRDDk4V6TggRAH5o6yJelEZOv0eL1qdBFeykrlgB6d/KH3UthqY4YSnckesx9i1kAFezr18dkeqn8b2raj3mPB99WT486uKyEpuGEHl1UIdBTtei9I5A9CnCRJ1tJRLJzVqJz/UmftlYrxBp2XvzMMEBQbqRe5vw+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753315; c=relaxed/simple;
	bh=DoXT244DtIAvKZ/IjgPkzycmqeC05trFol1kBZkxFwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esBSbSZezC93obQc/Z/byowe/criUcFEhg1k5jtTfBVFWX2FHry+QtrW1HUN1hfCMXuCxVwYnZSe54omfqAZOzDz9bqAJ0YCgIJCCqUl3Pdh6vLQs3gUcuwwnK1HkLhV6oM4aFVRhCR8aJ6JwiYSUMEL9NuQkk82dnuYOX9L0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7NHIj4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DCBC4CEE3;
	Tue, 24 Jun 2025 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753314;
	bh=DoXT244DtIAvKZ/IjgPkzycmqeC05trFol1kBZkxFwA=;
	h=From:To:Cc:Subject:Date:From;
	b=W7NHIj4WDkDZPbph2lTV4moVhSBItCeAzQeAa7+zODtRMvdXlHf80HKRjHHJbOxP4
	 a7lMRSYImP8RzyQKeuawZgRNdH4lI/Ae8nYBdp/gygNEu/dVnE8POETd08gsEAsZFO
	 3HzPnaRoR1TAMV6SXLsnbqW7TK4KZRMoguzmylNir35tlwoglvPsuHvLCjnS+XAG0e
	 5ekgMi4PTInO2VlULWP578Hp3ebMrQ0t28O6FDcnOGIY7Obi1/FQZgZBcEuYQaijdi
	 NZVsJZ0MsnXEfmRXMnQ4pQkD7mdv2BgjRHSF6sDdVOZFhGEY5m/jlVTd0oA3uV4V+c
	 lxB9oW1LIy2FA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/2] Fix EPF configfs attribute group removal
Date: Tue, 24 Jun 2025 17:19:47 +0900
Message-ID: <20250624081949.289664-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of patches to fix removal of configfs attribute groups of a PCI
endpoint function driver.

Changes from v1:
 - Split out patch 1 from patch 2 as requested by Niklas.

Damien Le Moal (2):
  PCI: endpoint: Fix configfs group list head handling
  PCI: endpoint: Fix configfs group removal on driver teardown

 drivers/pci/endpoint/pci-ep-cfs.c   | 1 +
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.49.0


