Return-Path: <linux-pci+bounces-20947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FAA2CCD1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F216CAD6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4731A8F79;
	Fri,  7 Feb 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SumRsikh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E919EEBF
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957273; cv=none; b=Q3COy1he7M/5CcxqqZOcxtyFnblgqDunqlCVOLH0kgg0KwgLY+xNiuP7JLPpzIfTIv8KGvvqtIaXMlSriqIBv9XfMbL1QVc3Hhuf7DLzOjZsZhrB4jRAJgLHILB0fsO5PyjTSVPonSsal0rnh5+dZsFJzRkU7Jjz8Hcj7Dgs6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957273; c=relaxed/simple;
	bh=hY6Zloh4mg7ZCNsjbeJ0HY1B9qv651w6ooNCAsuy9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfVY3lB+5zvkcJJwsg8cZ5xFJI/K4vJgtukdwvDyS2sT6WnUtj/fsxl4k+ULt/pPBKBhLHwvMDeOTJ+grdDTEJqyi3UyXEVy7FyVZZnEW2VW38H2VnEUdv8NGLYmWWNDBSp6g75dhi0N/cWJmL4K7q0BEKZ4U5qK+ECej7K+t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SumRsikh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e436c59113so21495776d6.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738957269; x=1739562069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4oAel342nYv5nBJe0AwxOmOsZherwYKX7ofeLtPQ0c=;
        b=SumRsikhI0AhtJmT+/ynpcaDr4MxquUujj0Z58+BysgwZy5/gQTy/yQJrLmc89hkl8
         JU2mO/402QKY8zBx1YzOZs/I/TA0CiNR0FPrXn4FcobOuhGrTCs2b1qMU9jbt8P5L2y3
         14qKVGQnt65GDvm153a2DctQGRQ1uTls4UGmSfrmah1ET2S2d7MaJcVYF19J+Olhhlnd
         6KGjrNhbp30urdjBEJKZ0bTZx2+2yy6Re+u7tIrNZ5PUJLGOPRSy1NbMTOuTS6fGiwYx
         q330Nw6QkuxEGd6Wm3IcXlHVDpUKzZk+kFHzT7SfAVvei9UJPaBOKp+v9CNSuJNpHhOD
         kPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957269; x=1739562069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4oAel342nYv5nBJe0AwxOmOsZherwYKX7ofeLtPQ0c=;
        b=nky29MNvEpSjNkuXptHFBSBMWM2TZRqtHEWCH6wMEJ6K0teYejfHJdSaNgh3Ik56Zx
         5f9CHpR2vas5GDVP4Keni2VjfuhKOof05+Kr/Bw4QkVZPNcdX9mi0ak3UzSq8il7W+KC
         SnyrohQhvCGX1jq/Cit/TCgoiGGFYJ8DU3F80qPC/vzhUgk0sxulRoaH3a7spRIWlaI/
         hMlCN18MUiLaAr37fMMUGu7cPd4av5vMZ8gmrH329nTYojlGF+8APRRT6rbSxrcyk6rY
         Tq3ymfBxyEHm5NZK3MjHEBdqbcIMAUA6/ZmjGRzZy72m4hFUlmTQHudUGjATi2WR/3x9
         ZSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL8glwb3is0bOhde1F0Af3c27xTYePMdOhbTsxRLPjQ4/4iIRVarjwpPabMnuoo4y73r46l2HUgus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia/mEbLpKET559/rriG9kx3g0QJaOEqrOCW+d8KOeiOBR1NvM
	8zTr4krTH3hMtm+yBAogBz1nK39XPieooxOKPD1YV5Xut7EiykacSqCigCXAjcM=
X-Gm-Gg: ASbGncsCtTxmVsHoxJN//HyAJMEvAUBzkRqDkftZyVVlyy5XE+tJpNpLVRyeMN8D8Vl
	3BQ369nrALXnBw+1cj6CVvKDUxjx/ZKi7KALcJ9jAVaDes9BhkHukeX4vlNoqbzEOVLpZrGhGhG
	kirx7ZiH+0kJwjxH+2MIWakGQZLN66A04q0vCo5kYuUnN02NzOAQGRoe0gVKy5B/+Hp295yM2Gx
	zFsnsqFs+36xoHCbpsgB37aL67HtldUTMbpLd+Zi5M2d1p261Itt7vVvebNX0OtPWiN6E4o/6KO
	eMMw7fcwbeiweNQlK4NQ5Zz3sITpUN1xI42OyQ85E3IUEsS1rhzwN22PwcMzxsItQZbnPXRVLg=
	=
X-Google-Smtp-Source: AGHT+IHaxpZee3sCSGfBDBfxwHempye2pj5zZfAfTlfZq36QNyZhbhDUkJdEyf8Z1mLKSaGiyhRixA==
X-Received: by 2002:ad4:576b:0:b0:6d4:3593:2def with SMTP id 6a1803df08f44-6e4455c246fmr61051826d6.5.1738957268471;
        Fri, 07 Feb 2025 11:41:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e445621334sm12230366d6.64.2025.02.07.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:41:07 -0800 (PST)
Date: Fri, 7 Feb 2025 14:41:05 -0500
From: Gregory Price <gourry@gourry.net>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <Z6Zh0faJrwxsVBLD@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
 <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>

On Fri, Feb 07, 2025 at 01:23:06PM -0600, Bowman, Terry wrote:
> 
> 
> On 2/7/2025 2:01 AM, Gregory Price wrote:
> > On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
> >> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> >> +{
> >> +	struct cxl_port *port;
> >> +
> >> +	if (!pdev)
> >> +		return NULL;
> >> +
> >> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> >> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> >> +		struct cxl_dport *dport;
> >> +		void __iomem *ras_base;
> >> +
> >> +		port = find_cxl_port(&pdev->dev, &dport);
> >> +		ras_base = dport ? dport->regs.ras : NULL;
> > I'm fairly certain dport can come back here uninitialized, you
> > probably want to put this inside the `if (port)` block and 
> > pre-initialize dport to NULL.
> Right, it can. NULL dport check here covers this, no?:
> 
> 		ras_base = dport ? dport->regs.ras : NULL;

dport can be garbage (whatever is on the stack) at this check because
nothing ever intializes it to NULL.

> 
> Terry
> 
> >> +		if (port)
> >> +			put_device(&port->dev);
> >> +		return ras_base;
> > You can probably even simplify this down to something like
> >
> > 		struct_cxl_dport *dport = NULL;
> >
> > 		port = find_cxl_port(&pdev->dev, &dport);
> > 		if (port)
> > 			put_device(&port->dev);
> >
> > 		return dport ? dport->regs.ras : NULL;
> >
> >
> > ~Gregory
> 

