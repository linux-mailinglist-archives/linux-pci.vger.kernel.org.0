Return-Path: <linux-pci+bounces-29644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED727AD8289
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CB93B6A2C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAB253B67;
	Fri, 13 Jun 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0ZC3sb6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC6252288;
	Fri, 13 Jun 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792674; cv=none; b=IbuQLS95W/wP+Ox/1u1je15O29/dgy9GJ9JtqwFgLUfJ38saayiU/HYnjDXIX+qG6/9AWlKZTQDWnJ2FUira1ckjl2HhgGQIBN/oqnamIt7BBfm5EnX0qreOZfCk8fgZBxJvJx/WsqMrPLMKO3IP6vyhLNUm9dscnOzKvSxk/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792674; c=relaxed/simple;
	bh=CNh+HiiRkB0XHFZ9RDPw/wKbUOdkeNHiRSJSctqLMz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCQ/x5TObjrbdZc2y7rPVVBJSeSPmK320WsaMl8bhrsCDAT3VVjDqVbXu9lgruX2MvEH7UenT8ecwxiobKEnqZ0rLYvxvVWMFS7LoH0TiUqH6DDvyj5/xFalYkt/0XYVA9DqOMbcXFrF6owlCXD94vy4SNh6BrQra4cXb843+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0ZC3sb6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748764d8540so1621689b3a.0;
        Thu, 12 Jun 2025 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792672; x=1750397472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxRccK9TPNkSjUlVA9FxqDEHBsSIzMxTRGu02KOjBxE=;
        b=H0ZC3sb6o7Wr3/LTZOvL5Ogl1/JJfiFdd+aMDFGds5cjpdcAticqA4AOvbPfnDEy5x
         EnjMEMiM6ffatNshqMhBNGWbpgCGwSkOpfQtBCcpBrcF2+KkPCWEA5rY5/iCD1TT6/lO
         O3EWmbHuzYlyKq2aaxQAFcRWF48vsKyvnJg54DecVex15urtRVv7l01T5spVpE3tB8XW
         zrV/wE1ouVLVh34Nu8ClDA7ApsevzyxjkNq4xStLc+sodpsX1VBKYIvKX+6b8sNBIK2J
         QsOaUcCOAYMmYYavP4clgm9n31kmzbfvouYvhKeat9FRlzCMR9FzOC5sKjmTG0zqSjOH
         0URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792672; x=1750397472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxRccK9TPNkSjUlVA9FxqDEHBsSIzMxTRGu02KOjBxE=;
        b=F1MsHrtPvnxzrYiSBZBZHf+5UasNPY2Hyi0I9oFRwNz0PLqaZhwF1e6r6Sj+PK45CL
         m5iGk6OW/U7Q8UTjICC1q060kM3gXJYajfT5tGV3AzeV/pAOUz5k5pOaHx1aIgfy/DLd
         yhEXDJ1glTrZy0Tdq+YAVQ2sXdYwAxep8+lgs99zla7GpjIXDRtEEWn1Gbomr5dNXjzb
         l4XEBJJePfAmod1CAHIIOa00nP2MU8GFKv65k2BhGoA21xIHlYqFU8CoCUIxccc3zZRc
         FSTm2jZJWDRayrGUnfUufU+VHesvhoDHTt5x9Fz9oGKr4qL17/OZOh39jbnu8aUAv7i5
         OrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHUkDcu3mXv1MtC+7MPoYRn9+EZanB8kFNKABoMY4+rP02pyZkEB8t/rlF2c9qh+GXkpA60He8eNHguE=@vger.kernel.org, AJvYcCX1PuQ4aDmFAjm/heqZdf6u/hGdEENq9bl+NH3/unddvUQPzRCBdeNiYj18HgbWNpTbMXUgKIuZdF8o@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJvLRv8DxhfPUEbzZQO3qCH4TH9TV9+HcCBxLlMCkv+SHLCud
	/r5O6W4ySwx+NxQyxLmo6iPzyAMQIF3+16FeaFISNdNHiJ1UwSkquezOFnhva5li
X-Gm-Gg: ASbGncsq9ngqLptlBCGENIjDWfI+gJILxswXWsu4hteRxvERtU4u0JoUGwE9dUn2MpU
	ooHhYQb0NFPR4wfg19HPTmJ2y4dj90ypu7HOJL8ZWvIiqtanFzyhN93prTQC70Evcw/kd3qHQkj
	PRkRZUIZImDjynW953Sm2RWJ3ePr0c0hNQ9aZ3ZPmdvpZ17SnewLaF049PVXi0dN2jo6LnjDz5c
	JjnoT41Fk9bCTTeixAUqPchgI5u5mcvi8jcgakqJLTyClibroCdKX0hJ3UGQI+c3HEkXCeKba7Y
	c7K9o4py6GUW5tEPSMZj6Qlkr+VtngzJkzLRgvNsqGqDcMaEGTAtW/eK/bs6
X-Google-Smtp-Source: AGHT+IFW3YLUNguMP7Jju7pJGbAloDxqM68G7zonX52FPkJnUD/CTS3dbXq3+Dz07CjcjRnXcH9SdA==
X-Received: by 2002:aa7:88ca:0:b0:746:25d1:b711 with SMTP id d2e1a72fcca58-7488f71e65dmr2200476b3a.17.1749792672571;
        Thu, 12 Jun 2025 22:31:12 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca16sm717943b3a.35.2025.06.12.22.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:31:11 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:31:06 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/5] PCI: rockchip-host: Set Target Link Speed
 before retraining
Message-ID: <aEu3mqIp-QjgYTWT@geday>
References: <cover.1749791474.git.geraldogabriel@gmail.com>
 <ad9dc26689ae2c9e811d093ba18c9e579b6747ea.1749791474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9dc26689ae2c9e811d093ba18c9e579b6747ea.1749791474.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 02:21:59AM -0300, Geraldo Nascimento wrote:
> Current code may fail Gen2 retraining if Target Link Speed
> is set to 2.5 GT/s in Link Control and Status Register 2.
> Set it to 5.0 GT/s accordingly.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 65653218b9ab..68634ae8caaf 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -341,6 +341,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		 * Enable retrain for gen2. This should be configured only after
>  		 * gen1 finished.
>  		 */
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
> +		status |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, PCI_EXP_LNKCTL2_TLS_5_0GT);

Although this incidentally "works" for facilitating Gen2 training
because mask clears 2.5 GT/s, this will shift the value 0x2
by the mask I think. This is clearly wrong, and instead
we should use AND clearing plus OR'ing the 5.0GT/s value.

But I wait until at least Bjorn's review to send v4 with
correction.

Geraldo Nascimento

