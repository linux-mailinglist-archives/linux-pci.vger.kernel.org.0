Return-Path: <linux-pci+bounces-33235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E50B17113
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 14:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC863B1C52
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E832C08CF;
	Thu, 31 Jul 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pc0Ruz+Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADF2C08B0
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964541; cv=none; b=CqH6G60Jthdl1vHOQjH59jlVRDvNenqsKlZcpCZBmvCzfRDIsAlTbdxUVvVbR3j/NvFh1j8mFsQw5VXlx30Ah4sKUzDNGeMQZi2Gj3utj22oYpSc2DaqwqKXXOfPTH489iofNQcl75+gZJDgTL4Q0iXkOwmZ5wNbS6LWDvyKcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964541; c=relaxed/simple;
	bh=X+4QeaSFicbF3O5vX3PUSK7qVCr8plMhgP2gRhF3p+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx0E+MpbqQUkZ6BAf3TiTGP3fKuDFfqcUNUN6d8HbATo8VqnDN5QgWn/BF/PV9uifg6loo39/nxqF+tAdxo7Ek+RNjGamKwmE8y02ILMftHZ6dofcJNrprStTIduttpPohm+NS9DoA6W/MLSqlKD24gP5IOniHU3Z7RMqdRWybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pc0Ruz+Q; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab71ac933eso6923871cf.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2025 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964539; x=1754569339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1plMRIcW1Bcl6c/s/tE9fzsee7elDjFfonquyZ/HhM=;
        b=Pc0Ruz+QOm1sFbg3HZMcBFqvVzqm7XFlhULHymXu9AE90U5XEEX8IA7IofFEOxRtgF
         1KtolxwTgE+OjId2TjBvleon+q0ZH1S2FXbgdQuHZV1cTBEzkf0Fmp1+BEXZGQQa3AXF
         OZrePCjmNmVP/M/9gvrxvGg0imZZA6oJ4uZXAwsk4+2vqAmSl4hozkfMdOnM498X75ly
         t4lwzrXSuqP7nxHkW0h+PV5It5jF5I5+hhldVJgGcgsI7b7sXDvfp+/2uRMRRkg7bUGZ
         m89Yry3ZaDZzfjtsKqPxiyCVDZ/1PeCNlyFzdj0i6gr/3dK7bErUZRAx5wJ+2+7TjVlH
         v/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964539; x=1754569339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1plMRIcW1Bcl6c/s/tE9fzsee7elDjFfonquyZ/HhM=;
        b=tflLzh3L+TEMXDzQRXVJ9Ao/tLubsaeDr4PK7JYQSkxklL8r1oL3vTQw3FgeeGJGnx
         LsN6NQ99PFBqDWndeJnH4gBJQQPCnaPGl3WSVf7Q6ifMw+VCHgtcBgojCmL6on3354tZ
         nP+K4emjZCK6DghgNlk8/R8pTgOnqwaTIzFFg3PTmTpQJ6NvAd4JiW+iKDl/RyIar6q6
         bImLj8oGn5nNP+IneQ5S12U5yX6Yfpi6yOYEn7kxrL7BoIXN9d+y72a5T07CX4WPPw8O
         4+LWPyvVOTyPu+uxxhBBjPIQIN6rRM6xP6a24rYc0jNB7sxrpO9YTlUo40obNIW7k3Ba
         q4dg==
X-Forwarded-Encrypted: i=1; AJvYcCV1EGrB0yi7x0MQL0AFFY2GfbQnFXtAKeTZIxATCWVrtCD7pxYYBlf9qAhwJ88fywk/HLbBhSmU7Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPPkaqRBum1S0yx+qm7h5DCDX17tVIcCOaW1DpDfj0vOGY+JV
	2kvb5nawRyu4i0OR6hNziKCpedadNSeQZdkhGYPnpRa9FgnZYT1sCOCFd95TeWGYbrA=
X-Gm-Gg: ASbGnctDAtTlf5SoF0trZuoGXns7x8AbN/qcImmFWDilzk6pWflO4FkEeKT9nKKTD/v
	MNGPPjdt+mVNBE2E90E+kJIuJVBOxpojltFbGBYS3wa/t1tDPSRZi26NEo4ekUibLIh+JkC+0ki
	+cOVfbi58d3SkAQoW+aPu9IcXpB7yCXo+8V5og2mmjRySJrCDuWzEuoUpPv1HyryPsZhOcui2Gh
	t1L+3ctBqamwsnPJm7kCgTmetASB1XDl4CsCZy8r9jWPdIn26HhCfuVFwtI7YOGD+1sP9OFOJmi
	4AHAPWbu5n1u4x+90vqL8BycvUNh8gZ0D3C4e5sAp1MkQQIYSx9RmwMAYrWV6i95CGBCH+VRMtM
	JH/GpWFAV0rLuVADObbsoQplsA8lfeHKh+7ONniG8QV4UrrRUZbGAki8zJB6j+o6ApQVh
X-Google-Smtp-Source: AGHT+IEG9A1JcQH+wdTVAVeKvLLO9IN7xUQV2FzilQVc+xKe0AMZGYYJKSglwslI/+w6Csl5DatYZg==
X-Received: by 2002:a05:622a:ca:b0:4a8:19d5:f8a5 with SMTP id d75a77b69052e-4aedbc45df3mr101058131cf.35.1753964538758;
        Thu, 31 Jul 2025 05:22:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeec0a6dasm7661341cf.24.2025.07.31.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:22:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSIb-00000000oYE-2zpl;
	Thu, 31 Jul 2025 09:22:17 -0300
Date: Thu, 31 Jul 2025 09:22:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250731122217.GR26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
 <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>

On Wed, Jul 30, 2025 at 02:55:02PM +0800, Xu Yilun wrote:
> On Tue, Jul 29, 2025 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > 
> > > > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > > >
> > > > Why would we need this?
> > > >
> > > > I can sort of understand why Intel would need it due to their issues
> > > > with MCE, but ARM shouldn't care either way, should it?
> > > >
> > > > But also why is it an iommufd option? That doesn't seem right..
> > > >
> > > > Jason
> > > 
> > > This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com
> > 
> > I suggested a global option, this is a per-device option, and that
> > especially seems wrong for iommufd. If it is per-device that is vfio,
> 
> I think this should be per-device.

IMHO there is no use case for that, it should arguably be global to
the whole kernel.

> The original purpose of this pci_region_request_*() is to prevent
> further mmap/read/write against a vfio_cdev FD which would be used

No way, the VFIO internal mmap should be controled by VFIO not by
request region. If you want to block that it should be blocked by
iommufd telling VFIO that the device is bound which revokes the
mmaps/dmabufs/etc and prevents opening new ones.

The only thing request region should do is prevent /sys/../resource,
/dev/mem users and so on, which is why it can and should be
global. Arguably VFIO should always block those things but
historically hasn't..

There should only be one request region call in VFIO, it should
ideally happen when the VFIO driver probes the device.

Jason

