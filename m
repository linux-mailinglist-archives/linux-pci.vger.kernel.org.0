Return-Path: <linux-pci+bounces-27536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA216AB2182
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 08:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398394C09AF
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C61E0E1A;
	Sat, 10 May 2025 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZetzR1e4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243101DF261
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858080; cv=none; b=NWo0qsAPSDzDgoLyQbeyWXdfEakPzsSxMBVCmzERc7fIk0DKqYwusYeW/vOSg70WJEYbKxJfzbn/X6p6jRm14JmyxrlyFl5e0JKsZoD83zw16LKov7cKWtILK5fCO9i1lg5+DAdMiubBKc/E+YlFuHIYeDm2HvZfKkL5qnrMSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858080; c=relaxed/simple;
	bh=JymhY2Lji1skbyDvgo/JCt7WXfz/HRAkCCgyXAqNJ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdmw6TrkOqvqgrMvkIUSITRAG+xJoH+t0DTFhMoMJs7XARfIbaCgo+EdUBXuZVMIHcUcRmzKpsJ6e+I/+s7Ka47sKK19iVr5aKvWDVJCXl9Na0ZcmPozC02HbHwOhaFABnYbzJ7FEI4bd2qkjMZ8gZ03g3exwUReY2yhI2cBBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZetzR1e4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a064a3e143so1515024f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746858075; x=1747462875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZIcjD8vza+9SQ6jTMzI89exoanQPlW8N3/Fn2TsVOg=;
        b=ZetzR1e4/krip/tZuYBzSahAfKJVBj4UC+KmkX+/KYnY176xT5UnmBz7GS6Z7dImij
         2HY0+C77CEV/5rIuHmKcg919SIzQ9YmTT2lPurGyKQtgLC57fa48sr1BBv8lNTQVUTJg
         qVtw2e9LSB/A7DrMf0c7aXxT+IMX5OPhFsgMOjbKl9ZYJytFUFG0ok2sLg0O0Ol/+Hu6
         OL5lf2pdI7q+3mKpkMagC5YvBvV1Mmwv+hqYu8x9Ydx53eOPx2oPqVYLB4gtzDgJ8VI/
         lxZDphZo0JpDBSILduoWArj+SXHz/KN1jg5sL29SXiCaq3+jg/SjYw9ODY9G0Z0S/4X0
         ghpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858075; x=1747462875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZIcjD8vza+9SQ6jTMzI89exoanQPlW8N3/Fn2TsVOg=;
        b=vlm1RdeMRNFVqP+tsV9wgd5dEheNv0lgSRKPdedMYU9EDVRdEfFZ0lFcnHPD7LcbeU
         1yUwxCG/cRGQ1w20GKSYK7RfC/d4TzUvuPHLzIvR7M0dNk1iHU03Z0t7hg5s0tOePtQL
         tCdwpZhAX/8/PEsWaI5/WFkyMG3STY7U6a3tg0m9IP4waoGLVITbGcT0C693ofvj8Erj
         ZELkc4Xq+ucj/NrDBdh8mtO4KqBSmSvXWgIK69+t91gU5zsku9H0Ma9yeTaj5rk74x75
         SC6bug0HC9+wUEWmieW0hIOxiHhkRZr5UKTtjjVl9qs9b+JB8Pz5rnqm8q3MXR8ER7Lu
         6ALw==
X-Forwarded-Encrypted: i=1; AJvYcCWlDMoiX33vRLpOBM1m0+sjTjMdDZ9aTTmDuU8C+FMZWpe5JJWiVk/olOxMiej5YQc+0XZEcVzIwSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkpFTqhJwimGPp631qsT9wbSBN5TP7F7CiaK+IgSHUK6X2DNN
	FqungHhiUbhfmCdsXbeX3UCJdd9pbN6CTuEvSF6OM71CL15/oFGSbcNbIs9KQA==
X-Gm-Gg: ASbGncsJ55THJOxGWhdpDjVPiirPRmtygD0EMBSQ7aPiek7IJJDy7l0QdXGYo7j7wF6
	b+BH1JuAb1spUTjpr6riBLpkUEc/91plUUQOZlOW6Pu3PIbYSuegrknPMAHos0J6Ns8CR2+FqaE
	qTkWViofto9SbOTiXggQh0nSMYEDJM/WJrWGEtBZLkZdEyJFlR/eD4XsVAkl2AfEYvCp4iPo4jx
	L5CuZ7QrCNY1l6dHMQobnSgXr43SBLEffLn4mWLFNXUnI7DwjyyJ78s5An1zIiGMrYnZzuwWXaX
	mqu2hiR8SBOXjqDPkRXLY8iuFxbyx2r0tyLAVGiF2/30YO45KZJu5eJBVFcW/u8Ox8+iGPpZX41
	VrIQjUZOOD/lCEwm8wnoqz0HPpIwzzjmqzw==
X-Google-Smtp-Source: AGHT+IGMLe8aqclfiaDHhJTdSSRAUPgdl8jvh/rZ+9Djc4Iov48r8+FjoFb55hRx9wfb+8KeZU0+Xg==
X-Received: by 2002:a5d:6604:0:b0:3a1:f67e:37bc with SMTP id ffacd0b85a97d-3a1f67e3861mr3909565f8f.0.1746858075313;
        Fri, 09 May 2025 23:21:15 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f1eesm95560225e9.9.2025.05.09.23.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 23:21:14 -0700 (PDT)
Date: Sat, 10 May 2025 11:51:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PCI: dwc: Pass DWC PCIe mode to
 dwc_pcie_debugfs_init()
Message-ID: <txuz4ri5z5tbaqguwyaekkxexffdkpe5knvw6xr35kikrbqjlr@27rxerrwmrdg>
References: <20250505-pcie-ptm-v4-2-02d26d51400b@linaro.org>
 <20250505183746.GA989979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505183746.GA989979@bhelgaas>

On Mon, May 05, 2025 at 01:37:46PM -0500, Bjorn Helgaas wrote:
> On Mon, May 05, 2025 at 07:54:40PM +0530, Manivannan Sadhasivam wrote:
> > Upcoming PTM debugfs interface relies on the DWC PCIe mode to expose the
> > relevat debugfs attributes to userspace. So pass the mode to
> > dwc_pcie_debugfs_init() API from host and ep drivers and save it in
> > 'struct dw_pcie::mode'.
> 
> s/relevat/relevant/

Fixed while applying, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

