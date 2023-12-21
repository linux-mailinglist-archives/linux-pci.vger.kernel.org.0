Return-Path: <linux-pci+bounces-1263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D481B491
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C66285C70
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E096A02D;
	Thu, 21 Dec 2023 11:01:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278226A32D;
	Thu, 21 Dec 2023 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6D419101E3643;
	Thu, 21 Dec 2023 12:01:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 400BA4BB67; Thu, 21 Dec 2023 12:01:38 +0100 (CET)
Date: Thu, 21 Dec 2023 12:01:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
Message-ID: <20231221110138.GA27755@wunner.de>
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
 <20231220005153.3984502-3-haifeng.zhao@linux.intel.com>
 <20231221103940.GA12714@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221103940.GA12714@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 21, 2023 at 11:39:40AM +0100, Lukas Wunner wrote:
> On Tue, Dec 19, 2023 at 07:51:53PM -0500, Ethan Zhao wrote:
> > For those endpoint devices connect to system via hotplug capable ports,
> > users could request a warm reset to the device by flapping device's link
> > through setting the slot's link control register, as pciehpt_ist() DLLSC
> > interrupt sequence response, pciehp will unload the device driver and
> > then power it off. thus cause an IOMMU devTLB flush request for device to
> > be sent and a long time completion/timeout waiting in interrupt context.
> 
> I think the problem is in the "waiting in interrupt context".

I'm wondering whether Intel IOMMUs possibly have a (perhaps undocumented)
capability to reduce the Invalidate Completion Timeout to a sane value?
Could you check whether that's supported?

Granted, the Implementation Note you've pointed to allows 1 sec + 50%,
but that's not even a "must", it's a "should".  So devices are free to
take even longer.  We have to cut off at *some* point.

Thanks,

Lukas

