Return-Path: <linux-pci+bounces-35135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759CB3C116
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1541D1CC0526
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69650334374;
	Fri, 29 Aug 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKeU1khi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F33314CC;
	Fri, 29 Aug 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485702; cv=none; b=GuDLSUdEXGuYCukrrXHONUlF/DeQsqlli7vYzct3jIvi3qKtoofzEGhnD8h3eSnXcdO5IVz2gPsoZh+TXxd//ZSUrDGi4jpAfRMYgTyUcmFlBY4KUqUuLv2ipw8JOhVu6kAwIfHWmw1gF2BgAizl0UYbxRYHVXKvm/JIKuU3lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485702; c=relaxed/simple;
	bh=relsKw9/OPOAajNcLPSs+4xD5qW1qyvZNMyRBzwhicU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bub0//xwla3HheuAHwzlHRMfhYrOCdaKcmwy/EKt9AR66m2zUFkBCWMb9DhpG07eI009t0eewOOyFhObjLfUiPS13Lot+wLo9eZ4twVS8leF3LMOddvnV4f6qW0h+We71uopqyjA/mCIONA48sBUmbURYt5n9/CrGjOz8+vQE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKeU1khi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D068C4CEF0;
	Fri, 29 Aug 2025 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485702;
	bh=relsKw9/OPOAajNcLPSs+4xD5qW1qyvZNMyRBzwhicU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKeU1khitz5yH3DPVFwxT3WGnwCYlMXqeDJ9W7TAKSUM/8fYV+8GqraCIqB+mayuG
	 GZatgcnFIdC4LOscP06HFLR7IOwl2VoLDBxF7xNEnbF0z+cnFx2gsCJbn8knq/24GA
	 7dvemSyOq+ZHtINsOIV9HeFIWwgvTCDlVkQ2u9gn5L8BuameAkSKWHwZVEAydevsgL
	 HEZDJswRaNv1bGQ7AfGSQfWlK34LFKPrAtBY66r2C/yhQDanLhbzELuXZ+Mh01k+IK
	 JfgqNXwBcP8K0A1RW2Jvl9VmNvQHTtIwHWRnQeb8VFGEr+Yn5aB63zHbgGq7W2DhEP
	 bUwk+1LSUlcNA==
Date: Fri, 29 Aug 2025 22:11:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 0/2] pci: endpoint: vntb: add MSI doorbell support
Message-ID: <6iodjcf36dp3zhpy3tphrn6a43jaenpos7vcroouseevyzmxub@y3orprye3lrw>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <aLHW5NWF3PVFo/xn@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLHW5NWF3PVFo/xn@lizhi-Precision-Tower-5810>

On Fri, Aug 29, 2025 at 12:35:48PM GMT, Frank Li wrote:
> On Fri, Aug 15, 2025 at 06:20:52PM -0400, Frank Li wrote:
> > Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
> > using platform MSI controller, PCI EP can get notification from Host.
> >
> > VNTB use this feature to reduce ping latency.
> >
> > The first patch impove epf core API to allow set any MMIO address to specfic
> > bar.
> >
> > The second patch add MSI doorbell support.
> 
> Manivannan Sadhasivam:
> 
> 	Do you have time to review this patch?
> 

Sorry for the delay. It is still in my review queue. Will get to it this
weekend.

- Mani

> Frank
> 
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Frank Li (2):
> >       PCI: endpoint: Enhance pci_epf_alloc_space() and rename to pci_epf_set_inbound_space()
> >       PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
> >
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
> >  drivers/pci/endpoint/pci-epf-core.c           |  69 +++++++++---
> >  include/linux/pci-epc.h                       |   5 -
> >  include/linux/pci-epf.h                       |  35 +++++-
> >  4 files changed, 223 insertions(+), 39 deletions(-)
> > ---
> > base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
> > change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >

-- 
மணிவண்ணன் சதாசிவம்

