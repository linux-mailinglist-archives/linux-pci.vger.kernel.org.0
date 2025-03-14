Return-Path: <linux-pci+bounces-23752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86AA611FC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 14:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6718C3BB99B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB01E521B;
	Fri, 14 Mar 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pxzv8TBL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEC1E531
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957520; cv=none; b=PLM7d2GecwVmijL3FtqzirM9Z5yObBA5x2G7qh5y1qCXyBTaTCLCpPIKJ+xp38gQ+3NKNNe/ETlyWT3L6O8VMwoGOttPDNBe3qcfMPqF3/EWhzUrHAHfPbuIoWBg+q2TK7+2Zrv4voSuAIxYC44Gh4zoe2IqMEVSlifFE3uyoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957520; c=relaxed/simple;
	bh=Bp+yUfR/BUVTN0kSxxdvBkfquqMsS4/iOvCdYieA9Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emko20XtpYR0DSxeMBdsCdjjKmx5i8XjDO0jXq4Dqm1fL8NigON83cZvp2pVWkuQyT/rAv+H68T7TQz7ltWd3xwThaku2oU/vdrhtiz3qEBikI8YjQsT/iy4DHEkzAsWJEbNm+6a7mrqgIhardsFTAsgiJzVIhrNv/ZpsBSsnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pxzv8TBL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2232aead377so45270065ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741957518; x=1742562318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRblWdI7mkID34LfuZJ2escYTtLCuKs2WVmIAWsWW0M=;
        b=Pxzv8TBLsUOahBo7PFQ7z2FQAb8cG0onBpYkSCGKbEI46NtGyhqVdm5MJpIWH9MgvB
         +mmXRv+FoOXR5rVYsMfZPFk4VfMfLSKwPQw7C8COD534s9hu/LhzEWNXT85rSypWUfkm
         put/N22IAGJ5C9gOmX3sGU6BBdX+zj9+3xkOELu/j8xegICJ/cyPuI8cEcy+/+ByEIEu
         C/ADmXIXSE7KKjliuHKrfKai2uyxpr+Ba089qQp2en+asbvtVFsanN0vQk/b3MLbmpX/
         dS3U6QXUZ9r4uuVljCOPXIbzrnNJabx2/mK1h8sud/aJHJ+DaHadyScQ9y9l0vfU3+HB
         ot1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741957518; x=1742562318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRblWdI7mkID34LfuZJ2escYTtLCuKs2WVmIAWsWW0M=;
        b=kBDmAbUflc8XrsnPzvhtNl/nlxiw6x6eQzE1mHpp+nVdqm+xJyOMc1kpeVIBIx7Kit
         VFgBIAiCud0ObDvFN6HlgvfVGLDBeZDguRaAJCPgQl3Xcz9Dq9DXVHIDaWPb6VN2Vnbc
         Y0JxpnKIn+U81bn2Q5lqxe3I75gcLrFAK2VCiAodwQJyE7j30z05ybGITtECHZK9Xaut
         un3pACW+2gh0Nu3vKF7dBwsE1dmZxFXuco9+QKAK+ow5gRaFVMYmqNOTYB4dA/xTOxIH
         jvsuBJeskvDsA9EogmZvWtU9OJaeSjAv5gNL4pdr/FLQv3loqDtMGlvPb5lfEutT4gIM
         0Cyw==
X-Forwarded-Encrypted: i=1; AJvYcCWwRhBkaTxKFeHTlGVlcTlnlB9GYqKhjEU28bWdUAxHw1pCfQNfJ2BaB2ZxYULOSE4xgolXgc2PuBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rpLZ16rxi29ooEsovMT8AtGPVhpvWzL4cykpnBiaXAN2l3mv
	8nrPc1fUnjx3/XGOJvNj9zFlrVYzL4aMmRnBqp2oR4Ck1tmn1N8ZmJVenPCcBA==
X-Gm-Gg: ASbGncsfr186FUCLYmMRo52fA90EJlb5wgQBQOXPS9oD/jniK5bdi/n24ObmyOowIK0
	qEOC+pR+lNiJm5MiCc7ZmDFJQZ3h0NyPRrvpmGxaR9ISt4rtOR5IHVMVnGqNC9I61dm94aNW5JW
	cpOYE3xpXaCDKuDL6vwzWwxVx3tLiYOvdXH98JnIzUTgiAa/4FjBL7wJFiRwFUqVc96/HkmIdru
	FYEwUVlisdcCVrGyVvvaPU3a6aToGZKf16BEe7zmy1e6nctdqcbxZeHUmH/aSNMA0d8y9QFXp8S
	9HXiJJ/6xe5zaGmviYytsBrah+yBEQShVaRqbrlxbZtWq/opSfjffK3CxNpEx5DACaU=
X-Google-Smtp-Source: AGHT+IGoPEXzVJnmuqrzVkeYZ3RggLz9YfKCX5FweKJeaERv4ORk4uqdfjB8FBS0rzsr49sWfcR5aA==
X-Received: by 2002:a17:902:e802:b0:224:1074:63a2 with SMTP id d9443c01a7336-225e0b09859mr33593705ad.43.1741957518482;
        Fri, 14 Mar 2025 06:05:18 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfe22sm28051975ad.206.2025.03.14.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:05:17 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:35:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	bwawrzyn@cisco.com, thomas.richard@bootlin.com,
	wojciech.jasko-EXT@continental-corporation.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250314130511.hmceagpx5oq5gvrr@thinkpad>
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
 <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
 <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
 <20250309100243.ihrxe6vfdugzpzsn@uda0492258>
 <9eee0ab5-d870-451d-bf38-41578f487854@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eee0ab5-d870-451d-bf38-41578f487854@163.com>

On Mon, Mar 10, 2025 at 11:09:54PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/3/9 18:02, Siddharth Vadapalli wrote:
> > > Hi Siddharth,
> > > 
> > > Prior to this patch, I don't think hard-coded is that reasonable. Because
> > > the SOC design of each company does not guarantee that the offset of each
> > > capability is the same. This parameter can be configured when selecting PCIe
> > > configuration options. The current code that just happens to hit the offset
> > > address is the same.
> > 
> > 1. You are modifying the driver for the Cadence PCIe Controller IP and
> > not the one for your SoC (a.k.a the application/glue/wrapper driver).
> > 2. The offsets are tied to the Controller IP and not to your SoC. Any
> > differences that arise due to IP Integration into your SoC should be
> > handled in the Glue driver (the one which you haven't upstreamed yet).
> > 3. If the offsets in the Controller IP itself have changed, this
> > indicates a different IP version which has nothing to do with the SoC
> > that you are using.
> > 
> > Please clarify whether you are facing problems with the offsets due to a
> > difference in the IP Controller Version, or due to the way in which the IP
> > was integrated into your SoC.
> > 
> 
> Hi Siddharth,
> 
> I have consulted several PCIe RTL designers in the past two days. They told
> me that the controller IP of Synopsys or Cadence can be configured with the
> offset address of the capability. I don't think it has anything to do with
> SOC, it's just a feature of PCIe controller IP. In particular, the number of
> extended capability is relatively large. When RTL is generated, one more
> configuration may cause the offset addresses of extended capability to be
> different. Therefore, it is unreasonable to assign all the offset addresses
> in advance.
> 
> Here, I want to make Cadence PCIe common driver more general. When we keep
> developing new SoCs, the capability or extended capability offset address
> may eventually be inconsistent.
> 
> Thank you very much Siddharth for discussing this patch with me. I would
> like to know what other maintainers have to say about this.
> 

Even though this patch is mostly for an out of tree controller driver which is
not going to be upstreamed, the patch itself is serving some purpose. I really
like to avoid the hardcoded offsets wherever possible. So I'm in favor of this
patch.

However, these newly introduced functions are a duplicated version of DWC
functions. So we will end up with duplicated functions in multiple places. I'd
like them to be moved (both this and DWC) to drivers/pci/pci.c if possible. The
generic function *_find_capability() can accept the controller specific readl/
readw APIs and the controller specific private data.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

