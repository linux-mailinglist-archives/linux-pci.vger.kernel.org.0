Return-Path: <linux-pci+bounces-36180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25634B5819C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B873BA2CA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77E2566E2;
	Mon, 15 Sep 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WwuuRcgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B824E01D
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952291; cv=none; b=JkKjDtDFbqh1tsu5xIaIjgqxZRIo6jiG1Z/Kqsj5Tj4Nx+F1ZYhQ8ukm0QgG6b62MFxKHxnFuqSTLRT4Yr5EIYBRX2hvoqZxFvruyAukx58w7t8KTjhhZG2fO99uWTTK5bYA7Nv0BZtJFGpoYaQONMx+kKav9UzVqR76Wmn9ZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952291; c=relaxed/simple;
	bh=qZak0IWjTFvTEZDlBi5GLG7k8WDKzZb2UcXYudM6lak=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=UjSD4IYuVgnyywsY8GbfOluVK2tRu1S5AjBK4kZLNe71irAqQ5q4ceDzPe9BrJpl/SCes4nBkTYLY52e0tXlXu64FjQ1RfNlqfqUc90km23lCWKHxSqVo723AklDbEYyjRnxOtMtfGccz9WrKwvKHQ7Ccm945/kcIRKtnjOpnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=WwuuRcgj; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ct6Q6jd9bg2f3Yaega2w/3bt4lVQ8RUfwQj2iLKeA0k=; b=WwuuRcgjKBfqMAdgftjSrkdCkd
	E98/p++osXW2XuK5DOyzTWeE+Id+csr7dnCOVTrW+zFjN0Zu0iPuuMWA8/wXxnNULDNJMe0oFmllW
	cHxMDutsK1cIl9fCp8UU4DvJhE9X93FfzSZn8bqda2lzpUH2EEfzCjiL5YLIpCbpR0yxtXJN+B1kO
	npoljLq5CyW84ZgE25L6yyivVlJ6qyPj7JiE0B8pl/gkXm5W7DMETtZp7AduSvCFm5rXQ2YmZwQaS
	LqGLFU4FB55rvQgSQWnc/umArpQUfxB4PI5PQGtACojtsQiUffX7029YRu6kf9RiXlmmDZPlGqjen
	L2YESB+A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uyBCk-005CIr-1L;
	Mon, 15 Sep 2025 09:33:22 -0600
Message-ID: <7cb11157-4b77-407d-ac48-7e75dc01a7a3@deltatee.com>
Date: Mon, 15 Sep 2025 09:33:19 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20250915072428.1712837-1-vivek.kasireddy@intel.com>
 <20250915072428.1712837-2-vivek.kasireddy@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250915072428.1712837-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-09-15 01:21, Vivek Kasireddy wrote:
> Typically, functions of the same PCI device (such as a PF and a VF)
> share the same bus and have a common root port and the PF provisions
> resources for the VF. Given this model, they can be considered
> compatible as far as P2PDMA access is considered.
> 
> Currently, although the distance (2) is correctly calculated for
> functions of the same device, an ACS check failure prevents P2P DMA
> access between them. Therefore, introduce a small function named
> pci_devfns_support_p2pdma() to determine if the provider and client
> belong to the same device and facilitate P2PDMA between them by
> not enforcing the ACS check.
> 
> However, since it is hard to determine if the device functions of
> any given PCI device are P2PDMA compatible, we only relax the ACS
> check enforcement for device functions of Intel GPUs. This is
> because the P2PDMA communication between the PF and VF of Intel
> GPUs is handled internally and does not typically involve the PCIe
> fabric.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: <linux-pci@vger.kernel.org>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

This looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


