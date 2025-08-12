Return-Path: <linux-pci+bounces-33863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3549B22B28
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553D818832C7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569102E9725;
	Tue, 12 Aug 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0cMKc2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C431274FC6;
	Tue, 12 Aug 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010193; cv=none; b=KPcI4jSbxmrM8GjVKHwhBAle/L+LOY5wHU/ZmH7RO7xh2AvV5iOFq7bRD0eu2e8bNDFE8eN8cvDSsrW2pN0ennAzgsW0lJLFuG5TFBY8qvp9CAIsulNzj2VdYqOV+wYD6VG67Gh8UOtXhwQtByO/BL7xAoc3feML7ZXCBsVIg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010193; c=relaxed/simple;
	bh=UKuqCyEgLnvgIIRxsYh7oEJjRyl6V42MwADrM0/ZGog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu4x2cXjxH+7jDKDBc0yBxXyn0putEtaM9zReinVzhzTzhe1E4NvCNZ9IIbn9CqymKr79kTw0GIgQ3IDvWT2dGh2paFhGSHZJHlhAYAb0H6oFxi8oBr/S3D90nArXy82ddiSIJtRqDZH2RdDHOdx8Kqo2UuQEcB9QVjgeZAT2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0cMKc2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1281CC4CEF0;
	Tue, 12 Aug 2025 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010192;
	bh=UKuqCyEgLnvgIIRxsYh7oEJjRyl6V42MwADrM0/ZGog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0cMKc2pTp3gYSKV+88F7qXc4YXgTAND6YV2DBzb3DPFWfAlu4jWKyYAIFsOnvdtJ
	 XRMKfd7xkuTPQNpKsKJAiz8d2L1q+ZFBVCPVzo3iIIMpb9P9lbynXheFeGWagw/sFm
	 M4dQteqxjKHuzc/Xl6XjtwBaews2MfS03CIPL8FTGM1ITXYfYy0BroZ9VhHp2/BhGb
	 nleug69klUzOUsvvcbvmtnBhRSA0kjf+QxUIsY8TCTEYCHKRpQFCYd6dP4AJcraXlq
	 kt1UesaL8nxpKCHIhZMZQZ8KRqlG7ktcRo4ootcOlTkKD+C0dvrkla+hxItFIN3dKq
	 aJTCUKqtvwxQA==
Date: Tue, 12 Aug 2025 08:49:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <aJtUjnuWr1S31jhX@kbusch-mbp>
References: <20250811053935.4049211-1-namcao@linutronix.de>
 <20250811224659.GA168102@bhelgaas>
 <20250812062715.X9TWWWh-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812062715.X9TWWWh-@linutronix.de>

On Tue, Aug 12, 2025 at 08:27:15AM +0200, Nam Cao wrote:
> On Mon, Aug 11, 2025 at 05:46:59PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 11, 2025 at 07:39:35AM +0200, Nam Cao wrote:
> > > Commit d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> > > added a WARN_ON sanity check that child devices support MSI-X, because VMD
> > > document says [1]:
> > > 
> > >     "Intel VMD only supports MSIx Interrupts from child devices and
> > >     therefore the BIOS must enable PCIe Hot Plug and MSIx interrups [sic]."
> > 
> > Can VMD tell the difference between an incoming MSI MWr transaction
> > and an MSI-X MWr?
> > 
> > I wonder if "MSIx" was meant to mean "VMD only supports MSI or MSI-X
> > interrupts, not INTx interrupts, from child devices"?
> 
> I don't know, sorry. I am hoping that the VMD maintainers can help us here.

The doc you linked is riddled with errors. The original vmd commit
message is more accurate: VMD domains support child devices with MSI and
MSI-x interrupts. The VMD device can't even tell the difference which
one the device is using. It just manipulates messages sent to the usual
APIC address 0xfeeXXXXX.

