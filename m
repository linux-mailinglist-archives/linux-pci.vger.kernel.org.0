Return-Path: <linux-pci+bounces-21964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34044A3EC4F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7220A19C5347
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAB1D5AA7;
	Fri, 21 Feb 2025 05:47:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7C18D65E
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116877; cv=none; b=XXfWzUx0W/w8sMQozVD3aTyMjkOV/OoITt6FeilZ/X5u0lJrnCJtlqlx5pv75xFjGC6WITCEPNhO8LTP14NcNAGC4RlIyL0beXeUs4rhUAbL/AeuWkD5DO2T8mk3SkIKf3y5PkRnkxfshpDl42MgWVktLEOBDP4fdfcxt937kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116877; c=relaxed/simple;
	bh=ZZ8tO9d6iN8KpDN5HnfHAb5Uti8+yAlQU4G+KsaICMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPEeDstIaRs3uLF1AK75Cjoih+uTeQFaiXjcGsse0+V6xDUFiTgldbkKnIb4dYl9HWNbZRWWMhfwiAYCEPLNFOvUS65v4ZFHQNopT7Ivj7Ex+2LG4mJikRu18yffXTb51DmBiOH03B3OFu1eYGpdRCfcWp86M/VQvapoVHaMLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f4dd756eso34175095ad.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 21:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116876; x=1740721676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+VcTlrh2l11IgMDF+pMIycmCnoBAI/KGvY2QstYpd4=;
        b=VSZXXcPPuNPzDjCwEwdSgUui2VX25ePhyJUaUOXkd6/aI3i7/soGafz3PyCcx32zFW
         ZTfncrhXVFQJYqem2v/numrOQNH+PFhOol+cn0SmHTLHItHePhWHcvKuEzbtZRNW0tzJ
         FtyMXa/a/YkIukaeWglk6+CjYd4ncTdsdYioXfw0UmJGUl1UJF1FBvp7RCn4J5zNM4hz
         3VpdARCUxTmboNMC2BhFnK1iBhza3ZwOkzNbMzELd1JDY73ikp6RmUQQuGhdxavTPZnV
         y2Z2SWdIxeUMxG79kSwVRAFBqNv6mRJIUJQj5bAzOI31mScEGIDwBdX1XE2aJOlpAC6D
         Swvg==
X-Forwarded-Encrypted: i=1; AJvYcCXa3YTOMF9c/YbhNlU/GlmuPZTkQeZ2iBK7VSQofjJBVK+iCbde7DyHSx8Qzr24Wep8/I2Pqcz+Xkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxIMHfJfjKClPJkdadZChK39RRQ8t3VzQYjj0oCrmnwclhWt8
	avZNh7+hbHMhZREpaSu8LLxLanqdwxytL4dNMljWr/4ZGYy4Zxz3
X-Gm-Gg: ASbGnctPKPd8ASQq2FvsZceqbEgFsqwRihypx6Ug9O8g0GOh3+QuiyVdjrcu87uSYME
	i3luk08Tl5nXXitKiIj8oOvwffEZ+2pCbW/Q4kLJmxuOIE07uUbJavbtcNEAA9yqEp/X2BJkiss
	5KiQeI3xEv/hK/2E3Yd1BmvPXaUyeswe6mkk4ReBysTc3M8NOXAXnNcxw4xfraTvAtRLtoFNVMV
	2DbNQ6X0cRO1xdLm9lr6GELm7Hn4V/WYwp/EW1jQs6DLC0hn5DP/MvkCynsrvBCLhkWiXqduALo
	NWlY7MULESFOLw7ZycMuMGk0j9YGDYFLAea6h+F3NdhdKheC/7QfijprTk+Y
X-Google-Smtp-Source: AGHT+IEdcf7MMT9L143/Y8zgePY0fQ0gqscRv0VoBJbbnWNbz1oWlX6sGsWy4WQoLC8z3Z4STYSKVA==
X-Received: by 2002:a17:902:c950:b0:220:e1e6:4457 with SMTP id d9443c01a7336-2219ff5e979mr28136435ad.26.1740116875566;
        Thu, 20 Feb 2025 21:47:55 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5348f12sm130817935ad.46.2025.02.20.21.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:47:54 -0800 (PST)
Date: Fri, 21 Feb 2025 14:47:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Remove leftover mac_reset assert
 for Airoha EN7581 SoC.
Message-ID: <20250221054753.GA1376787@rocinante>
References: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>

Hello,

> Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up().
> This is not harmful since EN7581 does not requires mac_reset and
> mac_reset is not defined in EN7581 device tree.

Applied to controller/mediatek, thank you!

	Krzysztof

