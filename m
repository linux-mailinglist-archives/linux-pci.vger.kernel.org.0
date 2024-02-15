Return-Path: <linux-pci+bounces-3560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE98857082
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295041C21874
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C801419A2;
	Thu, 15 Feb 2024 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxPn0pvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7851419A1;
	Thu, 15 Feb 2024 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036015; cv=none; b=M+q4qsQ9Fde5FUhAKosFERujvSErQEw3+lly+opAxJGU9zofsl8/8b9kmUBVSKdZoMaIsHsQNvznLcvAizNrtPXz130O6iQH3AYwevUKauTBMBOQ00TM3e9jl17gc3uNmXOTwbiBX5dRg2/ju7eOsVKxSNAwFVrrTyNmc+y/xvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036015; c=relaxed/simple;
	bh=ToW0bbGPh8qClTuUuVS5iQH5gOfGTw8X6iCGDZ9zDLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=og2goBsmYZbYMlb4ABz3E66G1r4/iMA0ovLrdJ14RVMB0iBAoRgoAyNdkVyRbgwvZvh+I7CCpvxwaw9f30hwTYCx/5mEf3aFhLe5b1IxJYe/vyjOjImQJ6fd7YBQzdr7U5g5SMnx43gEpWMc6pRqkkP3RsvR4MYidYDxHGDFUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxPn0pvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC653C433F1;
	Thu, 15 Feb 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036014;
	bh=ToW0bbGPh8qClTuUuVS5iQH5gOfGTw8X6iCGDZ9zDLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PxPn0pvq1965FRhRgADTNfDYHPt4zGcSyj4mlBOpelyhTGSz+0sQXAx1ZUzq4oyeI
	 aATJ2Q/86xk9LCCMPkQuj0kC9m0w0mZFqHmOR4Fj1qs7fVIB3oMS7IUAw6ribndbU1
	 3j75Gvw96cEf881p2ADJ20C2Dnuyws6LYB53RRputM9nGsmcDcU1ILeJ52w62qRrhh
	 arAT+XEDPIA6ADPRiQTRBD791IG88Iz1PA46FClkQQd0XIkywh2/tqrAq8wBmz7Oie
	 o5mqvPtWNXwnZclfvV+/TyEcT5BANhml61cckxY4uY/I6sDVyQNSTClwDzWL7+Z+o8
	 bSt4ob1lZfY3g==
Date: Thu, 15 Feb 2024 16:26:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 2/6] pcie/cxl_timeout: Add CXL Timeout & Isolation
 service driver
Message-ID: <20240215222653.GA1312722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd6b12e-e5ba-48a1-8d01-4c886441f314@amd.com>

On Thu, Feb 15, 2024 at 04:21:42PM -0600, Ben Cheatham wrote:
> On 2/15/24 3:13 PM, Bjorn Helgaas wrote:

> >> +	rc = cxl_enable_timeout(dev, cxlt);
> >> +	if (rc)
> >> +		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
> >> +			rc);
> > 
> > "(%pe)" (similar in subsequent patches)
> > 
> 
> I wasn't aware of that, I'll change it.

I wasn't either, but I'm getting patches to change them, and it does
seem a little bit easier than looking up the errnos when debugging,
so ...

