Return-Path: <linux-pci+bounces-26890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A8DA9E676
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C01898520
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF1191F94;
	Mon, 28 Apr 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDbc4/Mt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28452CCDB;
	Mon, 28 Apr 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745810517; cv=none; b=PDeJcP368vwx8VuGZYHkWdfP3pGmZL6xlJjGERZ3RU4XEk/QfK4Zr4gmv/5lYF4WzMbC7/8ZAKnB+f3woSr98h64HoXZgabWdL6tiJHdUtWZpY0fDV8p1pswUTaHB/Fuf1DnFq7lr5vS+c+CoYV2ZxlCss3JSf5RdveboCtkCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745810517; c=relaxed/simple;
	bh=4hDO0/hfxB7mm/pnzzRolSMT99RZuNRN8AffM9Q0oro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCpPamUoMJMMW3LjLnu9+j0rRaZk+7+wz4jhT8BwPJnM7CIdTZRdyuoTh/hWwMS5ga4kPTwcd4Ladl1fOpAWTddeMBF+txEkuAVm0g9aIalzfE1uRKFVkEuz4Vq+n5iuhHl8NgUI5P2BYv3VRUZC8J98Um3V9xs2b1wr04RaifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDbc4/Mt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so3578229b3a.2;
        Sun, 27 Apr 2025 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745810515; x=1746415315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8yYHt/qUGB7zSsH1QYJ0433S7HWdvxYqg3YPVEOlQg=;
        b=bDbc4/Mttm/NzgUTbFyM5EHBaKplo/3H4+l7rLpY5/5jvFVywm4SZ83GdAKqz/V235
         stW/ipKpDai0Zixs9gaUpZIU1hqyUXaoZ7dozHROO3ls/86YbXbzmpaSAyE0mONF74MR
         MT1Bd6m2uUz28fgHRGLYN1tK9vRH/ev7UMB8JGDU4x5mGQW3oR3b/VrUX9tKUjayIoJD
         3Cq2aP/Nz9qBnLVhhOmTBxpYrQCxRFkD+gR/UbDejvK+atFaR/BpNC0OqCjJ2bvmBcAc
         ee3f7mcENpp4tiDFbLMHIK9BaBku2Z3eUf03uCpWLz/DbQzGzvhngLz55qM/M/+rD4gC
         YuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745810515; x=1746415315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8yYHt/qUGB7zSsH1QYJ0433S7HWdvxYqg3YPVEOlQg=;
        b=juKNEZB7RHFm3fYFqEW3p9uSIEIiP+1VaFEATiIpoWf5C4tvEzcZiPYpUY2INTZR19
         6hmY71rK/fLKzJcazo8siHdPc8dnN0C934xZ71r7jWoXhCW8OpC6KJo+gXFtKlri/bmc
         0qn1KCVK8/q5kfB5MDgbCQD1F9n9iWQyhx5tXCJppjJPUPsdGpsjgbVXaQFYklnzOarO
         o7r9yYj4HnqGXGPW8B+zDdarlc9DAd0rzQhuLhfNUetSCbJm0XWIlv0L9Cv/ucCjFn7N
         YCME9xpggkP6D/FeRA0zvO6gr4mptcaeU21x26OmKIeq2mJ/VYPoIQ1Moxejm62quqx1
         9TrA==
X-Forwarded-Encrypted: i=1; AJvYcCXFoOwye4P0ovGUgIvh1WQKMorPFTHcVX7iLTN1gMtUnHwHzAJSGKxs4ecWEW3W9ZMWzHUnZuGmiM6Vshw=@vger.kernel.org, AJvYcCXM8WrFNoSIqbLmKzGfl0HGa7N7zUb7kNcB42wVgCFkpElVXeSI9MSNjCX15ExR+dlAT4Ctm0JOeYXn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dhVIZtt3vlS7o51sAI6mjXFICxVChr5cgQJui2NkBkjcVnLv
	b4kfMfGrDSMNwJlNVrxpRMPVSoNqH/y3mfxqSJzjKFzWalcWAs35
X-Gm-Gg: ASbGncvJ8KY0KQHJbziuRrzOXM2va+3ehaOpDDGASQD+ZIrza4NawZ3A0+1tWBlZc1Q
	9EshpdoTQYcpyVCoz6htVMgzql5kBEKqZvqTcLYJ4FNWbnaWEi+Kb0Ie9zc52lYGas5WXwnEMd6
	+F8iTvI0gduXpYZHFiCicPuaRtcikRWfkh8M+oUYKeFSNcQimMqOR2EV3JJndOSYOnw5JYmYwaI
	6F+jGXLwhueKeMTfgbKG2PzMmE6Htd4BJkrBuTSG2KDPN8JR5lS2l6qjOOVsJZ2uHaC6aNsIhLY
	7/GcXPWMq8k7gFcaeJBIcqkDQ3wBTQZCGUft//B1+BOWreXn7AFfx1L8lpNjHxktuA==
X-Google-Smtp-Source: AGHT+IF/CLnoxiVHuh9PWG8WGXhLiWoz1DQBShtf6eNa/Qh4SLnUeeqIbL2Bzlfj9Hx2I5otXfwjrw==
X-Received: by 2002:a05:6a00:3a18:b0:736:69aa:112c with SMTP id d2e1a72fcca58-73fd6df0163mr12454077b3a.9.1745810514895;
        Sun, 27 Apr 2025 20:21:54 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a965sm6878299b3a.118.2025.04.27.20.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:21:54 -0700 (PDT)
Message-ID: <641c7e8f492196d3ec08e7bd4adf212479a9b966.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] PCI: dw-rockchip: Remove unused
 PCIE_CLIENT_GENERAL_DEBUG
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Date: Mon, 28 Apr 2025 13:21:47 +1000
In-Reply-To: <20250423105415.305556-2-18255117159@163.com>
References: <20250423105415.305556-1-18255117159@163.com>
	 <20250423105415.305556-2-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-23 at 18:54 +0800, Hans Zhang wrote:
> The PCIE_CLIENT_GENERAL_DEBUG register offset is defined but never
> used in the driver. Its presence adds noise to the register map and
> may mislead future developers.
>=20
> Remove this redundant definition to keep the register list minimal
> and aligned with actual hardware usage.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> =C2=A0drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 0e0c09bafd63..fd5827bbfae3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -54,7 +54,6 @@
> =C2=A0#define PCIE_CLIENT_GENERAL_CONTROL	0x0
> =C2=A0#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> =C2=A0#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> -#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> =C2=A0#define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> =C2=A0#define PCIE_CLIENT_LTSSM_STATUS	0x300
> =C2=A0#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

