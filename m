Return-Path: <linux-pci+bounces-20470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBEA20BE2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40DF16222B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF21A3A8A;
	Tue, 28 Jan 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIvS/djk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D54199238
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074028; cv=none; b=fZK6LnZOwcmXoHXfiPpSerfhy+uWhVyrvNVQB3TXrXl3GxrEgNyZL58BsvKCSSAU9F1dijSVrSiisWzf92+XJQspQ+f6NSit1/6RFJbfvlvsukY8QPsC9kVHXWsTxYeSZZBZQ1Sgcvv5FrgzwfQ4/ZZkvilxICcU2Y7QOSwJf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074028; c=relaxed/simple;
	bh=0MZs5idq0szx9AV9ILdGQMpK/KTQRHnhZ74NQ8sF/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOfv0lwh1wOI4ig2FF10q7auND/+QJArcNizEt5b6vlA9oHyzaXGdcDy+5G3Kkr3PcH3a5cWEViU1Q1cGBjM44beV1bqdVNWrqCxmELObXHiOUPI4ZcbLDIfnwnjFLluID4HghvvFN4zO5+Or1KjFfHhziQL4PFUqliU8STmyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIvS/djk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so80300845ad.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 06:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738074024; x=1738678824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3KCYjdWMMGDvOb9PKKoJ+9LqVtNjKtc1PkbXjIXAiM=;
        b=LIvS/djkUx6eBmJdqoahH+zD5vULNKX/uz3fUinRpjYSLgBOItTxF6wea5wWsznNXE
         hYg6/YYV/g87nfuUWbIrI2rot86NLm8Iyvl8c3fXoPK2gbt7By/qMWfF4cI1TRU9drbs
         A52YQAIseq6bwySxXg1l4m4iCuMLP0Fs8JXHw34jlrIKg5050dZWzG/0MrVVVSQ6M4z0
         dGitJ377U/ZCz3RvjJuXhgMK+OKAHgNTnQlE5PmWc17/otWtMwNBqIMmDOewF3mtYj4E
         Py84gy/DghnfnO1vVRDXrydWsPnb6Hdamg/ptj9q/vJfK8yNZ/hGWmNHdYiNIqb1FERt
         9XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074024; x=1738678824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3KCYjdWMMGDvOb9PKKoJ+9LqVtNjKtc1PkbXjIXAiM=;
        b=WE9XvitnwkX+QT+MAqnpfrFycjOO7T2xq++z1OR6sb+W1nbas3I6g/BxT5EWKHeZEb
         AhSbkyVRiuPlYs6BkHI4Civixqoej3Op732lxt66syKXONXQdBS6Reh9KVNYNu/IP3iY
         kLj7+5iwK1jxuYElcin5EgwjJUiITYuVV9gTdcroWhb24yUg8xKbaLGpNRdUQ6yAK4fP
         WhiNeH3ixrx+VxofvOxHH/u2Fy+EVl93Xmeuw4Pr4QyGO5A1mQdlZrwlF0JTXhHtn+FN
         ZcO9yWtxlLNy2M3NV1xzjMblgiOA9i91D0udbSbxYEJuO6gJDvIjetIgvnVajUMdOh8C
         lkig==
X-Forwarded-Encrypted: i=1; AJvYcCVjJ2UxxfbF4M/JTncBOdKtK2s7hVNfqyOiM3DKaHVjtjClzf7W34Ndy0enR/2TYlh1qTcOixQwEmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZPz5tELbemClA5weNab9WKAYr51DGz9QZZEdH5I3MkFjBVjI
	GTjIHLrhprcpUMFB92VigDidOsurorvkNVjNjFi2r+Ft2fGt1pioDYDxqZ/crA==
X-Gm-Gg: ASbGnctEwgBdIlnObiNvhRDL53UiQNhIX6QEqFLcJoIQO5QYU/4yD888oC08wVVtokI
	QbYrNAHCCtZOb52e2AFyAstuy25SEtsyUcCTlLO3ECrZm2HhD8FRCO3XEMupTcaIvjDoponF4YX
	yHvnE/uztGJ+FAkIn1BLKS9N8j+9QXYATBD+cK+9Oq+qxjgWxnX/IeU5Ga29gs2qKP7b4zZvsDL
	7vEFTysJ1JnpTgNoyNLEcwo24Nk4V4TxMBh5bM2KjG/1pa/kT9rP+uQOZOQZjL6NHSPgryLxdgV
	qLwc1YOu/498T2eFWP8KlVayeGI=
X-Google-Smtp-Source: AGHT+IE1wVU9w8+Wk88CIRXF+UdLrqy0+JwQsDxv9zxbMcNk1CdQIbSdxAv48cv6r/JMBAYdgV50sA==
X-Received: by 2002:a05:6a21:32a2:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1eb214650bfmr72004607637.8.1738074024634;
        Tue, 28 Jan 2025 06:20:24 -0800 (PST)
Received: from thinkpad ([120.60.131.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48e84e411sm8298835a12.2.2025.01.28.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:20:24 -0800 (PST)
Date: Tue, 28 Jan 2025 19:50:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof =?utf-8?B?V2lsY3p577+977+977+9c2tp?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Fix disyplaying irq_type
 after request_irq error
Message-ID: <20250128142017.hoq77lo3aybbbgqr@thinkpad>
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-3-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122022446.2898248-3-hayashi.kunihiko@socionext.com>

On Wed, Jan 22, 2025 at 11:24:45AM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, global "irq_type" and test->irq_type.
> 
> The former is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> In pci_endpoint_test_request_irq(), since this global variable is
> referenced when an error occurs, the unintended error message is
> displayed.
> 
> For example, the following message shows "MSI 3" even if the current
> irq type becomes "MSI-X".
> 
>     # pcitest -i 2
>     pci-endpoint-test 0000:01:00.0: Failed to request IRQ 30 for MSI 3
>     SET IRQ TYPE TO MSI-X:          NOT OKAY
> 
> Fix this issue by using test->irq_type instead of global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 302955c20979..a342587fc78a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -235,7 +235,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return true;
>  
>  fail:
> -	switch (irq_type) {
> +	switch (test->irq_type) {
>  	case IRQ_TYPE_INTX:
>  		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
>  			pci_irq_vector(pdev, i));
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

