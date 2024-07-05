Return-Path: <linux-pci+bounces-9845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08287928A64
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789B1B21CC0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5E14A62E;
	Fri,  5 Jul 2024 14:08:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB916B391
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188484; cv=none; b=sSco6AeqW5kAHatUr1nz60z8TpjisROiIINrSyYCjsL2NhpcT1ADpV3qTdiftWwSrZDtZi4oIdtRCdvZwBaN2XnuzFYP0NDSiqiRQE7HmZzeE4GpYpYeZyBd5xkj2Ccx5cbnvEmZsWEC5sD0PjHjRF1vlmCXp42y/SxX/q6VGsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188484; c=relaxed/simple;
	bh=2+izzrW4Pdbai2Zmpch8ReThf++g+EgldVC4No5lC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb6/k/8JHgYn+oRTHgoSr3+hkmmJF63MJCvFcJiC73FDT38WkDq47cv6XcK4n8b4sdljssXqdjV1UR2e0UorhEmqfD3F6jxs9460QJJ/eQguXO75Xx05T7ayGONwfq6J68YZiiiOLgcAYOWix+4f/wRQGEM5C478/cEBDmLMwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A241C300002D0;
	Fri,  5 Jul 2024 16:07:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7231632FD7; Fri,  5 Jul 2024 16:07:59 +0200 (CEST)
Date: Fri, 5 Jul 2024 16:07:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Message-ID: <Zof-P7jNmoLvJTF-@wunner.de>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-4-mariusz.tkaczyk@linux.intel.com>
 <ZofvZyzIe_7tH6zZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZofvZyzIe_7tH6zZ@infradead.org>

On Fri, Jul 05, 2024 at 06:04:39AM -0700, Christoph Hellwig wrote:
> > +struct dsm_output {
> > +	u16 status;
> > +	u8 function_specific_err;
> > +	u8 vendor_specific_err;
> > +	u32 state;
> > +} __packed;
> 
> This structure is naturally aligned, so no need for the __packed.

Isn't the compiler free to insert padding wherever it sees fit?

structs passed to ACPI firmware would no longer comply with the
spec-prescribed layout then and declaring them __packed seems to be
the only way to ensure that doesn't happen.

Thanks,

Lukas

