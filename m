Return-Path: <linux-pci+bounces-16986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29559D0084
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8157286D39
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3EC19046E;
	Sat, 16 Nov 2024 18:37:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAA18E361
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782278; cv=none; b=qub0WWPfXgAPBwaS9vgUW9gJeclzVLfazUQNG0TuL9ndQk+CvVhazeTAzzKSzvt4josibTs+8UkXo+XY0KNIQbtCapws/n88ul2AlS+crdXZxt0+oFC5u/lFtS6L9hrau5cvERtlW6yDWXq0Z2keExzFTrDnN6pgiPiVlronKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782278; c=relaxed/simple;
	bh=OJD0HIYVluSfDAwsz03n40w1TA++lYn4bSEvEhoSc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKXFVMkPrx/531i8JUmGU21mD+mt7Mi/3ljzHqdzDx80Rta8RMlumUmv3CtlvLRiEGwRbyxuhEJpjiQ5VfhzFS2n0GMSw8k/foLBbhuTTrUKqcjMwc0F9d/gV0qAIDx9jAHmAaVS9Ph9M4piDOTEsg4PkS2XpKOL4QWCTU2Udd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ce5e3b116so4556685ad.1
        for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 10:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782276; x=1732387076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssDUbSFRnykumr6xwJvwrcFCjdAC9CfRw+lfy2PHrmc=;
        b=uhBGULbQ997nAthc3OTUZuJvwXVUGi659NOmbmceY3YNYUoJOeMXn6ME/TELQaYkAa
         FYgT1roHJ4JlqD9Qp5RfR/qcZPX8tUZt8uyIu6KAAsqiGjt15L8mNfgi4MySj1Fdwda3
         G5PuI6Ja1Byq/5/esSV34yWXUCvDtAt7x7WFkaw8i0DNSGF+Muq5p7p2L+dJf4K9g0hN
         B/+GwCFziDgQePPSbXegAWD73wmwB9UR83dR8StitTaMEFOfmyQiIshxKfcr+/ee9Op4
         U8Q47QTxR2kAHtpdro1QpCgIKwJJhysVXkMOFOeWmCHjxU18DwsHO/qV52BqUva/OVXv
         0k3A==
X-Forwarded-Encrypted: i=1; AJvYcCVba+CB9YsYQFR0xnxN+WRn9siORfjHIhzmIK/IeS4CXxNMQ6KRP8a7BsBeC8ay/uyhwn4UKPi+7qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaCG0FlweKVXiqn2fdZzFO/tpeJiiV4NJFVWFV2Hae7L7Guzp
	qm0AANuW2+JyRgKvgVCcfT+IP8ZTUh2KHg1ObRdi1yR5l0hUuPvN
X-Google-Smtp-Source: AGHT+IHV6hXfe3QxxmTqAy7LAxGmkB5x64aocEMuLdZWFq14pI6ldD5vJb9WHMCWbn6qe4dlXfxSkQ==
X-Received: by 2002:a17:902:ea04:b0:20c:e262:2560 with SMTP id d9443c01a7336-211d0ed2754mr69429635ad.50.1731782275945;
        Sat, 16 Nov 2024 10:37:55 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e2c17sm3340248b3a.160.2024.11.16.10.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:37:54 -0800 (PST)
Date: Sun, 17 Nov 2024 03:37:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Do not map more memory than needed to
 raise a MSI/MSI-X IRQ
Message-ID: <20241116183752.GB890334@rocinante>
References: <20241104205144.409236-2-cassel@kernel.org>
 <20241115071924.jn3xun6luqzd2ylp@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115071924.jn3xun6luqzd2ylp@thinkpad>

Hello,

> > In dw_pcie_ep_init() we allocate memory from the EPC address space that we
> > will later use to raise a MSI/MSI-X IRQ. This memory is only freed in
> > dw_pcie_ep_deinit().
> > 
> > Performing this allocation in dw_pcie_ep_init() is to ensure that we will
> > not fail to allocate memory from the EPC address space when trying to raise
> > a MSI/MSI-X IRQ.
> > 
> > We still map/unmap this memory every time we raise an IRQ, in order to not
> > constantly occupy an iATU, especially for controllers with few iATUs.
> > (So we can still fail to raise an MSI/MSI-X IRQ if all iATUs are occupied.)
> > 
> > When allocating this memory in dw_pcie_ep_init(), we allocate
> > epc->mem->window.page_size memory, which is the smallest unit that we can
> > allocate from the EPC address space.
> > 
> > However, when writing/sending the msg data, which is only 2 bytes for MSI,
> > 4 bytes for MSI-X, in either case a single writel() is sufficient. Thus,
> > the size that we need to map is a single PCI DWORD (4 bytes).
> > 
> > This is the size that we should send in to the pci_epc_ops::align_addr()
> > API. It is align_addr()'s responsibility to return a size that is aligned
> > to the EPC page size, for platforms that need a special alignment.
> > 
> > Modify the align_addr() call to send in the proper size that we need to
> > map.
> > 
> > Before this patch on a system with a EPC page size 64k, we would
> > incorrectly map 128k (which is larger than our allocation) instead of 64k.
> > 
> > After this patch, we will correctly map 64k (a single page). (We should
> > never need to map more than a page to write a single DWORD.)
> > 
> > Fixes: f68da9a67173 ("PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> FWIW,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Picked this tag, too.  Thank you!

	Krzysztof

