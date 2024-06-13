Return-Path: <linux-pci+bounces-8769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656C907F0D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE121C22303
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A914C591;
	Thu, 13 Jun 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTuwUo/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2213C8E1
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318297; cv=none; b=ul7YtW5EF9/bC4acTqZ2guWbYjPfnPGbxMQZWpR7tFiTLAiHxIrHVAPNWOnBdoPoS1D3M5oUeWXpeBCPd+HOfNb/2Zn00o/i+7myvCE/QOC/yLyenewgqE5mPnXXcCcXJpbtYopol2ZLdTQeR3p/XxXpHuiLEY0U8tNU87iNkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318297; c=relaxed/simple;
	bh=2u1VP7eGoXAMtgev4KjobLhkIzKXvMU3NlBQ+3wtuyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzhB76h4DDZoQkJxSJEDpTinQy032KVJ757yGygmH5moNXIdFOOYDW3in/VQK9zpmAb6AOlMfRm4iqNHmhQcqknEXcR6DhSwUSL4xwFKoNC8SCrmB3dCUKXivXVJaZLxGOUG+6FSHPYOT+LP+Ppq64Ae9e3zVColHhuDpNNMf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTuwUo/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718318294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=he5Yx1jWujWUE+IXddJY2r++ndCMDeeVF1A9UEVm79M=;
	b=KTuwUo/g6yXgoUxSAGC49yhGU0eLxAeJZc2zVxruS/qyGqkuVXTFUES54UWOtVpqPk9vAj
	7wRNlbCzuBYqIlUurCIbfheAhaBvVrLaEC/iyYotzRnsluvoVlOnCSccPIIDddMTmkN8iW
	P3l6hqtPfx0ZNOrwbTemVWBACDPn4Ug=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-KTYa5fhNNaizCWC7OyNO0A-1; Thu, 13 Jun 2024 18:38:13 -0400
X-MC-Unique: KTYa5fhNNaizCWC7OyNO0A-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb21854dcdso123337739f.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 15:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718318293; x=1718923093;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=he5Yx1jWujWUE+IXddJY2r++ndCMDeeVF1A9UEVm79M=;
        b=sd6NZQKyiCAHPzSNSYxUtVWca9mnybpc/04npmhbt8c70VxWpL1oO/ElzYOwvT95VD
         1TqNv/nTOd2tb98H3SibtqUTZwihYT7IvM2P+mCwDc6jmFbTM7YN7zjFGZWs9IJrB8xw
         7sA8vIhU+90x6c6DfxSBldJwQrDA+kjWS8hZz2HLORY4Pii8dJCeQt1Wf+87CRG9zter
         uLy7VU+xdejcWLo/1jWykVLDM+H5/qtHla8wPe37iFs65JnViuk0ZcuySf+XbSY+f/Nk
         4TaCZHUZzc5jzDDR6d1ovmu5ArhJp4ld2YCfS7FPDAkvjuKR+Y5Et0k+Jfe7zTvc6zzI
         mQTg==
X-Forwarded-Encrypted: i=1; AJvYcCWfnlxevu4NsMZtd3Ua09gRxDlGhiqN+MR28sVysIiG062rZTvFA80cjkzYwK8SSRipS8avJEhSIWLyh0WHD8Zks04R3a/DBzC5
X-Gm-Message-State: AOJu0YxqgNz3Hh06GjV36bBy4aJWkraBVkid+d7ZS0eFUmuMniBRC9iH
	3qyftgxq6osbdkbZ4FtCkMX3M1PyV+rLOUzX+5gt4IQ31fU5ERFthFQRhZg8PxC+p/ZQZbxdodX
	WziA3V5zBOPoHxRBeI2wwo3JHy/DV3NgXCLqa2UsZT4TPTKf0FTDgYMXrIA==
X-Received: by 2002:a5d:878f:0:b0:7eb:7c78:9bac with SMTP id ca18e2360f4ac-7ebd8eeeacbmr291418839f.7.1718318292759;
        Thu, 13 Jun 2024 15:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC5Q3qOf+xsCvCjrf11Bh2sb1u4xb0WsNH89tM/d7UXwv+XdN3cXQh9lfpTz/dBnTH+uebWQ==
X-Received: by 2002:a5d:878f:0:b0:7eb:7c78:9bac with SMTP id ca18e2360f4ac-7ebd8eeeacbmr291418039f.7.1718318292355;
        Thu, 13 Jun 2024 15:38:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a4e7b9sm567073173.156.2024.06.13.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:38:11 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:38:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "bhelgaas@google.com"
 <bhelgaas@google.com>, Gal Shalom <galshalom@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter
 <jonathanh@nvidia.com>, Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
 Shahaf Shuler <shahafs@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Tushar Dave <tdave@nvidia.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Krishna Thota <kthota@nvidia.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>, "sagar.tv@gmail.com"
 <sagar.tv@gmail.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240613163809.12f0334b.alex.williamson@redhat.com>
In-Reply-To: <20240612232301.GB19897@nvidia.com>
References: <20240610113849.GO19897@nvidia.com>
	<20240612212903.GA1037897@bhelgaas>
	<20240612232301.GB19897@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 20:23:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 12, 2024 at 04:29:03PM -0500, Bjorn Helgaas wrote:
> > [+cc Alex since VFIO entered the conversation; thread at
> > https://lore.kernel.org/r/20240523063528.199908-1-vidyas@nvidia.com]
> > 
> > On Mon, Jun 10, 2024 at 08:38:49AM -0300, Jason Gunthorpe wrote:  
> > > On Fri, Jun 07, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:  
> > > > "Correctly" is not quite the right word here; it's just a fact that
> > > > the ACS settings determined at boot time result in certain IOMMU
> > > > groups.  If the user desires different groups, it's not that something
> > > > is "incorrect"; it's just that the user may have to accept less
> > > > isolation to get the desired IOMMU groups.  
> > > 
> > > That is not quite accurate.. There are HW configurations where ACS
> > > needs to be a certain way for the HW to work with P2P at all. It isn't
> > > just an optimization or the user accepts something, if they want P2P
> > > at all they must get a ACS configuration appropriate for their system.  
> > 
> > The current wording of "For iommu_groups to form correctly, the ACS
> > settings in the PCIe fabric need to be setup early" suggests that the
> > way we currently configure ACS is incorrect in general, regardless of
> > P2PDMA.  
> 
> Yes, I'd agree with this. We don't have enough information to
> configurate it properly in the kernel in an automatic way. We don't
> know if pairs of devices even have SW enablement to do P2P in the
> kernel and we don't accurately know what issues the root complex
> has. All of this information goes into choosing the right ACS bits.
> 
> > But my impression is that there's a trade-off between isolation and
> > the ability to do P2PDMA, and users have different requirements, and
> > the preference for less isolation/more P2PDMA is no more "correct"
> > than a preference for more isolation/less P2PDMA.  
> 
> Sure, that makes sense
>  
> > Maybe something like this:
> > 
> >   PCIe ACS settings determine how devices are put into iommu_groups.
> >   The iommu_groups in turn determine which devices can be passed
> >   through to VMs and whether P2PDMA between them is possible.  The
> >   iommu_groups are built at enumeration-time and are currently static.  
> 
> Not quite, the iommu_groups don't have alot to do with the P2P. Even
> devices in the same kernel group can still have non working P2P.
> 
> Maybe:
> 
>  PCIe ACS settings control the level of isolation and the possible P2P
>  paths between devices. With greater isolation the kernel will create
>  smaller iommu_groups and with less isolation there is more HW that
>  can achieve P2P transfers. From a virtualization perspective all
>  devices in the same iommu_group must be assigned to the same VM as
>  they lack security isolation.
> 
>  There is no way for the kernel to automatically know the correct
>  ACS settings for any given system and workload. Existing command line
>  options allow only for large scale change, disabling all
>  isolation, but this is not sufficient for more complex cases.
> 
>  Add a kernel command-line option to directly control all the ACS bits
>  for specific devices, which allows the operator to setup the right
>  level of isolation to achieve the desired P2P configuration. The
>  definition is future proof, when new ACS bits are added to the spec
>  the open syntax can be extended.
> 
>  ACS needs to be setup early in the kernel boot as the ACS settings
>  effect how iommu_groups are formed. iommu_group formation is a one
>  time event during initial device discovery, changing ACS bits after
>  kernel boot can result in an inaccurate view of the iommu_groups
>  compared to the current isolation configuration.
>  
>  ACS applies to PCIe Downstream Ports and multi-function devices.
>  The default ACS settings are strict and deny any direct traffic
>  between two functions. This results in the smallest iommu_group the
>  HW can support. Frequently these values result in slow or
>  non-working P2PDMA.
> 
>  ACS offers a range of security choices controlling how traffic is
>  allowed to go directly between two devices. Some popular choices:
>    - Full prevention
>    - Translated requests can be direct, with various options
>    - Asymetric direct traffic, A can reach B but not the reverse
>    - All traffic can be direct
>  Along with some other less common ones for special topologies.
> 
>  The intention is that this option would be used with expert knowledge
>  of the HW capability and workload to achieve the desired
>  configuration.

FWIW, this sounds good to me too.  There certainly needed to be some
clarification that this controls the isolation of devices and IOMMU
groups are determined by aspects of that isolation rather than this
option directly and exclusively being used to configure grouping.  I
think this does that.  Thanks,

Alex


