Return-Path: <linux-pci+bounces-19933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312EA130E3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6010A3A5A98
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33BB2A1CF;
	Thu, 16 Jan 2025 01:44:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958022612;
	Thu, 16 Jan 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736991894; cv=none; b=SVjFBACSGnvBDJPCHD3W04aDJX4E2yFk/uBaYNsxf2pW1aIPx1Fk/BJpU0f6eFOxi0axmT84YqM7CchCfqDYCe5n38OGXP9bBL49Qq/PV0yVW5zJrUu6Vrr1Frfjde27yl4dx49na7WlXWg7TTo73A/6S+0qtPMA5SAoS5a7CkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736991894; c=relaxed/simple;
	bh=4BUCba/+fEkyAPQFGiidqmmL2WMf8cW+5Cxd3Mv84Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUybbsI4OhlWXz0h8K5wyIp88vxiK4ViwtQzvq5LvBoc5ihb7wSsl/EQ1j1eAfMjCNlzQHe4GYxDa1UQ2RBSQ2PFvJCIHgPHjVz4FqSFA+eU72Jhfhg4evtcYI8U+TdLcJpQ8/tTm8pOZ+W9YDfAugU0ABKVDBgQlIL8gXfKgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-218c8aca5f1so8218695ad.0;
        Wed, 15 Jan 2025 17:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736991892; x=1737596692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IxnCSmHJcqdacHXHVn26Xp3ngLM6GH49N7wfCQU1L0=;
        b=alMljgyp9+LbTkGHgvYIuY3+t26oqYQCpPZZ8UDLqVM8Fd9kO9/cHk2iFFpkNqzM+u
         vfp5jQH9EaN2DzFz5g2hla/F1g9NnuK7QQugNaMDN9KSklO/TXczyYnYUpPV/ojhCy+D
         1MvHWj2aDCiDyc3YbksV1HLwBUfHustJgJ5Sf/l9UKd/bDMc2GHqvrhWPPZlAWV4ltnW
         3+Z4XcHmNlFSV8wOL0DQg+h1QdxDrEABvwcYPcgNuWFm0gaMbxhAXcDeVFsKg3lJT4fM
         i/3vZBxeGhNWtONN12euPtIw2qv75+Q3vEVpd1ebTs/LTT+4XyZ22JpM+J4P2DDIsw7+
         K33A==
X-Forwarded-Encrypted: i=1; AJvYcCVNHoWwKA7kXxZ0SMjMM+wLI69zC6si+Xoc3xSMN1SOJNhn84vik58eZ4g97yQ6KJZZk5epajQgpp9z@vger.kernel.org, AJvYcCWflUDAzSmTQTe1uLy5bP8CPqoiBXZ77V+RS1CUVxHQ3aNv9HHdAcW8RckdTJZo4J4CdmgT1QfL6mPj@vger.kernel.org, AJvYcCXZJ95YQgSJlWJHL0QgOAD3oxvvbyRQcV1tQ7xSVyiWKT9tdBfvtiKLu/ZcXPgwNKNKtT0Lk/JiM05e9ZRa@vger.kernel.org
X-Gm-Message-State: AOJu0YzZomX4F4u7P/Vv9Of5H5usKQ4VkH0zLwXCEx2Hfqp3haxHTn1K
	dxlRsPXH1rPLRkKEeV7RKc/9hyC1is0SywgtL8gd6zZ1aC/atf26
X-Gm-Gg: ASbGncsxYlLK9g9wuClj/YCh8HBaM/upOnmw7f1VupiQ18LouVsEnivN+uE5B/ZAhdH
	FUYKPCjarEvFDio+qvm9dlV2f585y4K8Xq2uWHonhJz+pSWtaw6uF+csm3NOtW65PwPA+a19/GN
	L2+Py2LE5G6nCW216pkJs0sAa664DHmpOYExh8sT27wgZfjOW1nItSEJ9wZKXc/ajM5jkN4hK5P
	96vgOFynTnCkHsjAQehDaz5nEtQzx9B+YhbDxawCO1YBA0CVzUTehMXxvbQDAPDGTASX2BJ+VSU
	q4AEwUAYiEOlSYY=
X-Google-Smtp-Source: AGHT+IGGiOe+Hpc0pTCxovPJPJMYD6+JInJoiYZN0S/mOekGvxlc2y5Gy3dg47SbKjnI78xknytLhA==
X-Received: by 2002:a05:6a21:328c:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1e88d18b316mr46931346637.11.1736991892554;
        Wed, 15 Jan 2025 17:44:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3130d2eea3sm10500937a12.0.2025.01.15.17.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:44:51 -0800 (PST)
Date: Thu, 16 Jan 2025 10:44:49 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kw@linux.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Message-ID: <20250116014449.GA2111792@rocinante>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20250115130406.GS4176564@rocinante>
 <20250115130609.GT4176564@rocinante>
 <AS8PR04MB8676BD2E443B72DFECAEFEE18C1A2@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676BD2E443B72DFECAEFEE18C1A2@AS8PR04MB8676.eurprd04.prod.outlook.com>

Hello,

[...]
> Thanks for your kindly help to pick up this series.

No problem.  Thank you for persevering.

I apologise for letting this fall through the cracks.

> I checked the patches, they are fine to me.

Thank you for double-checking things for me.  Much appreciated.

> BTW, I saw the dts patch had been queued into pcie/next too.
> It's better let Shawn merge the dts changes after the driver patches are merged.

No worries.  I will drop the patch.

	Krzysztof

