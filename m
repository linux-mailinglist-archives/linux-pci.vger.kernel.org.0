Return-Path: <linux-pci+bounces-1497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477F81F8C3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339541F24228
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D579C3;
	Thu, 28 Dec 2023 13:18:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D178465;
	Thu, 28 Dec 2023 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A42FD3000D5B0;
	Thu, 28 Dec 2023 14:18:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 964802913A9; Thu, 28 Dec 2023 14:18:02 +0100 (CET)
Date: Thu, 28 Dec 2023 14:18:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Steven Haigh <netwiz@crc.id.au>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.ebner@proxmox.com
Subject: Re: Qemu KVM thread spins at 100% CPU usage on scsi hot-unplug
 (kernel 6.6.8 guest)
Message-ID: <20231228131802.GA21994@wunner.de>
References: <3a7656ab-df4c-4d57-8866-661beffcddd7@crc.id.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7656ab-df4c-4d57-8866-661beffcddd7@crc.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 28, 2023 at 01:03:10PM +1100, Steven Haigh wrote:
> At some point in kernel 6.6.x, SCSI hotplug in qemu VMs broke. This was
> mostly fixed in the following commit to release 6.6.8:
> 	commit 5cc8d88a1b94b900fd74abda744c29ff5845430b
> 	Author: Bjorn Helgaas <bhelgaas@google.com>
> 	Date:   Thu Dec 14 09:08:56 2023 -0600
> 	Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
> 
> After this commit, the SCSI block device is hotplugged correctly, and a device node as /dev/sdX appears within the qemu VM.
> 
> New problem:
> 
> When the same SCSI block device is hot-unplugged, the QEMU KVM process will
> spin at 100% CPU usage. The guest shows no CPU being used via top, but the
> host will continue to spin in the KVM thread until the VM is rebooted.

Find out the PID of the qemu process on the host, then cat /proc/$PID/stack
to see where the CPU time is spent.

