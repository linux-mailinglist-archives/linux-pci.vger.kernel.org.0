Return-Path: <linux-pci+bounces-14968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F79A9702
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2350B286A8A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D518037;
	Tue, 22 Oct 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MslA+tTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1C139D
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567590; cv=none; b=MDHUUnFCFcpef5wS1RBemI6mCflZNAxuqYLLqNrzfT+91q66hp57orkgQ3wXzuxIbc7yo9VyUwwfAaQIDPnXpt9HIr/XCuMC+DndemqUZ/zVohuqIX71yZ4nlv5tIoJeW7Jb/oOZJ/bJ40j6i6yK5okRGa4JJAIQ02P6lsnV3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567590; c=relaxed/simple;
	bh=aNfqgQwxxq0F5xne2GdL5f3h/R5/lprUEXxzK5WYPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dicAV2Rld6E3ArfxOPOIPdqrlztHPsRLsfqWhpgcX23XdNxzsZhrpUbTmUVhZ7ByulQsmx9s4hXk/1OkwcstOsr+261Lxp9ydy76eovj0A3W2RUF8Wv+K3mvYMtf7Qsr3naoTEhv7gxpaoDhmLA3zJFNSpbmk4l+e8quYhDvcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MslA+tTB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b5affde14so35538815ad.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729567588; x=1730172388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYqYpYdIRMbs6GYqTCa9EDOytdE5Xbkqeb8RNGzBjNg=;
        b=MslA+tTBdv8zXqTskTQpTMeuTgxpXaUHHfy4Jc7ZD8Ij0t2zTK8NWzcxSFTBeql9zT
         gdaRUCOgYFXRu2i+dywvYVpq3IlPQBeWQwjIFVaSNTQg6iWBW5GcWUFKhMWFckoPqBfC
         ovnpAAJat077QexQYq13p1igiXqN7BbEJDvt102mXX7aUqoyZ+dqR4EX92+AQXuxUs4x
         mQBYPYSMC9Oo3lefzpmait78oVjie4FJ57HhSfAbQmK85R266UwB21S+efJpCP0bcZrZ
         7ccJo7a3LBTduckXLXZ0x3ohP6NIDyJTVhyI/sXJnelb8SojmQkJXTu5TzYAK4MytBHJ
         0idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567588; x=1730172388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYqYpYdIRMbs6GYqTCa9EDOytdE5Xbkqeb8RNGzBjNg=;
        b=ez75qf4KyktK6E0LOH0yCIciswIQbVMwXhqGFvhZQGwQ2SAHrH3uL7c8bzYaskWD7y
         Np9e/0J2vATxtVhMck81EP/PqLpfF5JTR/iEOVvRNhLl2ZBHPkR2mTsax3lU7KuJtKuL
         +nZA8GNxybF1moWIX1YAc1/ujVJDO00jwBHabQB6/iegiNJ33aumYsFXk06qPClw2K3b
         RKIHyyB2vb3qTl23UjrXeCDpol7KdBcfqBqwCQcmguQuGBU6yAXtoIkGdSU+IbFcsEp4
         jGciMP3Lhlpq4fjt/Z9t03NOvZ5zzNMhGIlNdDyEXSGZlSVmN/L6nhzkcSYGsLM5nA/O
         6ceQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmkPXPBtb7hQzqCBUCq9un8F1zZjmG0x2Cz5PYxherA9qVyFijAuILY/H3W7I//QKS0yM0EOJSML4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QJavRs/VUOXn6K9bJ63eEfoAxf4q0zeO6KMQy7g4rDSzLZlG
	BqT8EW8p7J0+zbbCjtEQ1PlTm1MjIlOQbxBTV/VMXkPdjLD4xe34F4Ld1e6E2A==
X-Google-Smtp-Source: AGHT+IG6npBUuWD51w5AxrP4mVrn+QAjWNRttO1QeJPDOJBkRhnU8UQ/f2R+qbqRgWWeGDXiR2lWBw==
X-Received: by 2002:a17:903:1104:b0:20b:c1e4:2d6c with SMTP id d9443c01a7336-20e5a943ad0mr155621235ad.57.1729567588288;
        Mon, 21 Oct 2024 20:26:28 -0700 (PDT)
Received: from thinkpad ([36.255.17.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6414sm33178715ad.12.2024.10.21.20.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:26:27 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:56:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: PCI endpoint: pci-epf-test is broken on big-endian
Message-ID: <20241022032624.trhqdgpewaesnje5@thinkpad>
References: <ZxYHoi4mv-4eg0TK@ryzen.lan>
 <e6baa8a2-7c1c-4905-86a3-fb02c64637a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6baa8a2-7c1c-4905-86a3-fb02c64637a6@kernel.org>

On Mon, Oct 21, 2024 at 06:49:11PM +0900, Damien Le Moal wrote:
> On 10/21/24 16:49, Niklas Cassel wrote:
> > Hello PCI endpoint maintainers,
> > 
> > 
> > While looking at the pci-epf-test.c driver, I noticed that
> > pci-epf-test is completely broken with regards to endianness.
> > 
> > As you probably know, PCI devices are inherently little-endian,
> > and the data stored in the PCI BARs should be in little-endian.
> > 
> > However, pci-epf-test does no conversion before storing the data
> > to backing memory, and no conversion after reading the data from
> > backing memory.
> > 
> > For the data backing test_reg BAR (usually BAR0), which has the
> > format as defined by struct pci_epf_test_reg, is simply stored
> > to memory using e.g.:
> > reg->status = STATUS_WRITE_SUCCESS;
> > 
> > Surely, this should be:
> > reg->status = cpu_to_le32(STATUS_WRITE_SUCCESS);
> > 
> > 
> > Likewise the src and dst address is accessed simply by
> > reg->dst_addr and reg->src_addr.
> > 
> > Surely, this should be accessed using:
> > dst_addr = le64_to_cpu(reg->dst_addr);
> > src_addr = le64_to_cpu(reg->src_addr);
> > 
> > So bottom line, pci-epf-test will currently not behave correctly
> > on big-endian.
> > 
> > 
> > 
> > Looking at pci-endpoint-test however, it does all its accesses using
> > readl() and writel(), and if you look at the implementations of
> > readl()/writel():
> > https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184
> > 
> > They convert to CPU native after reading, and convert to little-endian
> > before writing, so pci-endpoint-test (RC side driver) is okay, it is
> > just pci-epf-test (EP side driver) that is broken.
> 
> That in itself is another problem. The use of readl/writel for things in the EPF
> BAR memory is also *wrong*, because that memory is NOT a real mmio memory. We
> should be using READ_ONCE()/WRITE_ONCE() to treat the BAR as volatile memory but
> not use readl/writel.
> 

Not at all. The memory returned by pci_ioremap_bar() is annotated with __iomem,
which means it should *only* be accessed with the relevant accessors like
readl(), ioread32() etc... The memory is still treated as MMIO, so all the
restrictions (alignment) applies to it also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

