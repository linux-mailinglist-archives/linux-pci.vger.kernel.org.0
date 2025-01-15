Return-Path: <linux-pci+bounces-19867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CBA1222B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF03A86D4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096A20764C;
	Wed, 15 Jan 2025 11:12:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4E20F999;
	Wed, 15 Jan 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939545; cv=none; b=DyxyrL1F7yMvN5OBwMUaS7oFciRe40m9fDXXr7twMTWG8CfVo23cCut6faZMcP8pkthMn2Zu1J1lxyGUnlKGbaO0eqGJ4Mm90KhsLyNs05tSutPcIaKaSM+0rLbaW8F3eqNAQdpBvbpSnShrDrN1wL9WOaTQcn427twvwmSRXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939545; c=relaxed/simple;
	bh=dMdJyo2ocCibz5X8C6KWjWTCyqIS+CPtK9iGS3MlpcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZV0gp0s6MBAVdgGQBuHSdqGfJwTyisionUKSRGluWbhCGZBBwVYQ9FEhOW5nziE6tk7rLz32jgEZ6besK3tLoEK5WifSiVUIek6h0v2oDkA6dD5x+uZQOutRU64r/4SSilspLJO6qcmvD1ldASHoRE9Aff7frCQ8f2wOki8RDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso111719995ad.1;
        Wed, 15 Jan 2025 03:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939543; x=1737544343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWwH1bDPMW4sIvL8kmJCxcSzCH8Ejrs1sg9Vv46J164=;
        b=aZzKG5+7JIzXVh2dEw+m/Q6KwEhZP+oXr3tw2L/y+ghiPwHtrNQeoctZ7vd1ZR64LI
         0hK7QrQLHMnzvVIjr5wC+Gd8IRM3q+Zw1fNshIv9s3kPDttmnUe8DGjI5smNyPdEmtsq
         Caxwjtg0L5JoBt1s3qVJ0WHkiK8G91OiCnzkttQRzTovAvTjjtVwT895Z5+UcK7NeqB+
         Me26f7MoWEHTMV/UkaVWH0+MLOBo5OYTR3/67daRCkaGj5YUo7bn+27SkwiQJY6DwJYD
         lLFL6vivTWNkOHSZG7PRFGIUB74Zhf/GVTUjn2S5c8mN6o8M7Je6EnlUb9OPTBP9lb9V
         gkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpePSztA++PSzHOR4Vu9AMQtUeKzNnbUNFtJJ55XinT1O6CQeWaJTBP1YvdjZbOayw+cblH7vEBEo=@vger.kernel.org, AJvYcCVCsi/jT0mJiQdIG11RVfw0LtoVTghvvKkOY+Tr7HTlGzoDRI62934ohowfIjqVVQBt3ryOVpGXdxba@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+L7RB3IBrxi8Uq5Ag8spFwCY9lgU0nOhS1BGaES1/AGJOKiUc
	2LA1VoJYX/9z4RJ4ytUeyI1Y5d3dYOpt7B2LgnEAm6apqeHd2gFm
X-Gm-Gg: ASbGnctrwuUi8B7v8utV6caYtJa0hlh8bP/X20UXXoV38N8qpuzRZimDvZQSBNlOSD0
	JcwZI0tYEihjqeNViDn2xIVcoXQzgOMQopmrm2VpKGraospVo/vZorkmR3ZOatNenRWuK619o91
	L7l40Ia5sbz+G++zG+WbQbxIwrh/BshEveDtdY8zakzfREfTzI8+fnE2xcUA7B9WBfB8j6S/3MD
	9VtRzFjsrtnjC/Qgrydc6pSXvab7bxA+AeGiM+cKUsz9+qqzrgMcyf3MbVKxe6yCkm9r0HflMzI
	95fWtdAZ4M/7kB8=
X-Google-Smtp-Source: AGHT+IHFoca7ZCISTDX0mGzInAWIQ58L8qkZmkBMA3Zf+oFefoTlL/1UC9F+En3y5YImzKRbiXnU4Q==
X-Received: by 2002:a05:6a21:a4a:b0:1e1:c8f5:19ee with SMTP id adf61e73a8af0-1e88cfe2ce4mr44391726637.25.1736939543365;
        Wed, 15 Jan 2025 03:12:23 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31902b137bsm9540020a12.35.2025.01.15.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:12:22 -0800 (PST)
Date: Wed, 15 Jan 2025 20:12:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: mediatek-gen3: mtk_pcie_en7581_power_up()
 code
Message-ID: <20250115111220.GA4176564@rocinante>
References: <20250108-pcie-en7581-fixes-v6-0-21ac939a3b9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108-pcie-en7581-fixes-v6-0-21ac939a3b9b@kernel.org>

Hello,

> Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine
> 
> Changes in v6:
> - remove mac_rst support for EN7581 since it is not needed by the SoC
> - fix typos
> - Link to v5: https://lore.kernel.org/r/20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org

Applied to controller/mediatek for v6.14, thank you!

	Krzysztof

