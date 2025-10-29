Return-Path: <linux-pci+bounces-39628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F259EC19E62
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 882334E1B0B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB62DBF73;
	Wed, 29 Oct 2025 10:54:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6830ACFD
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735240; cv=none; b=O89AA5FyNPBk48jTQnQZAGb5j3H7B3ryQO7bL6W0yX/KF50vdnAWm+qpzVfazkcR6+ysVXhLLVZhWyrMYRVUf9RV60V5+noTRKVYoFHQiyPodg8d4bvW4h1lcju0L/W4OqZvMU0zezPYGzpFRLVyIL7lb81g0nas5PtK2sStW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735240; c=relaxed/simple;
	bh=NGdHvcmff9+MsPmVWha4DMQbwfZzn5wP1Cb90wCQ7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgr5guEaBwJ+fljaG+AJ2OmHAij/nyHnYXManiPRYw9RSyTvC9gPpqLN/rFYc/Vi5m3HOiMqiaTbd89qAcDB30p7PyHAZO8QPHztgJZoqjC1MS5kwy8fAxjCGrpcG3UKS3jtK0mFm2zW3S1y3tTKyG1MjssUUj46tFDLwhT4rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0BC652C06642;
	Wed, 29 Oct 2025 11:53:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EA87F4759; Wed, 29 Oct 2025 11:53:49 +0100 (CET)
Date: Wed, 29 Oct 2025 11:53:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <aQHyPWYNSVTeOdYs@wunner.de>
References: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>
 <20251028170639.GA1518773@bhelgaas>
 <20251029053354.GV2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029053354.GV2912318@black.igk.intel.com>

On Wed, Oct 29, 2025 at 06:33:54AM +0100, Mika Westerberg wrote:
> On Tue, Oct 28, 2025 at 12:06:39PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 28, 2025 at 07:04:27AM +0100, Mika Westerberg wrote:
> > > @@ -125,7 +140,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> > >  {
> > >  	u16 ptm = dev->ptm_cap;
> > >  	struct pci_dev *ups;
> > > -	u32 ctrl;
> > > +	u32 cap, ctrl;
> > >  
> > >  	if (!ptm)
> > >  		return -EINVAL;
> > > @@ -144,6 +159,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > +	/*
> > > +	 * PCIe Endpoint must declare Requester Capable before we can
> > > +	 * enable PTM for it.
> > > +	 */
> > > +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> > > +	if (!(cap & PCI_PTM_CAP_REQ))
> > > +		return -EINVAL;
> > 
> > Isn't this going to prevent enabling PTM on Root Ports?
> 
> Isn't this function called only for Endpoints? Root Ports and Switch Ports
> are enabled in pci_ptm_init() instead.

The function is also called for Root Ports:

  pci_ptm_init()
    pci_enable_ptm()
      __pci_enable_ptm()

So I guess you need to constrain this to:

  PCI_EXP_TYPE_ENDPOINT
  PCI_EXP_TYPE_LEG_END

Sorry for missing that during review!

Lukas

