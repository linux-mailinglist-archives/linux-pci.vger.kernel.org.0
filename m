Return-Path: <linux-pci+bounces-14564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE099F52F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675921F2357B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC41FC7DB;
	Tue, 15 Oct 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Uor/DIgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477F1F9ED1
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016755; cv=none; b=sfw01p3dBjXl5xGq0zSzghuPH/lMUYywnOgqK5hqLac53nZC2taGHO8Jj5qwejT/w6jlxCMtymKm8juWXzT9WUhimXQRLZKWK2zkef4FlbiWAcNC4QbYeHBN4urp5aXsPqxxsBtA+zlyHAPKbdJtYFFSbOJ+DpLjCGvJECsWDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016755; c=relaxed/simple;
	bh=R0s84NqC1UZXYoEqVYP6l9vP2t18BCvm9IHdNVwwJu8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=LiwRuutaabInGqteqCcQ7yzo0OueKYoKt8jZxelkE1kmZzVLg5HwOw0mSTQUqWr6gWCyB03JPRyo57gVl7O5ZyW5INWUGnWui5dk+4dqPfMPfjzMIAcyp747bDaj+cXOcP8aB2iqnIPyjvXfFZxrO139OIUjE+DoDqicj2BzjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Uor/DIgo; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BPeAYwyDZnaS1vv2XNPfZK8JukXiODb9mxxHVbQ3E+A=; b=Uor/DIgoky+qPE7WjyzQs2QUoh
	pa9jfeEf4hSn43vumap+WTU9ySIFIptUHHIxWmAlLdlpStg+fDuQH+fHD59TAKWfwIRMiaaDR0UEy
	SZi/IbQOCtG3ci3qvidmZ21tkTKkai5YP2+VflPwJXD1bzQb/XGCvlMEAFWx1RNpUTZ9yKXsOIIET
	5bTy5D7MvjTFakF++0jLxfFVZykpsVg76Pp33TQrPwRYplNcBsdno4AGEBnJvUHmAuBaVXIm99Av9
	JDIn/wXmWkSdmwUfmxI5TFK/LgK7rf1cmWN7+LQbaNff3J0jw4l2PXmNv7VkErw4Z5/6gNIZlAf/R
	RHYhzW5g==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t0lbb-00A8Kk-2E;
	Tue, 15 Oct 2024 11:45:13 -0600
Message-ID: <eddb423c-945f-40c9-b904-43ea8371f1c4@deltatee.com>
Date: Tue, 15 Oct 2024 11:45:09 -0600
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
References: <20241012024524.1377836-1-vivek.kasireddy@intel.com>
 <20241012024524.1377836-2-vivek.kasireddy@intel.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20241012024524.1377836-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v1 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)


On 2024-10-11 20:40, Vivek Kasireddy wrote:
> Functions of the same PCI device (such as a PF and a VF) share the
> same bus and have a common root port and typically, the PF provisions
> resources for the VF. Therefore, they can be considered compatible
> as far as P2P access is considered.
> 
> Currently, although the distance (2) is correctly calculated for
> functions of the same device, an ACS check failure prevents P2P DMA
> access between them. Therefore, introduce a small function named
> same_pci_device_functions() to determine if the provider and
> client belong to the same device and facilitate P2P DMA between
> them by not enforcing the ACS check.

I'm not totally opposed to this. But the current code was done this way
for a reason: we can't be sure that functions on any given device can
talk to each other. So this change may break if used with other devices
with multiple functions that can't talk to each other.

That being said, the only alternative I can think of is another list of
allowed devices. However, given the pain it's been maintaining allowed
root ports, I'm not very enthusiastic about creating another list of
allowed devices in the kernel.

Logan

