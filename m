Return-Path: <linux-pci+bounces-6825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A448B69EA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 07:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2831C21DC3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01E17584;
	Tue, 30 Apr 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R81ZkMZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B31757A
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454987; cv=none; b=BKfTDnimWsb1t2lKHR93RZXhtgPB0iNNyN8Vtgq60pr6ocgc87xYbgUUkPutnWq5naSEvHq/TDmIt51Ph5R8Jf4j8xCw1+P3BVenWSIqXKwERdR83hOPgaTxBjToNwqUTm/1YKB97K5OLZwgZvwPHbK+OGvDuqaUkTieq9A35+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454987; c=relaxed/simple;
	bh=mTNba/21rcXQObBdesbtQYbtpWfVF1Ca5IJys+iS0ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCnB+jLX3aT6ve63aBTu6vGwoRbsGmKqTSnCMHdyuVHinytpqFApSxupWXIIb3my4RDtaedNDjKG2ph1vI+4tUZcwcuBs3NJ01VNBOOUoZzMj1ju90tvglEgUdnR5mNPnmr4b/9cl7IcwILR7FnKnScqNKkaEsrqB3P/UQMmqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R81ZkMZC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e40042c13eso35862645ad.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714454986; x=1715059786; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6mCZk6FdleSGbVvWLSI06B/J4ORyevzhTkeYx7XPwWo=;
        b=R81ZkMZC7iCj2+CIfNFwQMVtgR5oPrJtZ9UAFatpF3tuzbLPunlRKnZ7QgUcMlrV7Y
         HUHHXBFxrTvKwfLbHfbcmLHIyV9Yp7uYSQb4HQfDbwS7vvuK/UbU0oioD/7wGgSrEwnY
         F9XLuYUzWS1OY2EukF+zVBRuWQv+xpt8a/nlTxDW7jguUkR9emkP5nb0dsO76j9mPNok
         rIJYKZortxy9BplxVs1Exf+ukxYCcC4VXy0nRz/LQOTgm9IfH+GAzSkqhCKFpcJeB6tI
         Le5diOcutqItVdSdQY6bTRowma3zqhx6D171rPBd/VhEm2r6s70GxTw+ycDBLZBIe6iA
         WuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454986; x=1715059786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mCZk6FdleSGbVvWLSI06B/J4ORyevzhTkeYx7XPwWo=;
        b=IoD8xVbvlmjCb1yarMTd1rKWEckpcrO3k+ghJMMQ+KjVbwq6wU9+sUwnkBKxoaU+i9
         zB4IUu30Srg/TNrdSH2URdEb5Qz5D6Pk8nttWFE9w0tT2JeQAuQW7XGBX7d4qwwihjHS
         2dFrAbPpBHV9aMmAj3Xnz4Xai1025lQViPrvfsvo9fPqEEIfa8XOFzcTTmGlm5zkR6kr
         0cJsUQzs3KvKMnNLU2IjvalQeCUospT5TDxGZ6g+SCi6JwnCRyZHN9dMEdY5lyCpxH+m
         0el7lUQLcFNApi+y5JvTz3foNE6St74H/mTUez1moRY4tU49OCv/7vqhsqSLIYyCCARv
         LUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUdV4Trl0uBrUyHArGlvTQbSdoYsrtu5Q2Fma4a8OTMWeb+UK8RLiJ9gyGhgFUwfKVb4urOW/7fkRmxCUcfD8Q5Pz5SeEYZGRBr
X-Gm-Message-State: AOJu0Ywd5LtADlbKi+ZjXDtgBvs3yPiJinRVoSPjxHfnsRMWieBXPBxq
	rH0dvAP2SRjxbrRgNUS8AsiYoXQDsVNq9znQww0hZ9pEAQpTltroAGEQg7nzRg==
X-Google-Smtp-Source: AGHT+IG+YkNcmnhANKIa1YinNnGPCvN3qgILY+WOvZmumX3gU1H94lCCbUJOEm9TXMJO3Ge/E/b/4g==
X-Received: by 2002:a17:903:18b:b0:1e8:b81d:e193 with SMTP id z11-20020a170903018b00b001e8b81de193mr16766426plg.12.1714454985792;
        Mon, 29 Apr 2024 22:29:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm21298398plp.259.2024.04.29.22.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:29:45 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:59:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Switch to devm_clk_bulk_get_all() API to get
 the clocks from Devicetree
Message-ID: <20240430052941.GE3301@thinkpad>
References: <20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org>
 <693e631d-08e9-4ba4-8752-83246697b39c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <693e631d-08e9-4ba4-8752-83246697b39c@linaro.org>

On Wed, Apr 17, 2024 at 10:05:45PM +0200, Konrad Dybcio wrote:
> On 17.04.2024 9:02 AM, Manivannan Sadhasivam wrote:
> > There is no need for the device drivers to validate the clocks defined in
> > Devicetree. The validation should be performed by the DT schema and the
> > drivers should just get all the clocks from DT. Right now the driver
> > hardcodes the clock info and validates them against DT which is redundant.
> > 
> > So use devm_clk_bulk_get_all() that just gets all the clocks defined in DT
> > and get rid of all static clocks info from the driver. This simplifies the
> > driver.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Even better, you can push the bulk_get_all to a common function so as not
> to duplicate it for every gen!
> 

I don't see a benefit in doing so. It is just a function call and using a helper
will cause inconsistency with other API usage in this driver. I prefer to keep
it as it is.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

