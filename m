Return-Path: <linux-pci+bounces-12571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56339679DB
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B49281B88
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDD18594D;
	Sun,  1 Sep 2024 16:48:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74701DFD1;
	Sun,  1 Sep 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209313; cv=none; b=kI1IkCqRCo3XDr0e0Z7XlFy/HJn7R1ila6piAgiCfF1xiGNpwjXotDTTbt1V+lIWVlOhehZf6uoSYYJroyCrT92OaQB5RvqWrQEqAQIz1RelyXU50gyOErInTcrmQ7Unwgv3MNyPmTMtI8seGrcqPPGB+F2ZQNwI7axw/j47+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209313; c=relaxed/simple;
	bh=ZwZtIghE+btfuynxF46vgcwCbq5RGjkTykzDtRiJwaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRmEnYZphqCEjojq/7+ljUcADYgW234ABM6PJKvVHku2Jp1Q8VcF6PmrA4Q3LPKDnuUzd2EKo9LABrzT94+jeeQaCmGXrvufzfYkcFWAgbRvuqQ3BHNLEeXO+qXt9AiRE89eAILiyTe1vpx+qeasP6MTn8gUX2n2voZU1NvGTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so2483501b3a.1;
        Sun, 01 Sep 2024 09:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725209310; x=1725814110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm8DW31NTPQ9oBr/UoX+v9NAZdmhZ0D73f/xUI1wyHg=;
        b=b0hsp5d4OsoQiWnHffojgXzFEklXtitqZrbuAdJq389NUTz/zn3LGl4KnOvrjsSa+f
         7qdDYIhT/79d/E7x+y0HuxFZ7pNiC+y10tXHrpNht4No47kQ3KnvRE/4J3ceW5z3JMzY
         4j7HYKZIZJHchWAgdny3WkvrhvCVWUDIcOdDywkwYp7fST2c9yQJVvLQY+gg8ND7/tLS
         KqsZmHFH1caUQng1qEcv/Q1wbFYGtid0RoAWFBMFRjECTIWcYU/MhuNuLU43QMGrgN9r
         CUDdyofWfdbfLv3mHOWtGCS0Ksf8K0nuWpPt8fF2eM9UtTVK511ahB9+Q71yOu0GKTqv
         Ok8A==
X-Forwarded-Encrypted: i=1; AJvYcCUMRzbGL7LzL1NXUeBt37UUDxmzgxKL3g3kCLLJg45cZcGNrKVXa8ZEe+bW/ZS9QKjyYp7ylLd9YgUa@vger.kernel.org, AJvYcCVkUqiD2G0/3tTWbrep2mM0LsKESWrNxFgomYaISc2AGCy5/AO8MEUfomOp4T2l38U0Zx0He6wi5esT@vger.kernel.org, AJvYcCXO5nrhaMAng7pcEwgU/7++I72OuDfQRTVUMFOSl9GR/0mCy2Mi4cbJg0bGvmTJlWP2gGNW0pL6lqDIU/zg@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuTWSYfkVys/daH4QmYhnYL0hWDv1/ElgW2M8dHFPjgtGeaM8
	g/yjFVPzKPyrLkWgV/eX67k15gy26xYqIG1WK0y5Xma9FS18T8cP
X-Google-Smtp-Source: AGHT+IGBI1VisGzfbAgM1cvQ+sC+vrWtWn784maMtSzYfmgqtekMM+KH3XQkTZ5a1HgyynLHadyDMw==
X-Received: by 2002:a05:6a00:4f8d:b0:70b:152:331 with SMTP id d2e1a72fcca58-715dfcca5bemr15220453b3a.21.1725209310006;
        Sun, 01 Sep 2024 09:48:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575b7ecsm5540044b3a.189.2024.09.01.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:48:29 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:48:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vigneshr@ti.com,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4 0/2] Add ACSPCIE refclk support on J784S4-EVM
Message-ID: <20240901164828.GG235729@rocinante>
References: <20240829105316.1483684-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829105316.1483684-1-s-vadapalli@ti.com>

Hello,
 
> This series adds support to drive out the reference clock required by
> the PCIe Endpoint device using the ACSPCIE buffer. Series __doesn't__
> have any dependencies as the dependent patch:
> https://lore.kernel.org/r/20240729064012.1915674-1-s-vadapalli@ti.com/
> which was mentioned in the v2 series has been merged.

Applied to controller/j721e, thank you!

[01/02] dt-bindings: PCI: ti,j721e-pci-host: Add ACSPCIE proxy control property
        https://git.kernel.org/pci/pci/c/cb08c3a32be4

[02/02] PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists
        https://git.kernel.org/pci/pci/c/82c4be4168e2

	Krzysztof

