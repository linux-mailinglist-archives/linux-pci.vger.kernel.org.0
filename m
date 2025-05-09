Return-Path: <linux-pci+bounces-27473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B03AB088E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634E81C20106
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72963239E68;
	Fri,  9 May 2025 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcQQD+QO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2932397A4;
	Fri,  9 May 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759903; cv=none; b=EgJ+o+2hzFWMusvQdcVIWA6BjYO+ncYydegIBlrCpQkrGILwkYqaSLYCmimzW59KtlkJQst7aGPtboVrqH8xllup5XUk3pdPYLmFbPG33CzpXsvqNXxemAeSxhHIpGbOP+L0nHxjxPoW2Z7gmBSbPior8yTSvJXg+OAK1DpxwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759903; c=relaxed/simple;
	bh=4t2Ei0gDk5QvwRDY4Z4sHn1iXc6O7O7DItvDoocJa0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRzOD6os++w62PUT4uATOsK5FHyhqNRtbVc0yq98/ZK1q2s244zNvPAjxNq6WROpT+oVUZre8UuY7I7XNoNG7alqXLsLKnx6o33xyTslDJRWxW3QFdKvook5kMsrpretac4AQdYxY2YOWJGrPXHn1MFHLXOUddpYZlgEiRktqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcQQD+QO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74237a74f15so832870b3a.0;
        Thu, 08 May 2025 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746759901; x=1747364701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4t2Ei0gDk5QvwRDY4Z4sHn1iXc6O7O7DItvDoocJa0w=;
        b=KcQQD+QO0KThFKvvKdZTplMCQQzEkHt3OTL1CdSavlkvbez5JprTnrmerhmyc8v066
         V7RCrK4OaDZgielykSpI9ba96hPmbDWi3EIvCXAaQGlfGQur/MVnr8zIXC5NI1/WxRlf
         Y2eJJYz0Hh1183Vx9QZoVQrwNfcFWGOgwRDGyoRKaNBbpbvzUHmvrpl4Q6rvzUCcSHbT
         KuvdrgbQeu3PBklo+l1ELg9RciRrguXrH46A8wq+2p+fdCxz3Eq1ffu5AAH1sj3fUGOm
         NwDrXMT8d+Z/t5C4L7GmUHDiKH/UECJG74nd+wGdDbeMTy7OSkQ79hbEwMN8ECEeDSzM
         xXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746759901; x=1747364701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t2Ei0gDk5QvwRDY4Z4sHn1iXc6O7O7DItvDoocJa0w=;
        b=ZnWfefEUpnyCqxjv45OdjxAal51x51uMV4hI3QI+4xugNj6FbvJCD5SIS1jlqMAMKN
         DbInC6DCVtawm+DY69E1oVidZudwnsgecpsuGSTiX2DrPHVzHNn1ZpieoZOpSgkc1S/K
         Sf0W9eDOUpcE4a/DLb0XML79N5Jk9As3eFzBCh6g6rZZe/7Nj0AEuETLDQ/KbzE/0k0w
         1UYB7iE1lIkZKT9CyB7bEtO+YwU9y+EaKY/maFG4jSZp8NSN65h7dDz4I7G5Blnj45Tk
         iHV82ewPSFeJUkhvuCh4/MBiVu1QPkk+m225kW+U/QouErX1fuTudldiBIZU23QLzzRw
         JP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRzCVJJbM1CZfsR53luairKvaNHCQ3nkyf5MjuxgT6tbyopa/w/ug2oZ9pOMAmtLljmXGcpkqMmIg0TGun@vger.kernel.org, AJvYcCWq860QASEA7Kq+sRUwI/SkjHcWWq0jOCC4lQQTBJGd64qJroq9CxiPdSc14W750Y0VUEf2zczO2/VV@vger.kernel.org, AJvYcCXMKjwUvHavnbVfPw3uOCRBkIwxo9q579BGM+OJPMJKA9LqQtbML1rRXd5nrroCipPmHDcoJudxpAP/koQM@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaoDHAV0RlK3YXCIdLLUnLZKIibwFVLRvegkzwadl0wdRZszG
	CFdeSU+HDLmiRFU3pjU087pxhNMA9BOY+YK5RHITcix2QEX9Lvo3
X-Gm-Gg: ASbGnctVd+atzMdw+KYjW0JQl65n3h8r1IbB51VMI/1FS3iZ5NGFy7lxD49tWvBzyVN
	pLrPWqr0qINK9oW4D6XW+DGUQW7MHsCYpA1bRsU21UJC2E6QKLoACvQXcf8fxqJgzQGM2ISkklY
	Y8lRnkyimoUHisQgyLtBV4rOrE2d1YEqtRK/IGRQFuDVDIWRdSvGMVZMwECeTiMTA2jUugJEJ7m
	X8Us/2ysKL6JzlPSTWCYAvOOkHhikI1Ix9NBXVdFoCDALu4uHvrZyxg0Pl/FWXSOqhqG31nxtci
	tPaG34ONasDN1NF/6aGCp4Iu9uOfr89Iix13G1sTiY7KUzyCTf8zz+s=
X-Google-Smtp-Source: AGHT+IEwAifDsncJZmqJw68TT82q/qBue7rdP4C6uwfIpHf3Dur7C2E/ejrTbFWgc33C/qpZMOKFqQ==
X-Received: by 2002:a05:6a21:670d:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-215abc75623mr2418406637.35.1746759901018;
        Thu, 08 May 2025 20:05:01 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0f141sm775938b3a.117.2025.05.08.20.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 20:05:00 -0700 (PDT)
Message-ID: <09c558f2128c5f8ca1d4e51b0ba04646170d2de1.camel@gmail.com>
Subject: Re: [PATCH v4 1/5] PCI/ERR: Remove misleading TODO regarding kernel
 panic
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas	 <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kw@linux.com>, Rob Herring <robh@kernel.org>, Zhou Wang
 <wangzhou1@hisilicon.com>,  Will Deacon <will@kernel.org>, Robert Richter
 <rric@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,  Marc Zyngier
 <maz@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	 <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Date: Fri, 09 May 2025 13:04:50 +1000
In-Reply-To: <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
	 <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-08 at 12:40 +0530, Manivannan Sadhasivam wrote:
> A PCI device is just another peripheral in a system. So failure to
> recover it, must not result in a kernel panic. So remove the TODO
> which
> is quite misleading.
>=20
> Signed-off-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

