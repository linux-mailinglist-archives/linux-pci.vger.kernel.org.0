Return-Path: <linux-pci+bounces-22097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90023A40922
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA90188E5A1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DC14AD20;
	Sat, 22 Feb 2025 14:37:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA7179BD;
	Sat, 22 Feb 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235023; cv=none; b=nmMVqxIAPLSnSbkRQBGe9UFcOggl/njX+dW9v7HGB8IYCzn61/6E3B+gPmRIRPhd2n+jVT4SeXXA91U9ECpgYSvur46HYWuR9w0FKv6tFGpGPuUfjFIvdlnXS+wo4ayS7m7Z1kYbx5QnxkSCOXBII3PL92hYJncFUHuPKNwuigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235023; c=relaxed/simple;
	bh=nqmYL/X24CPIawYLWCaxMSv3NF5Wq/BThEPt/cHQrIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCcK7tqLO04MQFdo+gRYfF3qHlPbUO2eP400btynaJVa41CU7GQCmPk6/JIQFh9tCVKuchVt7j3lbFm/xaXZN5RZaPKAn0XfTo6dEZ0haXoRgkC3g5gCJoKH5dBD0PhHlP+Rv7icQL4XdkEnFyC1NAp+4+P/O2O7ynhki+c7dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ec47991aso41823225ad.1;
        Sat, 22 Feb 2025 06:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740235021; x=1740839821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ha9BMrvAHN6SwbJadC6b0CtKwQ5jXGdHANNksS1/Vw=;
        b=KXnDiB5mTJfcq0h511Fc8SHFPEOmFWdfaQCCBikP7Ql6Oi6DsVkJJiHW6lZLjGMj6m
         7BRTBTDR3dNadTFZAFvrdbcaD5MD2KERi3aDEXqAY2bFj3qpDjtz/4opS9zLoWFx8zzb
         9n4XtcfQ3IkWO/LH/EZ/t+KsIMcFSgIBxFaxpQLjHt607TcrsOwF3SwbShcJLPsW/UVV
         7XIKYw6MnmlsMmSsw1pCyIRQzLzzIjcwMoDEDVP8a/bkcSId+3yx+S6QA/po4Krtgome
         YSUKMBEekhOP1yXl/OXX/3e/gvaKJW/oyUKSBZHjOfRKboEOn/ww99o/qIsNOWaMoB6h
         QMvw==
X-Forwarded-Encrypted: i=1; AJvYcCUWNxYmBA//EcM7Dli76OCTtv35MOcaiAKvzEjtt5SKxwDu5ODquZ3UGwZxoLmuvOAHKCgqxZd8L8TSOm4X@vger.kernel.org, AJvYcCVkf9JuIhiaqVEquEEKb0epuhaTaeW4m+MpH3khkFXdbrE66ctlSO0kQ37jn6x3umn/p2xxa4dLe6JN@vger.kernel.org, AJvYcCXCKu1i8O3XAXeKltlIbr4QjO2PMoRb+X/krDMgH2FtBzFkz9PHoQIFNycOkCKYyoCwKmEzNlhSUWH9@vger.kernel.org, AJvYcCXHlu+sLras/nWQ4u3UCS0s+D9avsNk6HZkYWUIFk85LR6rWu1+6+dt/udfoCAA1roVJp1XJoWiPFHsoSOc2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDFot+hxB/BeKz2IxADubHjX+jcmaHTzjqDyAHxb0PsHIv7ye
	ojWlqMeDyjbwzfEhaG363qQJlK+GgLcSS/yrqNd/dZC7EHbMhstX
X-Gm-Gg: ASbGncuUzU2eXSTr/mwn3psPcvXkcoUDq4FBd/umBN1h1S24WlNYjdKmKDkSxvvIW/u
	lRyrUwzi+q4zyTUtm5DqjBtTEW89lshPuughZ7iqM1FKeEx+cK/zB93CKZUeyySQdhVnO4BWfVu
	c/Q2PLKZu9Jy4811Pmn7DePHCiPbqvkI6sOBYesAZN1+MMMkO4dhwoUxXkJ65JS0cwBvfu9WYzW
	FRJwYK2I9r83Gxx+wxZZPKR3R50peNmzp65BS2wIZsmmBGXCGKItLI1MG5NzPNtzdAoAaWFyBdu
	myds+PMuvojBChckWq8PvqWZFpLAPo7nOMBoWi747LD/Ex9oXeyPo/fSv/XY
X-Google-Smtp-Source: AGHT+IHgKc/pGbPqNt3bHHVA5eMyaWuH1nFpTLjpun4lMNQr14INrEnAaEobHgO9YFDinBAfQYGiQg==
X-Received: by 2002:a05:6a21:102:b0:1ee:d2d9:3515 with SMTP id adf61e73a8af0-1eef3dcc4ecmr12552295637.42.1740235020887;
        Sat, 22 Feb 2025 06:37:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7328619e138sm10884166b3a.66.2025.02.22.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 06:37:00 -0800 (PST)
Date: Sat, 22 Feb 2025 23:36:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI: qcom-ep: add support for using the EP on
 SAR2130P and SM8450
Message-ID: <20250222143657.GA3735810@rocinante>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>

Hello,

> Update the incomplete SM8450 support and bring in SAR2130P support for
> the PCIe1 controller to be used in EP mode.

Applied to controller/qcom, thank you!

	Krzysztof

