Return-Path: <linux-pci+bounces-26443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4BA979C9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F93F4613A4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03152BCF76;
	Tue, 22 Apr 2025 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNtzwtl4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089C1F869E
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358935; cv=none; b=UfTj3uiDTb4q26k6VJ6EBAhMxv+tP+F3Xauw5hbJKthLmf42tmOnPdD/VloYFuWAwaDM3MnDb6HgsDz0DkvudBDnfYNMgfd4j00TMVK98D58IgNCf1cfkWI1/bFlUmQxgweCl2RzF5RJ6viSDxnYRLMB+UKqldx2axUcCe1YGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358935; c=relaxed/simple;
	bh=IBg6T/8bdZueoIIYbP2yfI78xemmRKXPfW+X6Epwyb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzCTyKjETKwsXwSxFH9W9kSs7Vy3xQ7998FmPB6aoXhc528U1eLFDVd99Yvq8hL+yKB4Pe5A1ropDK/5k67FMzcYmBczOYo7gFqAkFW7d20fWKAfmFCzPByqeBmgAdmGM7RI8jx7rJZHRfZFUnCuJh9RbDxGIXCeYRflQuya87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNtzwtl4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e5013aso66298385ad.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745358934; x=1745963734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6asYMkdcVOCJg0CB/GTsjjXoi08Jnm+cXJbFRuu7HS8=;
        b=mNtzwtl4JAHZuhoc2HzSch8z8+L0KSMRub2FADRi2yRKAXF5gqNmxiX/ASd3KPKCD0
         dR35IalbwZ10/julJmkFHlwAQKQ7tgg6RX/DO+Gx/4eKhM6JAy4inXLZoj8uROrL4aor
         +wPI+5xwsS7hzMmsz8OBtqDOfxx0U8r89/zHLM/8fFDgpPCxQsL5zg69c+iV9wv3kS9R
         ENMqGwSN1FQFBW43oo63lGcQw4WI+zW1TLJYAiCMCUYEk2GBqpaq94KY0vU9IxUM2MAa
         K0dWQ2IRNpeGZR4bCzbnS/Jnl3axCQmYsS2NOSx9hbxQntCnLAT35OLwdhJLswFRaKsi
         g1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358934; x=1745963734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6asYMkdcVOCJg0CB/GTsjjXoi08Jnm+cXJbFRuu7HS8=;
        b=T9wmsQkbCmK3ykY6i3fjGS5W8eblwVEnv6rip+H2rsgKgErH4DC0TGOYBrN5NO+04f
         pFK5pvei54gH12hd1pjOUylVV9WNdqP9L2e5WfbW4UrgER4cSZo3QxWxkJSonvJ8BeJz
         Ek5vv0ykmgEbBxAx9f9brUyXp0UeFefc5hfq5CCkjnDBofnnaCqtOLHvRfuNm0T5fEhm
         e0qhAPOG9vuauNlNBjlot9yBDo80MMwLRipHiBKTjohLw4BChCht0ObK/TnrXhNXdL4l
         FiiUHf0wVkbZhOmkhWfmgBSHvTVNtjuD6kGTVwPFqs/5VBsuxt89nC4PZ8p4Bf0qIvcf
         fzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnPdFjtCLo/xL1O9KP2IBlDB2tqy9KBQay07pL1S1jMLzLAdcuaUR4SV8EpO098NVdLylB7BafKk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufNNezRPBCe/auiC7kiUBkbFbNjziPAA3uEeZToBMPLKONemQ
	8/p4r2L+hgHC6HzoIo53F0oglDPqpoxNzYU5akY31yqOOhhYlUKEJXXsCqgJVw==
X-Gm-Gg: ASbGncvCb+xv25E/QwoubRUYv83fip7EJ5V/qsM9T7ltrrl8UhG7Lcy9VopqcgjySUK
	Dzg/F1WF7i/OY3eZuem9PiG4sg3pHIeuo2gJXsuXIoXWSr1op0/lJH7hilz9TxYJLDIKZifS4yO
	NRR7f/4wduyQg7kd43xRMA+LoZ6ewQX3QxqxLOTKHHXZ/ytdB+0QDvsBk+N7zuvfFkE/NiNm5C3
	NcFpOCrCXs0se/mLNTv6tFV//Q27gancpkLrYcByNAPRn47RHi3FCbo+UIGNdyncHAJ4tslqeZ+
	42EUN9/6RfLjx126aDJDLMBsyflMeAL8EIfNjQQOMGrloH8I8FEHloWrLoxSZ6bBrScxHCjQLR2
	1j4GONQ==
X-Google-Smtp-Source: AGHT+IGj1WS3gCYuWNM31cHMqZpSCdXyw2eIzHGcK/aumOJ6NuA9dKBVMTjVtVR1uQU6qgyTGOQ+uQ==
X-Received: by 2002:a17:902:ce82:b0:216:53fa:634f with SMTP id d9443c01a7336-22c536303e4mr222403105ad.48.1745358933312;
        Tue, 22 Apr 2025 14:55:33 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3eb1sm90943865ad.82.2025.04.22.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:55:32 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:55:28 -0700
From: William McVicker <willmcvicker@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <aAgQUMbsf0ADRRNc@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422190036.GA1213339@ziepe.ca>

Hi Jason,

On 04/22/2025, Jason Gunthorpe wrote:
> On Mon, Apr 21, 2025 at 02:19:35PM -0700, William McVicker wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1813cfd0c4bd..6d124447545c 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
> >  
> >  static int platform_dma_configure(struct device *dev)
> >  {
> > -       struct platform_driver *drv = to_platform_driver(dev->driver);
> >         struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +       struct platform_driver *drv;
> >         enum dev_dma_attr attr;
> >         int ret = 0;
> >  
> > @@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
> >                 attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
> >                 ret = acpi_dma_configure(dev, attr);
> >         }
> > -       /* @drv may not be valid when we're called from the IOMMU layer */
> > -       if (ret || !dev->driver || drv->driver_managed_dma)
> > +       /* @dev->driver may not be valid when we're called from the IOMMU layer */
> > +       if (ret || !dev->driver)
> > +               return ret;
> > +
> > +       drv = to_platform_driver(dev->driver);
> > +       if (drv->driver_managed_dma)
> >                 return ret;
> >  
> >         ret = iommu_device_use_default_domain(dev);
> 
> The diagnosis looks right to me, but pedantically I think it should
> have a READ_ONCE():
> 
> struct driver *drv = READ_ONCE(dev->driver);
> 
> And then never touch dev->driver again in the function.
> 
> Send a proper patch?
> 
> Jason

Thanks for the response! Yes, that would work as well. I'll send a v2 revision
once I get it tested.

On this note, I was looking through `of_dma_configure_id()` and am also
wondering if we may hit other race conditions if the device is still being
probed and the dma properties (like the coherent dma mask) haven't been fully
populated? Just checking if the driver is bound, doesn't seem like enough to
start configuring the DMA when async probing can happen.

Thanks,
Will

