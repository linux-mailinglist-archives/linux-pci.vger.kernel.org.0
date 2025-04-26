Return-Path: <linux-pci+bounces-26814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EBA9DC45
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E75E925463
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A91AD3F6;
	Sat, 26 Apr 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsm8Xfwi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3F6FC5
	for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685615; cv=none; b=auJAt/XijisMCenW+XsMeo2iZApvnt61SdZIcfGhKEQWkTAHlTSEJvtykTztlUFffzhzNfBpSq5Ku9JlEUjVI+wmfaHj1amgibdEu1eOpZOxcFdSde3Tt0Jxd917Gk9KeoZC4d63MSl8UJmf9XbpM/+0JH1yQXhU2lk1PGyT9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685615; c=relaxed/simple;
	bh=wy+6QKzWQzOxQS5scLOiW/jejliu5GP0TiK4wLoJWyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ5XjG4eKEReaUmw62T6oDs5J4JUZHdp45PSO3AVIQEC/2xSWykR9wvJb66Zb3Rihv1P9OAgwEHL7khksQ7+BNYQ2rwoTKaLvCyfJPlMyvo3XNDYXWLBtzbL1w7zNJDAf9Tx9IWNZpNVBFVScd5nrz3HKK7Rz0vDziN0vwzyht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsm8Xfwi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736aaeed234so2820553b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745685613; x=1746290413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1dxk80zPIpL1q4PhQ4ndWv9Mj5fqZbTdnW5ZkYRDcU=;
        b=zsm8Xfwiz3e3STpvFeJrFwLoqRastVmc1jelVfHaKCSP053YiTMcF/eQBdy5NhbJS3
         m2U/d5jm8MvdQvKWqQKbouxL7kimYtD7B4f6GIBztIa4bHpavjrKFU9+dR/FcpZmJVwV
         Mxv7i3IBS5Re95dj0ZQWxTim9daR6u7H+YkJ1jr4BehOSXzh2mZrCf1xwX1vYISt91aH
         9tXBZdbBh8lNOBbSxIiao6dri2rN/AO4MwYXDWPIeD9iFwIJdKjJ8vaefRpR5OJciXOt
         09GOGjVIHlgwkhk9M5nZNZLhb/CEFzyVoumCywLMFXGEaP+uSK+ZPv1bP7SaGrRSGL/x
         +5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745685613; x=1746290413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1dxk80zPIpL1q4PhQ4ndWv9Mj5fqZbTdnW5ZkYRDcU=;
        b=FqI2QCT3KhDUkRG889URss3Ss1ML/2lhPL/ymLTfzJzFWi9TARfkkgYRE18acA9i/a
         ZN07zG+4TxtUU73DGB9X4klV0knSehQ5P6s6+7FKk3eV95pbaLMhhDUlKpVRarvavT4y
         5WkVx74qZ7eMzDW/E3B+3ciW3+k2Dcbdyp4I/jb5l4azB/VNQlqfxwrXc82NrQdCgdvG
         2JCMzrp0ZdncOnFq15IL068QDxk5alpU2+b8ge2E5pf72FUbkIb054lhj9nG/RriJZR2
         s4bUHVN7oH0dApaSnr5+yDtkat8JojtQB4KILpTgw+UcyTJ+u8huX/i3Usn5vIiW8lr3
         UzmA==
X-Forwarded-Encrypted: i=1; AJvYcCUSa7nFB/zor8vaN6O7E7HdaH94q2KlKfGPzAf62Gm3VtNa9R5pT2odU5KgB/E60Elu4Xbf6MKOZIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaR97AcRvvCVdil/MzKX9C7jids2a9+skeRB8ufVF/qrLDt4Qg
	gBTKm5p6rthkdkVZ7kiYHvZKfPGI/iLsA2dupk/iDWmCtctldADgkM3BQlTVYw==
X-Gm-Gg: ASbGncsSlBJwmvPWgn01PoGQYO/h5Q1b/J141wHruKCyNSZJVgKzGzDWSdRtGTd7cKl
	5yHeJ1WW20Dwjq48p1sfPwYUat9mn7KbQX2wUhsFo22SxW0pQLwWhaXW6cIkZR11OQGSw+Rr0dp
	Ruix1RwJgVELfN7zqitpVT6uvKWaY+UXyJPkh++/CcHv5bf+/ogBkNczmn6M+3B08Gbj5erGAOj
	/pAri40ulTns1vDx13UHuyNIhiyYlSfvZXrM7WFSBlhFkY5R5f0oNZr2v76hf3XpDxBqsJ5+PsS
	uX2VxkPhkmzINANV1S66OgpudmXSIcIRf3pPeK1zFqqP5SBl4KiB
X-Google-Smtp-Source: AGHT+IEwFTn2KnzLPGidnDgvRdMd237ilzSbG/yZ5gr9RWrr3uHMD0GXUKLpE0ghRpRy4DDG51PaGQ==
X-Received: by 2002:a05:6a00:c85:b0:73e:30e0:8a2a with SMTP id d2e1a72fcca58-73fd896a123mr7017507b3a.17.1745685612904;
        Sat, 26 Apr 2025 09:40:12 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm5216582b3a.65.2025.04.26.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:40:12 -0700 (PDT)
Date: Sat, 26 Apr 2025 22:10:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	heiko@sntech.de, robh@kernel.org, jingoohan1@gmail.com, shawn.lin@rock-chips.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] PCI: dw-rockchip: Reorganize register and
 bitfield definitions
Message-ID: <b6loj46o6txf3g7xrcjbewcz6kph7wh3lg732k4nfp72pfbnms@hsxzofycadgl>
References: <20250423153214.16405-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423153214.16405-1-18255117159@163.com>

On Wed, Apr 23, 2025 at 11:32:11PM +0800, Hans Zhang wrote:
> 1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
> 2. PCI: dw-rockchip: Reorganize register and bitfield definitions
> 3. PCI: dw-rockchip: Unify link status checks with FIELD_GET
> 

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes for v3:
> - Delete the redundant Spaces in the comments of patch 2/3.
> 
> Changes for v2:
> - Add register annotations to enhance readability.
> - Use macro definitions instead of magic numbers.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
> 
> Bjorn Helgaas:
> These would be material for a separate patch:
> 
> - The #defines for register offsets and bits are kind of a mess,
>   e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
>   PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
>   PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
>   names, and they're not even defined together.
> 
> - Same for PCIE_RDLH_LINK_UP_CHGED, PCIE_LINK_REQ_RST_NOT_INT,
>   PCIE_RDLH_LINK_UP_CHGED, which are in PCIE_CLIENT_INTR_STATUS_MISC.
> 
> - PCIE_LTSSM_ENABLE_ENHANCE is apparently in PCIE_CLIENT_HOT_RESET_CTRL?
>   Sure wouldn't guess that from the names or the order of #defines.
> 
> - PCIE_CLIENT_GENERAL_DEBUG isn't used at all.
> 
> - Submissions based on the following v5 patches:
> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com/
> https://patchwork.kernel.org/project/linux-pci/patch/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
> ---
> 
> Hans Zhang (3):
>   PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
>   PCI: dw-rockchip: Reorganize register and bitfield definitions
>   PCI: dw-rockchip: Unify link status checks with FIELD_GET
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 87 +++++++++++--------
>  1 file changed, 50 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
> prerequisite-patch-id: 5d9f110f238212cde763b841f1337d0045d93f5b
> prerequisite-patch-id: b63975b89227a41b9b6d701c9130ee342848c8b6
> prerequisite-patch-id: 46f02da0db4737b46cd06cd0d25ba69b8d789f90
> prerequisite-patch-id: d06e25de3658b73ad85d148728ed3948bfcec731
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

