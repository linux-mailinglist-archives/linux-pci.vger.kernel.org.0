Return-Path: <linux-pci+bounces-5563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8A8959E3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCDC282CB8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025541598F6;
	Tue,  2 Apr 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow5blX2E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB02AD1E;
	Tue,  2 Apr 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076126; cv=none; b=irb7G11ghkpSoCObUjZj0JONQFdb8pZHZdRHcpUStgggY0JtsswA3NWSkc8E2cu1j4ef9+wmKPSEkCl2UOjK/mg6BAXwKAwlUdRjAu7yhzo9MEMQEB7YTumz+olBtkrh1Ml8A/DRyCMyiv1l1xiQnZtVWm6NObvMjWkbq3YUVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076126; c=relaxed/simple;
	bh=xLl3PANjE+jumZuSKE0TaCE5Yku1ne7zWxY7dz03CYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pYXy9mVky/JC9YeyVHLwiNL7Z5VHpDH9H8i6fLI3tR79i345clvwBJD2iDk9OdQnVWsQV6+YsAewOBEcEPbdrJ2UA5kyAmkWEqrJK/XLoMX/251g2EV0g3v6njluPLHtnVABojEiKLQuBp7jxGSOBr0DNWAU+eARq8uzywNFi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow5blX2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FCEC433C7;
	Tue,  2 Apr 2024 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712076126;
	bh=xLl3PANjE+jumZuSKE0TaCE5Yku1ne7zWxY7dz03CYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ow5blX2EEjxUSwnM+bXTWrQlRpclXbppUii85Pc3VqSNZPacTaBLULVyvGQndkKCV
	 i5Vi/sjIMcmvKUNJOGusfQXJkYVUJb/Z0U/gDTn2Uk9XPmQxFht1qU/dnlgMl5t6lD
	 waBhnymuigTcGtwGTZ5TSlJ3WjA1acmODx3qQd3ARP4ENdcdLxii7SmfvzedJViYI8
	 Ys53M2xGuz6FpEEGwXzY0cfb8uiXSGuWT3e8DuErMdBfrNaZc/twJu+NIrfV0XmpdD
	 rXQPLIM6NrptklK7F6BYz6SZ4GeQ+SeZyxF742rLFTfoMscosNbhi+0Pv3i173qpSt
	 ROg4utgHwqiHQ==
Date: Tue, 2 Apr 2024 11:42:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/MSI: Remove IMS (Interrupt Message Store)
 support for now
Message-ID: <20240402164204.GA1809883@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DF6EF5910917DDB0EEAF8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Apr 02, 2024 at 02:45:50AM +0000, Tian, Kevin wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, April 2, 2024 7:23 AM
> > 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> > users yet.
> > 
> > Remove it for now.  We can add it back when a user comes along.
> > 
> > Bjorn Helgaas (3):
> >   Revert "PCI/MSI: Provide stubs for IMS functions"
> >   Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
> >   Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
> > 
> 
> What about the other IMS related commits which are also dead
> code after above are reverted?
> 
> fa5745aca1dc ("iommu/amd: Enable PCI/IMS")
> 810531a1af53 ("iommu/vt-d: Enable PCI/IMS")
> 6e24c8877329 ("x86/apic/msi: Enable PCI/IMS")
> e23d4192bf9b ("genirq/msi: Provide constants for PCI/IMS support")

Thanks, I didn't catch those; will add in a v2.

Also, sorry for inadvertently sending this in the middle of an
unrelated thread.  I copied --in-reply-to from my notes when I
shouldn't have.

Bjorn

