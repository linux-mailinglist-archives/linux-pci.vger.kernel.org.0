Return-Path: <linux-pci+bounces-15830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04E9B9F60
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5453DB20ADE
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F81714A8;
	Sat,  2 Nov 2024 11:37:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D4140E50
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547457; cv=none; b=XVhgOwanCRGY8wuIm11aPPEUmxYwTqqvYaGqlOz/PR+IhBg6P7r+J9Eez00Mjp5WZ12Amdkj5pWUtru4br5DvdziJkJZt1smDElDh7641ZGuaUpgZSwrpeVLn+Vk8QH6PQPRRYH3FAv3mmFZ1EHEXsOdtmLDqSCaX0aZzVAylRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547457; c=relaxed/simple;
	bh=KX4Zls8ASlpyXYfAEK30kER6vZyeLhNa603WXj1L3a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok5fi6hh8BVnaWW/OC7qtkanrXLXdB/yELcUO25fYWSE9PeoAhlcPmcie/krFGC0XlHPIC63/omCUj4unDCed5+r69nxUBnZEsBZ92HrIuPCEHSDPDWiCmPg+SSPBnOvRTvHpgQy0CPvdEVUffuT66PjIqVh/xcRqTmAG7+CFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so2265621b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547454; x=1731152254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQUXIltvXjCU3fgua6KXwG2kEySYCHDFpzgUvHWzn54=;
        b=f3f1tl+pfMA9KfQd6B2wVYGrFJsInuHgh2BrL+V0D8JeDd+TUrZVo4x+s7KaY/Z7wb
         gH4wMFtzCJggGcbz4UuMZK2swJE41czZ8OITCKXSoqDJUp59UXYzVsW8laMw5DmX1TkD
         tfZUpy9NJF/EA7E0Cf4CsSZeAmp+jDG8tOwqrbcMn7kDXccIwSUNo15ynRXiU8D1VWPb
         GDRyoR4JBeSY/E4kmVmVVGsAzuNCeZq37itfDPbV5GQt9XuLLcz+fp4PETUF51HWtZA/
         rVeu/p77E1P29tMFCn7ic/in2X+3ZzNoiwSJsd4g3ZETPhKP3jcvuHI+VqI8ALvROkwE
         fIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfl2LlvkyZ9Jzk8WZ3spKZ/MBiKOyV/yeUXo4pjEv0wIhbAxcsYxGLhJDfyp6cIFgGdyLamRKn0Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3K4dkZMM83LoutqqzPxPkkGa2L6FWDe937GmZsfcwlyhSxKv
	c8y44vYz+Wn3UudB1I4HYZWfCh2fxV8gl8JwdVjmJA9s/AJb9fhJ
X-Google-Smtp-Source: AGHT+IHrTGTqd+v1Jt5KxznHAt556xCBZDatUzCjcvE5KNtzOXY6eL8X+aAJVE1JnD2QJjeCxZ+Bmw==
X-Received: by 2002:a17:902:f547:b0:20d:2848:2bee with SMTP id d9443c01a7336-210c6892da8mr374236185ad.16.1730547453766;
        Sat, 02 Nov 2024 04:37:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db435aasm4072403a91.54.2024.11.02.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:37:33 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:37:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix dw_pcie_ep_align_addr()
Message-ID: <20241102113731.GB2260768@rocinante>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-5-cassel@kernel.org>
 <20241101071236.gddrtufnalhjf42k@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101071236.gddrtufnalhjf42k@thinkpad>

Hello,

> > ep->page_size is defined by the EPC drivers.
> > Some drivers e.g. pci-imx6.c defines this to 4K for imx95.
> > 
> > dw_pcie_ep_init() will call pci_epc_mem_init() with ep->page_size.
> > pci_epc_mem_init() will call pci_epc_multi_mem_init().
> > 
> > pci_epc_multi_mem_init() will initialize mem->window.page_size.
> > If the provided page_size (ep->page_size) is smaller than PAGE_SIZE,
> > it will initialize mem->window.page_size to PAGE_SIZE rather than
> > ep->page_size.
> > 
> > Thus, mem->window.page_size can be larger than ep->page_size, e.g.
> > for a platform built with PAGE_SIZE == 64K, while using a EPC driver
> > that defines ep->page_size to 4k.
> > 
> > Therefore, modify dw_pcie_ep_align_addr() to use
> > epc->mem->window.page_size rather than ep->page_size.
> > 
> > [...]
> 
> Fixes: a1cd1d901a5c ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")

I squashed this patch into the one this aimed to fix.

	Krzysztof

