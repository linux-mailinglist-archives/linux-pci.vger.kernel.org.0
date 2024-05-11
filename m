Return-Path: <linux-pci+bounces-7378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AF8C2FFD
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68ACA1F22CF0
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E07F610B;
	Sat, 11 May 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ8Umm6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B94C65
	for <linux-pci@vger.kernel.org>; Sat, 11 May 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715411739; cv=none; b=P0wgcemsJq18tyVpEssgyz3e8hevRJULuJMvLSmND4O0vAnK28z+addPhn1Aa242sWhvCf8286oJLp18U8+DurNWPwSlKGQi72QMfZMthCgwoH3WUYkcAolZxUxJgo2azQmGyTaD5FhEWH/L54Hc5XIMLIrJeMTo5P1e+jrdWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715411739; c=relaxed/simple;
	bh=kP1V+EtzTHOEEdN5Tn2jtj1uoNnrhiy0O47cc8AcxA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0e43rQjw4UK/8FRIufuJfyJt4IAhLdMwYt0RcPmp4gHFlzC+bN3BnLAuc8j6wO8p4hBk1vTB+aT6fjcyhOMnLWbYI37gncW7U3lOpEq4Vk30bQqbwQxoJJrlEVVYOwPKhJkIiFO+FaJ5QPqZREmFoc7LQdE4vqjLY8CO3L73XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ8Umm6z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so25170165ad.1
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2024 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715411737; x=1716016537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pN7vTSTZWouaFkH6aSeXVb/sXxzlUMYk7HqIZeYevwQ=;
        b=bQ8Umm6zvhdZEy8vmaUvU2Iw+3U4Exz8vwTgIRHmU1+T2F04dp0en5kuEIdr+5tQzo
         +k7bGjYcwQfTPZoIoQwrmCUzxfUwE54ypPLh4dgQhVYk48QK4F873xf5Sm6kzyHrMbqv
         Xvrhfeuu2zU+u1viYA5UESzip+io/i7WdnsN38JPvgdV8fr5YrCJzqOJS5SguRw1843M
         l9MTBCHS6/LZfI+Ql9sEZUvtDsJi1e8k9f5tb+R9ZdsX5s/pcFGLoLSNABEVUvClSFot
         fbpKjfaCo6BLb9yjTEhJHdbRompR68Fx+q88r9bt3BTpcaiuPSAJfO1kteIcRVkkvWsI
         9Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715411737; x=1716016537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pN7vTSTZWouaFkH6aSeXVb/sXxzlUMYk7HqIZeYevwQ=;
        b=OqPYdz95SnuRLDao1t1l+HwhMtPo36NcnmE2cDsvBYzj0pz531bA/ww8Foh3r0edLQ
         sxF1AEB/V0Sx6znU/N2ai5IVs6e2wlyj4jddlIgo+bcjfr+OjdJobjeYpqK1D3uC/Wxl
         DIBs3j14AB3iOqilrSE63QG83SMfcE5LxFmH7aSPkzyQYnPIU7LVAwDcqi5OJ95/S6QQ
         M1wEGZSq6JOB05H/HxCBhZ3zHbhySoRKq+c1uzHE7RCWAQwfUqv0zf0LLsX2IlQH0Rk8
         YFpk05P9CU2RnxzAMOw/cEnztxanzcXgEzEZp3Q/XLSo9gxdHx7Lfkk7PZjkDqvyhcSY
         KByQ==
X-Gm-Message-State: AOJu0Yydvy3BK4zAj5axNJyGBg21BCS+6v4wWWdrHXbnzEX7eayMqlyO
	D0QYpw3ajlGXCwtbTOOmgmgc9KRHQnqubuiCqNP6BP+FJhYk+eyK6j3bw/oH2ANKhrgecdd3aZ8
	=
X-Google-Smtp-Source: AGHT+IEY+B1BkjgUqaJCKTMhy5yVKUSG7mNrjc92+kUQaGR7pn2oJDp9knykubItipbI04Y4Mn3Nog==
X-Received: by 2002:a17:902:6542:b0:1eb:1240:1aea with SMTP id d9443c01a7336-1ef43d12749mr52124555ad.20.1715411736886;
        Sat, 11 May 2024 00:15:36 -0700 (PDT)
Received: from thinkpad ([220.158.156.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c0369f1sm43017055ad.185.2024.05.11.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 00:15:36 -0700 (PDT)
Date: Sat, 11 May 2024 12:45:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
Message-ID: <20240511071532.GC6672@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>

On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series allows D3Hot for PCI bridges in Devicetree based platforms.
> Even though most of the bridges in Devicetree platforms support D3Hot, PCI
> core will allow D3Hot only when one of the following conditions are met:
> 
> 1. Platform is ACPI based
> 2. Thunderbolt controller is used
> 3. pcie_port_pm=force passed in cmdline
> 
> While options 1 and 2 do not apply to most of the DT based platforms,
> option 3 will make the life harder for distro maintainers.
> 
> Initially, I tried to fix this issue by using a Devicetree property [1], but
> that was rejected by Bjorn and it was concluded that D3Hot should be allowed by
> default for all the Devicetree based platforms.
> 
> During the review of v3 series, Bjorn noted several shortcomings of the
> pci_bridge_d3_possible() API [2] and I tried to address them in this series as
> well.
> 
> But please note that the patches 2 and 3 needs closer review from ACPI and x86
> folks since I've splitted the D3Hot and D3Cold handling based on my little
> understanding of the code.
> 
> Testing
> =======
> 
> This series is tested on SM8450 based development board on top of [3].
> 

Bjorn, a gently ping on this series.

- Mani

> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org/
> [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
> [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org/
> 
> Changes in v4:
> - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> - Got rid of the DT property and allowed D3Hot by default on all DT platforms
> 
> Changes in v3:
> - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> 
> Changes in v2:
> - Switched to DT based approach as suggested by Lukas.
> - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (4):
>       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 possibility
>       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
>       PCI: Decouple D3Hot and D3Cold handling for bridges
>       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> 
>  drivers/pci/bus.c          |  2 +-
>  drivers/pci/pci-acpi.c     |  9 ++---
>  drivers/pci/pci-sysfs.c    |  2 +-
>  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++--------------
>  drivers/pci/pci.h          | 12 ++++---
>  drivers/pci/pcie/portdrv.c | 16 ++++-----
>  drivers/pci/remove.c       |  2 +-
>  include/linux/pci.h        |  3 +-
>  8 files changed, 89 insertions(+), 47 deletions(-)
> ---
> base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> change-id: 20240320-pci-bridge-d3-092e2beac438
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

