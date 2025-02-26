Return-Path: <linux-pci+bounces-22447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0205A463D3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31CB179F1B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3ED221DAE;
	Wed, 26 Feb 2025 14:55:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCD221736;
	Wed, 26 Feb 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581743; cv=none; b=uFA0dKg94Wr79ecC6Zr0JEo0ZFuLwfmVvpymObJAaNL7P/iPI1kDEnAPmf+9jlsxt1y8HTa6QGRyfNDysu25D28cSsuYWzQGSj3LNekN8ZajkNK4CDxJSHuul2EZj0rxI00D4urOjbim9RisRvTOuZZhSi5xcenWa7q7gdphK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581743; c=relaxed/simple;
	bh=kqe+6WP8zwuAM8lStwswFPaBIe7m1+DTxkz3F6unuCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVAL1NGPYylcy51VEB0Id9udYiAqgpY79q1XJtsCbpCmMJpx1rkWfxSsIHGeOxp55+vYIJfbAedaWAxeOhCjbW8zMexaR7J9U6MqCDBseSAeNZ408jjewx89dpHqIIPjR3goJqRWulg0EdhctlTWIb8Ip3DKvdGRibhVAYkMmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2233622fdffso13127965ad.2;
        Wed, 26 Feb 2025 06:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581741; x=1741186541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qygdnn8/rGb3p7MtdeT/GcR8Vsv7irPMGDAbFAo9qWg=;
        b=wVftFEvIU+SPPR6OVdvlIjsuOXVDDNHiB1panqSR5eoC0X7EZoU+xCbVxPIReZSJeX
         iNq7b1s1HpSYNd+wWli1YwP/Jp+AF3a0gqp+AA9QNHZIfBc6+Db1jKeWnl9Fu8ulTwLd
         WR/u76D2J4M9MI7NuK1g0ZcB7upRB0EeWSA8bvD/qyKw1qO/hUG8zmI0/vI2rjgvo378
         1xfaHtLo+cVBJjkJjhITNAPH+YPfScQiRGnuFkSvx2TaoushX+vIdw08oozhmH6CDA84
         mcwdggTSy4wZUaKoyXWRUbyxsZPzlHg2f723u9mGSjGboxoKd6GimJqnmDLc0JApQru0
         SHTg==
X-Forwarded-Encrypted: i=1; AJvYcCUhsQVsfQaoOQ5ZeT2yIYfQebBpSlvHOjbRVizV9SwatrBShSTF97nLO5ngUUm181z/A39raEpTplXJ@vger.kernel.org, AJvYcCWtRCCqNVcWIk4BVRrjOJaKzHG4LIM+x3A61jwRnIPanTdVxs1zc7vEQe8YztBZANCAvOeNcfXUFbBqynz8@vger.kernel.org, AJvYcCX7nSJrNm9watK4L3sW8nx05SY/3VRHretviFD1z6KvbVSo9sn1WUnmfaG1r/ehnv0MNAt+imTqn0Yn@vger.kernel.org
X-Gm-Message-State: AOJu0YyHc8n76jQSr2mDOmUy538+GAVgiU0p9bWR/0ftK2nyXVPpSJ+P
	t9zG63SHZHIoTD7zdbOJh90PBE+scmrATAIpGPgzqW/ue/yrbFzs
X-Gm-Gg: ASbGncv+XdAcMVItF7hYESmikrG2SF7EjabTdxtZfeSuHS3jBXg94QALBt0tJKNgIs5
	+n5DtEmCEisH78XjIeSuob9aUUdSpWLcAvQpaCk/kbrtsP3CJD5XZDucexfq0bk5nnYdsxRimo/
	C6Yju+WJYxJwgcuRYRnirbHULH/vDRmW0TeOJvewWlHHIST+wCFDCoEbYho8PQ3YaT1HfSNpyYX
	yCT/GIRIpRJe/XtVNVR3cYMbibEpMjBu19a4p7y1K1aCdUB8WTMukMcGiSIKqXjZyc0l3YapOU4
	8ReerGQxr69miNRycsgj/IsvfGxDdUFKzxZlH+/veGAFyEjPohgUb1QpbKsD
X-Google-Smtp-Source: AGHT+IHpReDZSPPm6VjjIZPy7MkI2n87DOyqv+KvtWFP7LuZsR9/Xzl8+SaiWZs9PmK6WFRJ4senxw==
X-Received: by 2002:a05:6a00:1709:b0:732:2967:400 with SMTP id d2e1a72fcca58-7347910977emr12444159b3a.12.1740581741225;
        Wed, 26 Feb 2025 06:55:41 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a6f761fsm3544593b3a.47.2025.02.26.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:55:40 -0800 (PST)
Date: Wed, 26 Feb 2025 23:55:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/3] dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA
 interrupt
Message-ID: <20250226145539.GA3691935@rocinante>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
 <20250225102726.654070-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-2-alexander.stein@ew.tq-group.com>

Hello,

> i.MX8QM and i.MX8QXP/DXP have an additional interrupt for DMA.

Applied to dt-bindings, thank you!

	Krzysztof

