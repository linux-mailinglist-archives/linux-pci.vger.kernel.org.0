Return-Path: <linux-pci+bounces-27721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427FAB6C93
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 15:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A268C7323
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D51C8614;
	Wed, 14 May 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q13wIhH1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE33270572
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229160; cv=none; b=jYVO1NSLTBivaJMdmW9WIwGbASQA9jhhrwSVOXV4Cn3o52MtWAtEu/9bFMjpw0zqFxIJT2jJe48w/qQ7URYyvBvch+qCbHVlXN77dniHDL5cYyrHZULx9MxvbKIIhyyE7XLBh501SsywQ3VIyFJAWoQp/H6QozBo2Hx3uR5C1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229160; c=relaxed/simple;
	bh=tr9E9784jwlXVIOi8Tb2FBN5PrzKrA+2gad6rjWiPhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aREbl+EJQu+Q2+13qSlfE/B82gdajBzORCOlk9X4FHPFT2vdbiT2EyQZxEV5GFKqjVJyiAG50gMHi0vRDTvi53Y/ShPU+z5+JuI6w1ExzduPzOtDHhzpzPI5twYY0KYYtWO9DMRUpYsbjP7zPlFCkwGOh0UhDbaQ2LlVf7QRUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q13wIhH1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso51853685e9.3
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747229156; x=1747833956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aakUawqIUHWGlW/tgWhb5T3+gxdqWvRqHtfYG+cbNxk=;
        b=q13wIhH1l4gkmvhI8ySwYJXgnl8fM6KJAOM54awKnP6P+XLryqZoGbR7RriQtlQS3k
         Rbppq/sWlUWAt2TI2QxEgShyITXVcCZGxqQjJts1fZGdutL3qZvEYiu1haG5wMtqiiU5
         mQRWAerULFRSYfa9jmw5tK9f3clk9JZsqv7qa4zN+Vzy0FUx/nAsgSMtwatfqm0Vy7G8
         XqDx8l6+B3QvWa2TV8kAX/gjCPNUjeKHRc9oEUNgi0CvVQvfdRPj8UXdaGc0a9iWXTTa
         A97RHATghSljYitriUG2MW/hd5kJpZWtDYCAexRbP+AXDkKyP5ygE8A+9H8X19qN7Fpn
         NnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747229156; x=1747833956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aakUawqIUHWGlW/tgWhb5T3+gxdqWvRqHtfYG+cbNxk=;
        b=e9NWr7OzJOm+TDru8OhYlJF5EkvOUz1YUVDogqxyQD7JH5d+371BF5QclylaQTO3P5
         4Bkn2aIsD8CHDHBcvD3cRScENZ1lbX/CXx9Y+kbOgFfj0xnh5Fvo0CZaAwosX4Rdf1LH
         vyoilh7iu/FnKFTNf2SobWorts+60/RlDZt8fOlTzZfvGEr2Fu7Xrj1T0w8YE+DD30xh
         c7de09TWCni3BjJbvv0kzbsjwipcjxLz/3hMjkGRaaosBZilFzP+TBfK9GtvEwBuGelI
         Ht/Cup76C50vbY894OckU7/rKNEQxaWxvKKrZUQxZ/c/PcdYh2/vBssnogNSJpaMq2nL
         1LtA==
X-Forwarded-Encrypted: i=1; AJvYcCWv5hZ+WRbaDdIG8DhW6DOrUTC2g3pLgZfkMjGX0Ay5mA047JdjzL6JPopW8EZMmhWGXmpZDMj1X5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTLjmwx957xAiHklKbfy/prwV4eALlYPTZnS67ouWuyOKN2Aa
	HHN+n9wJc1RMTmhmDVzzU8Blw2SRjKYGhF4PiKsAMZQG2kZEYgv2G44cOnzvHA==
X-Gm-Gg: ASbGncvilWK0ovhldvBhwqQr0HwUzoGhlQo6gyCb86GD7KlmWHVbiuJKJC4Ni3GsOCJ
	A6ztryLuy9GaOHPTTJc4yttfyhCpq2sKxAoW9FTJWSjFvNSZq6AUiGY0K+RFaJdpuf7NJNezFmA
	a+W+srGhB4H7W4MLYjnTJSsZmTFwQzh2zllen5j27rV1UVdpWWnMgp/lNuUmRodloOg+mAFi7UR
	gvLfIuPTI5q2M325yz/jG3xBqg9N84VYS7sZAYaPyNnld3RmCwQZo0SqMVuro5N6L/tmzSeu9SE
	FTdU4E2lMtIu+bCoH8/9LEFD9jJDqD1cv9q+BNz1FRVpIA6g9Br6D7j2q6zgQPdfoVOIc11h47d
	uXWetgaygAuey1UXry4l3ruKzt2vAD5tOcsqqXG/aDBzv
X-Google-Smtp-Source: AGHT+IF69aVHh6QQL7Y9zF5wlxFHQroYuTRB4UFZmRCFpZtw3Ef3bncMvZbprgUs4BgS/0hcTEg57g==
X-Received: by 2002:a05:600c:c059:20b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-442f285d105mr16754775e9.2.1747229155857;
        Wed, 14 May 2025 06:25:55 -0700 (PDT)
Received: from thinkpad.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8c7sm29528365e9.38.2025.05.14.06.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:25:55 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] PCI: endpoint: IRQ callback fixes and cleanups
Date: Wed, 14 May 2025 14:25:51 +0100
Message-ID: <174722913586.17855.970020852326837636.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 14 May 2025 09:43:13 +0200, Niklas Cassel wrote:
> The first two patches in this series are IRQ callback fixes that should
> get backported.
> 
> The reason why the bugs existed in the first place is because the APIs
> are very confusing. The rest of the patches are cleanups of the APIs.
> These cleanups should not get backported.
> 
> [...]

Applied, thanks!

[1/6] PCI: dwc: ep: Fix broken set_msix() callback
      commit: ef2a2813f4c738a5c8f71d47537a8e79b1058319
[2/6] PCI: cadence-ep: Fix broken set_msix() callback
      commit: 24e50b43ebb98f147984054730cf30aebae23c51
[3/6] PCI: endpoint: Cleanup get_msi() callback
      commit: 6f91c4cae6a3d895265e533630c00e1c4a0b8dee
[4/6] PCI: endpoint: Cleanup get_msix() callback
      commit: 262df0e1a10fa8470103d343fe85afbba4b25698
[5/6] PCI: endpoint: Cleanup set_msi() callback
      commit: 2b9391dcb26739d0b43927b329d2b670418c69a3
[6/6] PCI: endpoint: Cleanup set_msix() callback
      commit: 210de38727c862164e933d978ba39b66569ab552

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

