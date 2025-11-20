Return-Path: <linux-pci+bounces-41827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C90C75D4B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2F0113199E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5542FD1B9;
	Thu, 20 Nov 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYq1IV3W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsxWS8/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC62F49ED
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661530; cv=none; b=AROqmziH+sT85XfLLFpuZ9p8wk+uf3Jrzw6Xj/hF1i1bdyoqOMMfIYtO3G9BeXIkO2gjBHXwkNFg5aidlULYIPueCRDL7c33smpLFkO8j/nwld0IOYLqI4UFeev4gq5PQv98zGa0M8/YFUKqHBs5s+0jyDhY7RaH+5LRq9MHqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661530; c=relaxed/simple;
	bh=VmS5Cf/FqTbc4XNNokRvTgZc5rrdVw8jJtwpW2FLksg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FlgJEP3MuJmotfto3QFGHKpdWqOsT6ukq9YHTG3hJr/sR6MNNIw18BMsCgP89SjrvHQNlCntS+pAnJvrtbsp0C/FR2fiNkzXnrhvxWa9DDxag0y8NVnVurhab5I0YLh7pIv8+jIkH6yu7ypbpwTC9Is2Aj/1GcX4dneRpgCw+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYq1IV3W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsxWS8/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763661527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBAWQgLEjTxMhY3wdWptXKZF7ghZZcFHnbvHOBx3cmI=;
	b=gYq1IV3WTtC9rL3NzkIZlzv+ktX9/agVQgX+ZTGeyZLCLCy0mvlVlpeKG8YAOfEO1C9kdY
	RajoyS8x5vXWJ8XjyJfpNzj3uWQK1TJFjiUV8XeccFiqbLvynZon2C8+z8rp/Uxgnu9e7y
	cjDbuXFatFnGaEKJKK3buOWvvv86fm4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-InLTUSLgPZ6wMhr5AgrDkw-1; Thu, 20 Nov 2025 12:58:45 -0500
X-MC-Unique: InLTUSLgPZ6wMhr5AgrDkw-1
X-Mimecast-MFC-AGG-ID: InLTUSLgPZ6wMhr5AgrDkw_1763661525
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e2342803so351096385a.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763661525; x=1764266325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FBAWQgLEjTxMhY3wdWptXKZF7ghZZcFHnbvHOBx3cmI=;
        b=CsxWS8/mjGlWAADpUv0Ra49xbmgFFKhBTvKqxuKNbMCcgg+ajcJxTV1lOKuPz9lVMR
         QkCDoQEfEh0BFY5J2IpuouZoB9yxpmbXf2wd3Q31bNKxicad+lK0/hIIU6hGKEXczlBv
         jVEkQxaJ6u6xOrm67D50pd2jdgcT4AI7jiO93W/ttN9t0G4zFGDrRUt/nGeZmOiNRZi1
         wATLEd0/J8Ds7jTxlRtGhHT7ybVJup74y6Xc7RgpZvSKd0u5i3Jm35zhf2eeomIRE0wa
         vgefXFLRvxn9vFNDa9O6IAOmAo6fmZxr57QBjkW2nciW9tJLKks5FIewfhu84cTg2WsL
         LIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763661525; x=1764266325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBAWQgLEjTxMhY3wdWptXKZF7ghZZcFHnbvHOBx3cmI=;
        b=gu4FbDDIEXMSHQ4Wtuef72FFgamQf3MnbM2o/SyLlNubS/KgjnL1Tg8pgXUbl2y1jd
         XtbuIg4phPdaUGbgapOp4mOpsuDV4sJ4WZURvg7aSF7qztw+L3Zw3uCHbnEWuWAQVsvc
         daZE+htlMs1t0bIaQdiM4DJ9zil0XC83Q3x1MrziqBugBtRd1fvE28TJ6Ul4BajC+bUm
         x3g2DI8UCoWAn9+3N0qU0BQ9qumyef/n5Nslq33F8IG0WWYqCROOT+M9WJQ8dtT9aEN4
         l9wl98C2BZ9U9lF/2XVF1/6fqpKDj/IcDowKMp277xxg4GK09iFzS7RSDbLuTCytbFyW
         wZIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFXadQqvEOy2UaulXlZKUp+ud0UalrWyghYdwC0DfzgX2bElyGtcYsAewFEIQ2eBDH9AVfiYHRC9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q01cM5UqLkNpdKg5yH4qux+jiit1Z4t9PpB9kAk3BsAAETXv
	Nl2AdTdDzAcA7eMUdmi8Z8XctZH3Nt6Yrgu+7bP7uidWPEoRo+LhUvkjgyEQfwVnMAW3PTRjOVN
	WqBWsVlibs0ii5plL0RF8ea7OagIxfNkAGCZZZOkWr64XpzRl6yTuLuaBYEW+TA==
X-Gm-Gg: ASbGncsL53NYzuSbkEejkhKaj55o8UIGouBVZCU4+WDzbXhCsEcuv88aEs8KksiZ6Q+
	esS21meul5sI3V8WB1yS3P+dKA6HEVWa1s1QrCB+Z/PkxBFboSGXh2yjDTA6iSVSnj3sJNM/Itu
	Tk0JPzi5v5G96okC+Xi97cgEYJ/vEhVbhHhSbSM1TOvVASmI/rdNX1bKZWgeN7EUXQEQDdISDF1
	J0uHzU02zKY7YD/IlD3b7koRJMPFQ3F5uy65RUXndpLGmxUVn1df/NcQCZZ6jNbPlwHETw+7CNJ
	w2zOo98FBOMORIZt7hXDwMmgdxA9YNlAbOeyggw1XqI2dfs+QOlSBR+A/a4/F7RYQFRBqdEdz55
	sZHk9K2jcB3AaIa1oJBe6ZnoTS4yHyZJ2k/gH7V2lr0R/pESm5wF8vhnk3m+IVQFq4U409M6mYU
	wy
X-Received: by 2002:a05:620a:29d6:b0:883:b565:1acf with SMTP id af79cd13be357-8b32749c608mr633794785a.60.1763661524991;
        Thu, 20 Nov 2025 09:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQjuYnyNUCtoiqgSWFXqZwfTOJ3YABSpke0OuFWsE6r3fNUq9NnSWQn2HnLmxFjKwF9Y5Cqw==
X-Received: by 2002:a05:620a:29d6:b0:883:b565:1acf with SMTP id af79cd13be357-8b32749c608mr633791585a.60.1763661524583;
        Thu, 20 Nov 2025 09:58:44 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3293299b3sm200510185a.2.2025.11.20.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:58:44 -0800 (PST)
Message-ID: <73a0863a70d558efaf29d6b988f3fec6312a22a9.camel@redhat.com>
Subject: Re: [PATCH] PCI: host-generic: Move bridge allocation outside of
 pci_host_common_init()
From: Radu Rendec <rrendec@redhat.com>
To: Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <mani@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>
Date: Thu, 20 Nov 2025 12:58:42 -0500
In-Reply-To: <20251120113630.2036078-1-maz@kernel.org>
References: <20251120113630.2036078-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 11:36 +0000, Marc Zyngier wrote:
> Having the host bridge allocation inside pci_host_common_init() results
> in a lot of complexity in the pcie-apple driver (the only direct user
> of this function outside of code PCI code).
                              ^^^^
nit: s/code/core :)

> It forces the allocation of driver-specific tracking structures outside
> of the bridge allocation, which in turns requires it to use inneficient
> data structures to match the bridge and the private structre as needed.
>=20
> Instead, let the bridge structure be passed to pci_host_common_init(),
> allowing the driver to allocate it together with the private data,
> as it is usually intended. The driver can then retrieve the bridge
> via the owning device attached to the PCI config window structure.
> This allows the pcie-apple driver to be significantly simplified.
>=20
> Both core and driver code are changed in one go to avoid going via
> a transitional interface.
>=20
> Link: https://lore.kernel.org/r/86jyzms036.wl-maz@kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
> =C2=A0drivers/pci/controller/pci-host-common.c | 13 ++++----
> =C2=A0drivers/pci/controller/pci-host-common.h |=C2=A0 1 +
> =C2=A0drivers/pci/controller/pcie-apple.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 42 ++++--------------------
> =C2=A03 files changed, 14 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index 810d1c8de24e9..c473e7c03baca 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -53,16 +53,12 @@ struct pci_config_window *pci_host_common_ecam_create=
(struct device *dev,
> =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_ecam_create);
> =C2=A0
> =C2=A0int pci_host_common_init(struct platform_device *pdev,
> +			 struct pci_host_bridge *bridge,
> =C2=A0			 const struct pci_ecam_ops *ops)
> =C2=A0{
> =C2=A0	struct device *dev =3D &pdev->dev;
> -	struct pci_host_bridge *bridge;
> =C2=A0	struct pci_config_window *cfg;
> =C2=A0
> -	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
> -	if (!bridge)
> -		return -ENOMEM;
> -
> =C2=A0	of_pci_check_probe_only();
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, bridge);
> @@ -85,12 +81,17 @@ EXPORT_SYMBOL_GPL(pci_host_common_init);
> =C2=A0int pci_host_common_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	const struct pci_ecam_ops *ops;
> +	struct pci_host_bridge *bridge;
> =C2=A0
> =C2=A0	ops =3D of_device_get_match_data(&pdev->dev);
> =C2=A0	if (!ops)
> =C2=A0		return -ENODEV;
> =C2=A0
> -	return pci_host_common_init(pdev, ops);
> +	bridge =3D devm_pci_alloc_host_bridge(&pdev->dev, 0);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	return pci_host_common_init(pdev, bridge, ops);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(pci_host_common_probe);
> =C2=A0
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/contr=
oller/pci-host-common.h
> index 51c35ec0cf37d..b5075d4bd7eb3 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -14,6 +14,7 @@ struct pci_ecam_ops;
> =C2=A0
> =C2=A0int pci_host_common_probe(struct platform_device *pdev);
> =C2=A0int pci_host_common_init(struct platform_device *pdev,
> +			 struct pci_host_bridge *bridge,
> =C2=A0			 const struct pci_ecam_ops *ops);
> =C2=A0void pci_host_common_remove(struct platform_device *pdev);
> =C2=A0
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index 0380d300adca6..a902aa81a497e 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -206,9 +206,6 @@ struct apple_pcie_port {
> =C2=A0	int			idx;
> =C2=A0};
> =C2=A0
> -static LIST_HEAD(pcie_list);
> -static DEFINE_MUTEX(pcie_list_lock);
> -
> =C2=A0static void rmw_set(u32 set, void __iomem *addr)
> =C2=A0{
> =C2=A0	writel_relaxed(readl_relaxed(addr) | set, addr);
> @@ -724,32 +721,9 @@ static int apple_msi_init(struct apple_pcie *pcie)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void apple_pcie_register(struct apple_pcie *pcie)
> -{
> -	guard(mutex)(&pcie_list_lock);
> -
> -	list_add_tail(&pcie->entry, &pcie_list);
> -}
> -
> -static void apple_pcie_unregister(struct apple_pcie *pcie)
> -{
> -	guard(mutex)(&pcie_list_lock);
> -
> -	list_del(&pcie->entry);
> -}
> -
> =C2=A0static struct apple_pcie *apple_pcie_lookup(struct device *dev)
> =C2=A0{
> -	struct apple_pcie *pcie;
> -
> -	guard(mutex)(&pcie_list_lock);
> -
> -	list_for_each_entry(pcie, &pcie_list, entry) {
> -		if (pcie->dev =3D=3D dev)
> -			return pcie;
> -	}
> -
> -	return NULL;
> +	return pci_host_bridge_priv(dev_get_drvdata(dev));
> =C2=A0}
>=20
>=20

You forgot to remove the `entry` field from struct apple_pcie. It's no
longer needed now that pcie_list is gone.

> =C2=A0
> =C2=A0static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *=
pdev)
> @@ -875,13 +849,15 @@ static const struct pci_ecam_ops apple_pcie_cfg_eca=
m_ops =3D {
> =C2=A0static int apple_pcie_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct device *dev =3D &pdev->dev;
> +	struct pci_host_bridge *bridge;
> =C2=A0	struct apple_pcie *pcie;
> =C2=A0	int ret;
> =C2=A0
> -	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> +	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> =C2=A0		return -ENOMEM;
> =C2=A0
> +	pcie =3D pci_host_bridge_priv(bridge);
> =C2=A0	pcie->dev =3D dev;
> =C2=A0	pcie->hw =3D of_device_get_match_data(dev);
> =C2=A0	if (!pcie->hw)
> @@ -897,13 +873,7 @@ static int apple_pcie_probe(struct platform_device *=
pdev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	apple_pcie_register(pcie);
> -
> -	ret =3D pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
> -	if (ret)
> -		apple_pcie_unregister(pcie);
> -
> -	return ret;
> +	return pci_host_common_init(pdev, bridge, &apple_pcie_cfg_ecam_ops);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct of_device_id apple_pcie_of_match[] =3D {

With those two nitpicks addressed,

Reviewed-by: Radu Rendec <rrendec@redhat.com>

And thanks again for spending time on this and creating the patch.

--=20
Radu


