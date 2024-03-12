Return-Path: <linux-pci+bounces-4741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C467878F3F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE51C209D6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CBE6996C;
	Tue, 12 Mar 2024 07:51:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB6995B;
	Tue, 12 Mar 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229898; cv=none; b=fhgchgcyflu/OQukPZFncM6QdGY/RcSlUdk/Xlkx6d5sh2Nl1Wwuoj0VaOWsr2rcAmd4ZJyF6yb/INtK6ZJQPx1p7rasx/TNVLf1o8WJ3mPbr33wiOatRM7VI3VchVzKfevcqMPGBT8EqX5JS/GbInwoqEQuUiJZdSvDFL8ulQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229898; c=relaxed/simple;
	bh=PylpJHPi/9VZVZB/48DaTBqDjsV2m1sfhkn1ckM1BKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI1zVePloZMiuB/sL6Q/ksW6YJuckQHzNn2a17VUr2blDEn/6Tq0xKiRxMAERaW69LQ6cbM7fkie8SRcxn6DomiO4XGdBfSgCk84VPFKHhrJ91bUPHunqw9q2UNVSG4kCbFQus/KPeLIk/zhKkiZS+GLskjxrR3d9v/TdK6sO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 30376100D943E;
	Tue, 12 Mar 2024 08:46:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DCF4B48470; Tue, 12 Mar 2024 08:46:05 +0100 (CET)
Date: Tue, 12 Mar 2024 08:46:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH 0/3] PCI: Add Secondary Bus Reset (SBR) support for CXL
Message-ID: <ZfAIPSy8uih74ZkK@wunner.de>
References: <20240311204132.62757-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311204132.62757-1-dave.jiang@intel.com>

On Mon, Mar 11, 2024 at 01:39:52PM -0700, Dave Jiang wrote:
> Patch 1:
> Add check to PCI bus_reset path for CXL device and return with error if "Unmask
> SBR" bit is set to 0. This allows user to realize that SBR is masked for this
> CXL device. However, if the user sets the "Unmask SBR" bit via a tool such as
> setpci, then the bus_reset will proceed.

So is the point of patch 1 only to inform the user that the SBR has
no effect?  Or does the SBR have any negative side effects that you
want to avoid (e.g. due to the config space save/restore)?

If you only want to inform the user, then this functionality could
live in a ->reset_prepare() callback exposed by the cxl subsystem
and the pci subsystem wouldn't have to be touched at all.

Thanks,

Lukas

