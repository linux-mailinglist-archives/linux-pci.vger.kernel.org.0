Return-Path: <linux-pci+bounces-19871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E020A1225D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BC13A4F89
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44791ACE12;
	Wed, 15 Jan 2025 11:19:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377B248BA4;
	Wed, 15 Jan 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939998; cv=none; b=I2F5O76JdTVImte6K0dAb0P022OZ3Uqr0p7AWSFbuaf8DqPZMaK2HbpdgqHZr4QvwTz0sLgfxylkj2IhN6E4By1rBupI+56yZe0qwlPDwoQXPI4Vuz9T/5Z/EyhErW+NPVDYnmchAJLKz779IIAyaOjKqwIifEIT1Iv1jsbgIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939998; c=relaxed/simple;
	bh=1xoY/X3t17KdWhxRXY/y/d/HeEJBR2ipsoiO2TAOE+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td170exm7mjqSV2bVCc26zSldlxq+oAD3gAVVLNix2C8FuBFZtoHLiq1A3v1G/bBR46MgMAQ0fHnLgHwR0gqXmKwZjX6fATzU0pE2MRlutRP4XYWG1AddGrOLH1xK6pgT/kBn7GPU+tCYhRy+nFipU+IoK0gb2+4hfMIPnDR93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166022c5caso102844765ad.2;
        Wed, 15 Jan 2025 03:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939996; x=1737544796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTDc6QMGekaYyeE7wEFxu6Z5thWk8YbGvyNFBNiV5a8=;
        b=dDx4YVn1u9l3/zmz/+mMKPTnnwo8+kayfBjj8lgphHmmvfQEAGgTz5CnYys+Fw4CSV
         Bm2xS7rlvTiTIYe9Lo7PtyaeSoKAE5NQ+YOsOrGCERubQCVgn6LSak+lRcr5mqfc6vT8
         NIChhs6kuS5S01hqJsHXQk+betnGtECTZOBuE8pAadznNu6MRd/8u5EyHTJ6rueY4rN6
         vY6Ij4dD9tmhvIWqTrpq+u3hdIVhSM/I8QQSo1svwurdlcAw2Myz+tGnEVkCE2m7q7dW
         IvBfUgFciOZTkOecMfiC77HdP/XTrdSKw5xc/aqQI1jjlFG+M2xOo1x83hkvUUrbbd4Q
         Re4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVConallyVmpgsVRtKXU3if3dCOaVGlV4y/wVHuoJg76fcjiI5wsvV2gIiPJfT8COAhoXnHviQIz0AAK+3N@vger.kernel.org, AJvYcCVDFB/KuxLFP7CHbSsmTvKui/jp73J/hX4deUNvxnzhs/DTfw9luyHL94lNE7+L1kcEqdeGrcNY+lDIamgh@vger.kernel.org, AJvYcCVTetSjrhBMKIbB7M8E+zxFGsb+DnTZqhG7tyf2rgceBolUnebTzfVlSSpVHO/5IMu6K/5k2l/rCpoA@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsKlIQD/9yVjMTMMiYKNUk1pI4gFNKvk5IMrLIvss/hO1xZTe
	mSP4hPT8HFtq02WVZVLNOwA9ZNiGaqNPe2MZnNPf75JOJiE9zjaW
X-Gm-Gg: ASbGncvwObZQzoads0DOCCdLSFTEExUX3dXl8WkXpl2wUC6A8HrsROH7lSC1y6UC3VU
	aBLz3WOzqzQRRAcOlxIiu07wEUGUV6pnc0cn2tTpr75vu225Bw1Hun1OUaSXyKWoGf3WPh9onR7
	Y7DlPvvRVB5vf3+seiStdMc+LGC+rwVLFxh7afFDrFmXPvokqT4Nn/ygzYv2eP3Rb99dzdvv/5n
	2NkEdOC8zY5HujwaqY3MpglU9n+AmuTo9PKu4f7whyxQTb+77L8X2dzS+2UUjSFcfmgCqWWlRsM
	3BC8kj4UbKACHGo=
X-Google-Smtp-Source: AGHT+IE9u2Z+dWs0W1PQSRqxZBeGK7J7WB0qVFArVIy/A9e5JnJQBv0ieenCRc3uGDbRhD3/8SG2Jg==
X-Received: by 2002:a17:902:ebc4:b0:21b:d105:26b9 with SMTP id d9443c01a7336-21bd10529e9mr102917555ad.16.1736939996489;
        Wed, 15 Jan 2025 03:19:56 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e411sm80772605ad.4.2025.01.15.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:19:55 -0800 (PST)
Date: Wed, 15 Jan 2025 20:19:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v5 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Message-ID: <20250115111954.GE4176564@rocinante>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>

Hello,

> If the vendor drivers can detect the Link up event using mechanisms
> such as Link up IRQ, then waiting for Link up during probe is not
> needed. if the drivers can be notified when the link comes up,
> vendor driver can enumerate downstream devices instead of waiting
> here, which optimizes the boot time.
> 
> So skip waiting for link to be up if the driver supports 'use_linkup_irq'.
> 
> Currently, only Qcom RC driver supports the 'use_linkup_irq' as it can
> detect the Link Up event using its own 'global IRQ' interrupt. So set
> 'use_linkup_irq' flag for QCOM drivers.
> 
> And as part of the PCIe link up event, the ICC and OPP values are updated.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

