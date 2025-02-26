Return-Path: <linux-pci+bounces-22407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BCA45617
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D923A7301
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE3269CED;
	Wed, 26 Feb 2025 06:56:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E719269AE6;
	Wed, 26 Feb 2025 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553014; cv=none; b=ceFMRbkSVFldfui+qxB2dS1I8yO0WpZagvB7+lLCnzIEMBC4Og+aRxyAOXd/lGIm1AxenxYf58s/+62TQ56xMSN9PdThztWFxrH8xH7/8DF8Qmz+wSgPaoX2Jtgc9gpJS2prJh2Xb1eMHSns3hPsIQ/QaP2fbqnksb0F7P8bQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553014; c=relaxed/simple;
	bh=REyGxNjVGb//SnIP92SWCgFA+IpnNaqyQiyCYfcvNSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy/SKo48cmKvyXqR8+1vD68a8VhxxLcxbWvOdBkF4v5Ele6w81LxsIEXR3E+W/hACCnrHbaOkGREkfzfcEHubcneBrKldmVMwOYynQl7qE2/NSSlv8Rl4ATILYElBShLWMbGCqclQC7MzjSAGzxYNvaE/RvwB5UCT8cQTi6Qlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22114b800f7so129148985ad.2;
        Tue, 25 Feb 2025 22:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553012; x=1741157812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgmQrdXjfSpgmuZm0bmZrLFRaOfz8Weuouk07rmWvCo=;
        b=GLCn9ojCqc6csQIs68hVChXL5LaaXVZQsz5bgw6nfhpmj/NUDoqhdDj55G4R1b3E9S
         6lGxm8LXqSWwQkcOPslK0QS9vd2rEmZTIZ4q7xSNokevFSy+Fb+yICA5P+jEk1lWIf7K
         Uv0jC+OPZlRfxwq2gcRMNcjdLV/I+mmeiWjeTV7Q5VTd8pPYqwjxUuPdYv7JERRX72Lh
         vNJkHNr4xnCtff53XPlPbzlY9u6spEkJZZnoOATJAtWpHjLApEZLZGju/erohy/B0Kti
         sjIXmEeSB8yqSkxQdIW9+GkDXbB+eco0XUTeNjEw+v3OgcsI4Ry7vhnSzn4/7N6o7VIG
         XTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BYDieyOcIK9Lb4gS/lWfQkKjvvNppx/ENrCM5cBwWCeJ7DEROX6LO1/KZRnoa4NhK3G/280v5jD50ag=@vger.kernel.org, AJvYcCWAuHXBLDW8IfBcLEHqf/udPfTvCHKM5bGIp9p4jnUDE5CcN+mK6VLg4RQQzy3Qg4rZh3rbEWYF/5Np@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMxHhqrxyzfQlBCLoChpflfe4/87nLl7nqpDHZGGVcuqd28Mx
	QuNgtmC0ykq0jzH2tANeT531PJB0ng0HZgS/iKjnOtGI1Q8pQCMc
X-Gm-Gg: ASbGncsD8fvrFiNLiQR60KXlGnvmw4PGU8HVLE19axv31MXC8z+kDim8YDjif8cHiT0
	XVRZZBz26u9LsF0YRN6RhzwdIHBq6SKIElwu23NprSE6rqMNTL0PI3tsRYz6p3AR00hPJtt4UG8
	QJwpUyNdrf+tPzG4GKSmrfVuv2GuwEIYsWx1/8PaRathS7jpclFoRT5sziu1m3QT30n1EmBSP8i
	I5lbz73HG8316tqt0xxDPxuAbphpO14YUxU/ioJR1coKff5LncVH4zZqzX5lrqWjVGOJ0Lbk9ij
	tivGCnxIRGYYfcSqHDp+uNTLR0+Wb3UaUXDJa1HPpWsYeBgjC85jZrXCmv6F
X-Google-Smtp-Source: AGHT+IE90esSacLB2KmcdMQ1nRApbRRzIMd9mMfYID2+dXADWV/Ul+GxhLVJlLeZN+9ccdG/vujUxQ==
X-Received: by 2002:a05:6a00:b46:b0:732:288b:c049 with SMTP id d2e1a72fcca58-7348bd91343mr3518214b3a.1.1740553012171;
        Tue, 25 Feb 2025 22:56:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a7fa1bdsm2738604b3a.104.2025.02.25.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:56:51 -0800 (PST)
Date: Wed, 26 Feb 2025 15:56:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, shradha.t@samsung.com,
	cassel@kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc-debugfs: Return -EOPNOTSUPP if an event
 counter is not supported
Message-ID: <20250226065650.GC951736@rocinante>
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
 <20250225171239.19574-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225171239.19574-3-manivannan.sadhasivam@linaro.org>

Hello,

> If the platform doesn't support an event counter, enabling it using the
> 'counter_enable' debugfs attribute currently will succeed. But reading the
> debugfs attribute back will return 'Counter Disabled'.
> 
> This could cause confusion to the users. So while enabling an event
> counter in counter_enable_write(), always read back the status to check if
> the counter is enabled or not. If not, return -EOPNOTSUPP to let the users
> know that the event counter is not supported.

Thank you for following up on this.  Appreciated.  With that...

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof

