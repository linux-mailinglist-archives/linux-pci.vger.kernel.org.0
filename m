Return-Path: <linux-pci+bounces-28116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89BDABDDAC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10EC7B7723
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3A248166;
	Tue, 20 May 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbAGlZCM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C322C325;
	Tue, 20 May 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752386; cv=none; b=CB2r8lxiFenBqF42IKDh1l95G8Z6VM4h3bKSo4V5K0+kCCni5DlX9K8h3WvV3qabaxAhXIOl6ltvM9N4LabOvaHjZcZUA+9nU/EKdBX/jGwV3gGGEZmxpJmVru9PBKdz49S0+GeWlE0IDo+A6dwzDHW3RhAzffW3GVHy83j3SZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752386; c=relaxed/simple;
	bh=D3BgGUTiNzhwhjt2hSgNLPPTF85OQ9P1ypBTejbHZko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Syh+mm7CFf4gd5XEW/Kw3tr+NIAX/Lk4kpqLh4JuklBiB/5xbQ5AV/VER/jR83Ra28mwcwuy5mvlv9hct2y51dPifxY/b+GkhCf7TlE+L66BSpf44fk2E0fAhLVxwaJs698zxGPV+FIBNVb3CNTGgywCn3d8VcKLBUPhJWc20jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbAGlZCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240EAC4CEE9;
	Tue, 20 May 2025 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747752386;
	bh=D3BgGUTiNzhwhjt2hSgNLPPTF85OQ9P1ypBTejbHZko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RbAGlZCMWMkCSMaJRdAvBd/1tz6DyKGqPI+HR8PNwAlqGvYbYQUv4xtNLM53Uk1xV
	 6CFYXFEI30lzpJjTqi5EW6IIopse+lmMWkypA3qypP8BuLqIPGEoOEhFuZqWrHAFh9
	 oqMWHpk5DD+G8V8UdvGIZan8eC32I9aOf6S3V3x7LeqzMZfUXbrUwi2Bx9g5VYPy2o
	 VsSHa65ox0b0gp8WJW7DjQ34g1VYwCWAijh0Jh7DDd6CRcXujCCiqSCulJGGWHN2K9
	 FpTOprqOcX5KAfT9OCrGkFDkci3Wpwp8J7nVUOVMz/vIsE8LuS+wbbQpymEByNIY4X
	 kw9XV4zsJwcUQ==
Date: Tue, 20 May 2025 09:46:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Weinan Liu <wnliu@google.com>
Cc: Jonathan.Cameron@huawei.com, anilagrawal@meta.com,
	ben.fuller@oracle.com, bhelgaas@google.com, dave.jiang@intel.com,
	drewwalton@microsoft.com, ilpo.jarvinen@linux.intel.com,
	kaihengf@nvidia.com, karolina.stolarek@oracle.com,
	kbusch@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de, mahesh@linux.ibm.com, martin.petersen@oracle.com,
	oohall@gmail.com, pandoh@google.com, paulmck@kernel.org,
	rrichter@amd.com, sargun@meta.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com,
	terry.bowman@amd.com, tony.luck@intel.com
Subject: Re: [PATCH v6 11/16] PCI/AER: Check log level once and remember it
Message-ID: <20250520144624.GA1299876@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519231728.2550572-1-wnliu@google.com>

On Mon, May 19, 2025 at 11:17:28PM +0000, Weinan Liu wrote:
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index 315bf2bfd570..34af0ea45c0d 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -252,6 +252,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >   else
> >   info->severity = AER_NONFATAL;
> >
> > + info->level = KERN_WARNING;
> >  return 1;
> > }
> 
> I think the print level should be KERN_ERR for uncorrectable errors.

Yes, thank you, fixed!  dpc_get_aer_uncorrect_severity() always sets
info->severity to AER_FATAL or AER_NONFATAL, and aer_print_error()
only uses KERN_WARNING for AER_CORRECTABLE.

