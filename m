Return-Path: <linux-pci+bounces-23256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4388A58832
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 21:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B113188DD52
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24621D3CE;
	Sun,  9 Mar 2025 20:36:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161621D01B;
	Sun,  9 Mar 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741552588; cv=none; b=jztF54n1KHzCxtvWh039MjWgZVZwcTGMoSRdve15quroYi4r4uKeGyohhcEnyDocxsDj+2cmxuo1lbctt8YDyfco1/znk+CY6cbaFXPyOMLQDqbaEX1MZXaud5z8xWpVGtFH3AXVdiSOhZdTGYArkrkOVSqFbjKY8J86rWMOgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741552588; c=relaxed/simple;
	bh=vBSbV1b6P8CXHisFotONcoU0zzd7se5BPST4f4Y9UVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzl4flAquPP/AupFzOM28vPrAVvUn7PZJ37xm+71L6CuwmjI+DMzTn+M0rCaFVG2dqCVcmpQZUxPyavG0fEjzgFls8YErlXdFELmITLyOw07xGJYfyhEl0P40ydjioo3gdAowoN/pG8Ym+sTd+5AODwGHKAqLwxQ4EPwNC3izTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so67535655ad.1;
        Sun, 09 Mar 2025 13:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741552587; x=1742157387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W1PPB8C5k9Rxvd4JqWh8H/eOLc6K5SLc+31IQB3dkE=;
        b=sPrBLR4O9TKWQfy3BvJ1qP2ETut1333DjwPxnTFFMJJ4CUka+n1cm92MJ5Y79YrGPC
         SyZak8XdZ6R0wrpt4zGlCRrwVXTGRy2+Jlt96358femRO7TjAhl/ZHbOkDg8B276jY3w
         oSs80o7w0hMxWiU+1a300LBqpwRJMv3Ze8bK0H9pz0TP3gQ+1XvHJSMD32Hx2TEiI3YB
         YuQp7QxgYwt+g+j92h0yy2ma0yIeYaE2FxEyhO+w2OeUx4jcGAwoTEba67LcEXMmfWiw
         zeMzTxNonyIEzuLRrqSDQaPoy8udDxbeikHv8EKbao5X7xibtdwMA7PDfFo/daUK8M7J
         KuHg==
X-Forwarded-Encrypted: i=1; AJvYcCVKjruGyRwmBNSusnUdwnUPLqYfKIYeTLLfP2b/uRRZdjDoZS3YrOz8fD/tXgQ4pXV97A+1hHLDHhI1@vger.kernel.org, AJvYcCWY3pbz/Ofvaby9B5yTEsB3d2ViqNfZhMlbEXj8EYo3gmP/1LUhItyQDicL7hUgebV7C+BlCRCXfESa@vger.kernel.org, AJvYcCXcEMc8N3FbzO+jtdaFtUmg6JTfVXumWLFvJa3xgEFkxMbCV/h31TAw0F9LOgvz5eS7sxHwvi5M+8oEwEtF@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSJ40P5MqsInvigh9CbKVlNOaB/1iPvpKuZRi9lEhPoFBURW+
	dVyHlF6cr5cVRJyhqldzH4jzqlmXWDdhChIhx2Fhos+QD3Q3cmU1
X-Gm-Gg: ASbGnct79E3uvBlt3Q1roEDcmoWU9PP8We/8SEBTCr0LaUZSgytH9qAx20pqct/6Qa/
	BTLpO1vF0KChUoprghTOFHIZqGqToWriCPtXzSJIUcBx0aCcTqwPHBSpTFW1Av8DmVg0lG2rEkA
	SPoq0+MnyT7NOGtc2WelC45vVbME/V+0KYKF1gsC0nJnMFAm2eIB71PZMLsnNspcQSegNlrH0U+
	bvCGpZCPzpPC0UqsuMx9rMXTBIBp28b2xedgmUg8hXkJuX4NW9WQCJ6bprd5xtIvifRElPvx1pC
	swjIvNTjs3mfdLuRwUHOyhG+flkk2QwwD0uugerI115R2j3B2Yxe0u74kWRy1YYVDhq5gYLSh1D
	qYp3nDJr9+0HhJg==
X-Google-Smtp-Source: AGHT+IHj2p8QQGuPQO35NOVEoLjztQAIUj/vuHS+l9hV6ZdhMc7VKvfvvYb1Hm2TLPNP1gLnAWZ+5g==
X-Received: by 2002:a05:6a00:4b4a:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-736aaab75e8mr14689147b3a.15.1741552586706;
        Sun, 09 Mar 2025 13:36:26 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736c30b3a0csm2793283b3a.88.2025.03.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 13:36:26 -0700 (PDT)
Date: Mon, 10 Mar 2025 05:36:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <20250309203624.GB3679091@rocinante>
References: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
 <20250226024256.1678103-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226024256.1678103-3-hongxing.zhu@nxp.com>

Hello,

> Use the domain number replace the hardcodes to uniquely identify
> different controller on i.MX8MQ platforms. No function changes.

Applied to controller/imx6, thank you!

	Krzysztof

