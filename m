Return-Path: <linux-pci+bounces-13771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C194198F0C3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56970B21013
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D44154C12;
	Thu,  3 Oct 2024 13:47:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8498C07
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963228; cv=none; b=QUYLpqpCD4GcZFpnWckNYCFRsOFTJ0l4AWZmH+F57+Np4Yl5/MG+YM9AYgdIe6r2qOTSW+1EwGTAcvfLlU7Y2NUjnBxoFzwPjkj5Q2sCnUais9EHfNGUYJIciYkb1FF96pU4U68cuDcDmjkEDRWvO2WWEJv9DH+2m6vll4mphVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963228; c=relaxed/simple;
	bh=6TXy7d539OwogFJsue7rYjqKIXqVg3S8Gzxo+FbS7do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPer6Nf6wENmDzz2cmEVJaANdAP5ojzgaBQR5CpfgigDA43D4iE1iJ4Rpd9YfPouvgmvhRTolPtyPhuZ613Mamz5suP3G3l+sxk0B3bN94bgZvJmkJ1+go8M3wMZoRZkpXrL/tqmlE4uy/VI7ovKc+a8i/5ViOqBy1CocxJ9sYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 62E513000C77B;
	Thu,  3 Oct 2024 15:46:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E81428CC9; Thu,  3 Oct 2024 15:46:55 +0200 (CEST)
Date: Thu, 3 Oct 2024 15:46:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <Zv6gT96pHg2Jglxv@wunner.de>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>

On Wed, Sep 25, 2024 at 03:38:34PM +0000, Wassenberg, Dennis wrote:
> [    2.858063] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
> [    2.858071] CPU: 13 UID: 0 PID: 137 Comm: irq/156-pciehp Not tainted 6.11.0-devel+ #3
> [    2.858090] Hardware name: LENOVO 21LVS1CV00/21LVS1CV00, BIOS N45ET18W (1.08 ) 07/08/2024
> [    2.858097] RIP: 0010:dev_driver_string+0x12/0x40
> [    2.858111] Code: 5c c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 47 68 48 85 c0 74 08 <48> 8b 00 c3 cc cc cc cc 48 8b 47 60 48 85 c0 75 ef 48 8b 97 a8 02
> [    2.858123] RSP: 0000:ffff9493009cfa00 EFLAGS: 00010202
> [    2.858132] RAX: 6b6b6b6b6b6b6b6b RBX: ffff8e53029cb918 RCX: 0000000000000000
> [    2.858139] RDX: ffffffffa586b18a RSI: ffff8e53029cb918 RDI: ffff8e53029cb918
> [    2.858144] RBP: ffff9493009cfb10 R08: 0000000000000000 R09: ffff8e5304f61000
> [    2.858150] R10: ffff9493009cfb20 R11: 0000000000005627 R12: ffffffffa64db188
> [    2.858156] R13: 6b6b6b6b6b6b6b6b R14: 0000000000000080 R15: ffff8e5302b1c0c0
> [    2.858161] FS:  0000000000000000(0000) GS:ffff8e5a50140000(0000) knlGS:0000000000000000
> [    2.858169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.858175] CR2: 0000000000000000 CR3: 000000030162e001 CR4: 0000000000f70ef0
> [    2.858182] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.858187] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [    2.858193] PKRU: 55555554
> [    2.858196] Call Trace:
[...]
> [    2.858258]  __dynamic_dev_dbg+0x170/0x210
> [    2.858287]  pci_destroy_slot+0x59/0x60
> [    2.858296]  pciehp_remove+0x2e/0x50
> [    2.858304]  pcie_port_remove_service+0x30/0x50
> [    2.858311]  device_release_driver_internal+0x19f/0x200
> [    2.858322]  bus_remove_device+0xc6/0x130
> [    2.858335]  device_del+0x165/0x3f0
> [    2.858348]  device_unregister+0x17/0x60
> [    2.858355]  remove_iter+0x1f/0x30
> [    2.858361]  device_for_each_child+0x6a/0xb0
> [    2.858368]  pcie_portdrv_remove+0x2f/0x60
> [    2.858374]  pci_device_remove+0x3f/0xa0
> [    2.858383]  device_release_driver_internal+0x19f/0x200
> [    2.858392]  bus_remove_device+0xc6/0x130
> [    2.858398]  device_del+0x165/0x3f0
> [    2.858413]  pci_remove_bus_device+0x91/0x140
> [    2.858422]  pci_remove_bus_device+0x3e/0x140
> [    2.858430]  pciehp_unconfigure_device+0x98/0x160
> [    2.858439]  pciehp_disable_slot+0x69/0x130
> [    2.858447]  pciehp_handle_presence_or_link_change+0x281/0x4c0
> [    2.858456]  pciehp_ist+0x14a/0x150

Could you try the patch below and report back if it fixes the issue?

Thanks!

Lukas

-- >8 --

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 0f87cade10f7..ed645c7a4e4b 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -79,6 +79,7 @@ static void pci_slot_release(struct kobject *kobj)
 	up_read(&pci_bus_sem);
 
 	list_del(&slot->list);
+	pci_bus_put(slot->bus);
 
 	kfree(slot);
 }
@@ -261,7 +262,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 		goto err;
 	}
 
-	slot->bus = parent;
+	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
 	slot->kobj.kset = pci_slots_kset;
@@ -269,6 +270,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		pci_bus_put(slot->bus);
 		kfree(slot);
 		goto err;
 	}

