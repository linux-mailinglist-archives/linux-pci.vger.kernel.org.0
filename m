Return-Path: <linux-pci+bounces-27442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A70AAFB35
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255CA7A2BC2
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7D19D087;
	Thu,  8 May 2025 13:22:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033317BA5;
	Thu,  8 May 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710560; cv=none; b=GJxJhUWHJAc97EDi/8WX087bZJ9WWLMdO1w8brkwcyD3iX2yBFUx+Lkxyvkw/bAXyK/8fkRGPBUpVT137C9jXlHVRX3B7YQ505JD7B7JWANXrzAOVYX6EXJS4jLXTXePS7ElJw3Eya7clHcAFF7CIWDEmR2EOdyPUoyBIqQ2X6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710560; c=relaxed/simple;
	bh=q6v3wv2CDrIH1LrNbNW1bP/KarqhU7EJLpdk97Qi7wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poSfxRN4u/uy8sqBAvweZXWFLba3u7x8LiPHS8OtCA7uIqHYb3qrW0Mq9dm225plShL0cQ28XMGLhIs7crn4wk+uq2vZYcJTBlTY4mff75+MfW7VXg2qPOqXFTRfFPGdoOBRFOHCZhwFXW+hmU8OrquAU6Wj4QGq75mjIO7pTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1a1930a922so605205a12.3;
        Thu, 08 May 2025 06:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710558; x=1747315358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O6QW65hEVybU4HTPkPJYU+R7ruCJ42xt8K+t51LGkg=;
        b=i5qySHlTWkZDJtkdc7P+ZgcI3WBCn1OpSPp5PYuYq2p5Cqw2ATy+K5VvpU0+MItpz5
         f1LDWDcXSOm0GuTgOt9TlUnbd773nSQiuHbiIwtoYygF78jWTZR27NkhyyZtKt27gZfy
         teHFH5V5chvu+vjObv9Aa/S23cci+FIIMSdgSg+yuO3SSml5moVIlz8365cvAl5oM7qK
         uyOCih3mn3Z//vmIoS9uSpLAe6RYVeHs5CMaU51PFq7N42uesaf4DGZNVSTkFo7QBrtS
         +/4CMb9/qjmonHrYgzJUnQIzp8sYatDOr+EA+ayxndOqVzNu16+5NPhNo14ga0WZlwKs
         vZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxyO0Vss7puWzwotMhn2eMf4kHJudJs/OhcQvTMQERQ3AVJyPga6z/ybZ0fsEifd/ZasS1M6uT4y4y@vger.kernel.org, AJvYcCXE6HRF6zo5GWgMpmosizleIsQTUkrTJxkZsBGFJ+2XSDlNR0+ceAMT1VCHj4/B7un9EqExrExGGAXlkPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQRN15eVEqJ/H0tcDej1lrzffgQY2CW/0/kBj4aHQz82O/tUC
	5haTssZ8rVTq8u3mHN2/y08cPb3mZ6ASbf/WGzqZLBNP7msRblHn
X-Gm-Gg: ASbGncvJ92d/E/nxXIp36ESS2I+5S3BiXdWq2DrqJi3PDWJ88vpJHhPgPue7nSXYPAr
	X6Sbocu/YtP+eC55uIdt64KdumpjX8axjynPy2L4LC/EUwmVrZwtwpRaZdr0w8AyXnDqsxalQU3
	x80kNgC69UTSPKcH8xZIBXtP8EzoDN8n5zE3aDlenHHDbxJzdVY6rwhPHXyEHuRrsWhZrom5QcG
	SAe6wZNXn5FzkpDNYhKiYPptZvA/hXGcAMoV/xy5vIFzOsuAMguKksmCUuEXSt3YmbAstWHx9pp
	8quOnOP6KNRWP9S9jPMU2Laiu5sUfNgIH9AHybg7OjcdigycMyxIiefQIAP19y3QNW8yn5vOACo
	=
X-Google-Smtp-Source: AGHT+IHvkK35BjLOowcxL9xTZop9MziWe5tFjZ+j9y8giZnaraoBWrpSDPE7TcvXZ/rDNEHnGivYaA==
X-Received: by 2002:a05:6a20:2d27:b0:1f5:8179:4f43 with SMTP id adf61e73a8af0-2148c0f38f0mr10265113637.23.1746710558200;
        Thu, 08 May 2025 06:22:38 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058d7a397sm13182346b3a.28.2025.05.08.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:22:37 -0700 (PDT)
Date: Thu, 8 May 2025 22:22:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <20250508132236.GB2764898@rocinante>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
 <aByg1GUBno3Gzf4w@ryzen>
 <a6dx377rhakpl3gvvyofdbui5sbccf3fhw6o2qb55fmmx4v4fv@ifvzdjep2kp5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dx377rhakpl3gvvyofdbui5sbccf3fhw6o2qb55fmmx4v4fv@ifvzdjep2kp5>

Hello,

[...]
> Alternatively, since these are only platform-related Kconfig changes, I
> could pick this up into the Tegra tree if I get Acked-bys from both
> subsystems.

No objections!  Go ahead, and thank you! :)

	Krzysztof

