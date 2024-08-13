Return-Path: <linux-pci+bounces-11658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1B950DF0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DEAB28DF6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519CE1A4F37;
	Tue, 13 Aug 2024 20:28:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BB1A4F2E;
	Tue, 13 Aug 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580923; cv=none; b=pBxi3tvSNqDackSh1hyJ4Vn1e+dea3cJdxeuNOL3f5/odJhYM5xi+l+3HgYzhQnp5v/aYN3E82aoqHftGGGPQCphA9g9lUP2P1y2dPm146mqwVYaI9pRQKt4vN18Ac1UDbft88T7n6eGSdsEmFSkcpdatpOo42ikuY+K1OFNA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580923; c=relaxed/simple;
	bh=/PFUmkgY1QulNI+rk5a9mGs3zqRlK7M69ZAYL27vEAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvop0xQyEUN7GoUa5u9cXaHQqW2aChsa2z+xgoeXJxIJy9MsHjoNTw6PurMYFzrHNs8w2D1QPxf8RwgF7K6lO+/ZCpwe85J8oUqHcs/cuE3nSKvANxZef6sXQwGvTG3yyAXGobVOMG9hXt5zn5jWq9MlDNTyO3gaS3kyEdDt32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39c390998d9so9853415ab.0;
        Tue, 13 Aug 2024 13:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580920; x=1724185720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUAmovNw/ZzuwalCZ8aRRLU563G6mbaJnjMpSJnFi+0=;
        b=WeWHeU2UyfvJF8LPp1M+GWjTzNRfYcnCM4WhKE5yjMq6MtSn6MkM9nzu0oznk1syzf
         1fM+eCcwmqca+RPgL5TV67wS9Q22dyFzdvHZdZUhtBRJwvYSQpa1HBaWvmBhXOUqlhwg
         d2vfjmD/sMuljhn1OdoivOS8WYxhgkbN5Y+gfFhpMxxFYcyiKxaJKWz0ZQQLV1M+gRgI
         cSGoylRG6ujzhKU3wabkzov/lUmV8xzxSL9nGpQaNAo4EK8W4Mo9FqKR32DhrRXQv4w3
         oje/xCpeIU5uvMJC+aC8f9/lAKZmL4A47SmeXBbszqW5erODM1gil/ywnfY5aTO9Dsro
         6S1A==
X-Forwarded-Encrypted: i=1; AJvYcCUQUSkIkeM9PKc5qfuIjxh1PMCVLvclGFMcBvzT+qzc0vHn2KTmKVinoWUAbbxpjoXZ+hZOFVi3GTHMS1s/t6uC8rdH73O4Oar+OuWfNuvPjAKgkzpXBqeX6kiSG9yJGG3jedDKgvV1PdjCoPLTmwoPugXU6OCx5v8cn7m21MgoVgKvQWycvA==
X-Gm-Message-State: AOJu0YzSKjSpcY+BXTYn/nF+3M+hnFE5K/OTru2b/4oKxN2l/Ea5iYxr
	Wy//tbTs525o2jppwpqwJlSST7g6/FUVegiE9gfZ8XABGK+qdB1oGzGNlg==
X-Google-Smtp-Source: AGHT+IF/q55R7Ej6PxxPJwna3W6M2bsqCxI+YEC9+QpHvWh+ss0AuJ9xfXAm4+J5yXjnVukArEGGsA==
X-Received: by 2002:a92:c56b:0:b0:39b:2d7d:7289 with SMTP id e9e14a558f8ab-39d124c9bb1mr10330575ab.23.1723580919883;
        Tue, 13 Aug 2024 13:28:39 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a4b3c5sm1868255a12.61.2024.08.13.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:28:39 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:28:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240813202837.GE1922056@rocinante>
References: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>

Hello,

> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> deinit notify function pci_epc_deinit_notify() are called during the
> execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> PERST#. But quickly after this step, refclk will also be disabled by the
> host.
> 
> All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> the host for keeping the controller operational. Due to this limitation,
> any access to the hardware registers in the absence of refclk will result
> in a whole endpoint crash. Unfortunately, most of the controller cleanups
> require accessing the hardware registers (like eDMA cleanup performed in
> dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> functions are currently causing the crash in the endpoint SoC once host
> asserts PERST#.
> 
> One way to address this issue is by generating the refclk in the endpoint
> itself and not depending on the host. But that is not always possible as
> some of the endpoint designs do require the endpoint to consume refclk from
> the host (as I was told by the Qcom engineers).
> 
> So let's fix this crash by moving the controller cleanups to the start of
> the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> called whenever the host has deasserted PERST# and it is guaranteed that
> the refclk would be active at this point. So at the start of this function,
> the controller cleanup can be performed. Once finished, rest of the code
> execution for PERST# deassert can continue as usual.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
      https://git.kernel.org/pci/pci/c/6960cdc1ef97

	Krzysztof

