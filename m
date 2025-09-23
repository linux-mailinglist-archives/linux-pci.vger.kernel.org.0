Return-Path: <linux-pci+bounces-36720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E90B93CB7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 03:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBF13ADCB1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CE17A2EB;
	Tue, 23 Sep 2025 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcY3De/x"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894B1DDC37
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589836; cv=none; b=kgjMUDg7yEClEsbrz6hFkuVjcBJQ5SigzXip8YhU/Gwuevd1olHbLTTJ9xpe8Yg0BnSE04F/8SjsGR3SP3peTcfiN0i26QLcHZ+QZcynbEyQcqpGquY+Qt7Afmjwi2oo+s2SiZbNpfdMJ7rVxTi+xSzmNSUz1pUqn2LXGQkqcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589836; c=relaxed/simple;
	bh=9rAyCAp0JWycHOc8mJx4dBKJhDcA9CLu0OXu8TULZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3k75rFhVlLvlSdHphVuQ7NcTdt/mvUBMZiIMqK2KUcxvw/BVK5UcxWyYlxfemf75EESBJf+nVlc6R+ppoNSEcduzLypJ3ch2Dzyv5NUgUByzfrVsrTMWkM7LS68LvLV2RUNlzXDyuWkCcTAQbGGODVgQ9pVZH0vhIq9Y/V4Cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcY3De/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758589834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMdCl+IiTEZQdjIFjdJwfIpOIRvy1QynTRS3PoYFQjM=;
	b=GcY3De/xda7cLyeKuSL4ev9JkPKpyhESnznTHEG/uFAQBSZu9TfU4vyQn1oCtI3FKlKyQx
	AA2AAuCCbjzLTpyS3QvuT15R5+bp86Kv7eix1qjiRpNlIS4G56I7In2KxUadwsDJj0TSq6
	vsry2uRv62cDbKhP4ltclY8jcWUgG/s=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-44bdRM13N16CYDb19N-JrQ-1; Mon, 22 Sep 2025 21:10:32 -0400
X-MC-Unique: 44bdRM13N16CYDb19N-JrQ-1
X-Mimecast-MFC-AGG-ID: 44bdRM13N16CYDb19N-JrQ_1758589832
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42571642af9so6490585ab.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 18:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589832; x=1759194632;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMdCl+IiTEZQdjIFjdJwfIpOIRvy1QynTRS3PoYFQjM=;
        b=tDa7VJdHnpa9vxLT3u92b8zbHVQoc+foqOqqUgemktwmUprZFwfVY30sUFfA0gj2Ym
         zQkWDhUkF06aqfZTigOuuvEYcIy3crUERJggOIsAmmb4G6nEj6YDtOLGf7qnQfrAUQcO
         VrmQPjEz7ujSrsrfe5vHvwMaoP0ozIOTeW33bbk18PVPv/5EqtV4wDsG/gRw6GYnj9FA
         86dvpVXOa94y/tdEbEgYMUNPZcjIBdMM+XwVePDdj3TbqQMW0o1gfEALS4+cjY0ruflP
         8SDVWZJ6aaLy4dUGijVOIJl6t9XLqkWcNZ2XEYFDtPxUPT+oHyC/rAmfO9c3XhXaz4xV
         ikKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYckZgF7oBlUubVc9TRAIRfTHFN3FYHOMOJiEUKeyLPG1r2emPAx3WPh/XZHkk9ZUTONqCiZJBBww=@vger.kernel.org
X-Gm-Message-State: AOJu0YykC7XnYm31+oC+Oo2i/NyapDYpSKheuBzmN5DmRxVJrl//RtVf
	zSnTN17T2o3haaM8bCDS6QMayrl1yo77I8LIrBmiaTTgZaYDRve3JzXi7fQpXwHW8qhdxcqsEW4
	UcmpDsG69Xn3tlE7R9f2KVcTiQkRPPQzDuSUG6rJIOmdpUH3K78l1xjvx8y8i4A==
X-Gm-Gg: ASbGncu7miwvfIzLtfR3L1AexubeTUraOrpfEy/qkR6coCUW9wQuZt/Vp9QYjmGO+/P
	afKEiCwNze/Ig4P3V7rwLHNYvL+bN1yh/Bl9KUti0SEfyBxcJxBIq/QytTac4EKYpvXA37h2Ui5
	HIKnFAhRoEovgJGPG3u/a32OHMtFGHpkrX2q4HJsaWKDB6KEuvtIo5oo9E4BAPhH/yq2AGTr3h5
	p1J5YgkWI9bWtx9TpT7hK6b3F9JM0utUj4uKAdYsaofMREMapOttcWL+adHJigzdMTPWjUuM6gS
	HYUJC9JVr0IruAUXtW3ud9bAXFBN/eHGH3rKHhdDSz4=
X-Received: by 2002:a05:6e02:1062:b0:425:84b6:a7de with SMTP id e9e14a558f8ab-42584b6aa30mr980605ab.0.1758589831773;
        Mon, 22 Sep 2025 18:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjujwsV4+PvdiPV9xPzzt8xVXDXwwoMNeGQllr4EYycFAIvL2pedut8GhHoH/nZ1k7CtN0Ig==
X-Received: by 2002:a05:6e02:1062:b0:425:84b6:a7de with SMTP id e9e14a558f8ab-42584b6aa30mr980355ab.0.1758589831423;
        Mon, 22 Sep 2025 18:10:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56221c6f374sm865008173.55.2025.09.22.18.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:10:30 -0700 (PDT)
Date: Mon, 22 Sep 2025 19:10:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Message-ID: <20250922191029.7a000d64.alex.williamson@redhat.com>
In-Reply-To: <20250922231541.GF1391379@nvidia.com>
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
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 20:15:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:
> > The ACS capability was only introduced in PCIe 2.0 and vendors have
> > only become more diligent about implementing it as it's become
> > important for device isolation and assignment.    
> 
> IDK about this, I have very new systems and they still not have ACS
> flags according to this interpretation.

But how can we assume that lack of a non-required capability means
anything at all??
 
> > IMO, we can't assume anything at all about a multifunction device
> > that does not implement ACS.  
> 
> Yeah this is all true. 
> 
> But we are already assuming. Today we assume MFDs without caps must
> have internal loopback in some cases, and then in other cases we
> assume they don't.

Where?  Is this in reference to our handling of multi-function
endpoints vs whether downstream switch ports are represented as
multi-function vs multi-slot?

I believe we consider multifunction endpoints and root ports to lack
isolation if they do not expose an ACS capability and an "empty" ACS
capability on a multifunction endpoint is sufficient to declare that
the device does not support internal p2p.  Everything else is quirks.

> I've sent and people have tested various different rules - please tell
> me what you can live with.

I think this interpretation that lack of an ACS capability implies
anything is wrong.  Lack of a specific p2p capability within an ACS
capability does imply lack of p2p support.

> Assuming the MFD does not have internal loopback, while not entirely
> satisfactory, is the one that gives the least practical breakage.

Seems like it's fixing one gap and opening another.  I don't see that we
can implement ingress and egress isolation without breakage.  We may
need an opt-in to continue egress only isolation.

> I think it most accurately reflects the majority of real hardware out
> there.
> 
> We can quirk to fix the remainder.
> 
> This is the best plan I've got..

And hardware vendors are going to volunteer that they lack p2p
isolation and we need to add a quirk to reduce the isolation... the
dynamics are not in our favor.  Hardware vendors have no incentive to
do the right thing.  Thanks,

Alex


