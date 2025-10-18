Return-Path: <linux-pci+bounces-38641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297FBEDCB1
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 00:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43C02348425
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC025C6F1;
	Sat, 18 Oct 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAbNi8cy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393002135C5
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760827996; cv=none; b=t/LsN8XVhKt2kM9BVX3zt2kDNnwo/1Xl2Y1CidlUNws+5nbry5ibZYFOyT/yqjzTJ3c9keqDE3oFEAh6YT+X+5JbzZzzS9HJunuo4ny0EF3w3I0gcTmQGfoRLon7jFkLbWrpJTWmGQdTu9hmu0MrpYQRX+TQhCya0E84Daf/pFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760827996; c=relaxed/simple;
	bh=7qLVYcdBi8bpEpnS4F0eADPD2Bf5b4Eo3btCpBmFKVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiuccKdIhRB9RM7PqizTIsoYOcJcbY4OoS50WwRoHcOkIbrB4Bn1oHwUyGz4C2v0SpFpJWBLbvCV15IcNbxn+ttffggSXLAWDeHph47OfCpCVo2+JG7pMgii0NCyqiG0Q2YD0EetY39Mhm1JdNwZgLuXk2T1xpEx3nkpd6knfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAbNi8cy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290da96b37fso129595ad.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760827994; x=1761432794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExoVcTIek9AdjVCMkiYpZILDA0YvBh98/+0VTxUThlI=;
        b=UAbNi8cyjQbjrZyXCTT4a8vAp+AHgWvBfwiir9ZAZjgl1sA3IJj/GvQI3uf8xKsIXM
         lwL8tt0xwwordOaFzkyxegDoovfaXTshVMyFD8oWeZmVLtDhik0U2lcIRq15Dr/LejDq
         snj12IfKQSWfdL5LKVfhXhLE/kAbt6tqzMtOijBiv3pOIeAk0QfXKjmaWBI2Tepg3QFy
         MNxAtm3zcrMgyeCeyodHMq1o48Tvli5QY+z2z1hjktBZJsklS6bZ7dosbbrpApGUB/1E
         ET/hFglPHZzfOfygTVWCPR8kf2gv3DUBA7DigMaY5sGxaOa1kh1Hfxb/ImgVw0794oDG
         rcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760827994; x=1761432794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExoVcTIek9AdjVCMkiYpZILDA0YvBh98/+0VTxUThlI=;
        b=OGDl0eRjWzlGqyCX+8XajFfmJcB/M2FZh9qLb5YxyqkV3MJk2pOdcixOz+yPgn8SDD
         tLPqvwXGTJPCnTYN+tDDBEaiSwlcWaK5wiUg5apOuH3bTOE+UYcAcq1ClUkYD4rbIpol
         v/Cq9nxijasrsoc6vyNBZRSIUJrDIvh4Jb3yLz3vbthdJU38ue0UNATzLDxGYyP78/hJ
         Ep2Dvn6t48xQmIGCF34bQeHK139BOS8fCQoC5D4IWkFJoO0N3ooMXSzFCx5Tp1W74NLv
         hLKF0ASzPRiRaP5M7MPcDo+hSNhh4Ng1U3wHqaFgagRJFfLJnD88UO/jn3SlYsxpK1jG
         cCog==
X-Forwarded-Encrypted: i=1; AJvYcCWCvJ4mzEhc+3s4UmkoxCqjbwfWVgxboF2/oF43MBxd1e1M1ZUjK8uTH8WsybHuGT2CPTa96HhpsSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcU9DepUBXdRw9AiW4smBan9DfMhSpqn+yDs+9C2MQUsHJ4HT
	IpcxFyql5sucXERpSzF2y63VZgnJ/I+43vgV0f4J8//3ZdWRlqakJ6by56ZWe9/EDQ==
X-Gm-Gg: ASbGncvxmLNbZCYiZUuW8humq++6jyUy+mOlIt3PV4IQ/3NbQ/RJ4sPRdwRmZLRtUYc
	Q/G88vUuDcxTtxSqbIi0nVAwqaUnpDxq7WyVtkTV1VRgReeccL1U6rx90g+w+qMUK7vqP3uLYPP
	EPHo1GiA6c5ZCzl5/qMItnvT3asc3akrvia0I/Pr+Tk9eEWwfVXMtyVLruVtTK2aXSsEKC2nZJk
	RNG6pixVBnIJn2qBO2HI/diwTHStLl1+KHi7DxEFQmFCzCIJ/+xE3lQDuuJwDPAMticI+2htN3t
	PvbZ3D0G1EN9k29J0ykpStxGs5849xxxfIKS9ewl9vY8WjXP+UIcO9AGjohZjDtLkwkOjaJkG6a
	hCF0kEad4TdPhOfFkh1Dv5W6UQLm4P10stGDRbYTp/KLx4ZJll72gukpnZ8LFGQbjJUCfwJjYYX
	G89qlEOF9JqJ2vUzpc31G5dzCaIrWN2PLQCwVzXcNnrwvk0xo=
X-Google-Smtp-Source: AGHT+IHYSWZKJqORVU2MlERhdd7pLQTU+bgumM/RJ5rxntS44MT/2pojFpL/YQ8TyquwryI9b7dpMA==
X-Received: by 2002:a17:903:380d:b0:26a:befc:e7e1 with SMTP id d9443c01a7336-29087a1668emr19722635ad.12.1760827994094;
        Sat, 18 Oct 2025 15:53:14 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a834de75bsm1268723a12.12.2025.10.18.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:53:13 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:53:09 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018225309.GF1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018172130.GQ3938986@ziepe.ca>

On 2025-10-18 14:21:30, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> > 2. Integration with IOMMUFD and PCI series for complete workflow where a
> >    device continues a DMA while undergoing through live update.
> 
> It is a bit confusing, this series has PCI components so how does it
> relate the PCI series? Is this self contained for at least limited PCI
> topologies?

This series has very minimal PCI support. For example, it is skipping
DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
state during first open (bind) of the device.

We do need proper PCI support, few examples:

- Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node. 
- Not writing to PCI config during device enumeration.
- Not autobinding devices to their default driver. My testing works on
  devices which don't have driver bulit in the kernel so there is no
  probing by other drivers.
- PCI enable and disable calls support.

These things I think should be solved in PCI series.

