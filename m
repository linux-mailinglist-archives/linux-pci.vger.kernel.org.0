Return-Path: <linux-pci+bounces-21976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB969A3F26B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1626D1897D3A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B71D7984;
	Fri, 21 Feb 2025 10:46:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178D1F19A;
	Fri, 21 Feb 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134769; cv=none; b=TF0preP0HyTUmUnQ7Bf5In4hXUUeItn/ZDIt7MXxC5CqUExA1r+QzX2UGwZKupDvB3UPcRr7fHmCCiAwscMyc7G6WC+/M2j8Wj5FGttwPWqpXsPKLQSv4CE/MgMGYoqqy0XmLC1yAGIupCMvrpEbgZzp/Uq/NIzBX4Vq7lDjaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134769; c=relaxed/simple;
	bh=v8AtOv9yRrRcR/XBsR5xx+iZx1hHStWBGkJpoYAJ4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6rPDPnE++N+7/QlAkrAPDGvtRMf9tWe+YVk7H6WkD2vnCAh60xWxLzI3ntxKDQoDkzOon9xeM3jsAKjR1WhcZijQWDfitz7hIthuOMtE+h9WuPbuPpaOGFxqqb//S9Z72LLfdIlh/tqeScMeGZzAbBqkC5vwWfcYHrF/N5ynbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 13A1F100D9438;
	Fri, 21 Feb 2025 11:45:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D7D9C4EAE82; Fri, 21 Feb 2025 11:45:56 +0100 (CET)
Date: Fri, 21 Feb 2025 11:45:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Message-ID: <Z7hZZNT5NHYncZ3c@wunner.de>
References: <20250221043906.1593189-1-smadhavan@nvidia.com>
 <20250221043906.1593189-3-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221043906.1593189-3-smadhavan@nvidia.com>

On Thu, Feb 20, 2025 at 08:39:06PM -0800, Srirangan Madhavan wrote:
> Type 2 devices are being introduced and will require finer-grained
> reset mechanisms beyond bus-wide reset methods.
> 
> Add support for CXL reset per CXL v3.2 Section 9.6/9.7
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++

drivers/pci/pci.c is basically a catch-all for anything that doesn't fit
in one of the other .c files in drivers/pci.  I'm slightly worried that
this (otherwise legitimate) patch increases the clutter in pci.c further,
rendering it unmaintainable in the long term.

At the very least, I'm wondering if this can be #ifdef'ed to
CONFIG_CXL_PCI?

One idea would be to move this newly added reset method, as well as the
existing cxl_reset_bus_function(), to a new drivers/pci/cxl.c file.

I guess moving it to drivers/cxl/ isn't an option because cxl can be
modular.

Another idea would be to move all the reset handling (which makes up
a significant portion of pci.c) to a separate drivers/pci/reset.c.
This might be beyond the scope of your patch, but in the interim,
maybe at least an #ifdef can be added because the PCI core is also
used e.g. on memory-constrained wifi routers which don't care about
CXL at all.

Thanks,

Lukas

