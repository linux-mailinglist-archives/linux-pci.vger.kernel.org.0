Return-Path: <linux-pci+bounces-21908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF41A3DED8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312357AB2C1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27F81DE4C4;
	Thu, 20 Feb 2025 15:33:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC151D5AA0;
	Thu, 20 Feb 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065623; cv=none; b=o0G8oQRK9SvkEnnaRll77W6Tc82LkyMGNnHSbjODvj6tr+JhUS36uEdtBYx3UlkHIJx5IjKmoag3UrOlociQrtv0aGh6AckllC/RyWwl+ekU79lO9z5XaImykIBhkRErcghmVwpBNkRkea/hJMuSvA7llYFdrFzC8GkhW+8xWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065623; c=relaxed/simple;
	bh=sf36f2W8jJ8MdC9oTXglCoDz6cA2telgyEFjOGRHKgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVfverfm8nZR4kuqfGdzME3fu/Jtu2Ok7vD6wEfO/ORQrLAAFHDFdfd4xSfOUSRmTKPnjpQz0VWNNZpiubZkqBdLq6ef3ANjYQNyWsB4l1HJ5ELisCWOdWuutnBORKp7Xp9YCyLhTq7q4Fkx98wSo+ybN9cHz4pcgOkbCbRbw+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220f4dd756eso21640165ad.3;
        Thu, 20 Feb 2025 07:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065621; x=1740670421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0lXhDdruk8QUxXL0q8NP6qP4JGCF9C8FeXdpXFohxU=;
        b=cTM61NfoKQ7pxCN1PAi5GDfxpryLPvdCTVPSe8trtewx59fL+sZ8T6MeDAPU8TJtwP
         ls2+jquR0b4zNLkPkzJgEWheUSuW77VpWj20whs9pWAIK8ZTgGifAgRvjc4t/vXXCd2l
         uZyOKoPMxCk81dbTJa+/wE6Hdlj0gGdvgJxkBsbMUrkEn9jUlC5YMdj2FctFykQw7auV
         7TtEMECHnCIH8lpRq21YiATUuj/1y7m0AmTujFgVQaiX8sYgCUIiknLA4AiRnWb4tv2N
         +OD7kPjkDg3BV4jik/umrhF5+O21ApQIzg8b04J+yAhXy/lWHaL50sP0s2XCWsauzgmH
         Oyaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfW2UWARiMH5y2vbUmFl9uSIfqK7WaO8dtPX/TutqH9mhSzW/ZuOkyhBD93appcz6M9hMzXVfhH0FH@vger.kernel.org, AJvYcCVixLBhO3Ha5oQIK5JuCNEnaD3c5W+7YV2iWAXPhltYJn7aM/RnO5s2PCqqApyhEx/quNXesW6oaPf1CfhkwA==@vger.kernel.org, AJvYcCWvpnHNOqYb4QeGFHLerARoqkWKpB5Gm1uewGQYIGl9f8LJ6ICJpwaZ2IE4IKyws3O1cnFmTD6ZDTsIdfC0@vger.kernel.org, AJvYcCXI5iJ8TAiFRelUv7UBXr4HtTcg7GH6vM3jfZlsScQ2+GpRGVcT7recIrTm2bszanz0K2LeaMHxeQsF@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+rq6OacKeZ2VYZ5DUpqg1q8rF/FXiXHQDnESz7kpHNZRsVhG
	+EMzUp89TF6NXXgVDsHU/96e8cS09QyxdMQjOvN8L4faajZHqQg/
X-Gm-Gg: ASbGncuoFLdBJidPvGs9yqxCXa+UY/vo+G9/YCFr3P8j8JEC3c94E+vCkzg3KBA4r2J
	iWomkkKLR1i3eTJ65hwXvvjGxte0vumdUw2mwwNHCVlBUWrqJBdHWsKvpDkrN64WgRARC/UXMS5
	tN1p3toEDbtKMR4nMsik9xp5Cj4k72jy7uvbFcr9PdJ3j1uw75s6hmsvwR5lZmw5flPoN5777aY
	3+HpGoZevpcVWpcMhbtWSHLyHHPZkK+cymM8YyJ62lZSyHjWwMnZKsESxCuvwIJ/oZ2qK20/Fmt
	b+rMiKjpQf4T6xGGDyHh71V8fu/aTH4d6+1FfvQ+OR6MBxz5Sw==
X-Google-Smtp-Source: AGHT+IFbyXv/IUOI5OO28alBQP35ioQSMOeP7pKvdALLP7ZoBNdNEI9ro/4JO1qR1JaXYM8PNyI/gw==
X-Received: by 2002:a17:903:2cb:b0:21f:6cb2:e949 with SMTP id d9443c01a7336-221040d87c9mr358153305ad.52.1740065621580;
        Thu, 20 Feb 2025 07:33:41 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fcb8571586sm1887051a91.0.2025.02.20.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:33:40 -0800 (PST)
Date: Fri, 21 Feb 2025 00:33:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, stable+noautosel@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <20250220153337.GB2510987@rocinante>
References: <20241231130224.38206-1-manivannan.sadhasivam@linaro.org>
 <20241231130224.38206-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231130224.38206-3-manivannan.sadhasivam@linaro.org>

Hello,

> On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> cannot change the type. So mark the those BARs as 64bit BARs and also mark
> the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> use them.

Applied to controller/qcom, thank you!

	Krzysztof

