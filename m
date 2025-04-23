Return-Path: <linux-pci+bounces-26604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86696A997B4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F075A4441
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088028E5FD;
	Wed, 23 Apr 2025 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mw0BLyt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D628DEF0
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432299; cv=none; b=L982tOZmVInlxAdeszNFIr0bxxV+QEbikUAhUiNCMclVPXDfFenwdL5GT2HbesliD5NKupQOH13CQ8XF42s73d70GcWhLhSjKZM+YUhCk//KX/BdVivDeAMH3V6DCyAmo1ymCDi9RWjNK+Z/tIb/rHoXeMU45dxKz2SenKGLId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432299; c=relaxed/simple;
	bh=4Lb81w2s/iHKlg0tr1kLg33vsHa3w3DDNgPzLbNjD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9QplRKl9VLxfhFRp7jKolTN2uCDKRjiEzoeLgh1Ae+9QCRJeKhUQPS/BO5maQXHObrdroNkdaQr1myrx2XyS5zMO8AqSB8D2DJm/onL8B9rZS24wfqBjIWHmPzr0Vlmj/MOs0mNV3/Mfaic9BKd5YkdO1hRXONb9kX+DQjYO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mw0BLyt3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso1978566d6.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745432295; x=1746037095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2K4Lg9UXWodayqGkEaP9bm9sDSNteHJq58dHhFg6dY=;
        b=mw0BLyt31cJrngz/aBlEqUNCOkBB1gSFAicpqFxsnuU55usihLqj9CppOCLuDQTA44
         QGx2p6pdozkZhZRlIGlFVwDs2dtgpe6fKnSF94krJoWMELaEUPODqoGDeQkQzFCw7fMV
         18e8lwSuBtKVpxOxM6QBw77NM9mD/y5Y2FmSeg4RArtyuojpdQcARSL6ApYsWQ+PskiA
         VYLc9AXF9mmC8s11Eb3OYyph7ohBk6xnHFnCP4/3jXhK/bh74E+StCO4Lj+LW7u56WRs
         9XeG6U9hTlaw3CySXpgHG9sCEMP7zHmh4QNZbhH5sLPkW3k0S9B3Insiwp1+IWlISncI
         SbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432295; x=1746037095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2K4Lg9UXWodayqGkEaP9bm9sDSNteHJq58dHhFg6dY=;
        b=UygiIMKRjDNleTk7lLGyZKKUjMqdagNP6o0r4LWAc8h9cuLs1jZx5MuCNy8Mn4s8Bp
         NPnOoDrSNlpmTVfnU3eltCBJbA3Pk0dclrS3WNovxcBb+DHXUPWJ7nXs4hqQWbXXNrZK
         Vb19zfLC+ZgQ+mFUJZ6h5RGN05Vs1YB2FD9uxA9Yaa+455tgvDkhWy+KX8DK7Bmxl1KK
         oC5SO03qMVKbs3bYSUfrpVKAbSGj+0Kfp7cN+Dyr3nsKsofojnMc5D8XAfobGrptsTyP
         2VNe5xAkbPx/CLEOyO+1l98uawfNG7pK880nJYuLt2WfsA/MjfBV7pLBIEWTQ7DJffBz
         JC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvxNJi0tk+GTzT6/Hc3FUbfmonfo8FOtGqjq463JoOBsHXExrSAT/DB/oRZmInSglO3MD0AuOxDoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+IGXApKB++9dZgOWlkrC/3kc8uYvGv1q4EsTpGD8+ciSJhvj
	yMSyWvfkcRlQ9wKiNG2TZ8/7vijn0QMuQdlqc1XsO5ffkoVsnwHGdJmnKz/yuPA=
X-Gm-Gg: ASbGncvFFBt7MicLpdOn6+84mat1q8MO4gvhDKnjifDGyu+4iMWNJPDEefzS/n5KEfb
	6rwPB+gHzoni3G5+sU3BqmJjjpIYBHry6pPms+J/l+1/7VGbrakLjsTOm7mu6fmHQ6c6QisAuBy
	ngAkv/EH9ifqtGBHx2eP7iiof9s8Shz/VqtOaW/SxmhoVPLYCq3gLGVUa67DBSOEQ7328SomUdL
	2DcRiMpxGcZYns86Zq7G0pwdXF585PJMpjSVvEpQvpAHECjdHuU73R1+aN8KwV89CuNXvYasxZk
	NjigKP0YdVGrfwU/7+cc1uNjpdT5Kz3Ia4/fRzyH6UeL+Plq97GanEDtpvUbu/hooBjlbwGRSox
	bWw+ZvaGiJS4COCxGl3I=
X-Google-Smtp-Source: AGHT+IG4/MsY26Rj4xYm6pWmvlAPuVFdcPLdJFOh3iEBlJVLpm+B1c5dpvU4P4SztDpvWCyGwRESRw==
X-Received: by 2002:a05:6214:21c4:b0:6e6:5f28:9874 with SMTP id 6a1803df08f44-6f4bed4600emr4321856d6.2.1745432294768;
        Wed, 23 Apr 2025 11:18:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1433sm73395536d6.19.2025.04.23.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:18:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7efl-00000007M0V-3VVh;
	Wed, 23 Apr 2025 15:18:13 -0300
Date: Wed, 23 Apr 2025 15:18:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250423181813.GU1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
 <20250422234153.GD1213339@ziepe.ca>
 <aAkj5P1I-e9lylIU@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkj5P1I-e9lylIU@google.com>

On Wed, Apr 23, 2025 at 10:31:16AM -0700, William McVicker wrote:
> On 04/22/2025, Jason Gunthorpe wrote:
> > On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:
> > 
> > > On this note, I was looking through `of_dma_configure_id()` and am also
> > > wondering if we may hit other race conditions if the device is still being
> > > probed and the dma properties (like the coherent dma mask) haven't been fully
> > > populated? Just checking if the driver is bound, doesn't seem like enough to
> > > start configuring the DMA when async probing can happen.
> > 
> > I think the reasoning at work here is that the plugin path for a
> > struct device should synchronously setup the iommu.
> > 
> > There is enough locking there that the iommu code won't allow the
> > device plugin to continue until the iommu is fully setup under the
> > global lock.
> > 
> > The trick of using dev->driver is only a way to tell if this function
> > is being called from the driver plugin path just before starting the
> > driver, or from the iommu code just before configuring the iommu.
> > 
> > Given that explanation can you see issues with of_dma_configure_id() ?
> > 
> > Jason
> 
> I think the only concern is when a driver calls dma_set_mask_and_coherent() in
> it's probe function. If we can handle that case in an asynchrounous manner,
> then I think we are good.

You should never get to a driver probe function while iommu setup is
still concurrently running. That would be a major bug and break alot
of stuff.

Jason

