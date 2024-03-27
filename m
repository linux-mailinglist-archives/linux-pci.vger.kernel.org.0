Return-Path: <linux-pci+bounces-5270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4B88EB5A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9391C2BE21
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105313E3E8;
	Wed, 27 Mar 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKtoWiD7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67B1D524;
	Wed, 27 Mar 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557169; cv=none; b=msZmnRHdibeTy+4HkJNy8YC5RizrVVag3wX8BjpaMF8OEs2dNMR29OjDZPTmMOHErCCgvuUBIO6FgOj+p6HUQ8ZgMvRijt+k1SdhrQJQkTwxK8hkpy21dKt8QpfS/inEmgjeISuGW49ONHm4Lu7pxxdFkAJeeWQnumq5OClxiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557169; c=relaxed/simple;
	bh=K4I4rVAMidehsa7u5f2a+EfIeErs3yPg8kJvWfige4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y1V6nH2u827MrmWgsoR1cptui37LZBvMO3p24HtXbnkSjMEIK7PN+CsCpKC6AY8dBxgKOZxC0B5F4a+uBaMgxiM0Q0eeluWiJunBEopmULrxD5nP/yFzrTt0GBGLzFfWJf2wmtRgCy+cF44M+7qZVQC/Gi5rVDs1dIxsSJuC3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKtoWiD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE126C433C7;
	Wed, 27 Mar 2024 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711557169;
	bh=K4I4rVAMidehsa7u5f2a+EfIeErs3yPg8kJvWfige4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tKtoWiD73YPVPBvGaGKxhRfUrVy/XSY3CU9Rp1nwGZQhT0o+MCm3StVnlF1fX3xAG
	 L1xwhmEzZezGKx20sFzR9S7kv1XdnAHxB0mO1bhXY5GoWlpo+aa4//qiS1blgHSHCT
	 Jh+hQwY3H6XxZtb6vFonIOZInGCK+zxuNANEapNwONDSIZt3bVofL4OdjpXGG5Akif
	 WwL/oNv8MSCb9YhPA7UjD8w7GpswxE9lCLTKsWMY2hqRus9G2aGAbAEGS/qgPPFBlk
	 /UJMWOoaI4en2Wjj338CwXFSp4wYWm6In+Zgo7i01gm99LyYyOEzv6F63rqGhybGQq
	 K3tyrEqrlO51Q==
Date: Wed, 27 Mar 2024 11:32:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Message-ID: <20240327163247.GA1525799@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124232326.904316841@linutronix.de>

On Fri, Nov 25, 2022 at 12:26:29AM +0100, Thomas Gleixner wrote:
> IMS (Interrupt Message Store) is a new specification which allows
> implementation specific storage of MSI messages contrary to the
> strict standard specified MSI and MSI-X message stores.
> ...

> + * pci_create_ims_domain - Create a secondary IMS domain for a PCI device

> + * Return: True on success, false otherwise

> +bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
> +			   unsigned int hwsize, void *data)

pci_create_ims_domain() is exported for use by modules, but AFAICT,
there is no in-tree user of this yet.

I assume one is coming, but if there isn't one on the near horizon,
we could/should remove this for now.

Either way, I think "bool" is not the optimal return type because
"pci_create_ims_domain" doesn't lend itself to a "true/false" reading
and most interfaces that actually do something return 0 for success or
a negative errno, so this will look like the opposite in the caller.

I have similar comments about the following interfaces returning
"bool", but they are internal to the PCI core:

  bool pci_create_device_domain()
  bool pci_setup_msi_device_domain()
  bool pci_setup_msix_device_domain()

Bjorn

