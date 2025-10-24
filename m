Return-Path: <linux-pci+bounces-39240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B8C044DA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 06:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2650B3B7F9B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8F27EFE9;
	Fri, 24 Oct 2025 04:03:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9727A93C;
	Fri, 24 Oct 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278591; cv=none; b=GayaVDYy40ouqRoxp68Dpwnl5IKf4lzT/T81+y87IShMFVUcMYt+ih4W9mq2Bq7FYagR66RzwOVdSg9f6kxcrphGXj0BwftHqmGDOiDy51y/yEmHtOYQh/2QYdTwx1/Amjm8g9bmgIAaZvMmDYaeDWJ4sdcfY7KX5HUKY0KPANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278591; c=relaxed/simple;
	bh=nAHQFTDtDNSSjrWU9yMnE7nB0TC1qFVXUydRSxGKqL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTmXsZuH/jdxcSrvwGIKz/cRH4BYYUcg0yGnZAMiY2VuGm1JbBFqYc+cg73lcOFpaVCo8/MLpGDEjYSa+uD9eVcZorbdXVtUCEJpORsTqKW/VzqHt6qVY6pc9B3IIRXw/JNfr20FiQqsik0Qs4qJjUEkocasyh7ZmMEw5OcmhBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 258FA2C0163C;
	Fri, 24 Oct 2025 06:03:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 008A54A12; Fri, 24 Oct 2025 06:03:00 +0200 (CEST)
Date: Fri, 24 Oct 2025 06:03:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPr6dBDUUohRUzYg@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
 <aPoDbKebJD30NjKG@wunner.de>
 <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>
 <aPrvEZ3X4_tiD2Fh@wunner.de>
 <91cf33b4-7f67-4f3a-b095-e8f04d8c18e9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cf33b4-7f67-4f3a-b095-e8f04d8c18e9@linux.alibaba.com>

On Fri, Oct 24, 2025 at 11:38:10AM +0800, Shuai Xue wrote:
> The remaining question is whether it would make more sense to rename
> pcie_clear_device_status() to pci_clear_device_error_status() and refine
> its behavior by adding a mask specifically for bits 0 to 3. Here's an
> example of the proposed change:

I don't see much value in renaming the function.

However clearing only bits 0-3 makes sense.  PCIe r5.0 defined bit 6
as Emergency Power Reduction Detected with type RW1C in 2019.  The
last time we touched pcie_clear_device_status() was in 2018 with
ec752f5d54d7 and we've been clearing all bits since forever,
not foreseeing that new ones with type RW1C might be added later.

I suggest defining a new macro in include/uapi/linux/pci_regs.h
instead of using 0xf, say PCI_EXP_DEVSTA_ERR.  Then you don't
need the code comment because the code is self-explanatory.

Thanks,

Lukas

