Return-Path: <linux-pci+bounces-15887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73219BA7FC
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6747E1F2189E
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399918BB84;
	Sun,  3 Nov 2024 20:37:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAC18B462;
	Sun,  3 Nov 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666239; cv=none; b=rErR2ZxyN91k+0LgjF3ZJCzBz4tExjyo9VN4T713Hk7xfgXlOefPZeYt1nkkT5SuBY0heavH4F5vki5BXiZyPan7xZ8Ip7mtiQymUR0BldAoWsI78bPPv9UxkCjJrXw2yIz2IcVLd00HEAv0/uYa3QOhVe3+cGey5C43Q2GXqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666239; c=relaxed/simple;
	bh=A9EOa4JBXmYSS3mlfar36oAEApc9f8pq693+5pqpFOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5rZ4Z0GM4BN4bJDXnzNRB3NioTfG65v0OyrUgT0MMKJnNjSmDOoHLg0Rdo7fKtzWVnJJJELt41ppb1f3Hxw29fJjnxAwXS4XVYDzxhx4Da7vvE+gR6Ya77w4+04suNH/35FXVghPEx5+JRISyqp6MnJQB6KX8lvQclK/TiX8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso2728199a91.0;
        Sun, 03 Nov 2024 12:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666237; x=1731271037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ap+wpMERUFPUBtGPkZlL7XELI5aXcin9wACcBysLF4=;
        b=Y7J6dI8hkBXCaaw/9p9AAtoOSsBCUaiXGvTl4dGL7gPAP6PLhWYTQMP2WD7h7U9HUd
         MxUZ8/aZVNvRh48guIPgTL+nwMQIxLv/1890A4QWHoaFtt86a2n5g44kij5kIYS8EJVG
         SV+zkcQj025FLdhT98HXz5n64dEz9HU+pLy89C7A8PUdk5Mk/A3boQXKJ/4Z4J+Ja2oi
         x/NXGsCRXLr4NpDMrr7cdq/Du6K8PtDykqBAMFDuhUHuAEO62dAXxXaG0u4AzSfiTsQv
         QzZGVotzFDNULsSxcRgMTV8OPnvVQmjUHajEU9BUA2KYjxcAw1zvf0BDqBq2+a8w6h77
         U1LA==
X-Forwarded-Encrypted: i=1; AJvYcCVDBFPt4VHQjv6MIKgeOF+0vPLaL0W0nc7UJ9UVKzL7gLuOkefXUg2tGyzZ2Zeh+Z0QR6sbBjN9MCxZ@vger.kernel.org, AJvYcCWar2xuE2hGe5exlzO3k0FRLTvf5SSvMfvTLYB/bzBtDleIWZBaTY5rhHJQwHwz7ULmXmk22ESvrklkbqmW@vger.kernel.org, AJvYcCXDB02S4NQltQB9rloJmTs85G+EmTn3yDACLrweHOQq/XVWEYkKz2J4T6cZJu60i1gem2CT3FlCn42DL/XL@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs/9DAqNxV+oQoeFdRRhl96yB4ipniF/gvVcXoEcc5bkKBbNs
	Tefj+zpbx/2DaMv/IWkuXn05jf5GmgHQU+rVxY36UgJQrbzRd5vzzQtMKfiz
X-Google-Smtp-Source: AGHT+IG5esVoMq/DaiOQmxqQEXp3jMVEBPKwUD7klezgZxrekNOSjh60GNrmUcy5NcNXROlqRPek/g==
X-Received: by 2002:a17:90b:3848:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e8f11dcec5mr33727475a91.37.1730666237381;
        Sun, 03 Nov 2024 12:37:17 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc0084asm8461758a91.51.2024.11.03.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:37:16 -0800 (PST)
Date: Mon, 4 Nov 2024 05:37:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: qcom: Enable MSI interrupts together with Link
 up if 'Global IRQ' is supported
Message-ID: <20241103203714.GC237624@rocinante>
References: <20241007051255.4378-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007051255.4378-1-manivannan.sadhasivam@linaro.org>

Hello,

> Currently, if 'Global IRQ' is supported by the platform, only the Link up
> interrupt is enabled in the PARF_INT_ALL_MASK register. This masks MSIs
> on some platforms. The MSI bits in PARF_INT_ALL_MASK register are enabled
> by default in the hardware, but commit 4581403f6792 ("PCI: qcom: Enumerate
> endpoints based on Link up event in 'global_irq' interrupt") disabled them
> and enabled only the Link up interrupt. While MSI continued to work on the
> SM8450 platform that was used to test the offending commit, on other
> platforms like SM8250, X1E80100, MSIs are getting masked. And they require
> enabling the MSI interrupt bits in the register to unmask (enable) the
> MSIs.
> 
> Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> described as 'diagnostic' interrupts in the internal documentation,
> disabling them masks MSI on these platforms. Due to this, MSIs were not
> reported to be received these platforms while supporting 'Global IRQ'.
> 
> So enable the MSI interrupts along with the Link up interrupt in the
> PARF_INT_ALL_MASK register if 'Global IRQ' is supported. This ensures that
> the MSIs continue to work and also the driver is able to catch the Link
> up interrupt for enumerating endpoint devices.

Applied to controller/qcom, thank you!

[01/01] PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported
        https://git.kernel.org/pci/pci/c/ba4a2e2317b9

	Krzysztof

