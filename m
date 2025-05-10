Return-Path: <linux-pci+bounces-27535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147CAB217F
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 08:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3573EA06D69
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52661E0E14;
	Sat, 10 May 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJjYFr+J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BA1A841A
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858063; cv=none; b=lpSQrMuoCMJ/uMQNgFGI7cHefXjV8TQMPqjfcR081THEi+Y4OA2oyb4aToJJ8Hub03YUny+bE+8sXoI7ZCvXe5akwsj4mGxWxPLdG5/fk1T3NQFhHwDp7VVLj3iPxfaXzQQdaclJIe/pxKU9p3lEQhgTPQMptAJINUUE7cHICeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858063; c=relaxed/simple;
	bh=G7abpqL8RvpRlWD+zvtJLyi96mYVrRAzZ2niGWVpHIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8+HDlmeTzZjp4plpZLfSq3chr7DB20FLAWOqJG1V9z+HgxkRb4TCK4hVTBAPFpGHXiUg22c1m0A1Lmydbby9gLbxOjs+iF6GMPqu6cGD6ZL+aFZJ9vsK0+zWzsQu/b2m9ecHcuWGzr1Dy1yPSXGiw2lYx8yXInF2NjV4D1j0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJjYFr+J; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so1315781f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746858060; x=1747462860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I+RgFtK+DYsqfK+/OY/0o6c1VEud7Ds1bft4JaN/wS0=;
        b=yJjYFr+JTBeCBhcKr6FzN7C0L7dYoN8kPjjIK0h0QN5CaOrTKz2WiYSrNBwZ+j436Y
         WyO5EaRp1Bbo56BzpHbXpatq0zQ3phK+okEqK8hn/XBrBQlNs90e/QBWHRWvQelYGk0D
         4qJS3ZSABFr4wWffyC9XxYn9irgB/ZNRZXsu64caXAScJpSJMzGSgO6/BFQ2Teuvk3SK
         a2Nx6WnlHOYrzL/7a+3sEKf4ORHhr5VZtET61AXL3I5Lb8PJhsXByCgOiM2v/YDm4C2D
         WvwrO3EISOXVpUQa+s5M9REKVfjAh1WmCSoA6IZX2KDFx+Kc10ScWHC/2sKpS8f8Ao7c
         Cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858060; x=1747462860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+RgFtK+DYsqfK+/OY/0o6c1VEud7Ds1bft4JaN/wS0=;
        b=s38qD/ZG/jAc98CMDm3rupsco3HM19f7gro8yd2HFRPo4jSjg12ZXv+vWPPT6HRIeE
         NLMTfXFHwWvm4L00gCHjQ/iPEmDT0n49kW3Jush1nizrsnwGrMKjO23KpB/0aPat7ZpR
         9zPozDu3UkJsDDY2C2uyI+R3BA56e7slP71NDuk8ERDnkxeUkt3T8bpvCu0uVgD6gInL
         hQNCV3l+AbTBuUHqafJUcAxHgUFPyBcZiwlKYH32HoD5DBEPl76+3UN7eXK8OBPZ31He
         wHT+nvyK2LoUNHUmIGgIcie+ET9zVvcnzdEclTNwtbtI3Y72eBp2AwkDbYaHTGLt5yqu
         W48A==
X-Forwarded-Encrypted: i=1; AJvYcCUkAu0hKL4T//zNkWJN9HbH6CT1IZ9KR8dgvkayFGn+c+beRbHzNjMYArDklFEUe/iyXkHSn5QgaT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxKQzyDX7uvxPcFnqNItZuiblxmWSNImjLFVsPLpuvyZCyLVM
	JsUxq0jEtWaLsSmuDzrFHKJT60accektT+BlqNLYt5F5u1o9Cbr7o0rJnbp2aw==
X-Gm-Gg: ASbGncv4WCtRelCBSe/nFD2/aRCy6zoSfg79DWxlqtUpHUC1aXfzz2kskz4duYPg+n9
	6HfhncmQUm25LXBhQUGZ6iXT0sDfSEG173KkmkESoCD23dKVamFgBd1AiS3fW+I1lwbVMp+U1Hg
	7mXYMzmK9vqS3AlHIdryACgUAYXI38+mLyELmHx2BswxuZK4njE/Y9YD5UFHaE8g4qI8RulPa4v
	tvdixQf8BkSRSDWPYmZAhshNIl+Y9UMvvlN+91SP1oiMZJe6FKToZe8p4ARd+yDaTAMBiXcVMAU
	vc8L9zxhfL7PqERx5dJf3ppCAE6vizY53hQ2K7YuZr+bR4Yg23mRVWNNYRB+V12iGm6uf/LmYCo
	l1gVI9EbMEkaMVzHsnEXIwyuo49elScL1Yg==
X-Google-Smtp-Source: AGHT+IG6eqkQasSCxgXWl2HJjaQcUoIhzrtFbVjbO5iMI91GFHnIhLWlBtSGS6/Nh1kUl6LsJ3qWIQ==
X-Received: by 2002:a05:6000:2ab:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-3a1f643eaf6mr5487308f8f.33.1746858060057;
        Fri, 09 May 2025 23:21:00 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfc9sm5377930f8f.5.2025.05.09.23.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 23:20:59 -0700 (PDT)
Date: Sat, 10 May 2025 11:50:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: Add debugfs support for exposing PTM context
Message-ID: <fehrphcqvg5nyusktj7qdxnvve2pt3rj7r7sz6p6r5qenpfq4x@r6a6fqmx5zqg>
References: <20250505-pcie-ptm-v4-1-02d26d51400b@linaro.org>
 <20250505183714.GA990024@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505183714.GA990024@bhelgaas>

On Mon, May 05, 2025 at 01:37:14PM -0500, Bjorn Helgaas wrote:
> On Mon, May 05, 2025 at 07:54:39PM +0530, Manivannan Sadhasivam wrote:
> > Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
> > sec 6.21 allows precise coordination of timing information across multiple
> > components in a PCIe hierarchy with independent local time clocks.
> > 
> > PCI core already supports enabling PTM in the root port and endpoint
> > devices through PTM Extended Capability registers. But the PTM context
> > supported by the PTM capable components such as Root Complex (RC) and
> > Endpoint (EP) controllers were not exposed as of now.
> 
> IIUC, the PCIe spec defines the PTM link protocol in terms of these
> timestamps, but it does not provide any visibility of them to
> software, so any visibility is device-specific.  I think it's worth
> mentioning something to this effect.
> 

Added this info while applying the series, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

