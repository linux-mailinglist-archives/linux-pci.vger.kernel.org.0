Return-Path: <linux-pci+bounces-42597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76BCA2196
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 02:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D24301F5D7
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BC2222AA;
	Thu,  4 Dec 2025 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AP+Vz5GY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED1221F24
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764811662; cv=none; b=cM+nuCz5Z5aLO4RYpN8gl+QLtdeeiXLJw/jxbTbXd63N2caFa/vWwLGonOULtpErltk4y8BKv2RnpCC/pnrbSQPxCwRjVxcDgM7QwbOah3Xh+ShEA8Nvu05CM+1S5pGwXHCNdei+uMyJzmDNXd538JJYg6juxLKgv9qJ4s/D+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764811662; c=relaxed/simple;
	bh=caI45ddFp7kt1eiulmsrdTdVREDPt3hsmYyUZLW4NTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3RtPlrNp/zPTWbXxXmEnvTJIkoyrS1iiyDsYBuKAPDQWL8609dJDbeyVylpCYHEY79tMQ0q9v31d6IbdS/VlKwNyFh97jzv6fLYjanjv/Kcu1iIKrQDFImTvC/zYxEQmLU0nkYlhOdpzPpWkohFSSMMa4KJflyycx+6VlOdY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AP+Vz5GY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso225860a12.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764811661; x=1765416461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XAHtRoQcOO7NiXo5ZlsacuTJK3Wmi01LBywsFsm8Aic=;
        b=AP+Vz5GYhac6gmwq2Oc3OtC/+YiFyQ7QTtBJlSuzAEzD2KB4hhDuxd89U0yLJj9h3M
         GSonvxXquhkjjB8+0SXwUe0fvoJ/L2prtvShb9u9C/m57iZ5TY3Dz9T9b17yKGOowtBN
         NdvNJ0jVPf64OTLuIO2c6y87C2+kfMyguQBuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764811661; x=1765416461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAHtRoQcOO7NiXo5ZlsacuTJK3Wmi01LBywsFsm8Aic=;
        b=ffiQ7/QTdM5jf8cRDhmATkG12qxS5qMsG5oGfXhG35w9++QA9M0UV6/39IzzcR3Db4
         NecSoMBVXcTbtefESKq/ZTBSH6rXytHsX0vYq/OV6079Kh+JhS8i6Ih5SDjtSBYL2Lbn
         1lUwl0O94Il4/MTGnTZzoWsgI5ttggshW3yUt4p/E9S7NKsvc3zUjrDJAkdWsxfYvvbR
         2ehf9M4XfT/0tWKa8MdaqkY6xVoqOyQfXpHSV8xhjgUnOfdE7gl1A6d5jsGATmEFsbE+
         1hVFKfkzibKr4tRoekrKm/IagbmfCoetWY3qZb9XFCA6qrHYAoz+Vsn5vwjmYkS+sLxi
         YTVw==
X-Forwarded-Encrypted: i=1; AJvYcCXvjAgz5s5X7zk1rbKz6uHNqBI1kI/eh3+aCEcCxwN2h1ExyQdGkc/lQv9tGt/IaPIL3ldBtsCrpbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsoAa4iFVD5Cm7pHvvgHPhb/9vIe1QP4mxS2aVyjlTi6GOqvU
	0e6jpCCBIeoOwTlpe9M1Sdm2jfJ7nsqs0+jJObzwD4TC2Nf5BNq9jYY0glmNZ9SV8Q==
X-Gm-Gg: ASbGncsVtI2Lwmv+bg53bKUy+zD+XrXqPzH7AoKl9WVxmeDo1GI4VXLJGknw/eZfM9A
	Td0lluWvoT+gT6cDANVmKdQPrwsZlG3zdOldA3nQ92tBh9v/APlYGI+yvhDuVvJ04J5c/rnU8e7
	tzp+ugArzvgY80yLSkykXzk6kOY691XRdMkAqzy+qd5QxsCQvWJGoNO7eZ6cszvK1sTOCYDl5wf
	PoNDfMmyLg64SZ0LLcQ8sxu1+JmDuSvCUJYutOH3cpJR5kU+Bg0m2g6AfLBvc2Ns0fwVvsdQVAo
	UqRbcIj5gcXdU84JAXzdKCCFq2m+DROKX2evTwT4CtfMBrPXZMx0DzqBw6rvnrdHHEOOUJ8Otbt
	5WD7HSyHhxSZaxuR+Dp6HqznkFvqH+rY6ZAt9uJTPuynx/J+E74yWHUilPd16qwpUiBT2HwO7ju
	5g/BfzhuZRopoiMIusqb4Wozbcy4hMgnUxHjiZt0mcJmUVIaob7A==
X-Google-Smtp-Source: AGHT+IEmVrLEnwUtLOLcC4IYa/+PZl3WtmNmhtN08fPYo+um0/KXKXOwOqQoGis6U4DMtTDFddSBKw==
X-Received: by 2002:a05:7301:f2e:b0:2a4:809d:9a8b with SMTP id 5a478bee46e88-2aba44fba7bmr708793eec.20.1764811660700;
        Wed, 03 Dec 2025 17:27:40 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2aba8395d99sm991052eec.1.2025.12.03.17.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 17:27:39 -0800 (PST)
Date: Wed, 3 Dec 2025 17:27:38 -0800
From: Brian Norris <briannorris@chromium.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <aTDjihgJgKAw1nis@google.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
 <dc8fb64e-fcb1-4070-9565-9b4c014a548f@rock-chips.com>
 <7d4xj3tguhf6yodhhwnsqp5s4gvxxtmrovzwhzhrvozhkidod7@j4w2nexd5je2>
 <3ac0d6c5-0c49-45fd-b855-d9b040249096@rock-chips.com>
 <aSlx91D1MczvUUdV@hu-qianyu-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSlx91D1MczvUUdV@hu-qianyu-lv.qualcomm.com>

On Fri, Nov 28, 2025 at 01:57:11AM -0800, Qiang Yu wrote:
> On Fri, Nov 21, 2025 at 12:04:09PM +0800, Shawn Lin wrote:
> > 在 2025/11/21 星期五 1:00, Manivannan Sadhasivam 写道:
> > Could you please help your IP version with below patch?
> > It's in hex format, you could convert each pair of hex
> > characters to ASCII, i.g, 0x3437302a is 4.70a. The reason
> > is we asked Synopsys to help check this issue before, then
> > we were informed that they have supported it at least since
> > IP version 6.0x. So we may have to limit the version first.
> >
> 
> Hi Shawn,
> 
> I checked the IP version of PCIe core on glymur, it is 6.00a (0x3630302A)
> and iMSI-RX still can't generate MSI for rootport.

Same here, I have chips with 0x3630302A / 6.00a, and MSI does not work
for the root port. This series tests out fine for me, so:

Tested-by: Brian Norris <briannorris@chromium.org>

