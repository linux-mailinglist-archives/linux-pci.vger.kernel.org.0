Return-Path: <linux-pci+bounces-27024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD7AA4383
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18423A71E4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E401C5489;
	Wed, 30 Apr 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tamp2bip"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9A1EEA46
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996725; cv=none; b=hfOEopQhbFZKUq7rVUOAgGAHfJiZICK1CTdsLTVHEp80xPZvzboVTJJWCkWdX16hviF0qdVqId8ni4uSyoqN57Zk/yyAR+CkKfSthq6ossFPCSiEq5WFqduRqTh49Xf/pDA04hp0XsHKAea/0TH9JnZ28RhBZeTwIdqG/hBBmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996725; c=relaxed/simple;
	bh=+0dHt1yP787DSV8CSOwbZKx0Vsi1fEwM5a4JLD4PqAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXMpmuh2CepanaNFt4jfBozfSUkZy23JXKXQT9deC9/d36dz2h4bmiCioohEwpnaY8lhFPCJvrYZATQcqrsExcA9KCewEaoR4pZ/9oN9n4cw67GvmOWmv/ntz9rLdYHS2kdDvMW/CFQXCWK7FFEFJkWUcmfvOTk7Qb/wAqQ0aBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tamp2bip; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74019695377so2638906b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745996723; x=1746601523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOvTq6j10S4wZ2ouQEx1wtmHFZMHpjT96cwxcvUAC+E=;
        b=tamp2bip3bTo+e1tVeesmnvWzEANzUdcKWgh/UnjSXMU1Vij00FWVXAg2G/leyIy5c
         VfWluxzsnrJcx2bqTP4ekPCz/x7JTFpqz8OJM8TUBRRw1TBKLXYvUHztMKbSreylTXdz
         G/kV1kdNagrq6ce4cjO7DzlQuCLlCy7wVl+dPIG4u2HWP8G9IJDs9rXq8W0NUYwujom9
         Gi4t/uw9eNN18mgCsGd/yWdnN7xTs4p3JGI8hC+Qftz2fgTUTRxm2j+0RtOArW0gEA93
         j/lXF4AbnRTfiZz7s2SKuaDq1rIEbtO8rnU7tAA9NGhTuvpvq3FIjrJfHXQoXNo6XEuu
         aYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745996723; x=1746601523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOvTq6j10S4wZ2ouQEx1wtmHFZMHpjT96cwxcvUAC+E=;
        b=K/Sfvv+XEh7iyTp4oSFT2DTuXtfHHrYqAn0aMO6jOmcETrp8o1Y53BvpOBtO/SHRDh
         9pyP/oEnf6q+NQd/p+20akspcwIDfBA/Ba2+965YEnL7NqMNFRO+1x8dM/WW3lOTQ/Fs
         c9uwFnCRreKFX8rHkkpJZBSAn0fLF0EpK+Nyr90v7CUCJDuWBP7m1QiupJkBBIhcDfy+
         BRjcw3slSx9WpejXbEAtzLdmFFvBC/LQKC1yav2P1kCbbgbhZuX/lY3qSyii+nk+eao5
         kliX3N/r4wv0TrQE+mOKs9g/Qh87TRyACFLM4knjKkOlKM+bUEKajV939jFO37lfbb5D
         m2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIm0yWd/JQMnE7S4rK1YALFm2zRohjbIk8JPwyiMkNj3eB5388phfVq8X2GvowVmEXjXJ1w01ceXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0eNxlLVf580tM/bHDhdqzbRdClNdPP9BkxG30yc+aqjEsuml
	TrkbR1k9SvwRHTu+ZALriAiSU7o/ioAayX1C4KuhRdOMQDMV/WqkQmuYFJjeHg==
X-Gm-Gg: ASbGncs0Zk5JmplD1FOtU9UQiRpCsMC/GI7ncMLeoZs32iwvyUwG57wFEnL29sNn6WG
	kbF9SJEzUatGVTa17ifvUXuhM5qR+0sL8lIZzi6fzcvPl8BMAJC6nLc+vZHfh1Y/LRE0nLKzpEo
	eTMblnujkaGj0fQmsQBd34ysmS5e+4hyCfvU2oEH/DhAqaAqKqL6AIbfEuE/kN9MB10SoyBwJDt
	Co4NMwJ6KtiIMfz0qs+01aSgbVJzEtuZm+JoEkcKh0UgGgjHptQSXiy4+FAZ17kalTwqIaAt2KR
	aaB040eeY+E0jUNINpu0ahaObT65l3JCt4WFJpmyci3qdYeH/EGD
X-Google-Smtp-Source: AGHT+IGfZHTxKtJCIj/0xAUmnPi7/0zX7+jZWY55uH7h2ZYvLlYY79PgE8omUcoof08RTFx68ZkHeg==
X-Received: by 2002:a05:6a21:8cc9:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-20a87644941mr2521487637.5.1745996723449;
        Wed, 30 Apr 2025 00:05:23 -0700 (PDT)
Received: from thinkpad ([120.56.197.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f100d475fsm2787077a12.47.2025.04.30.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:05:22 -0700 (PDT)
Date: Wed, 30 Apr 2025 12:35:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, dlemoal@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
References: <20250425092012.95418-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425092012.95418-2-cassel@kernel.org>

On Fri, Apr 25, 2025 at 11:20:12AM +0200, Niklas Cassel wrote:
> While some boards designs support multiple reference clocking schemes
> (e.g. Common Clock and SRNS), and can choose the clocking scheme using
> e.g. a DIP switch, most boards designs only support a single clocking
> scheme (even if the SoC might support multiple clocking schemes).
> 
> This property is needed such that the PCI controller driver, in endpoint
> mode, can set the proper bits, e.g. the Common Clock Configuration bit and
> the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
> (Sometimes, there are also specific bits that needs to be set in the PHY.)
> 

Thanks for adding the property. I did plan to submit something similar to allow
Qcom PCIe EP controllers to run in SRIS mode.

> Some device tree bindings have already implemented vendor specific
> properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
> and "nvidia,enable-srns" (SRNS). However, since this property is common
> for all PCI controllers running in endpoint mode, this really ought to be
> a property in the common pcie-ep.yaml device tree binding.
> 

We should also mark the nvidia specific properties deprecated and use this one.
But that's for another follow up series.

> Add a new ref-clk-mode property that describes the reference clocking
> scheme used by the endpoint. (We do not add a common-clk-ssc option, since
> we cannot know/control if the common clock provided by the host uses SSC.)
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> index f75000e3093d..206c1dc2ab82 100644
> --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -42,6 +42,15 @@ properties:
>      default: 1
>      maximum: 16
>  
> +  ref-clk-mode:

How about 'refclk-mode' instead of 'ref-clk-mode'? 'refclk' is the most widely
used terminology in the bindings.

> +    description: Reference clocking architechture
> +    enum:
> +      - common-clk        # Common Reference Clock (provided by RC side)

Can we use 'common-clk-host' so that it is explicit that the clock is coming
from the host side?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

