Return-Path: <linux-pci+bounces-7632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFB8C8AAB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4C81F25D97
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BA13DB8D;
	Fri, 17 May 2024 17:14:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8312F5A3;
	Fri, 17 May 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966082; cv=none; b=Uf2fdw2FtmoWgjQhtktw9WZ9EP+AC6vleaLAFVjk6lVKpctj950Opjuzawq9Xk5df0q+E77Gy7VOatns7iAHNq+rA2IdtScLXMeD7mfKsdde5mKK69a+hk6nBYaSwUfgumgy9EO+/kZu1l+Vj7SrEOcLh6TlwW120wlv4YC3az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966082; c=relaxed/simple;
	bh=McAr598mn0hhm7/C7g/vi1fiDdRj9I8cf4gcjgVYjpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc3liFoXI+VY87pdAWvBiNqDzIFwhKWMl67rBRWBtd8IOMyZIHX3N606c/RdNnpkJE7EEo5M+pJMi0YBNKVH0PzYgT7oNHtKCg9q3F5UC5Pyt1F9NrseqT+yowt41tuX4Dsp4g0lgGHsJyerXYbkVyN0eRMPZIW1cPefTbxxWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso16958705ad.0;
        Fri, 17 May 2024 10:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966080; x=1716570880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdOPXK0KqzS8hVyL/a2vhjNm4BpbHyq09+x4bOdJ3dk=;
        b=QAuInwW49p+W9R6p1xzc4uGZUapwEUJGmxaCQz5AREDJEw34//7Jo36sw2NeRXgjyz
         9SzBFki0yXa+iPF9uYutrK9d/ONDIlRBrYdkE3fQcS/mcTJCLdK7pc1ghKiU33nctLTt
         f9FblbZzT9bd/BdXUjIw/2ZlY8l3H5vmDlWtk3xDWQRJQLGfqAvkmt9pToc+ozQyy7s2
         coZcu5KXwgObfncjWj+4xV9PJMcIGo0GAsKdPSxcQk7ZnveG0IE7ve5CAKDAYd0DlU/G
         XcpSzJuTSpYtHH+xGIHvv0zjmKJ8Xb7WY58YXkFw3iHpA6ZO1r8PAFwgClz3v23zh9ZP
         uuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAnIqVqCaSxFP4nZIfI3Wx4fk8ROoATt0+Wuq/7llNnv8cBiRfgEtdE1f2rut0kxPa/xow/2LTrPZFzYKBV00HHo2itQnmLVpnWC8+40vAJWUO39wX0oQCX6l4pCmiisE9H/LPj+PMDnU7B6oJ2XeYhZHw/iwXLLOPs5kge9L51uWclV3iMA==
X-Gm-Message-State: AOJu0YxCCmmKDTv9TyAlhd86QC49P4/G5dYs15AimJX8iK761Zq5Dq4K
	l78aaxEH8ozb+1uIMqobrPw1MHM1mO0UjpNYw2Sc/wFu8H/FQz9H
X-Google-Smtp-Source: AGHT+IFF0YjwAFmHHUK9zdHO3gPr5Dkp4N6sZ3Pd0lPUJeOAdRsJz9QQdcDSwPSMspRLNfUHnFWbFQ==
X-Received: by 2002:a17:902:cf06:b0:1eb:74c7:3eaa with SMTP id d9443c01a7336-1ef43d1709fmr302309145ad.23.1715966080237;
        Fri, 17 May 2024 10:14:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03633csm159134395ad.207.2024.05.17.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:14:39 -0700 (PDT)
Date: Sat, 18 May 2024 02:14:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get
 the clocks from Devicetree
Message-ID: <20240517171438.GG1947919@rocinante>
References: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>

Hello,

> There is no need for the device drivers to validate the clocks defined in
> Devicetree. The validation should be performed by the DT schema and the
> drivers should just get all the clocks from DT. Right now the driver
> hardcodes the clock info and validates them against DT which is redundant.
> 
> So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
> and get rid of all static clocks info from the driver. This simplifies the
> driver.

Applied to qcom, thank you!

[1/1] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks from Devicetree
      https://git.kernel.org/pci/pci/c/6720cef2df22

	Krzysztof

