Return-Path: <linux-pci+bounces-21107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5110A2F7A6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619671889E5F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209D257AD0;
	Mon, 10 Feb 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Qy5FLFnL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9D257AEB
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213044; cv=none; b=AVNSQXuSgen8vWkw99YNCYtorv0mbu89Zohk+YO7LYDhyAgr7u/QGKsQkV2lvYj9I7pTJUeWnSiMFv1DFMHFy6aNCECKSqwzCM1VOLgEqEuQ66Dj/JYJ72ie8SEcd/LAqmBBAUJ02BL8gncGhWWSEl8Ex43Sj3vQpAkaxvwehEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213044; c=relaxed/simple;
	bh=g+RLLz/xLn8yq3bJBjBR4VvexLtC/q9+LhWR2+/8h0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkqoaaVsjMtoIMRKcLwLMQIYRX1dcZwY4Nxjo3xjVBUjIBsQJOX5vIpWzfF/bs5vXmmIUm273SNSrCvYpn94Z9OIjXDpeNfmwIC77zwCpl7ZS7NJBSoIenEv8q9+Yn7gPoIrVePidXtPKAFCUG6kOtvst2qBBfXMnlovnhyvOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Qy5FLFnL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd0d09215aso36645676d6.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739213040; x=1739817840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKqmSL2H/APhjIZ2w+BTA5IvzYblxi2A05dvCygiAwA=;
        b=Qy5FLFnLjh32XI1zhzBCAjmSj/G5+YjKBZtlgsqxR6DVQYTLKlOB55yhBl42YjN9AV
         Qk4tvo9s4UxLngjTQRR5vMIrBuuV9Q/mpQbWBemdu1FHjyDyWFZmlbQJjnWy2k91Kdw0
         lZi6ysDQSmjAaFzcOWHXZdkYUdj1Idm4vwnTf+3rtVCM8biyT2NaqogR1pVEMf+7ERbK
         jVNJ04yacpJJ7PFFSZgGIweFYlWf6bp4TqWBldtlqjC7x08FXMgS60imNiQ0h47TP6FN
         pV8eiaPwtcr+sQ5kyYG1euniON+TOAOxZS48wuElJbRlIfc7oekjUDW68kJIXuXgMYA2
         Z9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739213040; x=1739817840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKqmSL2H/APhjIZ2w+BTA5IvzYblxi2A05dvCygiAwA=;
        b=rlRLKqnzvHniaMyazKFNznYmfftz1x84/00QaZZTJhwZYatPJ/JOfBtCCT0+en3JE3
         /421mdpkk5K3nfDeZuQZphsncRFQOYRT78VTkUoXXvHsPPNBX3ybVzwKEXfEY7CPqV0c
         zWLsmCGOY2jD4OX3HhobsBQzkGhTpWxxtORYArwIX/dXOIwt5NnIUhL7TgURPeq9Jn2a
         rEEidd6uD1wh7AaPs0Am1HW2TCnvvah/GwKWRa7z1Wb4GLpMNgYtfjTj+xWQ3jL8GFeZ
         i6sppskDy87o5ZuLwB8RoZUSVr1H4Fbs9IbRI6Q3oYbUOEs41d0zZ8ETJx2uMOeWH9a6
         VAow==
X-Forwarded-Encrypted: i=1; AJvYcCX+/uBiwGo1wC2+UjDN7w0wnuT2Iqwmxcw/ppQKbIGg52NnsPz0MSXWW/kNA/jn+Nx2jO6ZZu6571s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPYVKv7eBOU8DDaxH7nRw7SEMiMGTy8L5ffSBBvQ5ZAbg6Exi
	zpSSZx+a+7ypB3QgPZN62XqJqKHqkxapGEF+K44qCGASE+cnNjLrMeylCKzx7BQ=
X-Gm-Gg: ASbGncsdE9lgqcrc3R3oA3fMgmJYhR1cB34devIlWNMU/BTVYaCzqXmaKxS6mN9mpoo
	sCiK2FwBxeGoDE4McF1l+2OmsdjvaH2I7mejRoXcUN/V6OaRh5Ii6MzsCb20a0fSzV6KGjlGpM3
	urdpSPpSgn6Jx4TjSn+gscmdl07dAoPI3CIzSwd0phyWYHchwpXI49AuX9GA8foIcvuJgUAxT8b
	wekGhjEXlQbTL9zfnHiCeOC2DqfF3OafNYRx5bzdS6+IPxTorn9KT+0Yqdn3ICeSstnLR6Oi3Yr
	iZyE8M5TpUZYvjLXXAGnmmsKiS2YNr3rD9QJXPw4+6v2bn3Es7m3VnOim04tgCzMyxBeGBPEBA=
	=
X-Google-Smtp-Source: AGHT+IGPN0vUu+9xImUv/0T7AL/p7HAa65vynZmWp2hLCNl+jzDCkk1rpyc+ciMt5y0usbsQ2BCrTA==
X-Received: by 2002:a05:6214:21a1:b0:6d4:215d:91b9 with SMTP id 6a1803df08f44-6e4455e6ed1mr222298246d6.11.1739213040662;
        Mon, 10 Feb 2025 10:44:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43dd7818esm47643626d6.68.2025.02.10.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:44:00 -0800 (PST)
Date: Mon, 10 Feb 2025 13:43:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v6 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <Z6pI7oGXYyoecJzG@gourry-fedora-PF4VCD3F>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
 <20250208002941.4135321-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208002941.4135321-7-terry.bowman@amd.com>

On Fri, Feb 07, 2025 at 06:29:30PM -0600, Terry Bowman wrote:
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..eda532f7440c 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -661,10 +661,16 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK)) {
> +		dev_err(cxl_dev, "%s():%d: CE Status is empty\n", __func__, __LINE__);
> +		return;
>  	}
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(cxl_dev))
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
> +	else if (is_cxl_port(cxl_dev))
> +		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
                                                              ^^^^^^^^
Parameter isn't added until patch 14 - causes a build error.

~Gregory

