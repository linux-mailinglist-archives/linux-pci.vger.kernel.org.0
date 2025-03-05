Return-Path: <linux-pci+bounces-22983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5979A50438
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D810018960DC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CE2512C1;
	Wed,  5 Mar 2025 16:10:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57E24FC1A;
	Wed,  5 Mar 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191011; cv=none; b=S6zpv8idVzaLEEkSgxV3jK8K+V54+XgqMfdXVGkf/1Dzif8GKSa8UmHlBItEODO+cfHCrIiuXaurR5XAlW+l8cRBkMqtZ/FF04fmuTedei+y1BI+gIqfyJg8N4U5KJKpo76rkWW25gQjLXscaN6t/YcIWvOItrt09kXmzho85XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191011; c=relaxed/simple;
	bh=tQxIso6zdyCPRW3ea4lNOub/x+vWYMWUlcYeaXspf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLqYj2HgEw/U94wPt9Od1gNoLf0rEHlaBJmjcxwgnEoLQ2TcKvOW1ZE24hWHk8SSkluplfj+rg9daINx5Y7dH7dFbZyU8mtzHkKpSFIfYrzq0961Ln/LoMYwMdbuz9TPhc3wH5On0nRfruAO5CEI+7dAGmbE1PilHNnuKvtMovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234bec7192so129731115ad.2;
        Wed, 05 Mar 2025 08:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191009; x=1741795809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmm65+uA+Kw6OHf7ipiynKZVxICJEHzaO0o95amWfmM=;
        b=nqaq/hQ5jbkva+iKterslzZiUJWOUjgEx64UU2IdLqD22FNxQ0EK1Y4PYb755l4FFN
         Z39u72l09Kii6QjShOQcNaDFQe/m5T78abnKkkzPrHrr0HlZ9zwsswzw0njL53Mq+FSa
         3nn0OFfZ2C3bcS2h0AGYo2By6MEoI86LB7v33N+uMvAONol809CdR+8OmjpV2RdrgG5m
         z+OQ+jxb5EHXqfOEG1lsughLpFl05I3dw+cw5dv2NR53Gr177XXprDGPkeHmWsTEc4+w
         Q5bBXovkouaV3Y0inLak431n+jMpKaVsNnt8KQf+i6ltx4VbsnV+kwioaZimyW7/woOX
         pyRg==
X-Forwarded-Encrypted: i=1; AJvYcCUqV6MWfqnVLVGKlMCbZ5N9MH8hiwDrpYL/beY2DK45mKfQj825B9urD4bYQg9b9AZhOCEkFU5yAfO5vUFJRP8=@vger.kernel.org, AJvYcCWSIGljxjL6Q4RpSnw7JHmoLF5ds/sao1bRxp3Qk5nz3tUZSPjYZ5JoIn54heV5rojBDaqq3dsCF4xc@vger.kernel.org, AJvYcCXpcJ95hLp7uRHXAcm/qW2wK6WVqiIfKBZ+O7NA1Qppe0K9kHfpsuhl5SLff4M6xeYN3x8rUP/6FaaLMiCa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8on9RhDHU95A77NCTgmFMfJurvCiJ9CR2FxoaZyHG9ksvzOH
	qe4veoD9g8G+JV97zwNoxV2e4AMSuQcCjAviIkJ7vXiU1dUk3eG6
X-Gm-Gg: ASbGncvlpw2oYhyrH7ddnIX6pcPMPWd1Tp0Ijv789KQ10chxsZvPEAgT4Sw/QiovXJ5
	4cuVOto1nfDPAHf8x128LqVXNyFhpW9LfPWEbdwEb+BaGOB0u2IFqx+HyhMhYcOELncTYwnrH4T
	8qhInUvaF17Tk660KiWmqDFw9S6j0N3GWGbLebHO6cqp1cmSRYTEQgO3QNtJ0HO7TdDoKZ6D/jY
	Lnjq6ISOf3E2DGOzH0FSE9UtGBUlYUjLFBsV0aiRnRvhmdYInTiIw2pzmh5STixOMEo84Vd1K0Y
	6N5q17ywWPblHUlVt66QwKs7yHj9UnVc3a5pkeJQF5896k8g8Bj3EqVMsFQG7a+/02OMEr30dk1
	pcvE=
X-Google-Smtp-Source: AGHT+IHYzu2Hg17Iv+FAPzzj+vp4OtCZufp8iYDa3P2grWwais5vrBs1hTqGVRTHFIBVqoc2TiyA+g==
X-Received: by 2002:a17:903:19c7:b0:223:3b76:4e07 with SMTP id d9443c01a7336-223f1c66784mr69929345ad.4.1741191009308;
        Wed, 05 Mar 2025 08:10:09 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d2901sm114816735ad.30.2025.03.05.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:10:08 -0800 (PST)
Date: Thu, 6 Mar 2025 01:10:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Return -ENOMEM for allocation failures
Message-ID: <20250305161007.GI847772@rocinante>
References: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>

Hello,

> If the bitmap allocations fail then dw_pcie_ep_init_registers() currently
> returns success.  Return -ENOMEM instead.

Applied to controller/dwc, thank you!

	Krzysztof

