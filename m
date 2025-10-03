Return-Path: <linux-pci+bounces-37543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F5BB71D8
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF354ECCC2
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9A200BA1;
	Fri,  3 Oct 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e7f+Yh/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377172B9B9
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500304; cv=none; b=iIkFX4VWw7edL2mObnJ+TS5quBJYDZ9ufDCtE3Yu5Y53TBgAeLnbLxXIl6nPdk8Qe1esB4cBOwKeNYlV/EkK7/xSm+TEO+qI/+u34Z7yWvc6ZnHgPOnrCKWFce0gJUHyWYtFPetkxwwMbz4GavFIJk/S7iK94CD7JWYViSYEG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500304; c=relaxed/simple;
	bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3GeXS0VdwaqPlVZYPmWqyI4qFpCRFYTgG4H84Ix5eUEAzC99XFqPkIoPswEZcAwIFekm2I8nexhnscbZfI3+p1v7v9zKvoQiAmg5VD9aIWbCIXdBTSCi+pwB7eZilO2It3Re7HXcTyLgYBmRZWKDkD8pY6g6USF57lDQu5HXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e7f+Yh/4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6051afbfso25629287b3.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759500300; x=1760105100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=e7f+Yh/4xI08TH+ZaCFnzp0ODA8+QoY5uzzxWJ2DR03ctir5oPxfKL94XcXPLep951
         r9MFGcUUY/AYii/LrxcA24Jkmtc1xPgSzf9OPNOxpP+hAiZ8QSvLpzt/ZqzkHlUjjhOc
         9H+Nau8YvLK3pXjIyGVWG4kW9rHCb6UrmW4xotnIAW+pqoXv5ik+CmpGbHdlO1grMyap
         wDofKCXhs8vatpU0YqW/iy94DXDODFZrOMzH5jGwcFZ/iHkVeboCihgXe+LR7wfCtYzS
         f7jvr6/2rAIcV8AfEnGR2eYpvr71plCXdrdKR9a+dgA3i7M6K5g+yPdYl9h6N/uxsfN6
         HXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500300; x=1760105100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDOlaahyagViedfiSN8R/K37eGiBows/WNphK5zmxmA=;
        b=YFMegDIvM0FUUrLpuIJE7l7uzs5Eb87YUcm+dmW7s1+OUuIW/NRdtzCVeJJkCpU3Ev
         JiAkDUx9jq3HjPi2OvvQcdK8U4WqO+PunMfwvpYOI4g2GPkyKXNQ36AzSl3qvHAS7K60
         FAwcXRqcMY9y4BJQzxcOILf/nklidh3l7RAswuOdgC01tPBfR/TZF0MsSAElRESdh2zI
         4rpuqZ7RFw7aUkEPWH+TNad1REcgLKCFqicxBWoJ0ekxgXMm70mk+gbNIxD7H4ALGZTs
         ZaP10njGeMhia26CNJ2Gf6ul43Rq0g6TcUnMp9l2jauEuyXcvhqatmMxqbN0ziYogRy3
         Vfeg==
X-Forwarded-Encrypted: i=1; AJvYcCU0d1dvR5ZGJ6PJlwLeUyjfe2iRrGC99jjed13HWuhzvt1RJyo3BCLACRxCVPAAIM+JN5hMu2AxN2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQyONq/s5fUioaTQKJZGTWB+lnEJadkz0sXlvPFy+Je1LIUsj
	Y0a9ybdW3I0yRPrAgJ19Z9jxsLs6Ksy5TpLvofH+yNUHvIgJWTRNhulbUNV+ciZEtaY=
X-Gm-Gg: ASbGnctuMU6rneCPFvTGlyDu9kBo2KqucczpOECeTb+K/HS/IXa12DAwmwYyAB9azci
	zoq8oLKclHk6WE2jxzHyTd5r/rpaLzkU6y7oRYZJZUTMQoChy7QycpEFObpXf7Mm9l0IWEXwxJ+
	tdXOgn0mcg1utXaF71wmMDSRZHWThRofoKdbpE4SUxgMMPk2yuZtKRED/8P5E7UGQ/tuGwomP6P
	f2fwuNGzjR4YPmWmFQYeS04oMtTOfIBs3YzKopT+I6DDWWgfsQC5HtXdxV27trl0tow2wbAwdX7
	bf6MI8PNcbrmTwDJ8nhxwhJ4gYl67iA2nxdMcZ4XBR8KHbh2lt+3qXdWiLlSNzZf1qnyJEOhFZe
	M2XK+r7JsmBgyIWtLxEFlS+h5L5sGShMnm660TFuJffVbGArn09XhNcBjL/eNioWSoK0q3RLB6o
	AH0toc12g7ItVuE1lo8GOPBi8koLo=
X-Google-Smtp-Source: AGHT+IH54YOvJZyYdYQGXmSE3qP2IlgeXBlXhYdTBxgZJrUQNZBBNqv/BfQI4aqzb9AsdFrQGB3Mxw==
X-Received: by 2002:a53:ba42:0:b0:611:ecfe:3655 with SMTP id 956f58d0204a3-63b9a0f0194mr2116314d50.30.1759500300024;
        Fri, 03 Oct 2025 07:05:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877786508c0sm437278485a.43.2025.10.03.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:04:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4gP3-0000000E5yT-3Q5L;
	Fri, 03 Oct 2025 11:04:57 -0300
Date: Fri, 3 Oct 2025 11:04:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20251003140457.GO3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
 <20250929174627.GI2695987@ziepe.ca>
 <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:33:20PM -0700, Chris Li wrote:
> The consideration is that some non vfio device like IDPF is preserved
> as well. Does the iommufd encapsulate all the PCI device hierarchy? I
> was thinking the PCI layer knows about the PCI device hierarchy,
> therefore using pci_dev->dev.lu.flags to indicate the participation of
> the PCI liveupdate. Not sure how to drive that from iommufd. Can you
> explain a bit more?

I think you need to start from here and explain what is minimally
needed and identify what gets put in the luo session and what has to
be luo global.

Jason

