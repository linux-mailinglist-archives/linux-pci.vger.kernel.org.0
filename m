Return-Path: <linux-pci+bounces-11735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54735954143
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12F51F2436E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 05:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEE77115;
	Fri, 16 Aug 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNRoGv+L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F279B99
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786958; cv=none; b=Rq0DI8vETt8rD6/G4/ilhzYYCgDrJRE3eK3wugjWJxR1T8WAmrXKUmFqGfCoXUa5GTd3WL4hLcZ2TH8U4LDuC7RasGlKxCIgSbUgY/mUzT3C+uvry+bKU3EIsQSHazWTqdajYAGAPFXiFjeTKF+k525nVpv+iZO27rtrMqiOlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786958; c=relaxed/simple;
	bh=wohqTZf8t1Jk+MndcRSLVbpLyYPLFHLPjLBZp8g4Nck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPD5bU9OX6SEA8DknYX0qfpRlCvZJ4Svw6ugnpoWqzvX4ZDHtdkMbyUExZiREdcuHQXWRQxWtIeFBi/UmNGe/rbwpIif6uS5aBrnWl+rTy71e5tIVXqWY89nz4S0N69MX5H0se6BJAZc0NiLdH/PoAtwZVCWJ+/FpwFVXiGlT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNRoGv+L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201cd78c6a3so12940515ad.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723786957; x=1724391757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zci/IGVklrrERd0voR2gAN0eGC9GDr/hC8qN9xtn5Q=;
        b=MNRoGv+L75n31rXUDqnb6D1B4a/SdMcuNN7GhMn0Ip8O39p31hVQrNZh+3fWPh4vYP
         J9wCcJSX0K6qYjk6zOK25KUbK7ayidemcWKBXs9dalTVLNutbxnv8zYCU334qGdTub/Y
         nFuCd7lyuoGG2EXRKRA237x+k748N0KCVWO6kqfDR5RWTsZfBhTeGrfKyJplRrs1WWKx
         x0u2LRJIkun2w3y6AEIwEmY+H3txoiG7aoLQVscom0OmTEw+wVOW4zWwH1uq3dSK1Q0X
         SfyuBR+heB6p5xPjVBE/hwrDtek3QXBW7vUlE1/eux+T5q0Z5s/5Cvtw7VAgLA4Yon5c
         LA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786957; x=1724391757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zci/IGVklrrERd0voR2gAN0eGC9GDr/hC8qN9xtn5Q=;
        b=neHh1xdKM62lZCN9tpGYyOOwyMqNY1SP1UxipoZbxlfXggf9Aarv3EZBHFBYd/cERh
         frVGngrVSw4eZbuMsTJNNQk+93nZH9E1c4K8/bt5rRnLZjOTOcAjAQsjl0ZP8ZFqcvRy
         dmxYY0/kLIz8HrUTNVY8qmPFzEkkkhBD1hgLj+6XBTPv4HYE0MlKxzOQXXtsdhWwZSof
         njTTAzsrGxObF5QBKMw9kXrdKYh63rUo3fM/CFC5Nd0ecqXuW6Gz66Z/cxlOz6s+jfWw
         iMM5wt7/iA2NVR5u5nOkOsmcULc+pcTteNQi7BkB4DxyNfDev/QI9SqdB4+LISc+wUxo
         hLyg==
X-Forwarded-Encrypted: i=1; AJvYcCWHNzTvMVSGPTtw2ZyrHAAtbTktz+qQQscFpYW/ldlIReD3BpS8ZJDIYYQYas2Qt1yD6zCNULO5NJkuA/gi6diOQnVfTZ+VmPDq
X-Gm-Message-State: AOJu0Yx6QTvp3fwZ+fi2OBrB0BZXhyQs0agVHiTS2+UwHP4lDLQyHmNz
	Ve75DWwc12qIcYTH2ZcXJwBio3Rq4u9hOhcjOUJDnahbhO7hyfFEr0fxBJ2EqQ==
X-Google-Smtp-Source: AGHT+IHIZHrP5ZboVbh1QQZED8rf6LC/BeZ6VJ6E4Bv0Xpt5BhFb5YGqBfgkTjypqHMC3h9KdBKjEA==
X-Received: by 2002:a17:902:d4cd:b0:1fb:1497:c304 with SMTP id d9443c01a7336-20203c08736mr20189095ad.0.1723786956641;
        Thu, 15 Aug 2024 22:42:36 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa4a7sm18548605ad.38.2024.08.15.22.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:42:36 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:12:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Message-ID: <20240816054231.GG2331@thinkpad>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
 <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com>
 <20240815155343.GC2562@thinkpad>
 <CAL_Jsq+rnUB2pDjf6qFF7ThtSD-C8MMZUrhJmTYKfts34Zhr-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+rnUB2pDjf6qFF7ThtSD-C8MMZUrhJmTYKfts34Zhr-A@mail.gmail.com>

On Thu, Aug 15, 2024 at 03:15:52PM -0600, Rob Herring wrote:
> On Thu, Aug 15, 2024 at 9:53 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> > > LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> > > PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
> > > so drop maintainer information for that.
> > >
> >
> > Instead of suddenly removing the code and breaking users, you can just mark the
> > driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we could
> > hopefully remove.
> 
> Is anyone really going to pay attention to that? It doesn't sound like
> there's anyone to really care, and it is the company that made the h/w
> asking to remove it. The only thing people use pre-production h/w for
> once there's production h/w is as a dust collector.
> 
> If anyone complains, it's simple enough to revert these patches.
> 

My comment was based on the fact that Bjorn was not comfortable in removing the
driver [1] unless no Rev1 boards are not in use and Frank said that he was not
sure about that [2].

But I think if Frank can atleast guarantee that the chip never made into mass
production or shared with customers, then we can remove the driver IMO. But that
is up to the discretion of Bjorn.

- Mani

[1] https://lore.kernel.org/linux-pci/20240808172644.GA151261@bhelgaas/
[2] https://lore.kernel.org/linux-pci/ZrUJngABI8v3pN6o@lizhi-Precision-Tower-5810/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

