Return-Path: <linux-pci+bounces-18872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0C9F8EFB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BD118872FD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96401A83E7;
	Fri, 20 Dec 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWr9sniI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189A1A3BAD
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686896; cv=none; b=Aqy3THmfi3t0yspQKXyzAHYtR8Co8EU2JhvLyPMrrZwb/z86ACZqXaTlRL9MRz+ZLC35CbNTCD+NKqd34L8sbsioSqyNrO2t+98FcvwA00/2f6u3rW1C0zZRGKHIbiaP530SwcM5gRdzgioCnJEYD6NbxEGvZxmS74IkJGIfyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686896; c=relaxed/simple;
	bh=LvGW8QBcdW3zO0ImyShxRfJ2FM88OavyirnQFzdV0PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/VD+rESSiL9OA8EGjPsatIKCvcIBdKSIZXcBPFqulujUb5oZEpkY8Amn87odVGrIS0D6n7RtiqLyRA8+K/gdwgAtm2v63cXonaq5pmoDpt3DhFAzNtXh+emm3vicGNL+tuxSjpoEPuaSwRijKMUmluWP3fEl5gfFsjhOxMJIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OWr9sniI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f28744c5so1690541b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734686893; x=1735291693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zGOstDBbuzWKPR4GcvKniMYiDdZSOAYV5X1DyfRCjKM=;
        b=OWr9sniIyZsM0ysM88S+icLqfmNwo2/e8gvbRTWzExzziDF5WcXOgZzEIUOmt5cPlQ
         UyHxbo18kbU7yROcjGofwNLqHWP4BgZpFNZFU45IhUnTMGB1wRIIudjmb7kYUomEhCyr
         dmwCx127+IJiTYDI2hl0EdAK8cfcp6n7uOhlQLwhx8OwaYf+c4oAIoBirlY44TyMGjSJ
         zfV7fYEblYq4P3DJzlFpwRpUKitAru21v8/y+VbL/27W0rKCDA7kp2EQBYsUVmF8SFwZ
         yxsVBfRC+26hqkHgYrPBpYeKkoZbQe97J49TUQ8NYxBLoYUv4qj0n5A7gg5bFOzJKyyq
         KbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686893; x=1735291693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGOstDBbuzWKPR4GcvKniMYiDdZSOAYV5X1DyfRCjKM=;
        b=qyfScizFjaVygZgeyk4LpBUGPmu0UF+gu+50NqIFysJJ9KnMi0n8ffn0j/80DBn0hO
         Wep6AiRGI0Ndbj6VvVs1+O0GzjAktxfv++CCYK3OzOdOHMVuy3pIEg2BzkSnrFR3DN1k
         lC3AeUQQnKjhbrlOEHjtBbKaMNAeIKMvaHan6RLFMHNcINqiQCtT7MRWaGQlJ05vfCFh
         HKccy3MjK108VifyYmPmf2JkrkAlzoU6BMOpp3o56CKSeOcxL9tEanYL6vBCATEUx4Mk
         fITSeHb6pCGRwzMXAp/LfzwVlO8KnMqVDYyxc7FISQ8GcQOP1rr96ml9rPF6VAzYihzb
         g5pg==
X-Forwarded-Encrypted: i=1; AJvYcCVRhQOibGXIVKP4ilreaqQHkWcAEvRYSyylUn/OWd9Ne/oqEInUjKHRjIvktTqr0Jsq9iLDAPPJE/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mG6+tcl909/6h460ag7xv5vjW1lIQ89AzABJXFGQrMoQb/0n
	9xnIGcmy2ux09/OFmoGc2wfyt7mTapOJ2kr+WByRGPSzgN+nwHOpfuYEYGCCIQ==
X-Gm-Gg: ASbGncsVfzXfVnHHxyPjdniYn2aFmyb6eSk8WXuwIjE5yeRpE169lA5v6Fde7B8e9B6
	nqb7YizZyYAn1MmqQ9stD8Q+GMYRU4L2/TZXgMd3Ls5jSDP4bdC/zU6LlZREHIDsan3ICHWQ+zo
	htpKh5zzKKolhxpUL6pTapwkD7ta8mn1m6G1BUxluJrZ/lBPcUelBJxFzaUtgQT4QRdKU3UpUba
	3VQHfMnn8oJbDkIsp0C1CbZHH1z9ZQEUqWXV8KBN/3NsrI4xhZ/Mcd81wBYBn5eIhkv
X-Google-Smtp-Source: AGHT+IGUBmYsueo5Wz7hkGJCR2jBDC8RNOZlfQ5c+U1fPAd+Ac3LpGvoXg6oS8pEIjjRlHfe5J9L1Q==
X-Received: by 2002:a05:6a00:3e13:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-72abe060a05mr2947359b3a.16.1734686893272;
        Fri, 20 Dec 2024 01:28:13 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c25csm2674940b3a.199.2024.12.20.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:28:12 -0800 (PST)
Date: Fri, 20 Dec 2024 14:58:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241220092804.zgmge5pf7fm6wydp@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-19-dlemoal@kernel.org>
 <20241220081428.k45ydh2sl3m3vnhl@thinkpad>
 <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd769dd-9ab8-4811-8394-24f1c8e17935@kernel.org>

On Fri, Dec 20, 2024 at 05:37:20PM +0900, Damien Le Moal wrote:
> On 12/20/24 17:14, Manivannan Sadhasivam wrote:
> > On Fri, Dec 20, 2024 at 12:54:41PM +0900, Damien Le Moal wrote:
> >> Add a documentation file
> >> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> >> endpoint target driver. This provides an overview of the driver
> >> requirements, capabilities and limitations. A user guide describing how
> >> to setup a NVMe PCI endpoint device using this driver is also provided.
> >>
> >> This document is made accessible also from the PCI endpoint
> >> documentation using a link. Furthermore, since the existing nvme
> >> documentation was not accessible from the top documentation index, an
> >> index file is added to Documentation/nvme and this index listed as
> >> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> >> API index.
> >>
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks.
> 
> > [...]
> > 
> >> +Configure the function using any device ID (the vendor ID for the device will
> >> +be automatically set to the same value as the NVMe target subsystem vendor
> >> +ID)::
> >> +
> >> +        # cd /sys/kernel/config/pci_ep/functions/nvmet_pci_epf
> >> +        # echo 0xBEEF > nvmepf.0/deviceid
> > 
> > It'd be good to mention that the vendor id set with nvmet configfs will be
> > reused here.
> 
> Please re-read the sentence above the commands. I added exactly that :)
> 

Dang... I missed it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

