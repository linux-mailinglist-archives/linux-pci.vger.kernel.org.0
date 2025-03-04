Return-Path: <linux-pci+bounces-22866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A166A4E4E0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832617A7344
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1DA24C064;
	Tue,  4 Mar 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNptpm8Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A2209F4E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103177; cv=none; b=mFbRVg/OVzma3xWmjdMDgltU7o9Mn5AQVKw5d8jCHmMUqFAqMv9yp455JdNZyXTGasllq4GTOgzgG9FpdpUDflfh9oZyfLKypWp5Top/UoA8yibS0grhb/CIzT1ELJpAu+IPrbg3++u2NwF9NZHGn9PPnCrM7liJiIi/2HS0jgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103177; c=relaxed/simple;
	bh=p9MPleuZDVUI+Z5MIM/sLliMtf8a2r+Xk6MzUvX+8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+EbuXVOrv4CFEdiMOmbs7EMCePSnFJQ8+/tItcSHWSUtu/9bJM6vkLevjAGxpqbpBsaBEoCKnMyeZQP4H84MlORQaGkuE7LLHjimEU+awbh9bUIvA2mc1kXj++D5HMHFDZCQt7dKBSiG07KVG5eJBFWgBt3KcHw3JQrumFnoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNptpm8Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so110939305ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741103175; x=1741707975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YL+VxJ0Q3RaNWRR/aVESAdhzcvG1F11vJfodj75NqY=;
        b=RNptpm8YkrxZcFlQ2rmewYn89/+UhNfS16RNomfluGKNP0b8nm9uCeOcsTv9w8R+CF
         DtThGJFCaAFF+Bvq1IIltAJO1URcZ4z4ZXGbjXU2X2NTzzVCKCJEjyXUeHJgH7IK2C1q
         pmQwjPq4LFEsK9ukMBov1dgkFGpsVce9pNBJ4E5lboMB28Vl4H523S2ULXgiN7kzJoZH
         NiyIAT/6HzWP5IOswShSCBUQmLPjvPtK4BgYUDc2XUaYxsnaYlsLgyVexqgE8tcyOXaX
         cHCIpxgtFC07FBV26Bq98ANcYpLL93I7mXchbtXKqWdi3VYoVt7ktBQvNXwr2lg9S163
         2VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103175; x=1741707975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YL+VxJ0Q3RaNWRR/aVESAdhzcvG1F11vJfodj75NqY=;
        b=PljEaqvgoJmdPscBrve7IdkBhvx9qev5km2YN6FVWPAn7CF46L1kCWNHYxW/VHvgEu
         77/gQaxL6iy/csIj3Q/4lQ6hjnN+R2Py+UU24brERjHLB8aKXB0YL6xM03J51+G25ETN
         ZnNQooHhCC8HjT1ptvw6dpHRrCkKfXB1DS/PGReLJiRwAz4tFRsxQG6vAM5eu9IEHHrI
         UDEdXaS/BfRKRsib/ojalBSG1KiiUENh+BjjGEceNiGo+bzU6PUOtP+1pbYnnmq6eW65
         vhVFLHnBxiV4vi/0SqM9ph/5PYHzjBjiL9S3hPnUrmi+l1T+y/B/omVjFYKbNq36ulgN
         MgEw==
X-Forwarded-Encrypted: i=1; AJvYcCViNaDTaVo1At6PTZFzIRqbg238XW6btQfhBlFrwx4uM4Y6KwbTTfR0ppg2Uo8TXkMITePcCl6je6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQLnsBfP+HrR45clfOUhagNkFBTBQ/6LjTLtTbqOzraiyYHm+
	VAD9pLveC538k7N7ibp0l04G4iZQhAKn5JPdnUqqrnCx8qbj0DMKvLyTpElsvA==
X-Gm-Gg: ASbGncucVDlPCUDsFZ3BYeLe3/1gpfCZHo8nOktOUn7FgwyvXToaZ12lMlIdjOdz6ar
	9KQ/0JFY8uTAbQNHHKYf1y6AH/6eHh04YsOhkBKWvSajrGclyE0iSpRvPqMdM0vKMw9U2uRYk2+
	jPNdqD6aCQFFz87h521Dl1pHY9KKwKwH3RZDj4yt2s3BudaBF1fz1/eaVafWG71MqYGF19fadeO
	u8bHC555/lEk4znfUBVMN2gT/roJCWFu9MWC5qlWT53MCmvgJSqZATcUPcl78knPidFH0H4RgXn
	2lM+TjkwiaO0ZRjgE1OlZrVcXIX0AXtZW9QQoR2Z/5W5+CP+bsLGNMk=
X-Google-Smtp-Source: AGHT+IEu5Llady3MDRUfE27shPyV3JvqN+sd6X1GgDxXaMbDHoS38zRfVq5TjcSVc4smqJopw9/IuQ==
X-Received: by 2002:a05:6a20:2447:b0:1f0:e706:1370 with SMTP id adf61e73a8af0-1f2f4e4e1f4mr33125419637.35.1741103175351;
        Tue, 04 Mar 2025 07:46:15 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf206bsm10352962a12.6.2025.03.04.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:46:14 -0800 (PST)
Date: Tue, 4 Mar 2025 21:16:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error
 path of probe.
Message-ID: <20250304154608.5nmg4afotcp6hfym@thinkpad>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250224155025.782179-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224155025.782179-2-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 09:20:22PM +0530, Thippeswamy Havalige wrote:
> The IRQ domain allocated for the PCIe controller is not freed if
> resource_list_first_type returns NULL, leading to a resource leak.
> 
> This fix ensures properly cleaning up the allocated IRQ domain in the error
> path.
> 

Missing Fixes tag.

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..660b12fc4631 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  		return err;
>  
>  	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> -	if (!bus)
> +	if (!bus) {
> +		xilinx_cpm_free_irq_domains(port);

Why can't you use existing 'err_parse_dt' label? If the reason is the name, just
change it to actual error case. Like, 'err_free_irq_domains'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

