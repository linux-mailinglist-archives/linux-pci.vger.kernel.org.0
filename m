Return-Path: <linux-pci+bounces-1265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF40381B4AA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE881F237DB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733C6AB88;
	Thu, 21 Dec 2023 11:07:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1B6AB8F;
	Thu, 21 Dec 2023 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 65DC21003D0EC;
	Thu, 21 Dec 2023 12:07:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3411B1E5F; Thu, 21 Dec 2023 12:07:43 +0100 (CET)
Date: Thu, 21 Dec 2023 12:07:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231221110743.GA1619@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
 <20231221104254.GB12714@wunner.de>
 <6f49be01-89e3-4407-9813-51d62e723947@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f49be01-89e3-4407-9813-51d62e723947@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 21, 2023 at 11:01:56AM +0000, Robin Murphy wrote:
> On 2023-12-21 10:42 am, Lukas Wunner wrote:
> > On Wed, Dec 13, 2023 at 11:54:05AM +0000, Robin Murphy wrote:
> > > I think if we want to ensure ATCs are invalidated on hot-unplug we need an
> > > additional pre-removal notifier to take care of that, and that step would
> > > then want to distinguish between an orderly removal where cleaning up is
> > > somewhat meaningful, and a surprise removal where it definitely isn't.
> > 
> > Even if a user starts the process for orderly removal, the device may be
> > surprise-removed *during* that process.  So we cannot assume that the
> > device is actually accessible if orderly removal has been initiated.
> > If the form factor supports surprise removal, the device may be gone
> > at any time.
> 
> Sure, whatever we do there's always going to be some unavoidable
> time-of-check-to-time-of-use race window so we can never guarantee that
> sending a request to the device will succeed. I was just making the point
> that if we *have* already detected a surprise removal, then cleaning up its
> leftover driver model state should still generate a BUS_NOTIFY_REMOVE_DEVICE
> call, but in that case we can know there's no point trying to send any
> requests to the device that's already gone.

Right, using pci_dev_is_disconnected() as a *speedup* when we
definitely know the device is gone, that's perfectly fine.

So in that sense the proposed patch is acceptable *after* this
series has been extended to make sure hard lockups can *never*
occur on unplug.

Thanks,

Lukas

