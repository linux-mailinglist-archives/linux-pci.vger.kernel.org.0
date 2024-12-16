Return-Path: <linux-pci+bounces-18475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3579F299F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A56165E5C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27614EC73;
	Mon, 16 Dec 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoZqvn6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44A17DE36
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327184; cv=none; b=D2low/5zELpX6cajud+VeYaeSW0JJRzZPrhIVHQDvrJCwb0kIXNpO2yWuLrimgFPhagJ0jOiiSCcSBBjMxcsc8QklG8HRU/cSYrnOpzYZIdrPucwUA97M8Aaza5jTS/k443T9ZfpR1+p6hF/rAD61A25mxcjoo7Rp74f5OUEeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327184; c=relaxed/simple;
	bh=Kwq68aWDO6GJ8+k6YThM9/3tvRFmIeAl8WjioZc2kRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlt3Dh8z/tN6silOQ2PlcFw88kLC03KaCbGzPercF2JKdZJv1JHkXIV7hVzwXiRQ29eXt8GQsgXl1IMoLguKqYSsTKb6Uu1zWwUQcXReSSNVwGD0DKRa2RcP7Z5CwtRN+RW3eAnjWoFaxdLuk1tXkkMsZxwP8ZHtQ9Q1YdO/3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoZqvn6e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216395e151bso23381305ad.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734327182; x=1734931982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lEeBxgz2ocYTqkJRwHWNc0CCWq6wo0kC/ZkpzEKfNuo=;
        b=QoZqvn6esI5L+El8FHJdwCrG6sfZrPHhNpFe43zePBytm8L0Yv91Lkm6G6KhPC+w/K
         YTrFkO15xV33RZewNu4DcsLwl0qbySul4kCuQDOE5QSQuf+w052aDhPs4n7VomNDRYLR
         AXwz/0xtFeJoOLdtjIw/gDThyXJe854c1NvTtBAnxPtJYmhfwBkSj8jXfmYb0/T0RMcn
         +CXBXeXkzqBilCSmJ7nTwWXs01d4pNf39uTFt+Bhj1lLSEk8BVCYB4BtVvpnAk2hsdLx
         wuMNlewyCUPNRhuPmEc+1CenaC311ZLpxpHKiUYZQ38IahyZa2VHxE6OxrUNRXUjuj/i
         ovlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734327182; x=1734931982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEeBxgz2ocYTqkJRwHWNc0CCWq6wo0kC/ZkpzEKfNuo=;
        b=CRiJXS1Uxgnt8lvsKUOdLXpP06NeRFEQtRhyxZe3eUTnXjihdGUpGbPevQdazkCBQR
         bob9UOuDR8qmSrmPKJC+da4Lxblv5/08CVdXcKcmYW4VP9obrUAiGIU69QbI7BMhxu8w
         eO7sRDr4KF0NCwqdQo6bX2JSCaZKxPEfR6KGAWJ5u5iHRS3f83XEazIDrLFK2gWR7+lx
         cDlWcZyzqw4ceJmc9SJGJmM4wRVBbVauEkaN760QyoMmy7xyMOG/vMTYSbBFJBfydvc7
         KIky25hNJw3FascCs7mIjO8lmDMUftg3tMk9unK5kIg8/qnXIG6HgkXvRdr02VrR73xa
         5M1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8ojMKwUmMbpqT6M7+xULEmDX3Q7PUAwdhkxr1xTXHR9DlhA+EpS/d35CVeu3BXpHrCGSu3M275yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPTpCNr8BKCsl8gCPuuJ5+/5Ym6W0jieqMQn4se5uhg4ulYHt
	KzkgWVnsHV1x/YB5iJ1UsCvpps8X5U4mTd85NEdhKmN1pB4v7sXlEprmEm6qqg==
X-Gm-Gg: ASbGncvDwSvxfQ13AwEmXrUWu9Oem66FfidVZXAPmKfZTpjnB7O6ldi06GGHABezarE
	l5SGbjUsun1fHqwxBjqiVClVXZVZfM/gwDo8pOaoSTNWfo82cg0S+wX9T6Q0kYfjFIlauvJUC2M
	fRe/oDi3L0YQ9FFGV5aZ1fw1lPdiUcPj02yCJoVi9ojmBNUHVIYYbh69SKhZCXgne51UGZarlHg
	yjuSDDcQwrOAz6ZlMRb5X1HB2yqa5Kt7g3hB7DubMMjyus0csY7njQ39n4hQM6HOmk=
X-Google-Smtp-Source: AGHT+IHJQ5xMKrFsSZ5ugUe3p7k4cPG0E77U3s0GdMhWv0t/MHX+qLpC6AC4ccVA+hjZFvljcNc6uQ==
X-Received: by 2002:a17:902:da8a:b0:216:4122:ab3a with SMTP id d9443c01a7336-2178c7b6821mr238859485ad.1.1734327181704;
        Sun, 15 Dec 2024 21:33:01 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6416csm34673535ad.230.2024.12.15.21.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 21:33:01 -0800 (PST)
Date: Mon, 16 Dec 2024 11:02:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] PCI: rockchip: Add missing fields descriptions for
 struct rockchip_pcie_ep
Message-ID: <20241216053252.r422k64oosbci25e@thinkpad>
References: <20241215022813.35381-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215022813.35381-1-dlemoal@kernel.org>

On Sun, Dec 15, 2024 at 11:28:13AM +0900, Damien Le Moal wrote:
> When compiling the rockchip endpoint driver with -W=1, gcc output the
> following warnings:
> 
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'
> 
> Avoid these warnings by adding the missing field descriptions in
> struct rockchip_pcie_ep kdoc comment.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: a7137cbf6bd5 ("PCI: rockchip-ep: Handle PERST# signal in EP mode")
> Fixes: bd6e61df4b2e ("PCI: rockchip-ep: Improve link training")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 1064b7b06cef..36b868530769 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -40,6 +40,10 @@
>   * @irq_pci_fn: the latest PCI function that has updated the mapping of
>   *		the MSI/INTX IRQ dedicated outbound region.
>   * @irq_pending: bitmask of asserted INTX IRQs.
> + * @perst_irq: IRQ used for perst# signal.

s/perst#/PERST#

here and below

> + * @perst_asserted: perst# signal state (true if perst# was asserted).
> + * @link_up: PCI link state (true if the link is up).

This is not holding PCIe link state, but just indication of whether link is up
or not. So how about:

	@link_up: True if link is up

- Mani

-- 
மணிவண்ணன் சதாசிவம்

