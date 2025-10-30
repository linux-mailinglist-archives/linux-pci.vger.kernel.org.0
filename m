Return-Path: <linux-pci+bounces-39856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382FC226F2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747861890139
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA62F4A0A;
	Thu, 30 Oct 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4FPjt9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDE13C3F2;
	Thu, 30 Oct 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860239; cv=none; b=DlFtMQWnFofS0ij5sVEdf7BPGWYmfJDgWJgPajf2VJLEsIuokgiQ5l7EjwtIRTVrBqEMBBNJuq3Hg74Crbqd9kwsn5zdDDcXKk7HD+WoQi7KVUk6fNaamWr338Zy6vI8ETTnljzKRvB0gg/m8wex3P3dz9j0oVYkEuK/yf5WDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860239; c=relaxed/simple;
	bh=RQV8VsAwL7GfMPOHPWtG6Cbipfky+OsqKk5IlhozZ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K6TzVb4JCk/1f75/U9SU8eXfPfdinwHl3Qz7QOGu2mzBL+QDRBjQX63c+jcGsGmSPbZ5yY2SE7LlRA571LBGBtNmAJXYxU3TTKsf7bZQP7EwcqE5LVXqdtIjP6ui908ykvCmJoo3FkkwETNezNLr+gEOu8s5VDMhll7rbOVbREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4FPjt9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6E0C4CEF1;
	Thu, 30 Oct 2025 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761860239;
	bh=RQV8VsAwL7GfMPOHPWtG6Cbipfky+OsqKk5IlhozZ/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F4FPjt9IEmkD/xGhe0hqbA/f608IkEK1jPLTFEjtth+M11qMV6vXr1d9jNIE8Inq2
	 BS30ZLu9a9yjHSxTnf+G/h29aJ7gRNEUDq10k9WxHdEyFRuBCDyRefVMS4O6pc2c9q
	 EW6SC+3v8B3GDO1T3dan2Fmgs82xQ0uGn1Z7NwBmlzp2mPrPvO1y/DzvZF2rW/rexJ
	 hrvWqJdoNNWB011CoKhxNwmtLt5zsFfAJqMgIQ0nA4Ltja1duGbldPLcLPOOPhUhkX
	 qY5c/OfnszNV+Hczoi3wSc4gCqSPon1XU2nl5LO3MqU9pquSizT/rOlz9FRY+KMuSU
	 IfAzT9CxeQtSQ==
Date: Thu, 30 Oct 2025 16:37:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org, bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20251030213717.GA1653974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74738e82-5861-4ac8-8e96-c98a22173afa@amd.com>

On Thu, Oct 30, 2025 at 11:59:30AM +1100, Alexey Kardashevskiy wrote:
> On 24/10/25 13:04, Dan Williams wrote:
> > Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> > 7.9.26 IDE Extended Capability".
> ...

> > +#define PCI_IDE_CAP			0x04
> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> > +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
> > +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> 
> Since you are referring to PCIe r7.0 (instead of my proposal to use
> r6.1 ;) ), it has XT now here and in the stream control registers.

I haven't been following this, but is there an advantage to referring
to r6.1 instead of r7.0?  I assume newer revisions of the spec only
add useful things and don't remove anything.

