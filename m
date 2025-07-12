Return-Path: <linux-pci+bounces-31986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A88B0285A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 02:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452AB5411DA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49A76410;
	Sat, 12 Jul 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHeaM7ke"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1B3A8C1
	for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2025 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280701; cv=none; b=SPF5Mshg6tesLLPqnzasybJxm1vMtNuCCbjBGUPSiOym8/zViASahy+zuRx67t+QxF6DRyJ/vzzoJG1v87dmij2yChojrkFUNNLnjq8yMZcY62WTMjOmVMoBLwFaP9CTEKkin30Vo+R5OSBSKyxw2w6RcTqYfhqsYnKEhkmMOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280701; c=relaxed/simple;
	bh=UkFyYdb6Iv006IVH2XSxgBssHRSlceqPI9zmw0qg5XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrB9ZI+55HjZYeTDdMEsyE0a1akJHA8tRPY0H9nDq3F0gpWRatVbKIEbqv7B2IVkYF4TxGoORjJBf/FbLYa9as0xHuHtzX9Fi5TDH0JIlVT7htcCihYJ7Uy3BEAIBIAtZqs7Cqx79jeAjED4jry0WJ7LiTla3S93iYSTwuqSSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHeaM7ke; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-749068b9b63so1866552b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752280698; x=1752885498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5C0aZGzWah4ZFBuTYCZpMrf26VMhYKg7WxsS6cFuk=;
        b=nHeaM7keph5DJFO6L1PCa0jjZlgXQPER8qH55smAi+V0Y98ncyo45swyReedMZkVG6
         OBRgXUiQMnl0XXzWCMb52ldxIRAfBSy+55pCMFO+AMOHcYwUVUPROYN9ikXNOmoAHJm8
         9BxDlsGL+ZiiJ9TXJSFlxzDvvwDJ5/BcGWsJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280698; x=1752885498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai5C0aZGzWah4ZFBuTYCZpMrf26VMhYKg7WxsS6cFuk=;
        b=A+dUmwEh7h9qjQwLy6BQd4crkw1MVCOIpEUwg2QcVGiMBiN+YKL1U6DGwnlERytz/d
         9CT0ansj4rLZdRnwovXV1ok65QW2d6i0BPaYkTDyxJio7+rXg2uMTZvoMlUjhm+8DG+E
         pBwjtaYlMqlq8LuLXWHVBnaOwKSYxheuvMawrnUh+h6yUw672hvXNN7qG5LHLzvrY6wH
         M/mh3faqBg4an400wmZ0wDIaB6rH3EYoMnUreE+61vL0M7rz0qx/OJbIHJNKqDxA+PX+
         W91hsuk6UlqvjQ+yUGp+BLHXOpLsGF/4Jbi3AgxopLWNNA9FNfOpqeANAHWQXyLy4tpP
         ex1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUMtMRyFxdfexqSWYGlHuX511HXK87oEuts2xtS9E+xLctoRlk3zlJSClKOTeLjQtjX2KmXF6Grk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXEC3jEf21mlYagbBKFFvkCshXfdlnpEMb8xs9kGeWlwS+J4N
	9YjpUNQPP1/kh2Zd80A2Wz63YBtYFYRXYyuorKfzALygLskFeqOJW2VFreUTAf5CyQ==
X-Gm-Gg: ASbGncuakyfCHjdQKjWwAUIX5hOsF9UbhimgdfpDlVumeyC6M4tU4kvycGCMgoZj7/u
	naz57nH7azzBygdmra0s1PDiYbWfXUrEVVzBW9t92ghDsdeB61/jie8XlYvz0wtOb2xzdGGQvXe
	89DsX5lkCl3wmUwm7mzrxLcW6SVUgU4sxc60wIQZLAcN9D4iakAxiomNaIKs/adyc+8JbxO3MB/
	xfZrgv7yHVDXKCn4AOArKWpwmSzw4xWub7hs8wn7sGfn/zYiGRU0z77YGzWfZI5ck0fA1oaMWQH
	khM8mQ34C8lyaizhc/g55J0zQnBmJUUdKzmDVVPyPYJW2ZjixaE97r4XaX3NJhK10xsVLoRItBJ
	I3ZCQGL/Y7/FmXeL9+vBBR23cm63Q2q2kx+z9x6iuoUurXBXtBF7b1YWGQLFZ
X-Google-Smtp-Source: AGHT+IH7cTn36pVPXMTL1GrAJZlMQg6zx4a7aTWAnpBBYd+bO+7yRb9iKsSRX8MmnkAtmBgMMU/W8g==
X-Received: by 2002:a05:6a21:ae09:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-23236e39bc8mr2668926637.40.1752280698443;
        Fri, 11 Jul 2025 17:38:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f8bd3bsm6429988b3a.149.2025.07.11.17.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:38:17 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:38:16 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <aHGueAD70abjw8D_@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>

Sorry for so many individual reviews, but I've passed over this a few
times and had new questions/comments several times:

On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> PERST# is an (optional) auxiliary signal provided by the PCIe host to
> components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> sec 6.6.1.

>  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
>  {
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> +	int devfn;
> +
>  	pwrctrl->dev = dev;
>  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> +
> +	if (!host_bridge->perst)
> +		return;
> +
> +	devfn = of_pci_get_devfn(dev_of_node(dev));
> +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])

This seems to imply a 1:1 correlation between slots and pwrctrl devices,
almost as if you expect everyone is using drivers/pci/pwrctrl/slot.c.
But there is also endpoint-specific pwrctrl support, and there's quite
a bit of flexibility around what these hierarchies can look like.

How do you account for that?

For example, couldn't you have both a "port" and an "endpoint" pwrctrl? Would
they both grab the same PERST# GPIO here? And might that incur excessive
resets, possibly even clobbering each other?

Or what if multiple slots are governed by a single GPIO? Do you expect
the bridge perst[] array to contain redundant GPIOs?

Brian

> +		pwrctrl->perst = host_bridge->perst[PCI_SLOT(devfn)];
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);

