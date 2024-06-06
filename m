Return-Path: <linux-pci+bounces-8400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCBE8FE7B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A6528816A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0E195F04;
	Thu,  6 Jun 2024 13:26:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE59193080;
	Thu,  6 Jun 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680403; cv=none; b=tNcKzt+yntsdzzQLC23pPy8glVGEzE5Z5KnL649AZRPo7r9HdXUfuFGSiY1MmCfoCjsA4xJVypDsFvWrPUUojiVefUi2CpU/b0DuxYgXZKxjGglBnYmRRxuXbJmQw3RBnGqCZfgMBAborxdCEnJawEy0GiGD+s0I3j4BVq9/uho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680403; c=relaxed/simple;
	bh=PJay4cZomYriBHZN2gRfCs5VYfX+Qcn2ic4chJUd5Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amQ99kZ0wsRaZB42xMHEsrRh8cTn5iLsxHq143bh9u5svibFaj1aOfSgVD+b88kg7BAlTRup8zlQurhWF0GhegKKsNSZQpMgCl9ItLCuFWhItooJ7L7gyLVn/hyzYBSWBUUvBoeKx1Zla2y3xhO82Gw8qVzznFbOaRrCWN7T6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 51618300034CC;
	Thu,  6 Jun 2024 15:21:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3F9A24D387A; Thu,  6 Jun 2024 15:21:02 +0200 (CEST)
Date: Thu, 6 Jun 2024 15:21:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, terry.bowman@amd.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register CXL
 PMUs (and aer)
Message-ID: <ZmG3vjD2sbCOPrM0@wunner.de>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
 <20240605180409.GA520888@bhelgaas>
 <20240605204428.00001cb2@Huawei.com>
 <20240605213910.00003034@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605213910.00003034@huawei.com>

On Thu, Jun 06, 2024 at 01:57:56PM +0100, Jonathan Cameron wrote:
> Or are you thinking we can make something like the following work
> (even when we can't do dynamic msix)?
> 
> Core bring up facilities and interrupt etc.  That includes bus master
> so msi/msix can be issued (which makes me nervous - putting aside other
> concerns as IIRC there are drivers where you have to be careful to
> tweak registers to ensure you don't get a storm of traffic when you
> hit bus master enable.
> 
> Specific driver may bind later - everything keeps running until 
> the specific driver calls pci_alloc_irq_vectors(), then we have to disable all
> interrupts for core managed services, change the number of vectors and
> then move them to wherever they end up before starting them again.
> We have to do the similar in the unwind path.

My recollection is that Thomas Gleixner has brought up dynamic MSI-X
allocation.  So if both the PCI core services as well as the driver
use MSI-X, there's no problem.

For MSI, one approach might be to reserve a certain number of vectors
in the core for later use by the driver.

Thanks,

Lukas

