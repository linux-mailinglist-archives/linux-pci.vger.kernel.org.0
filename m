Return-Path: <linux-pci+bounces-9163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84069140F6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 06:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F301F21251
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 04:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D579EA;
	Mon, 24 Jun 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuqg5stB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546D79E1
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719202282; cv=none; b=aXK9CRzRzmxfSE22oS0YF05SlTQS8jaugHtGPt8Gt9pXZeaBg7MB1woGivXqKHnbou1QKuBSb9KoVptqEeMQQVpbdEy2sTTThz5ka331Cm0lqfDHTXfR/uJb9MdOh8ttD7ZiQ568edbmv/31EyaoqyC8QX+5temvZKttVBKC0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719202282; c=relaxed/simple;
	bh=9u8o52EWGziA0Df9Qmtvc0vTwC7W/h7kedKatOM/y1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGgq2aH2Wu8XQsDMgB/HnJ58AbdvYsJ2CsLPmQpNnEobAyzxbQ5jUhhFB91FNObs6w5TP3hy7B3mS7oM7lcKUAgrDRfzHeS8qUoZr6V1fySeF9bZ2ybIU7YyG3Lu8yRPjG3qHOvaGht3RoKzzoF5zMPvGd5dIkAO0QCZjFdU+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuqg5stB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9c2847618so32103115ad.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2024 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719202280; x=1719807080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNrb55ZnmxeoPLWrQNF1x0WvyveJ4F7DKPXc18CwF+4=;
        b=vuqg5stBCmUKDgGeoNrAmGd0Pm3pd0vGwJRvg5ALX+M7oMwjxpiPfEtvhOcqfwgcMw
         bL3bsmiX6Cj/GGtHHmKJUZ+KzQ/r0sbQrffOuHWAevr3XpORgEzr4Hd7luNQZyf3UdZD
         lXY6p4qRzjO5DdqXEnUMrv0J5pf8JR2gIVylK4wuJ2wJsmAt7tHo0sFip5XS5F0oV+79
         uAh6yGaFYg3ReHrAbNkTs5kEoQSxC9Sc3hu09TxHMF8yyMkcBlrj8iRPfaKxFljvf0qC
         lBx/YuqZX7v2kk9Skb11OTZjyQol7KC2bsE4Bcb6aecUMsjYqWCGdrBtcESrvSFkBYql
         CdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719202280; x=1719807080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNrb55ZnmxeoPLWrQNF1x0WvyveJ4F7DKPXc18CwF+4=;
        b=NF4/E8BkWUhxcyYLo5OLTwdE6Lwzjfbh38xV2o9fYchY3pAn6+Dken/oqcA1A+aYdo
         SKKRtdaZveNjUPQebYmeMLNJtgoVkxIfiAWmDSZ02yAhf8z5yxUnL9fb99R5VHTCwPif
         f7KQGcGiq5UznZCaMTc1vLz5g/F+vqlcsq+1JjdKjEseuQ+FcJHL9HPAb2UFOZpn5W3Q
         QOpw/RcEgT60/IDTdinp78MPYZvwNu4xlw7szs5TIZ5n+WugBIJNtuU+IWSEXfzK1Hem
         EzVdlCXw6TPBY78iZp2R+Lo93Ftf1X0XMD0XgvMGmri7zfbpTly4tZOJtPEreOpNckFL
         rzhA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Bm8PQZKyhkhVtSxOQ523xGRCLh5IDJ5dZSwEn1NGM5k0Djjf9cDrAm54kQBXvxkMU2PeUo+3voiYQrMY7i1OWQ7ZTpbCnHD4
X-Gm-Message-State: AOJu0YzF+oV7G+RVp7ACvKzkNJ8GW3Gx2S41OsZweqgJ2us9APrWAQmd
	o3m2z6NHBQHZqHP70aUIWR87eNJ6mYBiZgF3iJ8OwMgA6iOg6VeTpK0fCBJ/pA==
X-Google-Smtp-Source: AGHT+IE40mJUbLjZTjhBUbiX2PjvjDfMIW/+xRH0/mNF4kLsH0BV+JMXKi371+iExmIKX0c+N42rXQ==
X-Received: by 2002:a17:903:32c4:b0:1f7:2a95:f2d7 with SMTP id d9443c01a7336-1fa15943813mr53029915ad.59.1719202279886;
        Sun, 23 Jun 2024 21:11:19 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5f7csm52448915ad.140.2024.06.23.21.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 21:11:19 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:41:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, quic_kathirav@quicinc.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 5/8] PCI: qcom: Add support for IPQ9574
Message-ID: <20240624041114.GB10250@thinkpad>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
 <20240501040800.1542805-15-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501040800.1542805-15-mr.nuke.me@gmail.com>

On Tue, Apr 30, 2024 at 11:07:56PM -0500, Alexandru Gagniuc wrote:
> IPQ9574 has four PCIe controllers: two single-lane Gen3, and two
> dual-lane Gen3. The controllers are identical from a software
> perspective, with the differences appearing in the PHYs.
> 
> Add a compatible for the PCIe on IPQ9574.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ea81ff68d433..e61888e6c63d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1551,6 +1551,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

