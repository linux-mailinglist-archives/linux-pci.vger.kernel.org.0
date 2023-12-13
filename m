Return-Path: <linux-pci+bounces-859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C980810EBF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E1F1F211EC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B491FBED;
	Wed, 13 Dec 2023 10:44:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A18112;
	Wed, 13 Dec 2023 02:44:19 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 77D1D28045DDC;
	Wed, 13 Dec 2023 11:44:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6B25515AB43; Wed, 13 Dec 2023 11:44:17 +0100 (CET)
Date: Wed, 13 Dec 2023 11:44:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231213104417.GA31964@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 10:46:37PM -0500, Ethan Zhao wrote:
> For those endpoint devices connect to system via hotplug capable ports,
> users could request a warm reset to the device by flapping device's link
> through setting the slot's link control register,

Well, users could just *unplug* the device, right?  Why is it relevant
that thay could fiddle with registers in config space?


> as pciehpt_ist() DLLSC
> interrupt sequence response, pciehp will unload the device driver and
> then power it off. thus cause an IOMMU devTLB flush request for device to
> be sent and a long time completion/timeout waiting in interrupt context.

A completion timeout should be on the order of usecs or msecs, why does it
cause a hard lockup?  The dmesg excerpt you've provided shows a 12 *second*
delay between hot removal and watchdog reaction.


> Fix it by checking the device's error_state in
> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
> request to link down device that is set to pci_channel_io_perm_failure and
> then powered off in

This doesn't seem to be a proper fix.  It will work most of the time
but not always.  A user might bring down the slot via sysfs, then yank
the card from the slot just when the iommu flush occurs such that the
pci_dev_is_disconnected(pdev) check returns false but the card is
physically gone immediately afterwards.  In other words, you've shrunk
the time window during which the issue may occur, but haven't eliminated
it completely.

Thanks,

Lukas

