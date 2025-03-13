Return-Path: <linux-pci+bounces-23668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A808A5FBBB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701DD16992E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683ED2676FD;
	Thu, 13 Mar 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdSHNCwS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8513B5AE
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883424; cv=none; b=lwLrJQCqdWfNoyVO50cmxpDpdDwtmDZCmGHsefKfHoFpp18LsAuCVMG5ZZtNUowTLpzZN0vUOkv26l3ek46ZBDSKUiWGUgwuGLRFgQW2W2WUraukJ8X4NCYCq+3/QuRdaPFukJKwtIEtnGAF4JUBoASJyALXMg15Ipv535fI2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883424; c=relaxed/simple;
	bh=4hhdqF3Rp1vH31nmCsGM4U9PNPxQFzWtChioTmpUmgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4azSGd9qlx1MKjlyaCfcnTpvuBUi4Ois4eaefwJ2sVUc/z28BuVyw9TMJNTJqc4IMbzz7vxAANxFl1WcPanfKyCEL84y4jCvTE7WsxDmIxUfovlTZQO+tHlkBz2VYKFiSA4E8SilNyzLXvpSc7M0UgtYeOecnv8FjsHqoGMuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BdSHNCwS; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499af0cecdso116367e87.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741883420; x=1742488220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=BdSHNCwSAeeL5Y3xTG/X+vUoIFihijZZoWuYcRRMTHFIRnsBz4De3p6QtmdcHbrb3Y
         16F1R4C+ZCbk4YBFzW3fXK0CV5BR5BpPaUfnTf615Lflxjhcup3I9ZQqhc+TCDRxbGEq
         RtVJnuC3ZKo4tDm5GL76ZfoPvN4MJrn3WVaujV50V5L9sfjEfFKirOx1AZ86PJqDFT/v
         /PsMoNS+jNceKIuS4QmqRoFqYYNSDhw0Vf8NTF6ypP6ZtP3DQuJK7d4YrFMJz11EBsXl
         mzP81WvgtvLLUYJxKUX6Oyk5o/nXoo9wksUJaImn7aG3/KZmRKly2eCYKXfnWpAW92KG
         3V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883420; x=1742488220;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=kWmxfVyO/5N74vIclcxz1VDBNUG1kWqmrgoYi2xqTnHtJsMn43RSALz9ZDshE2lv9y
         WfnWAqrxuTlOaQ2135cvoCyJ8EBRH+9YnG0Y9IcXuSE+z110J3XAd6U6onU+/5SeE44V
         xuVbSvzUyNhFWz4lbsytmVo8kpMt7c2bRpMaip0gXOc0omrHh6w8xQedN0tH+ysIusLy
         FPvtbi7GeF8bW8kXbdN5KeMNwBSMizJLrkSb4Qtj8DMeucJVQNGV0N5xDR8zz2W8nF2J
         rosek59MPvYmri/fK4lWHURkWKA3jlmuT6dSsBnBjTlQEr5gHkF+lzJU0HyLzNUa59mx
         yxBA==
X-Forwarded-Encrypted: i=1; AJvYcCX29WkF2YMCMkaly0zuH2pSAlSehRBVpiSyVHIJq8Vu8U+EPaussCISPwZ+qGCkYyjqxrIig71CGS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2e66ZpsF7GOJu8K6CbNzvVDKe+jO7AJiCjN6VrPgepJj3k6u
	giqACVvIdi7ENIxjg6s8EPAPAQjLPZdCVPP7Gka3s2RkZ0WprjThtJrrMlWporM=
X-Gm-Gg: ASbGncttDSO7eTQuajR6v0J+QSUUmBl0D3uC9odhCQCL7ZnLCGuGaZgfGH5fy4hyOyw
	v+GTiQwOlhvxCY+sDfllADnHR3i9rLDzUPI7Vh8WZn+HSSGj1emttXtIFErNmnmeEj9B5eDPojN
	IXG0kLojW4p5UX2EorEtHBoZewGyjIe6xvd/Mv8K5X4/0kJgsmTmwnFsHlHMEh2I30znVvGbrXJ
	lIo9tZEgi9OaO6eDjAEJMylDYWreXmjihdoJcOx0980V3PBSMMHXEyNxupmV8gRFZrvsxlGziJG
	R3vkViyKk6jiPmsG5mWRBEAWWC0vMhDYn8T144ntv+9L8f8Y8r6SsUdKyWUnVD7QhFU/+gvg7k+
	xlmXeFhZEzLSNkjuQaw==
X-Google-Smtp-Source: AGHT+IGtn9WumNOaMuo9cAzRTdloUKB5tTLRLe9/61uA56u97uNJuHXYLD/mRuofS9RqJFSJqixgYg==
X-Received: by 2002:a05:6512:b0a:b0:549:8f39:3e63 with SMTP id 2adb3069b0e04-549abaea8b6mr1524832e87.9.1741883419995;
        Thu, 13 Mar 2025 09:30:19 -0700 (PDT)
Received: from localhost (c-85-229-14-155.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-549ba8851e1sm256528e87.201.2025.03.13.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:30:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: robin.murphy@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_charante@quicinc.com,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
Date: Thu, 13 Mar 2025 17:30:11 +0100
Message-ID: <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com> <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com> <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
Received: from foss.arm.com (foss.arm.com [217.140.110.172]) by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBD1EE7A7 for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14]) by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D5E1516; Thu, 13 Mar 2025 04:01:50 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246]) by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60353F673; Thu, 13 Mar 2025 04:01:35 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
> [...]
> > This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
> > ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
> > found it breaks booting of ARM64 RK3568-based Odroid-M1 board
> > (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
> > relevant kernel log:
> 
> ...and the bug-flushing-out begins!
> 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000000003e8
> > Mem abort info:
> >     ESR = 0x0000000096000004
> >     EC = 0x25: DABT (current EL), IL = 32 bits
> >     SET = 0, FnV = 0
> >     EA = 0, S1PTW = 0
> >     FSC = 0x04: level 0 translation fault
> > Data abort info:
> >     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [00000000000003e8] user address but active_mm is swapper
> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
> > Hardware name: Hardkernel ODROID-M1 (DT)
> > pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : devm_kmalloc+0x2c/0x114
> > lr : rk_iommu_of_xlate+0x30/0x90
> > ...
> > Call trace:
> >    devm_kmalloc+0x2c/0x114 (P)
> >    rk_iommu_of_xlate+0x30/0x90
> 
> Yeah, looks like this is doing something a bit questionable which can't
> work properly. TBH the whole dma_dev thing could probably be cleaned up
> now that we have proper instances, but for now does this work?
> 
> (annoyingly none of my Rockchip boards are set up for testing right now, 
> but I might have time to dig one out later)
> 
> Thanks,
> Robin.
> 
> ----->8-----
> 
> Subject: [PATCH] iommu/rockchip: Allocate per-device data sensibly
> 
> Now that DT-based probing is finally happening in the right order again,
> it reveals an issue in Rockchip's of_xlate, which can now be called
> during registration, but is using the global dma_dev which is only
> assigned later. However, this makes little sense when we're already
> looking up the correct IOMMU device, who should logically be the owner
> of the devm allocation anyway.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
> path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This patch fixed the boot on rockpi4.
Applied it ontop of next-20250313

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

