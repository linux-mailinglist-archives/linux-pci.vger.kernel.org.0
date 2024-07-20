Return-Path: <linux-pci+bounces-10565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65AC937FF5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79980B21214
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A1282FB;
	Sat, 20 Jul 2024 08:08:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84122F14;
	Sat, 20 Jul 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462922; cv=none; b=i2ZKMY00L2tqUkp0L2VNM/nJ0l8jZlx797Pi/0/WMtQjTQUIIup9aT9H8I9h9zBmkR/ds0TOD3pnEDEkXiJ8rMsPWuwbkb1k6qp6KbHdVeC1Unc3heHe9aW6H49v/7pgQIAJTswdUzsLCtVRjnIO154fstqP/peq17RL3Bc4IbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462922; c=relaxed/simple;
	bh=uJ4nfxr/PYV9M9WCplar+NquJmoPtx8qBsxRlGDXkjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyeU/3qB/Evsx84eqU1CRmxj8rQQLcYggqf6q8XhGuzSP/ENmIM3VOvAqOD6B67IuHU1wRiov2tpeJ12w8DJBNsDAgt72P7vRR+UUD+VWv+qqEqu+usKtZ4z6630qYM/mw5+woFMi3TQu6NXVuOQyAVsO7NHptFeXDdmYx4u1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 86CFA300002AE;
	Sat, 20 Jul 2024 10:08:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 70AA21C83D; Sat, 20 Jul 2024 10:08:28 +0200 (CEST)
Date: Sat, 20 Jul 2024 10:08:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, Paul Luse <paul.e.luse@intel.com>,
	Jing Liu <jing2.liu@intel.com>
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
Message-ID: <ZptwfEGaI1NNQYZf@wunner.de>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>

[cc += Paul Luse, Jing Liu]

On Wed, Jul 17, 2024 at 03:55:01PM -0500, Wei Huang wrote:
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices to
> provide optimization hints for requests that target memory space. These hints,
> in a format called steering tag (ST), are provided in the requester's TLP
> headers and allow the system hardware, including the Root Complex, to
> optimize the utilization of platform resources for the requests.
[...]
> This series introduces generic TPH support in Linux, allowing STs to be
> retrieved from ACPI _DSM (as defined by ACPI) and used by PCIe endpoint
> drivers as needed. As a demonstration, it includes an example usage in the
> Broadcom BNXT driver. When running on Broadcom NICs with the appropriate
> firmware, Cache Injection shows substantial memory bandwidth savings and
> better network bandwidth using real-world benchmarks. This solution is
> vendor-neutral, as both TPH and ACPI _DSM are industry standards.

I think you need to add support for saving and restoring TPH registers,
otherwise the changes you make to those registers may not survive
reset recovery or system sleep.  Granted, system sleep may not be
relevant for servers (which I assume you're targeting with your patches),
but reset recovery very much is.

Paul Luse submitted a patch two years ago to save and restore
TPH registers, perhaps you can include it in your patch set?

https://lore.kernel.org/all/20220712123641.2319-1-paul.e.luse@intel.com/

Bjorn left some comments on Paul's patch:

https://lore.kernel.org/all/20220912214516.GA538566@bhelgaas/

In particular, Bjorn asked for shared infrastructure to access
TPH registers (which you're adding in your patch set) and spotted
several nits (which should be easy to address).  So I think you may
be able to integrate Paul's patch into your series without too much
effort.

However note that when writing to TPH registers through the API you're
introducing, you also need to update the saved register state so that
those changes aren't lost upon a subsequent reset recovery.

Thanks,

Lukas

