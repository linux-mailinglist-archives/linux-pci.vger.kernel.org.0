Return-Path: <linux-pci+bounces-15897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55DE9BA83B
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 22:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932372815E2
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5EA18C015;
	Sun,  3 Nov 2024 21:06:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF915C14B;
	Sun,  3 Nov 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667989; cv=none; b=nk4IVaYiihnIRnYyOhYi5rnKhWEr53JQvz4DcYhpYY9/3bv/BLgGNkCGPMEg+XvFC6bFsVWaAAsRnZ6YbZWu6l//Z85PIMYW8Xm1OdmciHuD0S/lAs6ZO5iOnOvblonvD4vX/4ACUYN9yYg61sgizO4hGYoLKYfHc+Ku6hOGP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667989; c=relaxed/simple;
	bh=bViyCNx7IkwpIkvnj9Zr4e3mF74VuUnl0vXRLZmYLRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAn9Of766louwuj0l+gkmHLpmXj5lb9BJAiyO5xsKC6MfRWgH/D6wHmXzhWOS3Fj4cJunQzIZOGMaQglVAcABJH6ZmQptt1TBlN5Zu31dcQXQ38jkqTDF8wuJvSS/VkjQPMo8HP6n6Rn1rzqOXsuWoayR1wrSvt/vDiVagCiwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720be2b27acso2784073b3a.0;
        Sun, 03 Nov 2024 13:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667987; x=1731272787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdXLylQlZ9Tj3s4tp6NVE6CDQHIYZCRiCbzxNvRzB8Y=;
        b=FoW0xWFBkjG52LdnyaNopZXGyImuaw6cVT5ZAzSBLUmS5ool1Y1W04udIVhYUqtH1M
         qWMLG3fX5seVPyHl0GGrHW0ZctbGzwaBcTVYkzjslbTp9Zz8THTBBYk29hurSapjhNM1
         bFCjGrI6mqeGOfoxRJrAfn9Nuu3+ebYo5rzg2KwWEtJT4k3K2D9bc9DYyPTfjeyHc+Hn
         saWWXu8M1E6LwJHHqNO+kwUaG1urC7Odi9EJrO+A7cxoz/dMgibIyU6Gl+HtEoIdURkW
         tnhOICnEpWiUIgEDkMXFUC/20+aohcIG6+yA91Hs2AwKgUuE+WfT7fEz5iaAf7pdtu0s
         PGMA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8NF6pM++g8/WWB7MTkqdH3Ot/k0nk26NoI7LBnItWZ0WCB75hm4WMoswHpufzQDNAxoIS6O8DQz4b7k=@vger.kernel.org, AJvYcCWCLUmhj9ZOdMBtQO6fKYJsRMzAnMcjn8Yb1g8q0koYJCzC9Upd9E56GhNz5E2B08+oYSrtF1PK/vra@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/DqtzpPBW0v66H+Iyb/TMEJVPK51Sk5KWMq/a9oH/o/3sMTP
	oZucHfJs3Pofs7Bc2ZFZkbJ6GfFBoN4cuMfF2zILuBIXZNEjUsVH
X-Google-Smtp-Source: AGHT+IGYy5jVsN3Rgu5s8FJn2BIs27OnMRPfCyk7W+axLO91wyEHj+Gcm+Hn5gMgPRNEcSPhj8rh3Q==
X-Received: by 2002:a05:6a00:1794:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-720b9d949eemr19292028b3a.20.1730667987502;
        Sun, 03 Nov 2024 13:06:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1efb45sm6144523b3a.85.2024.11.03.13.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:06:26 -0800 (PST)
Date: Mon, 4 Nov 2024 06:06:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	vigneshr@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	u-kumar1@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Add PCIe support for J722S SoC
Message-ID: <20241103210625.GM237624@rocinante>
References: <20240524092349.158443-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524092349.158443-1-s-vadapalli@ti.com>

Hello,

> TI's J722S SoC has one instance of PCIe namely PCIe0 which is a Gen3
> single lane PCIe controller. Add support for the "ti,j722s-pcie-host"
> compatible specific to J722S SoC.

Applied to controller/j721e, thank you!

[01/01] PCI: j721e: Add PCIe support for J722S SoC
        https://git.kernel.org/pci/pci/c/08e835268c35

	Krzysztof

