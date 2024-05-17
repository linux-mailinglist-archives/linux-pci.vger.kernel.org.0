Return-Path: <linux-pci+bounces-7599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AB8C84D2
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCF31F22F11
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEE6374FB;
	Fri, 17 May 2024 10:29:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75C2E84A;
	Fri, 17 May 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941758; cv=none; b=Cg7TgC4Tl6AerxWd824HDesYRM8LKz5FFRdOTNI0Aypa3ide3t2pdy5bZmAFe8IW0Y3oEvPSajwwuaa8lGakF941k3IpkkRPgnSAWFF9n7bmI+Nwf9DZoDIiJsOEh4yrnqvwUjvv+4Ooww6JaSkCiMuBaD2UvWlJcQOgftckR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941758; c=relaxed/simple;
	bh=LLZY3WjFD8I5+1ImrLRPAhPzEnAArC/7gw7Ln89IYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OntNNqW6+uCGZ8/7YMsD1/UJ0w+4oUcklJJBY+YeVyGhfJKOLpma916uFFf6uvOGj0GzYJX2aqJPQY0tJgZ9/QcNlTNqxyWl9oP0PfdXG9rgjjywh1YLpQjxNNCZvpu5KlswaMCs+dU0Qh9t/WrZTF8t1YS5iqmp8M1iluhbjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eeb1a4c10aso3414415ad.3;
        Fri, 17 May 2024 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941756; x=1716546556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbkSajw913m55bQQldLnsc4x/7XwyxTc8CoOMVI1dew=;
        b=qr7WloIr9RbzPUQ9WvcS9nV6Kik/WvOJgbOiku8d4D85uVCXrMNm1q24wwX7CGPKm5
         tM5fMv73pgQ9IGUZcf+H1SrkKrXtVvH3Co8479LbyuRgOdRi7Q+dBAJQeXHih3VhK6Ma
         hJ7EKINL4H+WF7BFOZNoG9tkTJOb83rDuDzoaDFH1nofx69xDC3ofOxC5ZH1QH9lxItJ
         tY5t9OW44EdWvGqq6g142lqj4pjjsdFPwT+wrPOMnm3enRvzTFJjtVhTxzyUz4ix7nFR
         jA8QNWoeNgWjvWAWqBRyQ5NbZrjvFtC8ADWh0chQLoUtPBmys2xsdXu9AnhqPjDj5Cde
         KxdA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpFK+LFBHiIAD2vmHTS55PhirGmvJbreAFpPXm3AnUTnhvJno7WWOtFqkmRU+wnHaLsArAK9dA0cVDbajuoDZ+RG0IJInBP/m7jPLeS0V8FE/i9EyaVvjpB/EQe21PxocJz4wnLztDHHnJmOtQ1lIZohgyLXCqXOylwIDrXGj31yWdg==
X-Gm-Message-State: AOJu0YzG2fNiZFUPGwAe8qGi/fNBLHCAA6LR+JdjWi/a6ZqR08+8Ojan
	wOGI0ZO6P5hN7Szgsf2dBnPLpQLsbQB18KzvjIktGniKCG1I5qAt
X-Google-Smtp-Source: AGHT+IE87Wuy0teK9NuY+rKXX+mYmZ09a1f4fftYoK6XCoqBgXScIUYEbzP29P63yrvw1ppT0AgHdQ==
X-Received: by 2002:a17:902:e5c2:b0:1eb:2fb3:f9fd with SMTP id d9443c01a7336-1ef43c0cecbmr272300315ad.14.1715941756095;
        Fri, 17 May 2024 03:29:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d44e0sm157916565ad.4.2024.05.17.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:29:15 -0700 (PDT)
Date: Fri, 17 May 2024 19:29:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add device-id
 for TI's J784S4 SoC
Message-ID: <20240517102914.GH202520@rocinante>
References: <20240401110951.3816291-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401110951.3816291-1-s-vadapalli@ti.com>

Hello,

> Add the device-id of 0xb012 for the PCIe controller on the J784S4 SoC as
> described in the CTRL_MMR_PCI_DEVICE_ID register's PCI_DEVICE_ID_DEVICE_ID
> field. The Register descriptions and the Technical Reference Manual for
> J784S4 SoC can be found at: https://www.ti.com/lit/zip/spruj52

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: ti,j721e-pci-host: Add device-id for TI's J784S4 SoC
      https://git.kernel.org/pci/pci/c/b7a791b26409

	Krzysztof

