Return-Path: <linux-pci+bounces-7615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63868C8588
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D05C1C20D66
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A83D541;
	Fri, 17 May 2024 11:24:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE23D0A3;
	Fri, 17 May 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945071; cv=none; b=qNBNj1+o2V/X/UDkKfG6dBu0YisJsuiKv7OGdM7s23mfP+SEwJUWvvzQ6e5ndxusaJwy4RuxOJZOmmleb0GdiYr38+WiTdxUansNRFbNoSiKzFcbiDjBYsrtX8hTAZsuakTc3fls2Sd9/LGutubgS9OapFramdyBmG//PmSsgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945071; c=relaxed/simple;
	bh=/U/WRK8hRfylmU9DyqslMEgp/3MFClzyh1OpQT4xCks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVcxQoULUbs7nZ2eCiqIUy8wM1AU1f2DB0SRGCj/+Wwl9cEksJPhyNZk9YyZM27m/pG2UsQCtIvYWS6FDktxKJgDkZoUhm/52wOGKlnzuYUTZsh5NQ0tG1R2B+vhJYielEHarQCmUmQHAy2U+2qTIO8qsR1lP/0SkmV9aaj60ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f472d550cbso1104985b3a.1;
        Fri, 17 May 2024 04:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945069; x=1716549869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYuusdJL7E+8RFZR+POmkQq9dUP8qkt55MVFLW6H1bU=;
        b=pS09+26Xq76TVy7pAuUQCkQPuZ9a16CC4m87kGZyAQsCHi66Becw6tDGcyMEXQmXxR
         JIJU+WZiHc/4ETIkZF/ddWH/qyz9nBEW6Tre8NJHBNG8cdEVx5qUA+uRXmwg7d59WmR1
         7lJ1TjDREPEVeGuWRYtKZsb/fB2hxJdIgj6TRySQA/ydbDGaTCqUjU6XA9nwvCsG0wmq
         0Q7lkzbBqDzuHOqwyOqYZBjW6cG7efai7b8bYdgg9kWSMrx67Qc9ecAUgZ/4newIL7sl
         c7t31t8PkiwHiQTRYfeaDFz68cQM2RBcb8dwebyyIAVNu+0+vrQpePIyjNMWrtray8p/
         szKA==
X-Forwarded-Encrypted: i=1; AJvYcCWqE2MMVc/LpE8GzzU1flRSD8JsEX1+fqNS2Mz5seA4vXynZ2hBBCx5uj6f5JgOJCAAjLfCdg15RyXSxOWgFiROgHPpmSgj/IDJy3pvjrdLj+qH1VJNNNffzCKLuvai+O6DDLmvy/kZ
X-Gm-Message-State: AOJu0YxKtaSbdrGuPymjpsd4HLHDA3dYiqcWKYTHulnYnYniHhuuMa8U
	4mNAJfeV6Hwy1yNWkpm9QwOcbmAXtz3tvhYV91n5CwAd+iQ8PNMD
X-Google-Smtp-Source: AGHT+IGyX0R1DkrtBZ/0KeL2ZtPjsZ+lewMwoXHcsdMFhMwYU4ngDrrOKr2M0Ysn6NhiflYUxFNzsg==
X-Received: by 2002:a05:6a00:21c1:b0:6ea:b818:f499 with SMTP id d2e1a72fcca58-6f4e02d3f9amr29359227b3a.19.1715945069495;
        Fri, 17 May 2024 04:24:29 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b72sm14538961b3a.159.2024.05.17.04.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:24:29 -0700 (PDT)
Date: Fri, 17 May 2024 20:24:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jonathan Chocron <jonnyc@amazon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: dwc: al: Check IORESOURCE_BUS existence during
 PCIe config preparation
Message-ID: <20240517112427.GV202520@rocinante>
References: <20240328180126.23574-1-amishin@t-argos.ru>
 <20240503125705.46055-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503125705.46055-1-amishin@t-argos.ru>

Hello,

> If IORESOURCE_BUS is not provided in Device Tree it will be fabricated
> in of_pci_parse_bus_range(). So NULL pointer dereference will not occur.
> But other drivers do this check. So it can be added for code consistency.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied to controller/al, thank you!

[1/1] PCI: dwc: al: Check IORESOURCE_BUS existence during PCIe config preparation
      https://git.kernel.org/pci/pci/c/d4f21f188682

	Krzysztof

