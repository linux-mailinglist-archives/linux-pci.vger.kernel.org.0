Return-Path: <linux-pci+bounces-9869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF04929052
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC86B1F21FBA
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83FEAD5;
	Sat,  6 Jul 2024 03:26:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD317E9;
	Sat,  6 Jul 2024 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236371; cv=none; b=ssplbrPraMeAkDDASXYcuQkIn+TilJhFdF1kkwq93aFKoEwl3L1X5rGe4Ge/wpLArnuNfAOyF6+sZySKv37Al2CJFCE5RVsOgmQghVYSWzjwkmieNTarV7mwncnid3U0OqyuhFZJ9UNRXOR8wnZWmMOeD0MEpNIaNKJaa4YFAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236371; c=relaxed/simple;
	bh=+TXwSh/K+/7dzLBqK/+aAGJReo+yDzwCTEYDWwA39T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWmFK0Q0xdDwtRDj0ZnK/Oq6KfDRWc22qbEhTzLlEKlDFQrp1mTppzwnTEkZ7kbpt2b9xEwwTpCJCm2HWCyvVrv+0lRHAcZXYDKlUc5HcuF9816YLH4+PCHXsnCI0xx6f0xLXqbGsZWu32Urfxv/w0sk7E6IiNCvTNuUn6cpawk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b0e7f6f6fso1031503b3a.2;
        Fri, 05 Jul 2024 20:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236370; x=1720841170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVgSc8GNtK/lVo1UoA4krbjJ3ZwCn4eROYjG/WEOdiI=;
        b=VYZg6Q3TbhoLbZuCx5jrxH+uHx4mBmB/PCuW1vRsosCUCJlLomS62B105icIW7jUyu
         0zySYq3wYdaSrCnUPi26liiVe/QwpSSOtI8x/8Wj4KT4neCdmjiv1CSfhnh8CqlO/rXg
         eOXldPp1ryFBf7Em6Mgj/y3jOr8ife/TlsGiD/KKcGTLa9YCipc0UXBjiQKjnxn9480I
         ExfYajHgzLFTNPqnJEnLM8+IyLwe7ptiQUIVUYHg5XEycBRIKcyifEEiuZzl1ltKud00
         2UiZgXBsTv4XLugTjW2qh/9OHZRZDIvduubGlYn6jPfHRfg7GtE/nIlt5WOrPBsqyKVp
         Dh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIHNbg/BIn7Z2/SIDdpHAWDsUuUKsIIyLjxZ2mde3Lde1T+UrG5Cvko9FMr1N/TXmWJ+4tZVDR4seNlwFzTqvFUKa0iHfsvAaa8Rbnaaq0rQE2xv8raH4yd4BiZEDVqIv6lIYI/9BVE3OvZoOct6iA0Tqs+Ts0BWkmaRRw7tuD6+cgzy8ZYtGnGJXjSMKsfdnsSNOrgBPj7XA1MzTZETSoY9U=
X-Gm-Message-State: AOJu0YydYyXDUXcFArBiTr/sDFu1c9kbeU21oOt/URc0fwjIHqd9gqT5
	SqQUzEkNZfKvzsdFuT5Xi0tFGcDJ3FyNyOCwBh6hgOy8FpfceTqk
X-Google-Smtp-Source: AGHT+IEdoxvaT2/kcYlzXgol0cgeRkWRdEBz2ni1JGS5NCi8WzSduPBbPe3rFCanhwzewK67DsRY+Q==
X-Received: by 2002:a05:6a00:240a:b0:704:23dc:6473 with SMTP id d2e1a72fcca58-70b00c1ac7fmr7158523b3a.30.1720236369589;
        Fri, 05 Jul 2024 20:26:09 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ae395sm15217226b3a.144.2024.07.05.20.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:26:09 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:26:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: x1e80100: Make the MHI reg
 region mandatory
Message-ID: <20240706032608.GI1195499@rocinante>
References: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-x1e80100-pci-bindings-fix-v2-1-c465e87966fc@linaro.org>

Hello,

> All PCIe controllers found on X1E80100 have MHI register region.
> So change the schema to reflect that.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: qcom: x1e80100: Make the MHI reg region mandatory
      https://git.kernel.org/pci/pci/c/30e7c6cc88b0

	Krzysztof

