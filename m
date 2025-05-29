Return-Path: <linux-pci+bounces-28670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97D1AC7F60
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D344E5F6D
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7CD21D3E1;
	Thu, 29 May 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cg2PB2Ns"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A726227E93
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527161; cv=none; b=AYPCKL3vokMcwKXImUWXhFajbE+sOwNuDT1lfAI5PT+G5BrOymrh1mJSzau0I7HtIu8I8M2/vSwG73RVrpjNIC/YInxGxGf5QnUwvgIznO0YGo0zD98voQiOfEHUjNICx4KUOHuYW1PD/iIYglKPP+JoF5oV3Me9R5bIcAajr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527161; c=relaxed/simple;
	bh=7LbxeiQ9CUarb7MM6uFQy9Q+5QfMHyPo1PcpNWESj6g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwmPOOtQydqPNT5Ed2H6AbP2rgKt41iHn2O3M51DGHQroqKHuLwwCn7sZbaczrRbHIFSGh37TEMK2uG57QBd+sY1lwx+Uq0zyYZPwdAIQqGJK2vdo4tjG8FT+KVNTGYHbkjm5/WNj0sA4ZjBH5TxC4Qb9y+aqJv09FY+LigW7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cg2PB2Ns; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad88105874aso137469166b.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748527157; x=1749131957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bd/re0W0O3SfKxkSQq5B/C3J4e51HN+gv/k4x6dlG2s=;
        b=cg2PB2NspTTW82Qn12xK+O8KVnbJs5xRi261SUqSFQDkvz2oP13dKXJAprPXik5gKT
         xsqODPzQ+hRtKPLed0FyKS5UXSBVKXoph1hfNVJgwI259/TW6yJVZy++FprAh+lkr0FH
         zrAoJqW2XDsDaxazpMJVEEuQ45y2WZxeXBe5hYO3IG1oL5+9CoIdDVFvOnc3CW3+Jicg
         ovYKx5wt95SXDO2zD98anfDAnCHMRGevdMe38Xyg7sfFIpGD1AkdkLNmICtX7KLTynjz
         Q+4j4biALOBjSABx5Gf0UCivsGJexFRJQzF60I7i2bY5XeCAoriPrrqT6B6WQNQ+W84+
         nEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748527157; x=1749131957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/re0W0O3SfKxkSQq5B/C3J4e51HN+gv/k4x6dlG2s=;
        b=q++fJ8ewvFve3jnqszcGMdwMV2X8UpoN5saramuZn2neV7+9qiKda79tO31saM3i1g
         OLcy21Zn7bBind+uxbeoGhbcq6q03kF8FZeSNIH+qp2Sp6eREy3MEqo/vLcnS6UcwNZW
         5HA3k2Wahskhg37yUhutVHruap2OVYR2QAvtB7LMBaqx2jwfBmHXp1yAOE5skxgxnzdi
         A9IZR79PtY+jUkQk7sWJaP3+Orindgknp5QIqjwmLlaLHgcGjrMQdE8EHmn0V+LBqB75
         HqAKG4SfntQUtbS48I1TnUmEvdtNj8tksyFc9Ww5mPdxplC1xOYjIuy3WtmljLmsITod
         oKpg==
X-Forwarded-Encrypted: i=1; AJvYcCX31HdwyRo2GxcLK5oBW0u5krgz3jQF1vllhrw8hZ4UsdkTOXoXUtgUu2k/dAMtikRYQjl00VtgMEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OBi/3INlqsUQk96W8OCXdyRgFpmfqvqFcNgiwDqX2MrXAH00
	auBYZ1/HI4nGkQLz5vPcHshZfq+Ka7oMKsfRcWaM2qjJz4J5aufBnzLJvSiw5VbHDms=
X-Gm-Gg: ASbGncsMw0axJRk3Xepg40yDiau3SJU/kuuGkis+jObKi8CFRQA22VYsEkck+cgv1gj
	Cdt2Wv2z4sOIqe8GAvgD6usAav2t0lF/D7cYA5kN96yflv4BP6pd4HeGyQcjlKwbovxl3oA9FHu
	xaKCNx1MAmsLpBywBSMxnG8xEINMBJxX1ICM1QZurCEMVIomD95l2ZSIwoJZIZvUpQTXEWF6Ioz
	IuUj2CViym7orJRuoGKzwNYszI1RuhpdFjy3K+PaAE3hqQVq26hxCV+GpXZIJW73fj9IxDi/so3
	nb8nSm1GyQoEpupi4Yo3HwPUHvslWFkSzdBNxhgwPZ5HNVkPnknhiLZQxXI7+EVY62Qfj1m6oL9
	tiLWXqCjfpu4qNpMzN4urAA==
X-Google-Smtp-Source: AGHT+IFe10hNzzDGzxOKftk1BYzLU57XNvgcDOZ24VhiK0GAx5icGmaI6U2aVUUNIweLENXOhsxpSA==
X-Received: by 2002:a17:906:4fca:b0:ad8:9878:b898 with SMTP id a640c23a62f3a-adacda56014mr193178466b.9.1748527157319;
        Thu, 29 May 2025 06:59:17 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045e2sm148109966b.90.2025.05.29.06.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:59:17 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 May 2025 16:00:52 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v12 0/13] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <aDholLnKwql-jHm1@apocalypse>
References: <cover.1748526284.git.andrea.porta@suse.com>
 <0580b026-5139-4079-b1a7-464224a7d239@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0580b026-5139-4079-b1a7-464224a7d239@kernel.org>

Hi Krzysztof,

On 15:50 Thu 29 May     , Krzysztof Kozlowski wrote:
> On 29/05/2025 15:50, Andrea della Porta wrote:
> > *** RESENDING PATCHSET AS V12 SINCE LAST ONE HAS CLOBBERED EMAIL Message-Id ***
> > 
> Can you slow down please? It's merge window and you keep sending the
> same big patchset third time today.

Sorry for that, I was sending it so Florian can pick it up for this
merge window, and I had some trouble with formatting. Hopefully
this was the last one.

Regards,
Andrea

> 
> Best regards,
> Krzysztof

