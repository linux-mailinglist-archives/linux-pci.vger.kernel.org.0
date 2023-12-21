Return-Path: <linux-pci+bounces-1259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBA81B412
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43751287598
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A368EA0;
	Thu, 21 Dec 2023 10:43:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7D697A5;
	Thu, 21 Dec 2023 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 65770101DD8A5;
	Thu, 21 Dec 2023 11:42:54 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 298141782A; Thu, 21 Dec 2023 11:42:54 +0100 (CET)
Date: Thu, 21 Dec 2023 11:42:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org, will@kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231221104254.GB12714@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 13, 2023 at 11:54:05AM +0000, Robin Murphy wrote:
> I think if we want to ensure ATCs are invalidated on hot-unplug we need an
> additional pre-removal notifier to take care of that, and that step would
> then want to distinguish between an orderly removal where cleaning up is
> somewhat meaningful, and a surprise removal where it definitely isn't.

Even if a user starts the process for orderly removal, the device may be
surprise-removed *during* that process.  So we cannot assume that the
device is actually accessible if orderly removal has been initiated.
If the form factor supports surprise removal, the device may be gone
at any time.

Thanks,

Lukas

