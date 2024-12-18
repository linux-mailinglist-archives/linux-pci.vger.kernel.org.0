Return-Path: <linux-pci+bounces-18741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DD9F7123
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7548162FE2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60681A23A4;
	Wed, 18 Dec 2024 23:51:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745EB192B94
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565872; cv=none; b=AAcpsfbcJxpLZj16i3eTBxcJUgs8xIwsvyX+AkRMqMaYpolNyycct+FmgRm80g853bedHZR/I+Szx/htxksSoCFYjLrsA+pFAhrb7rz8gZETSsO5C+e9tJnjiFIHaxYTMA7KRpRLxQR2xvvG7bgMy6KBQOsQz2r2Kd6brYVDhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565872; c=relaxed/simple;
	bh=SoLL1PnzIOe3iAquh/i8Tf3FCq+67+DOEvcee7IObns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMQ5wT09C0kAGImn2QQRIYHIe0SGvXQKSSKXjOkjEJ9uZvHHcIKf52ohzKk/C7RAwl5Kf8NkDuLGEMa7TLxcdMzXpC3dff+oIUVh7v5d5/YRQUz2d7nM/MTFv4hygPZP1VfXwXn2fzEc2P3Q9rAlTdSfmmr8lMh7wYEAaEtHEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21683192bf9so2319085ad.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565871; x=1735170671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzN6KUH/XKsGdxwRVNtcBO01x87zR9xQK6xk+fqGvUs=;
        b=X6M+8ti2ZUCiiQ/Imy8BuIORfPpHOAiKPIF70CkMZu2I66/wTJjFEX4bDw8rfrnGv+
         sgBhY8H0xb9aoravyQmgJvuXfMLhX+GYvH6eRXKAQhgjVYecPPHT0QlaqXs9P2abMfpj
         hH0+4P810HRezqsdNjn4rmVecxDmyD826nR8MKGzZuBER864xazfGkkr55frgNVCHHwx
         w3mBGM4puKrtZ24MqgWWtVRfqtn2QJFH5wu3+eACvOoODL2RC3VuMWpPFLthyTmPQYV9
         L+kXYL69zW38gaaN2XKM845tTag4xMDSGDc7poAORsTfX1y1xBlIsvvpzdexpnf1UTy3
         Ny/w==
X-Forwarded-Encrypted: i=1; AJvYcCV1FA+05Hs75kP+Td/zxhZeKtrlZyOZ8nbhQ75B5LoNallFH8Ag9AtyOc94SU+hh6xHQtcIPizQoVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTY5wPxRISIPrmESJkQBC2qmOjV6J4Va5sUIVFxZjcfoq3Cn1
	euJOVHtRaKV2n30eVcSgTeYlo+0R5/8Y41JGMxdKpxO4EkzxBN0e
X-Gm-Gg: ASbGncvC03AbZ1UrJHkG//v1nM4KUQjbB0pDTooZQ55pfmebofOXZHzYtO9SZhrQdEK
	0ntt8FDZYoPslWA4EncAq1qU6e5hbeyKWwjR1p1vxk3PYG29fbJ92Qj5Xyei0oGTii5lPEwgjnr
	xE8XQyBoOxTtHc7JqCMrMW5hnmbJn3HDKgyz7lB9M2cLYJgd4tDp+XHPsJpisR9EX7Ic2MT8Wl3
	UCiR4dE63CJq7/scGz/KHdYPKy6ypLSawTf+LARL4gShiLBrcQA8m25p8f0ReoAaDfOeeUbc7jW
	ORvidOF4RNBlz5U=
X-Google-Smtp-Source: AGHT+IHFJ3Hex4ljjhn5c+eO+B7dIt/GY54A1+OZE45PAdShXvKAxUHUtqC48IvWHlemfT1Z4BJD9g==
X-Received: by 2002:a17:902:cf0f:b0:216:5e6e:68ae with SMTP id d9443c01a7336-218d7217a47mr67380385ad.31.1734565870758;
        Wed, 18 Dec 2024 15:51:10 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d447fsm899135ad.128.2024.12.18.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:51:10 -0800 (PST)
Date: Thu, 19 Dec 2024 08:51:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Schnelle <niks@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2] PCI: Update code comment on PCI_EXP_LNKCAP_SLS for
 PCIe r3.0
Message-ID: <20241218235108.GC1444967@rocinante>
References: <6152bd17cbe0876365d5f4624fc317529f4bbc85.1734376438.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6152bd17cbe0876365d5f4624fc317529f4bbc85.1734376438.git.lukas@wunner.de>

Hello,

> Niklas notes that the code comment on the PCI_EXP_LNKCAP_SLS macro is
> outdated as it reflects the meaning of the field prior to PCIe r3.0.
> Update it to avoid confusion.

Applied to misc, thank you!

[1/1] PCI: Update code comment on PCI_EXP_LNKCAP_SLS for PCIe r3.0
      https://git.kernel.org/pci/pci/c/537470b7f131

	Krzysztof

