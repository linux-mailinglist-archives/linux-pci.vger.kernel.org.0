Return-Path: <linux-pci+bounces-18942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB579FA841
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 22:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6267165825
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D18259489;
	Sun, 22 Dec 2024 21:12:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38A143722
	for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734901928; cv=none; b=RonYR2DjpUWGEzOK7qxS6cksRWXdYOO/f5BP8D2fHCrb0LBtV+J99sKhe3SMqKaL/7AJTOr+PZZCPUMoBRqBad93BQraQK6td7gywybB2InwFu/PNXzMm+FqcghWPQjUiFGWSvt65viot99bvQCFqsc13DLfCl3RbDd9iYE5FiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734901928; c=relaxed/simple;
	bh=qrt0WYkaDaC+HZxSg7tM+jHOEP26MyXvQKedb6iz40g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwuCw+AMEMQxEnxBd7+V5EMTVSZfc0fxD7FoE5z6JIZEA78m67QyPHwJQgIdvenU8plouRklpuq+WLBACVTmjdEKIsbss+dcW23JtNlsQAfj1HDFybG8apIsbobt3dXDiACf1oLalqnU1SGu5h0wEe/9qArbwUj9fYKbj+nbYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so40604945ad.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 13:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734901926; x=1735506726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k38+bC4o4JY/nExyesCKw1Oyf/W4W8hN/wgHfx4tKk=;
        b=fBHuuaIRR30howcP6Hst0oBxhd5TQTgo4ZIxC3CrGr6j7tG3+Ukk1kSNbtKxsdVwES
         qEbiB6157Bk0y4Jw127uCudEjoUui3dUMd282CzE6WF4i5bxerKKW3915CYLDlvfO3qY
         SxStFd1YEIweXozhQc08fdqJx+pM4nmvb3KrTY/KxSDiMlDsbXEOo0rxHvWSzTgDNvRo
         2/QVtsWkyY/qwQV6sV3ynAnj0OBL+VpccCcKyb2Towgd0KnS/o2xLm5Av9X4JkyqsqV2
         iAnKQut0wrc4GBCVV6PbL53a5awaEPEVzvcpRltk7s7kxGMYC6X/XDfG88cPcTAA5TiY
         qBoA==
X-Forwarded-Encrypted: i=1; AJvYcCWysMVo7ItTkvDo47yQEeHjae51kRgKaoAtmMCHpQTWUoEH53JyVvok4VtT/xkBCiHHEkdHw0vXZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhY+xajvTJBoD61wZfKMhD3NHCAN+VcUS37sPdgtYx+HHBV68
	ETH6VoEqMqihtL0Hl4e7ngJ+B6RG5KfADbt4sPuoGgSrzSE4cC1l
X-Gm-Gg: ASbGncvbR/hqtIobll+0TDs9cTWU9sO086GAYWEw29G5vo0foAigZJWCtpfkP2M9tu5
	dn7h33JpbYF6sZc+vTnE05u21ZE0C0uFGfy1ipMFcormhmXB2LPkQks+RGTzwG8gSe/bbD92/6g
	trJsSYo852635BSDdvotKO55uxGUgGNxU48CTEpDmbp8vXqvYRUlDRjk4kmWguZKAUCZ3o66EjT
	VcbeJHWsa1r+fkumrlxW7jl6U9Cy7fiKPi/MfxaEMpumfa+QB1WHazqX7DabwJ6Dav2VDJ1irqw
	BpEv1sBx07lXG7M=
X-Google-Smtp-Source: AGHT+IHvYfdLxwvSBegIAr+l+/j6AuDpyaWscN+dBbMElcNGPAGpUwZZ++vm4K3x0zJBaL3mmLcrHg==
X-Received: by 2002:a17:902:f644:b0:215:7421:262 with SMTP id d9443c01a7336-219e6e89283mr175922225ad.12.1734901926177;
        Sun, 22 Dec 2024 13:12:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d444csm60664785ad.137.2024.12.22.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 13:12:05 -0800 (PST)
Date: Mon, 23 Dec 2024 06:12:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <20241222211203.GC3111282@rocinante>
References: <20241127145041.3531400-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127145041.3531400-2-cassel@kernel.org>

Hello,

> Most boards using the pcie-dw-rockchip PCIe controller lack standard
> hotplug support.
> 
> Thus, when an endpoint is attached to the SoC, users have to rescan the bus
> manually to enumerate the device. This can be avoided by using the
> 'dll_link_up' interrupt in the combined system interrupt 'sys'.
> 
> Once the 'dll_link_up' irq is received, the bus underneath the host bridge
> is scanned to enumerate PCIe endpoint devices.
> 
> This commit implements the same functionality that was implemented in the
> DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
> endpoints based on Link up event in 'global_irq' interrupt").
> 
> The Root Complex specific device tree binding for pcie-dw-rockchip already
> has the 'sys' interrupt marked as required, so there is no need to update
> the device tree binding. This also means that we can request the 'sys' IRQ
> unconditionally.

Applied to controller/rockchip, thank you!

[01/01] PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ in the combined sys IRQ
        https://git.kernel.org/pci/pci/c/191b732176e7

	Krzysztof

