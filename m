Return-Path: <linux-pci+bounces-1339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C381D8C1
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2981F21952
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC111FD2;
	Sun, 24 Dec 2023 10:47:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328220F9;
	Sun, 24 Dec 2023 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 42C042800B1D7;
	Sun, 24 Dec 2023 11:47:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 30CFF10A64; Sun, 24 Dec 2023 11:47:09 +0100 (CET)
Date: Sun, 24 Dec 2023 11:47:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 4/4] iommu/vt-d: break out devTLB invalidation if
 target device is gone
Message-ID: <20231224104709.GB31197@wunner.de>
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
 <20231224050657.182022-5-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224050657.182022-5-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Dec 24, 2023 at 12:06:57AM -0500, Ethan Zhao wrote:
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1423,6 +1423,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>  	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>  
>  	while (qi->desc_status[wait_index] != QI_DONE) {
> +		/*
> +		 * if the devTLB invalidation target device is gone, don't wait
> +		 * anymore, it might take up to 1min+50%, causes system hang.
> +		 */
> +		if (type == QI_DIOTLB_TYPE && iommu->flush_target_dev)
> +			if (!pci_device_is_present(to_pci_dev(iommu->flush_target_dev)))
> +				break;

As a general approach, this is much better now.

Please combine the nested if-clauses into one.

Please amend the code comment with a spec reference, i.e.
"(see Implementation Note in PCIe r6.1 sec 10.3.1)"
so that readers of the code know where the magic number "1min+50%"
is coming from.

Is flush_target_dev guaranteed to always be a pci_dev?

I'll let iommu maintainers comment on whether storing a flush_target_dev
pointer is the right approach.  (May store a back pointer from
struct intel_iommu to struct device_domain_info?)

Maybe move the "to_pci_dev(iommu->flush_target_dev)" lookup outside the
loop to avoid doing this over and over again?

I think we still have a problem here if the device is not removed
but simply takes a long time to respond to Invalidate Requests
(as it is permitted to do per the Implementation Note).  We'll
busy-wait for the completion and potentially run into the watchdog's
time limit again.  So I think you or someone else in your org should
add OKRs to refactor the code so that it sleeps in-between polling
for Invalidate Completions (instead of busy-waiting with interrupts
disabled).

Thanks,

Lukas

