Return-Path: <linux-pci+bounces-34166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27FB299BC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA477A86F0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5392215F7D;
	Mon, 18 Aug 2025 06:32:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922C2741CD
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498752; cv=none; b=IOnDr5btq/ZVL6dUnhexWg+VxaHeUZt9pXfeXy4uAi+0Nfuo1m0c8Nm+0/w/WXsHkNacwABfOWbmyjtHYViDDgNG1B+KvigFgkNOuXx8yDRiX3DXmBGHtaX+rIys+TXgFlUwDYTwVEdwJBASFwGtBJS2PVCiLyj5/NkrO0ZsXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498752; c=relaxed/simple;
	bh=fxPC7rmM1Nh3s+2IXTy425aajso0iNHgA+zUcVUlkUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFRwtqgUbb5ERyGoCI5F01s1O55r7BgRGP4slJu039do2gpl2DT9yztRN4CjVuu+x7TD3cAA/cz871gBxucXQ0Cysr9lvlYxgdEOhuhftVpeTzMdzRlTsujDXxWFYZexAvR0UPVH1zTPYkU1sAVzrG1UUGfX4qnz+h0habMC3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5D06D20091A4;
	Mon, 18 Aug 2025 08:32:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 56AD82D65CB; Mon, 18 Aug 2025 08:32:26 +0200 (CEST)
Date: Mon, 18 Aug 2025 08:32:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: bhelgaas@google.com, alikernel-developer@linux.alibaba.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] [RFC] PCI: fix pcie secondary bus reset readiness check
Message-ID: <aKLI-qrOpvkbJTwx@wunner.de>
References: <20250818040641.3848174-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818040641.3848174-1-guanghuifeng@linux.alibaba.com>

On Mon, Aug 18, 2025 at 12:06:40PM +0800, Guanghui Feng wrote:
> When executing a secondary bus reset on a bridge downstream port, all
> downstream devices and switches will be reseted. Before
> pci_bridge_secondary_bus_reset returns, ensure that all available
> devices have completed reset and initialization. Otherwise, using a
> device before initialization completed will result in errors or even
> device offline.

I recently received a report off-list for what looks like the same issue
and came up with the patch below.

Would it fix the issue for you?

It's not yet a properly fleshed-out patch, just a proof of concept.
But it's smaller and simpler than the approach you've taken.

This patch is for a Secondary Bus Reset issued by AER.  Is the bus reset
likewise happening through AER in your case or what's the code path
leading to the bus reset?

-- >8 --

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index fa83ebd..8b427a9 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -761,6 +761,10 @@ static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 
 	pci_restore_state(dev);
 	pci_save_state(dev);
+
+	if (pci_bridge_wait_for_secondary_bus(dev, "hot reset"))
+		return PCI_ERS_RESULT_DISCONNECT;
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 

