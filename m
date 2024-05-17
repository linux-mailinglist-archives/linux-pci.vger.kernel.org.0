Return-Path: <linux-pci+bounces-7597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC98C84C6
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CE71F216D8
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5EA374D2;
	Fri, 17 May 2024 10:25:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B92375B;
	Fri, 17 May 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941522; cv=none; b=fuypgfFdu+/JTCJfxxp5iR03r4V6yrWlpb4UYpg2T+19N6GrV8y7DQi1nuhnkzhPplhhma+FsdocJZA6aA9vlPdwD8iKx8htR3u4jG4tyqbTKH3kpQR9SB6GlW6Bm2joUBoKPtljgV8beAfswIgretDp6s64Xm92VhSNyjI90rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941522; c=relaxed/simple;
	bh=YUe7WGNiCZmHB++e2tOElMgpt911tiH8NX/7arR3i00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Njz3QTKax2skmh5EMt3vbhwvy2qTcQkcMw+Kbu52kYyPP9xhPG4M6aafS7zPf6SnwAnV5uU7YtmqpvLCBwjP9K2AM0Fwxhyw7KqpgdYDfXAYhpIbSiAF2C9fKUezFVZWCDypBbhC+e/KneNrUloj7pm9COUjIoASjCFnOI21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecd3867556so4294265ad.0;
        Fri, 17 May 2024 03:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941521; x=1716546321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Gy/Jlpjo0cWiQdacLUZcFoAON1Ee5ZQVL8p8HxTN34=;
        b=WFd1Dzjg8FUKC2+xFOAjkACCldhzHPp+lTPye3WZ0IbmcJhj8/okP4Zomqjp33Ud82
         KYXAeE4q9ar/glsRgqN0SjWcndAgVgGbV4FRyCWWnAzR3pzKHKl2koq940F0ZdAjxdf1
         cqXMmdejWZl4meAvHEdIq6xDg1tsnmbLR6FKmxOGNegtwB2rd5qVupUe2k72AzMYUJpa
         K2XVds0PMarAUGEHGW/zqosiZqtvnfgAlNlvDU7HBRsallPE/MJ9jC1+8Stt7FTvgBkN
         de99b2frcExpvuRTqUs6CH6Fg6JE6UqVYTBM64FIZmEMGBGk26/asVpglXvWao5rj75n
         rjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZbGUvL1U8vggELasXGK+4MZZvW47prDJzNsgeQK9d20V9oIA+YTSXqW9etdshh/m6FI4FoMxOKQY2uxpOf3RM8c0PNK0yBMgxB+MYFYG5E1x/UlyqnBC2z7Hm/aRNQ15mtTyB3VxuBMxM4SqJd5Nokm5Xcr6vk1zTUsaMlsOGD9CSA==
X-Gm-Message-State: AOJu0Yx5rE9t4SZV9J/m+WSAnGVaRpU64RDY2Qh34umv3PliscutaW2f
	Hhv7H9tsHb4yuE2roR9OM3s2PHZc4nWDBx6Jd36dB2KJ3EYAB+bK
X-Google-Smtp-Source: AGHT+IEKpH9BDgVleQeLLBS6dmwrxgLB/fvnFdp/cvkrZeZOTWFswt88zHi6TbjZfCRirLEdP3heRw==
X-Received: by 2002:a17:90b:707:b0:2b4:fcfd:741a with SMTP id 98e67ed59e1d1-2b6cc7591aamr16871900a91.17.1715941520581;
        Fri, 17 May 2024 03:25:20 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782d7bsm16621808a91.51.2024.05.17.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:25:20 -0700 (PDT)
Date: Fri, 17 May 2024 19:25:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	vigneshr@ti.com, afd@ti.com, srk@ti.com
Subject: Re: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Message-ID: <20240517102518.GF202520@rocinante>
References: <20240124122936.816142-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124122936.816142-1-s-vadapalli@ti.com>

Hello,

> TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
> The controller on J722S SoC is similar to the one present on TI's AM64
> SoC, with the difference being that the controller on AM64 SoC supports
> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
> 
> Update the bindings with a new compatible for J722S SoC.
> 
> Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC
      https://git.kernel.org/pci/pci/c/01fec70206d4

	Krzysztof

