Return-Path: <linux-pci+bounces-22832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B9A4DBC0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295A9189D08E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3797A1FF7AC;
	Tue,  4 Mar 2025 11:01:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33B1FF1BD;
	Tue,  4 Mar 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086099; cv=none; b=iuno+fxEHf5LilqnvQrYqgJ6WtY80EoHAWjaq3F6r2gnrVLW/PrQ7aqUWUUF5tDhPZbLWhK4ObsLhdcmK6kGx2CraxEhontB4j2830KIud8pWsgvglTUZEAJn5zp2kOmKjtYvStE+0Ko/dimmrhWzRxpGCVINbAsQJQM1m7dKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086099; c=relaxed/simple;
	bh=NwIfxOJpjQKKWVZOWUDaFc9aD87Hn1O3+ngn0ThENbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+fEHCp4+EypRNkTosoKt73YKfDVbCLjf4MjfVHz2QWc2MUv5J6P8CpZSq2nWGx+89r9uBXIUIabJJAaDufuffEeAkeO+czCGqGa5asJ/MBJE5tamm8f6dvM49QG8cPfbizDiR+E7gECRHFfGHViugsvfHqjz0evLT83i9t61LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so9808366a91.0;
        Tue, 04 Mar 2025 03:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086097; x=1741690897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ+Oq7PC7q9BySActJt+1QaCy/AKAyIsoVNBKS++4W4=;
        b=UzgCN2bqoQ2N8HU79ltFDPJaQgNKAQQbGGhCOVWfrIvgpUTRTt17Is2foNNYiEVfgm
         dCqBtDqFrI406wyDhuuJfgDMfdrrnJjsnyj28SRkvbdoWZK2Se0AlrtXuJlDR3KX54FB
         ggLU83+jsftC2phRUyalXyGbTpRamUO/AkRo6qsv1JSzWIthlMNXj0Or3ZgtWy8+39i1
         TIeh3jpRN0o3YA/CznrD8OyeIZy5z14Xy7ixxqeIF4Zi18NjxBbR+h9D24wjBR1mwXdc
         2kXsbLXxcPG6FYq2iuGtS/Hqwk8onJnUM6lXWqq/J57LyMBKbwq825CB1SnrZh/tOHj1
         vRPg==
X-Forwarded-Encrypted: i=1; AJvYcCUCukJI3rAtliz/RdGU/zDF+90c1jrezutJcX/MGAr2C/x6Q8/+mTsAHjpFLd1m4x9nWNbVlnzdrc5JWkA=@vger.kernel.org, AJvYcCUYr2YmnETYhQ4cUzqbM21NAne0Sly3KuZMqwoCx7j6Zc4kF0vK0p05fY1DLfgZMVkB5nQEgphC3pcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgghu91aAl1RpWJWCtHYJzPlbzvgzj+jTTp5+EWWi5zHOJzXd
	7Fp1ZBoADiUPh/b0mHcfGAWlVYFQJBPW9CrDoESbuIhxw9WK6N+Q
X-Gm-Gg: ASbGncsh82it8H0hkzGCFwm/fIPq7O3aIA/xX9KdpIgj7UjZBtUeRcAxmDZqLoL8jVD
	kFphHkJ1jTkT2wN0TfC4iDpWLIULn/tccmgtEQcR3kmXeV3IvqGdjAGZJtqUwtHNkj6KcFbETuN
	c58omgkmnJz9fObuOHto9mB2VsiP+tLj1UUHJ4Z+MPLoqiC9zZsEhM1ImvmxM4kYnsD5RFKudkA
	hwRlfmwXZFykyIIhmlt8i9xnz45Ye/Xf23TsPLfWMoo8N3KkWtIiI9trb7HFU7QjFBCuUEeUvpX
	gC6JbH1y9ddy5F4wcRWjVnr4926POQ0jzGYMd+Vwg5BrO1R0/e7duH4iKSC9x3LVG8uYSuitbFE
	We/U=
X-Google-Smtp-Source: AGHT+IH/XwYcLajY7Y4xCSf8zrz1ql2vE4I7XndeYgzjQlRjSeF6nzCNQa9fNe9VhBdw8XDoxdT+ag==
X-Received: by 2002:a17:90b:2e44:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-2ff33994c2bmr4918931a91.0.1741086096855;
        Tue, 04 Mar 2025 03:01:36 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea696dcc3sm10612202a91.36.2025.03.04.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:01:36 -0800 (PST)
Date: Tue, 4 Mar 2025 20:01:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
Message-ID: <20250304110134.GA4101682@rocinante>
References: <20250214165724.184599-1-18255117159@163.com>
 <20250303190602.GB1466882@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303190602.GB1466882@rocinante>

On 25-03-04 04:06:02, Krzysztof Wilczyński wrote:
> Hello,
> 
> > Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> > 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> > axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> > set, MSG without data.
> 
> Would it be possible to get the full name of the reference manual mentioned
> about?  I want to properly reference the full name, version, revision, etc.,
> like we do for other documentation of this type where possible.

Hans, I came up with the following, have a look at:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/cadence&id=09f4343a59cc2678a3a5b731d16e55c697246a40

Let me know if this is OK with you.  Thank you.

	Krzysztof

