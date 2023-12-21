Return-Path: <linux-pci+bounces-1258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05781B3EA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775B7281C38
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DDD6D1B6;
	Thu, 21 Dec 2023 10:39:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC36D1C2;
	Thu, 21 Dec 2023 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CACE02800BBD9;
	Thu, 21 Dec 2023 11:39:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BFA402A7C1; Thu, 21 Dec 2023 11:39:40 +0100 (CET)
Date: Thu, 21 Dec 2023 11:39:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231221103940.GA12714@wunner.de>
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
 <20231220005153.3984502-3-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220005153.3984502-3-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 19, 2023 at 07:51:53PM -0500, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register, as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU devTLB flush request for device to
> be sent and a long time completion/timeout waiting in interrupt context.

I think the problem is in the "waiting in interrupt context".

Can you change qi_submit_sync() to *sleep* until the queue is done?
Instead of busy-waiting in atomic context?

Is the hardware capable of sending an interrupt once the queue is done?
If it is not capable, would it be viable to poll with exponential backoff
and sleep in-between polling once the polling delay increases beyond, say,
10 usec?

Again, the proposed patch is not a proper solution.  It will paper over
the issue most of the time but every once in a while someone will still
get a hard lockup splat and it will then be more difficult to reproduce
and fix if the proposed patch is accepted.


> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>          OE    kernel version xxxx

I don't see any reason to hide the kernel version.
This isn't Intel Confidential information.


> [ 4223.822628] Call Trace:
> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50

__dmar_remove_one_dev_info() was removed by db75c9573b08 in v6.0
one and a half years ago, so the stack trace appears to be from
an older kernel version.

Thanks,

Lukas

