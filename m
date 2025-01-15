Return-Path: <linux-pci+bounces-19868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F747A12247
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78CC3AD3F7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3120DD66;
	Wed, 15 Jan 2025 11:14:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B242063C3
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939683; cv=none; b=XGzzQUj+SAzyeYnqnBtprlQTK5PZ27+n07KwjjcUBGS+D51DVzQ/CoVQwjkEZzOjt+jT1g6M1YcFKVAKlRWvpcWrHnQnBoNPNFhfwB5coFQsteEP/R/VOYdlqk4njeFZ74d+KfPJf3CIl8cvK9wTSQfa9V6H/0v9fDiEM9h/g3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939683; c=relaxed/simple;
	bh=LIOOZSicKPW5eyg0Ppshh70j76aKyelwZwXVlWpiZD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrBCCeBT/Z63NI7Y3/70i7nPtC14i9TnYNbZIBP4ZkjT90SAcy78Bf8GJ14yf8Yxe6Ogsr7k8kMJOPziL1ctFtF4EQoP5Sy3urd13Q+gYz0Up0W322FOG34At5BjL80U9tpS1qa4xN+dS11UEQX6JRcc8vvMkUvzNgmNuvRlAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so8637968a91.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 03:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939681; x=1737544481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz8qYCut2vMXxqWmWVOJ5WSfbE/dmnJ2d6EiHkz1mpE=;
        b=Ay57hrO0vKr61f3dwTIkJIEgBj4C0qGyAZQE4Brk/lc0wal1TZQGz736Iu66iCq0dO
         5emFKNSSL1N0/o4CPFqfa7cqAXm5H9YdYffyewjr0tvmREzKhdyIlj3B2dvBMr7LhNV2
         nUdFu579bQXkH1Imtj9XK2MZ6wrADkoLsW8IrWLm3emQTuuwGQKH5Xse9OZKQzb/fdQb
         vNXTGnwT0aT8Fu1tvZZSnFGgEsNDQMqMA03CG4HPw3ZLVQfVzd7F6NVCA1pHLE3ZMoh6
         NwsVgwCOWMQ4QlyWEOr2lhisDW6/4MNbuOwmPwgSesi+nOYGh69/sU5BU3LsxJeCT5PW
         SuUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCfq0Iexkja8E9p8HUCt6/cA+IzBldcQHvU9Dut/ZLp5yW5L9QH82hjF3cOG4N2grANcKxYtZPOQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQqScn+3dPDA4ieH1v8KeEdlLJD5BcCbit+f35qADYiQp9VLP
	3yMqDXaeP1KGdUPuER+m6JtG0nABUOJgArPih9eOhamVLB40AXI/
X-Gm-Gg: ASbGnctsim7f7d2UZiFF9J9NP+fdtV745yP5mnoxpdgAWgBv5c/qhKFN4WSkcFqrX/V
	2VISRvzcRJgVcBs/yxfRGspLnWdi+m1zfXpLIqzyw1nx6+Jp5B8JQs0paEkCjCOEb1ouVH0GdFx
	uxeR/eSLYC4VtFxqV/krmv0L7chc6iidP6dvRwLSjH3OZA746O+pSNQud1kWbFRUV5YZRxSe6bk
	OBmNAPQmLmZ2fJ7jf0mURILY2RXhz9pZwV5cAFaZPh/v+1IWB0+iPifwdyTwT0+Y8zLvMh8UZ8E
	rTJPYj4CfVc0TD8=
X-Google-Smtp-Source: AGHT+IHBi1TpzbH8P/aWhdgwF4SFs6U00POoo7gCP6dZ7wsv46DHk24a0naYWm/T9JwxKv4fWUwHVA==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:bbd8:2b9d with SMTP id 98e67ed59e1d1-2f548f75de6mr34988834a91.34.1736939680740;
        Wed, 15 Jan 2025 03:14:40 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7085261dcsm1908286a91.0.2025.01.15.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:14:40 -0800 (PST)
Date: Wed, 15 Jan 2025 20:14:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v4] PCI: mediatek-gen3: Avoid PCIe resetting via PERST#
 for Airoha EN7581 SoC
Message-ID: <20250115111438.GB4176564@rocinante>
References: <20250109-pcie-en7581-rst-fix-v4-1-4a45c89fb143@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-pcie-en7581-rst-fix-v4-1-4a45c89fb143@kernel.org>

Hello,

> Airoha EN7581 has a hw bug asserting/releasing PERST# signal causing
> occasional PCIe link down issues. In order to overcome the problem,
> PERST# signal is not asserted/released during device probe or
> suspend/resume phase and the PCIe block is reset using
> en7523_reset_assert() and en7581_pci_enable().
> 
> Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> specify per-SoC capabilities.

Applied to controller/mediatek for v6.14, thank you!

	Krzysztof

