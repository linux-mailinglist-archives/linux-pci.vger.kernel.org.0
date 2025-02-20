Return-Path: <linux-pci+bounces-21880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE4A3D275
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862363B1624
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0131E9912;
	Thu, 20 Feb 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWOcM0t1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0F1E990A
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037290; cv=none; b=V0QXQUAR1zkKENX0pC6nnfa2ohls7PJYUuUCKKS8fvx0VCpQfKipJyyo9tesPmgyGqhNe3Adp+J0ngWFvLvIyQ0q0g82LM32O6eoEUam6+szZ61v/9RNPiZhRKx8h7ZYXGpFpt4E8OZK6Fp6DeAgCt8Ly7o4VDALBkiQ/68OyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037290; c=relaxed/simple;
	bh=FcvfMD+JBBVNDDsu7+aYWKzpf97y9eyX6wNGdgF4LxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0aOwLwmMLvhNQAXw5vNGdcbGJtQAVUon9cxbt1bBfZThVaHCWK5htLG4zSW4o2uoqnsKKym+MGEdQU2tlKINjW5Y67PzcO/kep8DT1HMsHpLG70quTfUoMIkgUwdK+MS4KIv1p3WZpH6TavaPfLn5+G79wzWwDKvdarRKwFej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWOcM0t1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c92c857aso11174875ad.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740037288; x=1740642088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azToiCO+oZ/zxxr4mX51zUb1S/Hn5fc+tCyD7exrK9Y=;
        b=dWOcM0t17tV11JLGEzr2KGJ3nNSjbcS/eN2UFGZ+d4Rv/hT+x1PYgB8I8JhJRPWEPM
         2V0Cb9wxKJsY543PLSveE+4P05DuKp9GbFujxdExDtpXOZuSMktWiSSHRF9LUZZQWGra
         hBKgf1KUYJ3nVoi1OiHvJLaZEMTx+Jeemf1f6MxFYYHXoHUj8GxmDWmKsYUHS7CvObI1
         yEQmkCb2LN9qV1mItygMygEJ88p1Ds85aRukSwy/m3eWkmh3qBIDo6ISQpjK0H4j2Vkv
         F1iBJLx6FrVebWHudPlozimDh1xqzbi7NQ3uGjqGjgT0R0YSe0U93D+0zEysHuU0wtdX
         sgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037288; x=1740642088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azToiCO+oZ/zxxr4mX51zUb1S/Hn5fc+tCyD7exrK9Y=;
        b=K+0WTuRZJmlB+LipXxYrdZPnavnABHtFsIBvxKfUkYWB9ULji2w7+LnOh6S1LgK3A2
         h3R68aeZC/VrV9+MnT7+VsWrmajbcXebWbaN0H5UWv8PHY6SUYEJaADFEHDOKn8p3V1R
         xx/BrBCdmFqzM/gkKO2Reu55LRQQspxMLa/4e+C2qBzvnqqPtscvrXiLiKAeNU/fbjco
         eHPApRozIrog3rDTaEJbA3Ag0XuFoodjQIxtllsZ3izHNpDNqstqB2J8qlNVFC43qCNV
         XGg8lqdaEg9j6X7zluKEVAeILAAZdw56GNoJ3cwwq3LN9cDh8F+3HqUzKXn69tgD8NOS
         lqoA==
X-Forwarded-Encrypted: i=1; AJvYcCW7WK0sL943Oz8yGU5q+P9boylfa5BiDa9rMZNFIE7a7v+2UftuyGz4gwGcxNW16ORY6R2ZQUIJglg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+ZtfmmrvBqmHfxColI35i/qYfawJMElWKSP23KM7afoZeCjo
	AwdqYsnWWpQruK3KOr4ddwO2h8RrmMLRw709N5u2UTATXkRFrWrGOw+9Kt0AiQ==
X-Gm-Gg: ASbGncuVVEdO6nBpljOA8svbTxLHM3KEeE6fUOr6dju+QAWK8qY1BJqdjcrrGkazQ8S
	nqzgDcYUJG96tqqqaV6WzCcX2CuBBYWfqD0aPi1DSFod9GFQBFJ1mk/e2khGA1yae4UdVG6/pJb
	lXtON2W1Pqu4bOhAVL2UJWl+9LmrZqP4RdPffnfkLQJQixlKriO2ty88fg9kRXIExQZ2piqXWNS
	kVuKX8eLHe0zae9xrFwyWuhszP4+9lcXikbvGKZHyw1Br2Aqsy8TacVWUzuZQSEmmqCaM0mJlD+
	MEJN8zXi6G866VeqtVKEz+oA1Q==
X-Google-Smtp-Source: AGHT+IH0RZscPfw2CZq9/P1TKqceXF2BijFi/n0CVEH6aHnPTW2U7yD19fJ4fdTDIp7uABus7lNjyg==
X-Received: by 2002:a17:902:ea05:b0:215:9eac:1857 with SMTP id d9443c01a7336-2218c3d080amr32992605ad.5.1740037287863;
        Wed, 19 Feb 2025 23:41:27 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf76sm115597885ad.131.2025.02.19.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:41:27 -0800 (PST)
Date: Thu, 20 Feb 2025 13:11:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250220074122.xaeefquqwh2xwsxz@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
 <20250214172533.szrbreiv45c3g5lo@thinkpad>
 <36cc27be-4ba7-4d65-b32b-2a1e0b03b161@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cc27be-4ba7-4d65-b32b-2a1e0b03b161@socionext.com>

On Mon, Feb 17, 2025 at 08:26:44PM +0900, Kunihiko Hayashi wrote:
> Hi Manivannan,
> 
> On 2025/02/15 2:25, Manivannan Sadhasivam wrote:
> > On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
> > > There are two variables that indicate the interrupt type to be used
> > > in the next test execution, "irq_type" as global and test->irq_type.
> > > 
> > > The global is referenced from pci_endpoint_test_get_irq() to preserve
> > > the current type for ioctl(PCITEST_GET_IRQTYPE).
> > > 
> > > The type set in this function isn't reflected in the global "irq_type",
> > > so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> > > As a result, the wrong type will be displayed in "pcitest" as follows:
> > > 
> > >      # pcitest -i 0
> > >      SET IRQ TYPE TO LEGACY:         OKAY
> > >      # pcitest -I
> > >      GET IRQ TYPE:           MSI
> > > 
> > 
> > Could you please post the failure with kselftest that got merged into
> > v6.14-rc1?
> 
> The kselftest doesn't call GET_IRQTYPE, so current kselftest doesn't fail.
> 
> If necessary, I can add GET_IRQTYPE test after SET_IRQTYPE of each
> interrupt test prior to this patch.
> 
>         pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
>         ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
> 
> +       pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
> +       ASSERT_EQ(0, ret) TH_LOG("Can't get Legacy IRQ type");
> 

Sure.

> However, pci_ep_ioctl() returns zero if OK, the return value should be
> changed to the actual return value.
> 
>  #define pci_ep_ioctl(cmd, arg)                 \
>  ({                                             \
>         ret = ioctl(self->fd, cmd, arg);        \
> -       ret = ret < 0 ? -errno : 0;             \
> +       ret = ret < 0 ? -errno : ret;           \
>  })
> 

Ok.

> Before applying the patch, this test fails.
> 
> #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
> # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
> # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type
> # LEGACY_IRQ_TEST: Test terminated by assertion
> #          FAIL  pci_ep_basic.LEGACY_IRQ_TEST
> 

Looks good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

