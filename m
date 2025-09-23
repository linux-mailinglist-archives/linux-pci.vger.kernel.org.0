Return-Path: <linux-pci+bounces-36721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19674B93D18
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 03:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDED517F3E4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA75149C6F;
	Tue, 23 Sep 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUOkvj2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107C1F4CBC
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590271; cv=none; b=kHj3gbI5Pmj8Gr5pL0rGzBkMFopYZM0J9KmwCxQAJX+4iUdY9XQjEv8IVi1m5jYS/AUv5dN4sbZYli2yCp6Z2teXt/ZhSWfEF4e2QyEtmXL6RG20/Wj3ZVUfX5fjyBz2+4TBoh+CMYGcqiD8hRRy65QyDo1ymIHEo38NPB7hsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590271; c=relaxed/simple;
	bh=1/e3AyiZPS/c0G1aMUyRNLYzo4gjhYckdUnHLFkO2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgtFurFJGdxV/WY0XRVIJwdtfYzAErPJgXpX4RRYriu5tylgB8DFZVFHz/fpxoHQrwxUbnOjvKCmtUOaEe97JOh66nphXIhOrBI8he5eXFKUHmJTb1e/CuSZ4HcnKc7BroUFuXOt1Y84n3ZprZcO7oizzyOj+3jFdwTWK4Yfec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUOkvj2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758590268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ut+zQ+Ol2AC0M60Dd4+aidn6RjiEypu7DiFVdYxlNks=;
	b=YUOkvj2SX71CbkRsIo2DhrD+1mtLHARYkIpq/UcXnT37OEsViRXyIoZM+so2xM0vw3m0px
	c3blxIbyShH1RpZfTJ57BjImZeZIpSBbDeOjnKpNMFWBJG9kgZLj1BA5I3LCrs/oR0g+15
	tr9U3xSM9jZd8FkuvIHCG1DxmKD5NWI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-nMAXed3yP6alMCUCHNUiVg-1; Mon, 22 Sep 2025 21:17:40 -0400
X-MC-Unique: nMAXed3yP6alMCUCHNUiVg-1
X-Mimecast-MFC-AGG-ID: nMAXed3yP6alMCUCHNUiVg_1758590260
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-3413a52b3fdso484911fac.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 18:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590260; x=1759195060;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ut+zQ+Ol2AC0M60Dd4+aidn6RjiEypu7DiFVdYxlNks=;
        b=kac53u0xYkv5Ra2cVTgVKnycUmu/DxkuGfgmlmMhKPSAIARtB8pE9GxiKD28xfCacD
         nt3dw+OVxl8cib8rrYUF+SQi3Ym9A//FKyf4K7uTnHXhQkz4kq4MwLFgiEIZm26eshYs
         aGXtcdLeruNpC2y+tjQ8GzSCkM65nRTzsks6ACaStwmboVxRRlG7HT0wOlUhN3/uGPt8
         pCJgJnrgvM9SlP4FYgkHm2agVQGA5WddkF5Zu/axtwYpRde80oO0Jbc7OgIYfNLpMo+5
         F4GtJmmyMcnIMdQjONWVCLtwYz76qsGXkTyzg/ALqdbD/LAi9gR/+uQsrlUQ31D/w/w3
         E+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5NR1k0EbXzJtLVHf8VEIm1SX4CShtDJ95eoDCPiudpehc611oz3cXybRBNGN89ucrnx9RLLGF/t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDHb/mlCLqP5ho8Yb7VVTYXRa6DCEVX/aWj7fEmQBR51lVMnK
	elK3pRbz2VncJORcTuMipsf6hvAX/UhmLVE67zJfTpf3rXhOZkNMAIjAwap8i1IhOhvXY3Yu7ku
	Utb2krGo8Ojcdcz3qp1X5n9Wd8GaK332W78Qm6cI6KDy76IhG31CfkAmRhX8iyA==
X-Gm-Gg: ASbGnctu+1k+VmLaDv4tetKEIJtctnLjKKJ6EUVSTtk3bqeTaA15TVwH3xMidogKwat
	SZu3WpN+eKMGlRXzftl7YPuDtHCq6J/ou+GAF0SPKW11QWGPs+EpCeJBRsu4qvz+OJ4/xjisB+E
	GL7AwoRDusnd+6Ap6ex48Vab1BBWqD9S91YzdSEFrdC8yn0RqP+35Wv86cOEEXGH6gX0KUhwJil
	i/zZh3c06w2p1pIFQzAA7IIEqhq8pyoS3zjLF6V9ZJThB4DstmURU6Ty78xzNVFvxUXTho1dMhb
	KX4O3fbJ8E7GLCNU3Ou5sWxrP36AgdWW0hWlA2G1mGs=
X-Received: by 2002:a05:6808:308d:b0:43d:3c37:a342 with SMTP id 5614622812f47-43f2d12e4d7mr161929b6e.0.1758590260135;
        Mon, 22 Sep 2025 18:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq9zHgq75BiE7ApXBV1Yytp3xnXFPeZg11oR2JKDr/lqHrXhwW6Di8HRCOFBIdLqEvOuYtIw==
X-Received: by 2002:a05:6808:308d:b0:43d:3c37:a342 with SMTP id 5614622812f47-43f2d12e4d7mr161918b6e.0.1758590259726;
        Mon, 22 Sep 2025 18:17:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43e20b45410sm3700113b6e.12.2025.09.22.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:17:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:17:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250922191737.0df0dbed.alex.williamson@redhat.com>
In-Reply-To: <1845b412-e96d-438a-8c05-680ef70c04e6@redhat.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<20250701132905.67d29191.alex.williamson@redhat.com>
	<20250702010407.GB1051729@nvidia.com>
	<c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
	<20250717202744.GA2250220@nvidia.com>
	<2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
	<20250718133259.GD2250220@nvidia.com>
	<20250922163200.14025a41.alex.williamson@redhat.com>
	<20250922231541.GF1391379@nvidia.com>
	<1845b412-e96d-438a-8c05-680ef70c04e6@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 20:51:31 -0400
Donald Dutile <ddutile@redhat.com> wrote:

> On 9/22/25 7:15 PM, Jason Gunthorpe wrote:
> > On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:  
> >> The ACS capability was only introduced in PCIe 2.0 and vendors have
> >> only become more diligent about implementing it as it's become
> >> important for device isolation and assignment.  
> PCIe-2.0 spec-wise, was released in 2007, 18 years ago.
> If hw is on a 3-yr lifecycle, that's 6 generations (7th including this year releases, assuming
> gen-1 was 2007); assuming a 5yr hw cycle, that's 4 generations of hardware.
> 
> Maybe a more interesting date is when DC servers implemented device-assignment/SRIOV
> in full-scale, and then, determine number of hw generations from that point on as
> 'learning -> devel-changing' years.
> I recall we had in in 'enterprise' customers in 2010, which only shaves one generation
> from above counts.

I don't see the relevance of these timelines.  A vendor with their head
in the sand still has their head in the sand regardless of time
passing.  Device assignment has a heavy non-enterprise user base.

> > IDK about this, I have very new systems and they still not have ACS
> > flags according to this interpretation.
> >   
> >> IMO, we can't assume anything at all about a multifunction device
> >> that does not implement ACS.  
> > 
> > Yeah this is all true.
> > 
> > But we are already assuming. Today we assume MFDs without caps must
> > have internal loopback in some cases, and then in other cases we
> > assume they don't.
> > 
> > I've sent and people have tested various different rules - please tell
> > me what you can live with.
> > 
> > Assuming the MFD does not have internal loopback, while not entirely
> > satisfactory, is the one that gives the least practical breakage.
> > 
> > I think it most accurately reflects the majority of real hardware out
> > there.
> > 
> > We can quirk to fix the remainder.
> > 
> > This is the best plan I've got..
> > 
> > Jason
> >   
> 
> +1 to Jason's conclusions.
> We should design the quirk hook to add ACS hooks for MFDs that do
> not adhere to the spec., which should be the minority, and that's what
> quirks are suppose to handle -- the odd cases.

Sorry, I can't agree.  I think we're conflating lack of a specific ACS
p2p capability to imply lack of internal p2p with lack of an ACS
capability at all.  I don't believe we can infer anything from the
latter.  Thanks,

Alex


