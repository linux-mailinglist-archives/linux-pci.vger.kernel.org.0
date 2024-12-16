Return-Path: <linux-pci+bounces-18480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78949F29D4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC418815DE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0D1BC064;
	Mon, 16 Dec 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+07gorJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48279192B70
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329137; cv=none; b=Z6+J4bKBVR7u3T/zQI+I/qjO5gir+JbTvl+hOgW6qQEp2h5STv20OMSTajar+09Jp5/CarmvRb2k26Xo69JRujSNUVRG8kSeBYSA8TZiSDgV3SugU/pQNRfBQ97sSn8fPCZsRWLkGhTk6uT2rQcZu2kZof+OvOYBT+vH8T05HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329137; c=relaxed/simple;
	bh=0oxnWjjTJmQZ5WXrDVl3sUQnCL6wKEhOCT9Px58TBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ/E7xh5TG/YSKJrV5H2Ekjcydf+YKZgw3AGBXK57KZCV2LQdwFcC9lHUME10oMjehOdxzYcMUhkFakNbcn69loMhqWDUeBoPeNi+T5068OOj+k2tJQotBTmbf/L6oFJv6MkNSPKMcSdkEspcvm2UTrxtnfX1Idc5Cvsgobh29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+07gorJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso30839275ad.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 22:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734329135; x=1734933935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CDtToB1uPwC4PcwoC3FtKaZg1gP2euazdW0XojEpOzo=;
        b=K+07gorJ6KRpcMU5v3kfjNDKr4Ur8UNkYIe2IOPpoMCTDsm9NFS/rWu5rR3+maF62o
         Peok/hKovrVPWPeqIja4jUYumeEPUlj6Rl90Ty3+APcjeBuxIJM5GlUl6zuBplRfJWyO
         pH650OHxMF+kFxVBJxSWS/DBkrZerEJ+yj87vrniwKJN7MzzBKEZW8fuymxScNJNaRwl
         v0NiGo4O8HsJA23XFq7hnXjrUjyl7Zh7k03dBkhEWPA1nz/W9lDW/NFpbKxHsZZULhce
         n2on9mFaKC1LiIS3I6INVn9DMcV8EyMsr1Vdv/HoBuyfdgQ/TV9/Jksq/kMzg/fnKgm7
         3bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329135; x=1734933935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDtToB1uPwC4PcwoC3FtKaZg1gP2euazdW0XojEpOzo=;
        b=qljXE1zaFF1j5dWICdbT2TBO6y68o5e3DMue/mbUMNhIx+E3JQLr/o5UTsFwTBZhQn
         dCACRW0kl4qdUIAB5Un1DiuZxnoq1y/7oPNvo+ZbtJiDE0Y1QV+tbQhYgidACFJ7/4xG
         /JpneJ2MWJyceVRtFSfulytZgTH2067lhhmStyhZxmzufaWS/jkccprYr8HUIgLoUlZt
         Vo8ORCle1UF+YwWieqdIR4DeLtamPM15pRJZdYLPEtGztGgTDUmcznh3txtvXxvasOXA
         JTasmDMGtZwFh+yKvE0GCy/+H6muRh1V0J7EQv/oZI/ADvVI96aXkBUxsSMH51PQcrkU
         bt0g==
X-Forwarded-Encrypted: i=1; AJvYcCV5IkiZtwzdzfpXt9RFeWf0HKs9z3uVl8FfNzQwVKV2uI38TToEGbwrHCjuGgQlbs++j7ubIH54Qis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5NtZl4huRaaelWQD94BQPrNBkyMeHwNv5fxV4Qdh4MK4bxVc
	wRIsFQwMXvMVPce1atECyaP7ipjFzWzyWIboVy8rhUWf8TqzsQrPBtdxY+4Kkw==
X-Gm-Gg: ASbGnctLIfgiiwTiqlNXNzqA8ou1fLCjWDXb5p9d+EjKDx8rXQG693A9d+eInTrrpm+
	/2+zM1vgJv2cXR/ky21CsSWL1jvfOvvjYIeo7Z2iHA1T8Rs6P39tqfjOl7JLFgIKhajf8bbMFXA
	8+dw7pnvLPKfldkBMFZ9FytqPVsvWlTcHcNrVX16FsEfGg4bgojzJFENQUfeRm3V2iRHkWs4ixv
	AWNytKTZLYHQoomF4p5/E77txQ0ewwKu9cgzTToYCMlyPBW96qox8c9SMomICmw9Xk=
X-Google-Smtp-Source: AGHT+IEhH2izMGHWoXgAHYtfFoQE1IpdsZiJPq/F6hXFB+rjYb1tbCyHV6DgMbQe+W6rYlwKdP0A0g==
X-Received: by 2002:a17:903:22c1:b0:215:6cb2:7877 with SMTP id d9443c01a7336-218929814dcmr172477885ad.4.1734329135658;
        Sun, 15 Dec 2024 22:05:35 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db63a6sm35073355ad.37.2024.12.15.22.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 22:05:35 -0800 (PST)
Date: Mon, 16 Dec 2024 11:35:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
Message-ID: <20241216060524.bc5fiwdyaxz4git7@thinkpad>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <20241216054953.kj43om6fbjksbjcy@thinkpad>
 <45CC5230-1DFD-4F7E-A0E6-F4FAC5586038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45CC5230-1DFD-4F7E-A0E6-F4FAC5586038@kernel.org>

On Mon, Dec 16, 2024 at 07:00:16AM +0100, Niklas Cassel wrote:
> 
> 
> On 16 December 2024 06:49:53 CET, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >On Thu, Oct 17, 2024 at 10:58:35AM +0900, Damien Le Moal wrote:
> >> This patch series fix the PCI address mapping handling of the Rockchip
> >> PCI endpoint driver, refactor some of its code, improves link training
> >> and adds handling of the PERST# signal.
> >> 
> >> This series is organized as follows:
> >>  - Patch 1 fixes the rockchip ATU programming
> >>  - Patch 2, 3 and 4 introduce small code improvments
> >>  - Patch 5 implements the .align_addr() operation to make the RK3399
> >>    endpoint controller driver fully functional with the new
> >>    pci_epc_mem_map() function
> >>  - Patch 6 uses the new align_addr operation function to fix the ATU
> >>    programming for MSI IRQ data mapping
> >>  - Patch 7, 8, 9 and 10 refactor the driver code to make it more
> >>    readable
> >>  - Patch 11 introduces the .stop() endpoint controller operation to
> >>    correctly disable the endpopint controller after use
> >>  - Patch 12 improves link training
> >>  - Patch 13 implements handling of the #PERST signal
> >>  - Patch 14 adds a DT overlay file to enable EP mode and define the
> >>    PERST# GPIO (reset-gpios) property.
> >> 
> >
> >Damien, please wait for my review before spinning the next revision. Sorry for
> >the delay.
> 
> Mani,
> 
> This series has already been merged, and is in Torvalds tree.
> 

Doh! I was referring to the NVMe EPF series. Let me reply there (and also get
coffee).

- Mani

> Except for patch 14/14 which is a device tree overlay, so it should go via the rockchip tree.
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

