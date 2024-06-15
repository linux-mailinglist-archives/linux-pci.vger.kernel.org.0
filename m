Return-Path: <linux-pci+bounces-8860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D7390989A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22E81C20F78
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86951E89C;
	Sat, 15 Jun 2024 14:19:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D01E861
	for <linux-pci@vger.kernel.org>; Sat, 15 Jun 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718461199; cv=none; b=JYmAcBjB7bs4Ya7ht1YahJDfGmM2UBK5iDqZXsTo92RNU/E+hu49RDGo5WOYd+YX0CUPvgcXzUMmwqhQiP4kVSZQfT/WBzEsMiiDXLPWgLyHbLgNZZ4P3oBoj7C5MpH2qvLlkTelTBqTNtEHKm/vP+KZEtJBvqSDbRvosl+Lyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718461199; c=relaxed/simple;
	bh=eLylnJxrdBhX1JMDRBSQTqhwpZQuezEmSAyPqDvPwsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQFw5k1YLhoICHVt800EwecAeEUKujI3kwme0W6gPITJnHOZB5ud7w+1P1z+/Dm4TBB40rPXTcBUQCPkL1kTmjKXY00S9BbaVY7LM++QN65PtrMNmwAW/0kXLed7w8CnwdlOJujd1JQtzDvB7QRaA5ph2Dt66DMb8RFKdHu5oPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 36425100B03A3;
	Sat, 15 Jun 2024 16:09:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 04E54335381; Sat, 15 Jun 2024 16:09:41 +0200 (CEST)
Date: Sat, 15 Jun 2024 16:09:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] PCI: err: ensure stable topology during handling
Message-ID: <Zm2gpY_Yi9JTrS_5@wunner.de>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612181625.3604512-3-kbusch@meta.com>

On Wed, Jun 12, 2024 at 11:16:25AM -0700, Keith Busch wrote:
> DPC and AER handling access their subordinate bus devices. If pciehp
> should happen to also trigger during this handling, it will remove
> all the subordinate buses, then dereferecing any children may be a
> use-after-free. That may lead to kernel panics like the below.

I assume the crash occurs because the struct pci_bus accessed by
pci_bus_read_config_dword() has already been freed?

Generally the solution to issues like this is to hold references
on the structs being accessed, not to acquire locks that happen
to prevent the structs from being freed.

Question is, which struct ref needs to be held and where?

Holding a ref on a struct pci_dev also holds the pci_bus it resides on
in place.  So I suspect we need to call pci_dev_get() somewhere.

The stack trace looks incomplete for some reason:

>   ? pci_bus_read_config_dword+0x17/0x50
>   pci_dev_wait+0x107/0x190
>   ? dpc_completed+0x50/0x50
>   dpc_reset_link+0x4e/0xd0
>   pcie_do_recovery+0xb2/0x2d0

I'd expect a call to pci_bridge_wait_for_secondary_bus() from
dpc_reset_link(), which in turn calls pci_dev_wait().

Indeed pci_bridge_wait_for_secondary_bus() does something fishy:
It takes the first entry from the devices list without acquiring
a ref:

	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
				 bus_list);

Below is a small patch which acquires a ref on child.  Maybe this
already does the trick?

-- >8 --

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2a8063e..82db9a8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4753,7 +4753,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  */
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 {
-	struct pci_dev *child;
+	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
 
 	if (pci_dev_is_disconnected(dev))
@@ -4782,8 +4782,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*

