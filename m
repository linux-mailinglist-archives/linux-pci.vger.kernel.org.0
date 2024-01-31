Return-Path: <linux-pci+bounces-2864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473F843869
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 09:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BF8B21D02
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9EF55C08;
	Wed, 31 Jan 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E04Loq62"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265C657DD
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688100; cv=none; b=kzG6aaSTmsA6dN0a/Czpp7NiH+BTbCJ04kMO3/wjx3H3ApJWeNdKjNnyludZNwjfzD0ckgcLKcUP5G43rkPsqFUhHQd9kMlMB8IZ/jUt1ompKOWm/fNR8c4EQz5UbtzLSJXQBl1ygfS4t07uTurvpIZRJEERPg8I7SX9PZslxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688100; c=relaxed/simple;
	bh=bcdYESMliQGwmnXxlM5uRrAlJUkgH4mbAcDcbEkBiy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGAqAiMJ6TqYI7DntBqndkUhuGR/gclUihZJU71we3wI5S/Ee6kmAqoohs/sGFyFCK+Yvf18CazwUKzAIBd8UHnQyMXD73mQfCKMMqO57xF4iEUb8FSUA35yYjk6Ls7sukgNs9opfb6XOJ4S6Kx3MbQL0q7CW49GWlv4fS3lg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E04Loq62; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a318ccfe412so445768766b.1
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688096; x=1707292896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31HHx0QgCVuAgnQ4tzCd7Ii1IZudPB4QFu8JKjXKEyk=;
        b=E04Loq62M4WoB+GJcgafbT5/MW9CT0PUXpqioR/Xwji08OIv9mmvdloYDsi2O73bCk
         azVRYzbAd/na8iwdsH0od8hZAj2KLCH0BqT+eEZdLTj74+2rmJiIkul9Uoz24YbVABTe
         NwuILiEupnlx0SayCNSlU8wcB0UW1skM+olUnD8LKGHhzfDgqnN1zWV7vVFiLH4GkKD3
         HsqXl1vZz0R5qJ1HRCy2u8CMS/fIy5kbpBiU4fP3YfiA4PVB/XZN3tcqHrR7ymaFLssA
         3xegW9x56gl+osABZ0njZ6zdYmF8G0RPKugfbRHRFdUAvArC/j27AC5zXr6oXkf7XARE
         5tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688096; x=1707292896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31HHx0QgCVuAgnQ4tzCd7Ii1IZudPB4QFu8JKjXKEyk=;
        b=WbDyll1pfDX0hQaZk+4Gr+Wr5TAgyT8RrhPcWYhYZ349PeVhTxxH+bFEIkYCLAHOYx
         AQ02/BVRv7w3e/h+ZkjdM7gtp/gFiK6dbKUcXXE92rMdNRsPtgLuW5IBKPd4IO4kHJ9v
         xu3tV2+pCsoNMCbThdpaaTsgJlRjJHOVLpkgnSVqxex2SiR0BFLtLrQzrG1o77Bbnv+B
         /WC0StP1Xt66fVwHeamcZJrty/mtMZk+UwjeUgHg5WokTSpoXdwOrEA0sQyZhotEYksT
         hWhhkXKfOwOiqv0HCpG0MiB2YHMwp7ayb0mVnCHYSNKdH+wZ80PLQJGCvLor25u2OUuT
         annA==
X-Gm-Message-State: AOJu0YyICEfR1alqj8UZ6Dec22cokfwPm0f294MEIbiLvYis8jdPbsO9
	EE1wCYy0BVwzNmDMilSLXRbtskn6PdJimSggcw7ha7no8p1mzPlsW+W7MhiNxds=
X-Google-Smtp-Source: AGHT+IEdAof27yhgTklY1BaSC03UZGW8w2/UZ7s+/KaHZPtPCy2fxL7XqnrhdsryXCuvprnRGu/V9A==
X-Received: by 2002:a17:906:f6cc:b0:a36:7bb0:e2 with SMTP id jo12-20020a170906f6cc00b00a367bb000e2mr438749ejb.34.1706688096295;
        Wed, 31 Jan 2024 00:01:36 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tz9-20020a170907c78900b00a35920de35dsm3678369ejc.188.2024.01.31.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:01:35 -0800 (PST)
Date: Wed, 31 Jan 2024 10:01:34 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: PCI: qcom: Document the
 X1E80100 PCIe Controller
Message-ID: <Zbn+XmyG5+X5fm8z@linaro.org>
References: <20240129-x1e80100-pci-v2-0-5751ab805483@linaro.org>
 <20240129-x1e80100-pci-v2-1-5751ab805483@linaro.org>
 <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>

On 24-01-30 08:44:56, Krzysztof Kozlowski wrote:
> On 29/01/2024 15:41, Abel Vesa wrote:
> > Document the PCIe Controllers on the X1E80100 platform. They are similar
> > to the ones found on SM8550, but they don't have SF QTB clock.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> This will conflict with my series, so whoever comes last need to rebase :)

Sure, no problem.

> 
> Best regards,
> Krzysztof
> 

