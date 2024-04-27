Return-Path: <linux-pci+bounces-6720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61D8B4480
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 08:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873EB283434
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94D3D575;
	Sat, 27 Apr 2024 06:20:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16283BBF8;
	Sat, 27 Apr 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714198808; cv=none; b=n2DFqbDRfASd6iUCPYNOfkAdmm6s+mEw34gP38EwDZexb0Ofz2MTCt2uxWomyBU0tlLDwjiWsBNmeCp+jOUYzqgH0gLbzraspFYKWpvogBgfQO0ABaYKJPfuFt5QCRu57L/cHtI1oMfOBmI8XeXZJO5rJROEFwxmfxMWfuNHBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714198808; c=relaxed/simple;
	bh=/xJEAhZH0Zk2g9NfWsGaNADXVhIjlC0gvs1hSvu7Q70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TshSk2fGe0/jzKzyVOloYcBJd3xblVSvIWAGEdeAO/f59L+/lb3IRE3/mmANC9QC0cOX2pFbEG48ECBJRETkAx77FCbO2UjcUOQGv3nR5tS3B9MQoP+9ofUXk0t+eZ6kch6jMfYlwmEEq58XM3aLZGzYhhOz+GCmG2RdpUoLOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B4E7D28010383;
	Sat, 27 Apr 2024 08:19:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 81E317EB19; Sat, 27 Apr 2024 08:19:56 +0200 (CEST)
Date: Sat, 27 Apr 2024 08:19:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH v4 3/4] PCI: Create new reset method to force SBR for CXL
Message-ID: <ZiyZDKSxtfeYi0N4@wunner.de>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-4-dave.jiang@intel.com>
 <662c04a5d8f5f_b6e02945f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662c04a5d8f5f_b6e02945f@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Apr 26, 2024 at 12:46:45PM -0700, Dan Williams wrote:
> This also highlights that the pci_dev_lock() performed by
> pci_reset_function() has long been insufficient for the
> pci_reset_bus_function() method case that could race userspace when
> pci_reset_secondary_bus() is manipulating the bridge control register.
> 
> So, if the goal of the lock is to prevent userspace from clobbering the
> kernel's read-modify-write cycles of @dev's parent bridge, then the lock
> needs to be held over both the cxl_reset_bus_function() and the
> pci_reset_bus_function() cases, and it needs to be taken in
> upstream-bridge => endpoint order.

No, the device lock is taken to prevent the driver from unbinding.
It has nothing to do with protecting RMW of parent bridge registers.

Here's Christoph Hellwig's explanation why he introduced acquisition
of the device lock in the PCI reset code paths:

https://lore.kernel.org/all/20200325104018.GA30853@lst.de/

TL;DR:  The PCI core calls the driver's ->reset_prepare and ->reset_done
callbacks and the driver needs to be held in place for that.

Thanks,

Lukas

