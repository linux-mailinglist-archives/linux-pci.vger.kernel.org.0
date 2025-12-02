Return-Path: <linux-pci+bounces-42522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E7C9CBCC
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 20:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99ABD34A3D9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6042D0C80;
	Tue,  2 Dec 2025 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kWP139KA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B22206AC
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702938; cv=none; b=c7X40UZFrmO1A4tPgv9Oh/6B//9mN1/KEO+UuOklCuE3cTYVQNCMCLnBtLlahOfkH6XJBp9lhgPYZ0ltckTviD/c/Blo8dnE3K95STDi3Jyjbvh5vg4vMdgLQnsxkig/rLK4z8oEmTMT7LDO0gtI0kgeZF5aPMKL2srIbj8cyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702938; c=relaxed/simple;
	bh=02VswylmaKTEELLi7Y6w3IpRRDcUxofhyMHg2wDIGqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caET9uoWeBTsIMhJ+afcPpEw+7R6zerlsFrl4O1nnoPYW7+GzzDwq9Wl3snv1CABvFOzUaUxwkw1rLiwrzUK6QdLYI3KB/N+9K7P6ZKNRFhNOFD2ruI1lDV9aBF9LSv4dHq2oi75i3BeTxevzPRLE3hkpK0wN9SX4Jbwf2GqZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kWP139KA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804ca2a730so81615556d6.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764702936; x=1765307736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYXufk/CghCmeROphf028hCDLM+wcJfUx/di8AGxJis=;
        b=kWP139KAPyp/x89UBZzd4Jy8J0yEPt+8KRzYLgSU/K3M3mXmfg1HMZgwb+5k7Y65Xc
         xRcu2FoVGiwmCRFLpLSudS2AGlelbjA42DgnG8Hu6FezOm9fNecGsoxrNA4d0PnqoGtO
         Wva2DgxL+yPTrsKtqDn74jMNM3uuJpt64Qtmhy9EVyxjiakAM2oro7+wE2Twwb60rKoY
         Xqx/x9uinLrkLw68NiFfAj02EtyWwVcZmIYaFz3KxCgWGXWf6eWJmcUcWjb1Rk6tC/Ga
         3UDYdZ70FeVMf3QFsPR3nsSJJLEk5sWW7OO6XQe+zKh6aW/DsjixFxfFcrW/NSRlqXPI
         kDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702936; x=1765307736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYXufk/CghCmeROphf028hCDLM+wcJfUx/di8AGxJis=;
        b=bImbIeF2ZHv5PjOeITRzq2hxXGUkB9J1n7BlF0IBztC6hxxQbwexis3S/1CaKNvKRe
         pRcoIC650h35IrpNICf5wlJvtyC4VxpEIIl4qqCqt0YEB4R9NRC1qBiLGKMi+qTfcOhG
         89bdk0yue6SIwtjBH8VUlIuMPF9V+2oBPkvcK96dpZDoLVlUxnEPQgH6FxUryMvxWydl
         k/plJlKs1VZAhRf8CN6ooJSOypJDUTtsP4wnJ5TMlGYbY1vmiZu92TqeH0PHkGoCqNwV
         rg+llRytxm2Bww45QXTHZZc/rWogj0q+PQ+9mSntHrXfx7cZ1Dpu9NVFxtSYf8/j0BXz
         CusA==
X-Forwarded-Encrypted: i=1; AJvYcCWcOo2oUIkSNreJLuuZbn28WpghjEe9ZilRy8BWeP1h6LUeb2wYJlycEdOxIBIY3aYHPY30m3u89FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjXRxvFxX0aklEJypTW6kWoBwf429OwuDVLT1iPEUF9nyddry
	qt9NXCuJjNBrkbzMJypxgpi0LJ7YcT/NRTChFY8/mWRpXLVg8IhV359CJD/JVZDMbB8=
X-Gm-Gg: ASbGnctyh1CTw9/6BvDkJ2bYNVp6m9ugeV58xFFAHQAm/qvZXR8mzLH5qksdR/dm5V+
	OF8Iv5P9c94qnsRrlX5F1hpZH+vZ0lQMcHj9wYxFQxRbba9YlDQwbY2+FwHaRJXca7Yf9uexOl9
	e1b1YqkCpX5ILL3Fb+rsqjFQU+OfqffNsg94K+RR6uHN85a1lDfawOIoaXa3k2ABAzfvpLjnHa8
	x2E3pTd5Zl7whIX1GqtoVnlo73AU9XZuCAgTWxcnR6KshQB5pglkiaOHHMeSJhE+ggNZUSWCtbD
	ftrKBxQw0v/dyrzrx10624gOLHd2Fer55K3wDKX/eEJ2MMFzHiuBgPdRoTozMDiqnWxPpUzsPKl
	nAkPmgFZcWOsD6QVU8YhFpAZEf8EFiru8ISeS+u+oTbUQe66HIKxamm52/FYntsYRwsKQRHNSvs
	J4xFXjWRRvtQTx0SZIhV7N1VD5vp8CExGK2s05tNuGdn53cjEm4oFJqf0h
X-Google-Smtp-Source: AGHT+IGmiowzXqNsrWumuA10yrxW+wsYpQdV9eVH0NfTUqUkzV4tZO5Fje3s2ud/cDX5d0jFbs8uxw==
X-Received: by 2002:a05:6214:23cb:b0:882:47e2:9cb1 with SMTP id 6a1803df08f44-888177d47f8mr7616446d6.43.1764702935239;
        Tue, 02 Dec 2025 11:15:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b91ba3sm110766546d6.53.2025.12.02.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:15:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vQVqX-00000004tAz-3gdk;
	Tue, 02 Dec 2025 15:15:33 -0400
Date: Tue, 2 Dec 2025 15:15:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20251202191533.GI812105@ziepe.ca>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
 <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-pci_acs-v2-3-5d2759a71489@oss.qualcomm.com>

On Tue, Dec 02, 2025 at 07:52:50PM +0530, Manivannan Sadhasivam wrote:
> @@ -544,6 +544,7 @@ struct pci_dev {
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	u16		acs_capabilities; /* ACS Capabilities */
> +	u16		acs_broken_cap; /* Broken ACS Capabilities */

Why do we need this? Have the quirk function accep tthe
acs_capabilities from the register and return the value to program
into struct pci_dev ?

Jason

