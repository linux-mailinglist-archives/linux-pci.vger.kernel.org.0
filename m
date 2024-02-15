Return-Path: <linux-pci+bounces-3496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EA856586
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2445B1F270A1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3913399F;
	Thu, 15 Feb 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTaj4Z/5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03131133430
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006157; cv=none; b=fjewvKUICMR5xosC6TsAVEIv6rqwGgPCdmVNcxZ813Ppz7GWgz7Q3jZh/z+oXVe1ICY0Xeem82MzJJBsqkpdo/Hwv1I7K4vC6bS9wVKeqlHth9cGO21Z/OTbJJv3eHLACZ57znSnx2AH0DKhzK2X0/hZjc49fFxCdGdrKmNnqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006157; c=relaxed/simple;
	bh=OXAaOLcxTVVCUohYzHxnxGpwdzrfREXaJ7dqDljCuEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR/KGaMzzV/idT8KwuGScAyybM3HFMBV1dAMlQM0KKsu+etKcs+WGdcArK47Cq74YEiKZXFSIvJpBji21IJQBhJNwKag112EtuKgMLJek5lCt544OZSQdsW5r4/7RqpQfDnME8BgSRqi4+IZviIXKJ5qbBI+QLhujsvfQ3NTqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTaj4Z/5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so719771b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 06:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708006155; x=1708610955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZFPLtCtBRgacOyd+el6f1Argd7Vid/t35WmuLI8v5aU=;
        b=VTaj4Z/5vb5u5xIGqn5SYnyoXg8/FsX6qXvmRrNSfnzmHPaYc7YxRow+XCfmOSzXqI
         sEygWzQ8BnpvNKzrOgWPXIprHy/V+Qs+vPsYaIjIRpG28Oh5O2wFK0B/98LrNtDtHb/V
         qup1W/Jeli2m0cb3lmKZ/D6tdcAWZQ7CDGJWO3xI2wEfMv2CASteHRwHV6XSzQeE5M9I
         ba/36Zkyo3/tVDURYLf/N0Colego72dTnTKxmAtK1/OLkGLEE9dYZqEP7uHWWvEhZxgw
         w0Np17inzjLHw8JMP+aUjuH9PoupWFWBYCvQMb6mefe+VBV8b8uG15w8j0ZseQJfcgyz
         Ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006155; x=1708610955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFPLtCtBRgacOyd+el6f1Argd7Vid/t35WmuLI8v5aU=;
        b=JoLRRplHcj0di1Rj1lpojUE9EUCY9+Ev9qRVLa2AC2TFxQ2s/80D+XusICYo1EeEvl
         cRPGFXsdBbSWStckiS22A1TO/yjVJ+tEWM9yqOAaNUkiDFoSowRYvsaQIi4IBczp1k4r
         cn4KH0N+5fHDLwSK1rgcg0ZwwetNsgkD4oP4X+MiM84LRdTArsGh/svV8Q9ni3HWHz/k
         uZNtWJ+1grkdhlhBzz5cmHi7dwxA8wOoYpU16Y1ptZC7QZeE698ou3liZJJZlXby0R3R
         VcYhA61FHCWALEYlcWTaC4CWkjObK1I9RwIEppnOierMwQszFqL1wUGtTZw6Nd8P6HK0
         KN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoxehmdWmXzUHwRQBVDxoAskBupak1MwSG0sUdcJyxCw39UVAYcRYD3h2oizTzkW/hrw6Uu3TzAlTMyGV48uKuPG7DHFvjUuct
X-Gm-Message-State: AOJu0Yy/72I96UKF04V0juDc/ibiXDfqnPm5UZVTIazXU35nZ21MRmU7
	t+XVSx/+sszPOoB/PhvTFIG/f+KoWrgqf1vFweKuCGYQVOCKGm4DMBL0WaE7pg==
X-Google-Smtp-Source: AGHT+IFwlIPHu2wbrKOCbos5zu8iz0dCSWXM3MUM1wH84xmvNuCtTBRRLayIB4gw+uT3VkBaeSk3Ww==
X-Received: by 2002:a05:6a20:33a6:b0:19e:c1da:cbb7 with SMTP id f38-20020a056a2033a600b0019ec1dacbb7mr1517316pzd.27.1708006155249;
        Thu, 15 Feb 2024 06:09:15 -0800 (PST)
Received: from thinkpad ([120.56.196.166])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00125600b006e04e9c1d50sm1370607pfi.31.2024.02.15.06.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:09:14 -0800 (PST)
Date: Thu, 15 Feb 2024 19:39:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240215140908.GA3619@thinkpad>
References: <20240206171043.GE8333@thinkpad>
 <20240214220228.GA1266356@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214220228.GA1266356@bhelgaas>

On Wed, Feb 14, 2024 at 04:02:28PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > ...
> 
> > ... And for your usecase, allowing the controller driver to start
> > the link post boot just because a device on your Pixel phone comes
> > up later is not a good argument. You _should_not_ define the
> > behavior of a controller driver based on one platform, it is really
> > a bad design.
> 
> I haven't followed the entire discussion, and I don't know much about
> the specifics of Ajay's situation, but from the controller driver's
> point of view, shouldn't a device coming up later look like a normal
> hot-add?
> 

Yes, but most of the form factors that these drivers work with do not support
native hotplug. So users have to rescan the bus through sysfs.

> I think most drivers are designed with the assumption that Endpoints
> are present and powered up at the time of host controller probe, which
> seems a little stronger than necessary.
> 

Most of the drivers work with endpoints that are fixed in the board design (like
M.2), so the endpoints would be up when the controller probes.

> I think the host controller probe should initialize the Root Port such
> that its LTSSM enters the Detect state, and that much should be
> basically straight-line code with no waiting.  If no Endpoint is
> attached, i.e., "the slot is empty", it would be nice if the probe
> could then complete immediately without waiting at all.
> 

Atleast on Qcom platforms, the LTSSM would be in "Detect" state even if no
endpoints are found during probe. Then once an endpoint comes up later, link
training happens and user can rescan the bus through sysfs.

But, I don't know the real need of 1s loop to wait for the link. It predates my
work on DWC drivers. Maybe Lorenzo could shed some light. I could not find the
reference in both DWC and PCIe specs (maybe my grep was bad).

> If the link comes up later, could we handle it as a hot-add?  This
> might be an actual hot-add, or it might be that an Endpoint was
> present at boot but link training didn't complete until later.
> 
> I admit it doesn't look trivial to actually implement this.  We would
> need to be able to detect link-up events, e.g., via hotplug or other
> link management interrupts.  Lacking that hardware functionality, we
> might need driver-specific code to wait for the link to come up
> (possibly drivers could skip the wait if they can detect the "slot
> empty" case).
> 
> Also, the hotplug functionality (pciehp or acpiphp) is currently
> initialized later and there's probably a race with enabling and
> detecting hot-add events in the "slot occupied" case.
> 

As I mentioned above, hotplug is not possible in all the cases. There is a
series floating to add GPIO based hotplug, but still that requires board
designers to route a dedicated GPIO to the endpoint.

To conclude, we do need to check for the existence of the endpoints during
probe. But whether the driver should wait for 1s for the link to come up,
should be clarified by Lorenzo.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

