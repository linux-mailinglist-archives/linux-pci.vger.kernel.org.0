Return-Path: <linux-pci+bounces-15896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434F9BA838
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 22:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454901C209CC
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDF18BBA0;
	Sun,  3 Nov 2024 21:05:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5215C14B;
	Sun,  3 Nov 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667924; cv=none; b=QaJMLQUFxXl2l6uMMeLcVjz3/F4CEYuXP1VOW83ssaGS+8Mdc4RzkW31gidcriHm4x49iZz0HJ5Bh0gW+39bMTGQo0ffFRCkraYmHkrJN/4GGNh2WymII+Bz1dfBBLWLPegbB+ykm95fVJ2WGNK5Rgmx0+senjqWFizqi4WRA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667924; c=relaxed/simple;
	bh=dIUgAXTSYsAJu+7ewMuElxWdtP6APm5cbGiKm0/4ipM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB0kzl+M2WXZvD5iYHMd8P5oYrFFKTtdssSqsYaFm3SRlZeIJley4jEmuwj0semGCVuWAAN6+hLE+MW9MxBJS4kBxoEUZLMBnR3cx/iuCuL0L2YrNAgiUc/8x0nwCWfe3Os6JPzNT5KbT6EoYtqPLzJF/urAfxOtZgRkapTLZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caccadbeeso37248695ad.2;
        Sun, 03 Nov 2024 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667923; x=1731272723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNiETQqq1UCKEb0cYaC36KUXh3nW00A/xcFef3/fb8U=;
        b=EGpkcKklGVGTZvdHzUbgs7t6Mi+K9LDV2jjb5vHRYQbAbWhfTWQ0wutFdXneywYBbj
         eehrKs6gI8it34hioxOU7IzInxhO9ha6Fw+HOIf4hF51WyDNXIMd/Sb5RJanuqc0ZXwL
         GFopYQmsJmzxi4n4F0bd/yehZE6f7LOSSuOXSJj+iOcgfZArI3wQSdjxv/0TvpuPNUex
         WGiWdAMxaCs9wiXRAOMISaInNh8og7nJARqCfYQN2V92YJ2x7bV8/Q0qKlhKWWiT3+Xe
         GlViWl0YWoL+nwfjuKfzYu+Shw3ZVOyw8M54StoGnRibBnLQSqG4eUzxZ/Pi0tHMKrdQ
         umTg==
X-Forwarded-Encrypted: i=1; AJvYcCXTjasdFnCDEfoR8gjA2JH5RGEUSI0lrie2A6zl7iaaOhKCmL3N24CPGkIL28SeIaKSNmQg7jBfDPNw+w8=@vger.kernel.org, AJvYcCXg4prlwszvDjpd9Qmq/1iu881N7FOLxKegJBkyW7q++KRdaMcD2QpALpBg9Y+kWaKee8f2jogU4VDX@vger.kernel.org
X-Gm-Message-State: AOJu0YwPExwjL/SB6bLxbVtPos+gxysoHowtRgEJ7GHr/vNp208Br0TC
	svVSb7vAp8OOsLbX7zUUnnjy0TJpyqQ8zvWHwEdNh760iakJw9Vd
X-Google-Smtp-Source: AGHT+IEsYeFE1lJc2aiVA3A0z+UJcWlxmRRyHQYQ/KK9DhmdwXc4RIW44CfdrpG0c7bSj17NZa01Og==
X-Received: by 2002:a17:902:ce07:b0:20b:7ed8:3978 with SMTP id d9443c01a7336-21103b1c60dmr204824515ad.26.1730667922717;
        Sun, 03 Nov 2024 13:05:22 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056f14a9sm49955455ad.62.2024.11.03.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:05:22 -0800 (PST)
Date: Mon, 4 Nov 2024 06:05:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	u.kleine-koenig@pengutronix.de, cassel@kernel.org,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 0/2] Fixes for PCI Keystone driver
Message-ID: <20241103210520.GL237624@rocinante>
References: <20240524105714.191642-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105714.191642-1-s-vadapalli@ti.com>

> This series adds fixes for the PCI Keystone driver.
> The v1 of this series was posted on the 24th of March 2021:
> https://lore.kernel.org/r/20210324121901.1856-1-kishon@ti.com/
> There are no changes since v1 except for rebasing the series on the
> latest linux-next.
> 
> There were no open comments on the v1 series so it appears to me that
> the series got missed when merging patches to the PCI tree. I am
> reposting the series after rebasing it on linux-next tagged next-20240523.
> 
> I don't have the device corresponding to the older "ti,keystone-pcie"
> compatible so I wasn't able to test this series (specifically patch 2
> of this series). I have only compile-tested this series and logically
> verified it for correctness to the best of my knowledge.

Applied to controller/keystone, thank you!

[01/02] PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
        https://git.kernel.org/pci/pci/c/7a941315dd2a

[02/02] PCI: keystone: Add link up check in ks_pcie_other_map_bus()
        https://git.kernel.org/pci/pci/c/76a496ad8536

	Krzysztof

