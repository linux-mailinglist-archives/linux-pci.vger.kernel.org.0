Return-Path: <linux-pci+bounces-11850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1D957D34
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645D2284147
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7131494A0;
	Tue, 20 Aug 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVubNwED"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB95338D
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133626; cv=none; b=ar78sOAZdUKSIXQ/V4+CQpFDvkkefHW9xrvGFoVuFHp1c/6pNh4larCdeuQeDopXNzH6cSPWp7xZngKFBFBHYcb18v4M2RVtdeZmleailuK4suNmRHi8eqzuJTiwmFltN2DoGVonhniCIMDTHUEKxKdMK1+G2ofk6chEU55jQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133626; c=relaxed/simple;
	bh=sF3PRRiLeL/D5znM6gXQZ3NeF2qGdjIeuDfpPWTothE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMr6CqTcc2kGEgs005Fs6qLw5ne3dIp+Txur23MnFhVqIMzhiJtHnRbAMlqTlNbgupDeZ/t59LgRU4IiVeAARr+8YXs1/vkBVAZM5QdEzpsxq1VkdvnopN15hFxsQUMlQ2yVkmSLpjoWyn3Xzth7OHyefRaJ1D1ci3+fB3/fzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVubNwED; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7126c9cb6deso3123176b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724133624; x=1724738424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=SVubNwED69a/mXs1SjT0rjRq1WPUZ0detoMNm4mzDGId+IuW7LsyU2+8mJDHN+9UlA
         +Nx/n7yOYkzbra1aXxdICCB7VeAhcGjs4eiffZ4DMFoY5PfvTxmrwZdxjZJ2ZAOjBDuy
         1xH7H1ATRN1fS8wAPKD8+wPkj6bCyDkmaqGGsazK0s24NwHvvFMlSKBCq8FnYAW36SxP
         7WBW996b0+s+utBRglB49u7IN5L2eTAwYreXxnKJKKlWS/d6byeBo0Gh4vWdQoTwlUcu
         c0Bvmlkv/mSLa7IhS1JwoGUC55GNXa9dbnpoicKz2LFo2vBJ7npsHBTHpi4osoRh5njv
         xO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133624; x=1724738424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=WqzDtXnwurkaUuKj5LZwrYm83x71pSOg3aVShlE2n0YaJAEB/MfscyQy2aOmTA7ZkB
         d8xFdNYYtjvU3bngsZCvpUTcmfpiwcUABJkKVtyn8mJPFJS5PpEccLyJ18v2g4y4DkTW
         i6WlBjUTfb3yHXe8Lt6s0b0bp5NBdPGtFDPJuWu4hls3dZBUsnpVn/F6yNhShT2YN36u
         5U7L05WFptfuQ35UJvJ3ehcRw72oks2MEYErCuItSYWIn7F2f6yrWOvleI/Fw/BT8lyk
         Gw+TgrZCUXjyB3sg/MAzxqk9mRMR7aTRv3+gHk0rtp4Iv8/9cEBpgY9c0JKuJ4OSOlwK
         0PUw==
X-Forwarded-Encrypted: i=1; AJvYcCVxj+Fl7oACtUhS5ek7f60XIF0YR9C/qgIOusX11PKgzpyUDWVopXmF34kSbPOgxWq7vlQd7hKuxUu60qHGL1s9heX5raLg8Yyf
X-Gm-Message-State: AOJu0YyKO+dLZXSm8LiZeuKDPA6pYzqfTYgZcTb89moeKK5vjiPgmGV0
	ONSW2rFKgcKMkZTno8okW9F9l1USO5TySIbar+zrJqVg3uIf23FHqInMH6HFjA==
X-Google-Smtp-Source: AGHT+IGMZLlXvU8CAUAv9DT+q3r5OtQYUBhXTxRSLpbUg/fgZlURHFtLGiA10dUYE7hx79M25yG/rA==
X-Received: by 2002:a05:6a00:928e:b0:706:74b7:9d7d with SMTP id d2e1a72fcca58-713c4f19e9amr15133166b3a.25.1724133624443;
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c380sm7489929b3a.203.2024.08.19.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:30:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240820060008.jbghpqibbohbemfz@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
 <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>

On Mon, Aug 19, 2024 at 02:44:43PM +0200, Oliver Neukum wrote:
> On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >   	 * reason is that the bridge may have additional methods such as
> >   	 * _DSW that need to be called.
> >   	 */
> > -	if (pci_dev->bridge_d3_allowed)
> > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> 
> Are you sure you want to require both capabilities here?
> 

Wakeup is common for both D3Hot and D3Cold, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

