Return-Path: <linux-pci+bounces-16000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 639399BBFD7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41601F23DE7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DB1FA267;
	Mon,  4 Nov 2024 21:14:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F31C57A5
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754840; cv=none; b=frVtRIOyB3owzApsXMjDXlzrZfZ6dF2CykoNna62Krdt++cjLeU6iuBYl7aKkRC+fn0DGxwenin5tFnbK/YGWO+vVqhuXffBqF271FpXgRXxrr0ID/5XmJR+RvW8HdhjSSio6TIK44xPI4MnaX+UnlAKQPOtiSy/XxxMtntfHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754840; c=relaxed/simple;
	bh=PCssWm8+cekSQv5vG/3e+WVppBcYN8YP23hZ4YrleS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGuSpqjqX448FtC8bhIa97Zzby/qEVtZFsuN+53agudcWmSy2HUAeh7MOTsParqzQFFlMz/8VrBi/PiKw15jmx1a5NRZR1ukbI/KpVbSkOUphrhAa2M6Jc/JJVgkgaxqPyT5AkzwvaeZMLyF1mbjTM7TanUBOCjoT+hfRLOvuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf6eea3c0so37017125ad.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 13:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754838; x=1731359638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+j0iUu1tOeIF5urP0/QB+vpPwquIh8XJO17a88f80E=;
        b=o2xHyoOkYTFiUgxvzeftZO6KnaZqxsjKEBL38TEsXLuG5RjBQxCmXGFlRl1iIKy1g6
         ybTmMYAPFyI1+Pk6Jpx46051+7FEY0L5z0ZkYK//59wnh+DzCXjCf5871lTb4GUwYLmx
         ogErO3A2werTrBsk2bQ9zB9Y2u6NkIokjKRWVTgBrS1PqplwDkW1bqu/mDxfr+59aDmx
         5t1aDCgxHf4e7DgiY+cgYE8CkOXO8XbHCVG6VsxBEagpPNRuoYeplrhYsMEQe2cV+G5p
         xEJsb3EJfpKvSKHIG96axM6UxXMCXU/qr0H6qpZbpd6OC9YoMVcncwO/w3qfHYsgKyoD
         Ippg==
X-Forwarded-Encrypted: i=1; AJvYcCWp+p/TOFwpXa8kR2uGeQfLvuvCEkkArson6eHBVkO2f364tKVFjejUdD4HjFo9PMfHknqTBj5YUS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos67tLeSevN9vyZ9SVfB4ycO7kVQYMp7FZOpITHSL0FbBg8AY
	tcEWnq7187u7+00dBXorgIRHDxKgdL4n5GUgguz+NCX60WKFz12z
X-Google-Smtp-Source: AGHT+IEEZ6L456TFnk5jUYOPRdEEYcYRdMTikdWuGbFnVg+6RxBgQXB6UhFjEcpWjgxkD3znvLhBFg==
X-Received: by 2002:a17:902:f547:b0:20d:2848:2bee with SMTP id d9443c01a7336-210c6892da8mr482187425ad.16.1730754837469;
        Mon, 04 Nov 2024 13:13:57 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3b8bsm66120385ad.248.2024.11.04.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:13:56 -0800 (PST)
Date: Tue, 5 Nov 2024 06:13:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Do not map more memory than needed to
 raise a MSI/MSI-X IRQ
Message-ID: <20241104211354.GB880663@rocinante>
References: <20241104205144.409236-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104205144.409236-2-cassel@kernel.org>

Hello,

> In dw_pcie_ep_init() we allocate memory from the EPC address space that we
> will later use to raise a MSI/MSI-X IRQ. This memory is only freed in
> dw_pcie_ep_deinit().
> 
> Performing this allocation in dw_pcie_ep_init() is to ensure that we will
> not fail to allocate memory from the EPC address space when trying to raise
> a MSI/MSI-X IRQ.
> 
> We still map/unmap this memory every time we raise an IRQ, in order to not
> constantly occupy an iATU, especially for controllers with few iATUs.
> (So we can still fail to raise an MSI/MSI-X IRQ if all iATUs are occupied.)
> 
> When allocating this memory in dw_pcie_ep_init(), we allocate
> epc->mem->window.page_size memory, which is the smallest unit that we can
> allocate from the EPC address space.
> 
> However, when writing/sending the msg data, which is only 2 bytes for MSI,
> 4 bytes for MSI-X, in either case a single writel() is sufficient. Thus,
> the size that we need to map is a single PCI DWORD (4 bytes).
> 
> This is the size that we should send in to the pci_epc_ops::align_addr()
> API. It is align_addr()'s responsibility to return a size that is aligned
> to the EPC page size, for platforms that need a special alignment.
> 
> Modify the align_addr() call to send in the proper size that we need to
> map.
> 
> Before this patch on a system with a EPC page size 64k, we would
> incorrectly map 128k (which is larger than our allocation) instead of 64k.
> 
> After this patch, we will correctly map 64k (a single page). (We should
> never need to map more than a page to write a single DWORD.)
[...]
> Feel free to squash this with the patch that it fixes, if you so prefer.

Squashed with the rest of the pending changes, per:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=d2d9f84914e147d6ee399e0ed8d938fea7f0c35c

Let me know if anything needs to be updated there.

Thank you!

	Krzysztof

