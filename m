Return-Path: <linux-pci+bounces-7596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989C8C84C2
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E044C1F241BB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50F38DD6;
	Fri, 17 May 2024 10:24:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE4364DF;
	Fri, 17 May 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941456; cv=none; b=aklEUCz1MYvxFULPWy8FJTiBUfE/F+lu7UL8Xyg/Ov57Xlc8uVEz+muZwbSlPg1i6mBsRYnyPn7ifZJoC2ohnkBJdBIk29tW/zlcP5gCCKzxyyQM4wytPzGuA8xcn28nJxRMViRp5K9gocoZ/30QmNX4cD3ebV+gkIwYFW0oZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941456; c=relaxed/simple;
	bh=uVgTaKt6dOTbKZ3jwebyNXN0H+AZAn4CwTMKG+928vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoWLhSMp3g55BUIYvKbQF3SzcnGIGxH282nW05XTya2/WryXLgrmd1NwBJTSwfKjq8toVru2zFY6lvAC6yogq8wpPycvEFvLz6Glqdv6IYR29EV3LvGg4UHxKYE/ZAtcQoiuDphoOliylTJOWhVxswm0wHOyD7Q8yx7RyzEMIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b31f2c6e52so71959eaf.2;
        Fri, 17 May 2024 03:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941454; x=1716546254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utTS+aOX/YDTXs3/LL/rdwsXu69hxlwppleXahmsJw4=;
        b=EBKOV6RO1wZnzBDt6m89F5x001YW1Lb5COuOjMAJZ/H2trMlNbtNIR9M8Neb9JnhSr
         b/474I2Hd4R28YvlWjOlmbp60dZbRNv/u1vlXGQKgEBXEeQfbGoErBuHMhWSGObb+VuB
         6oz1jqNnBoNBYELvWA/FxvAWNNmAr94S7uyVOm6Qu6kpGGavgO9XZOmmfykQW/A6pgeQ
         uLTOzjOHeVzS/ZoOwvzUcbZJxxrYsuY+NFjpgKZHJJ6Xu/IS09phHow4N221NPxZyxW3
         DTEt7bU1UaWT3FHJRSQNrtSa9i8itr4DINhQMwrO9CIKN+diWfCQL2YJuMbw/VIkmPm/
         9A/A==
X-Forwarded-Encrypted: i=1; AJvYcCX+XYh/8lePdhmfWgXjpwI/J4iAMibomcEB0/NdiyV6tTLxabKfmXbnjuLB+aH2IburhKZ5XvUJ7Po21JfYYVQvtA6ZcXBHlgfB4lbj2BBJPJRw68YUoy9iVRr/keK+HlFoJxLgTEDT2XOg+tFT3GNbJHvrkQmvSCOCHrrrnRu4khopnA==
X-Gm-Message-State: AOJu0Yw4VoUdt3ZPEo2jRPPOkIfxtGnG2Yl1hzr7feoc2pM8H46K+fq+
	vERbQ4jyvbTICA2OIfK6zwfD3daIMs+OpAga/qSyS/6pdLWXdiNK
X-Google-Smtp-Source: AGHT+IFkkik74BEqe3gBhvwlCwhm9yFWu4UcK6wzhxoD5njw6OTN/q5iOIOZIlXmELGdYAaylWrj8A==
X-Received: by 2002:a05:6358:248c:b0:184:c1b:4136 with SMTP id e5c5f4694b2df-193bb50c35dmr2328637655d.6.1715941454537;
        Fri, 17 May 2024 03:24:14 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65ae1565c08sm2378754a12.20.2024.05.17.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:24:13 -0700 (PDT)
Date: Fri, 17 May 2024 19:24:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rockchip,rk3399-pcie: add missing
 maxItems to ep-gpios
Message-ID: <20240517102412.GE202520@rocinante>
References: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>

Hello,

> Properties with GPIOs should define number of actual GPIOs, so add
> missing maxItems to ep-gpios.  Otherwise multiple GPIOs could be
> provided which is not a true hardware description.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios
      https://git.kernel.org/pci/pci/c/52d06636a4ae

	Krzysztof

