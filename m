Return-Path: <linux-pci+bounces-27472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B7AB081F
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 04:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBC65058F8
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B65230BC9;
	Fri,  9 May 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSsfACAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399F225414;
	Fri,  9 May 2025 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759592; cv=none; b=iowMk7OG6guFUf+EQMe/stwD3ZJcgF2972o2DJVZ65pr6Bw0bU6fOcivgx1SHIGajAm801Ruole0wQP09mcz6niSpgxFQ9euSQB4oy3Bgy6zFG1bmrfytuAP6cVH3pGRwAU2lM5/RGUsF4Ls6hZm0ZkiUr0BuurM3GDfp5ZkBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759592; c=relaxed/simple;
	bh=ZxQEcAvzVs5hRAXlrlOyX5QOnKVlWvMiWvM9EPXP2kg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c01F1R5y5tn18yQ7nR1y5IJGg1WfKDrU3uvHm7aeD8Ca3DYIDYoB0d58+GczrkMbERjDJYjX+aY/8P/8IUvPtQ4SRGckZNnWnrtVOWzvWz+7ILIrsZ6ODBfliMjwM80KGDV1LStF9bMKBnljahk1LMBf5o/wwWT9jnRAxM7pnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSsfACAD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e16234307so18894905ad.0;
        Thu, 08 May 2025 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746759590; x=1747364390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxQEcAvzVs5hRAXlrlOyX5QOnKVlWvMiWvM9EPXP2kg=;
        b=fSsfACADURkr4W1AJRkJNREhiC4FxKDFKCvgGH8wofaLaytYC5wGL6GM0OVuwp8WgD
         LLhQkX6W1Y9DdnvNtqDUH7LiNWXpTW5hXvY4h7vIUlbHY5XV8zAMf7gIWWUZvi4nGCve
         w65N/xEMlFeT7Ky+WnwuOrYmAemp3rKtSVjaxQL+wFkEDWeATHLf54JdvOfIT2CoSQFc
         y3HvNZHU4H//kcvx2orkcScZwDw+CT44iUqo3iu7d/gpC0PR71dzsCKGuZR2pkOkdZGL
         Uqsv6DliO7c7IYR4i2IHQDCztkoPyS7X+FCEr9ePeyjF384mM1h3kueaBi8FO0jlsSQE
         AOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746759590; x=1747364390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxQEcAvzVs5hRAXlrlOyX5QOnKVlWvMiWvM9EPXP2kg=;
        b=hdqnhj+OktT2UMDhOZLaQk7C4DZELWFI0ZTII37CQG8vCP2Awo39WbeE7kaYYXSYS+
         Ssi4Zkge7/k/nk1NIjON+NLWkhdBQn2xFIDZUscpjVBd8/E9QtH/Hq8HZA8s6lGYZEhS
         0VhQ3jgXUFqzuDs66qZNmain49qvf3cAiWwkKmV+1Z1Wdi8vgi6mfpEm1zCRO5RvKiMx
         lDO6e+C+FQ8KdYpj7ys/fLw5fxnIpIj9CiHkFUHtqI3oaWM9SgOYdSfpHcQEnEwTchLK
         El1xMbOmd4K61o4pwdE/i1iYNw3KWzg9ogGkNSNV/Tuz7XPWM2KkkaWNn8wa4LhD3ma3
         EHKg==
X-Forwarded-Encrypted: i=1; AJvYcCVkgvsfeUaJIcy7ZXtO2Uq8V5zotJJa/1dsZGx5yUo/93Obyjb2KVtiC2QFW/CeHc6fPJza53UHfQh//TXe@vger.kernel.org, AJvYcCXEV5iqkdMWBAEUuXlfFkWNVSOsOUIAlOr9X5rVJUFufxxSCO2kwebDMAfDRWmWMTQif+V0vmh44im9CCqt@vger.kernel.org, AJvYcCXm7uTnbgwrBc5+DYHej7Fy68eqybynfQnkPIyWH+ulIK1zoXxBPX1q98/9Gy5bWQrSkbc4MZMAO5Sa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FDmNy/TFdqzvtpq4iaDljRmJaO8VRSIB2cMNR5VVPUBEOB/s
	WwFwiddZcCkFBxeAd9rJtKqN3MPYoAjmM1jYsZ9/HOU6EhHQj1lm
X-Gm-Gg: ASbGncsWjWsvkbfQMB9d1vvpbc6C3ym8lCvBCb1nD9hs/AYWcmMZq7KnZOOQw3lf1YT
	ixPCZoNlFDdVbDWRXHFl+gCOqCooCdC8hxpb6pP4YnZXLjS1UlXUkggGjhCoa43HomQe2OmBTJm
	Q7SK9cz6sSq654iBPxJ7527a/I+yRix7tcLUgHqEU5DxJYZafITOsM86rU7pZq5h8B3bS75aS+H
	qHCHz5kpzksEa9Gn2Uppb+kVkFleL+XfTGkdWlSOKc3UgLAHEONKLRMpaotsk84hGl4mOzrBN3w
	hbJ5ropIZX97uqtZawbQXRP1XqjtNwOis2vWSRxJXUMvFNvn+eUVnKc=
X-Google-Smtp-Source: AGHT+IFKUhpmwc9Rxvi6M/bPhs3f04cu9R3C2Hy466xXe6CJzKmuEEz15S5GyyqX36uHXpmQGFCOwA==
X-Received: by 2002:a17:903:3d06:b0:216:4676:dfb5 with SMTP id d9443c01a7336-22fc93dc352mr25153235ad.21.1746759590482;
        Thu, 08 May 2025 19:59:50 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b216sm6976305ad.168.2025.05.08.19.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 19:59:49 -0700 (PDT)
Message-ID: <ad737e02dd4b7958ecac1d67ac2f3da7a238d012.camel@gmail.com>
Subject: Re: [PATCH v4 2/5] PCI/ERR: Add support for resetting the slots in
 a platform specific way
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
Date: Fri, 09 May 2025 12:59:40 +1000
In-Reply-To: <20250508-pcie-reset-slot-v4-2-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
	 <20250508-pcie-reset-slot-v4-2-7050093e2b50@linaro.org>
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
> Some host bridge devices require resetting the slots in a platform
> specific
> way to recover them from error conditions such as Fatal AER errors,
> Link
> Down etc... So introduce pci_host_bridge::reset_slot callback and
> call it
> from pcibios_reset_secondary_bus() if available.
>=20
> The 'reset_slot' callback is responsible for resetting the given slot
> referenced by the 'pci_dev' pointer in a platform specific way and
> bring it
> back to the working state if possible. If any error occurs during the
> slot
> reset operation, relevant errno should be returned.
>=20
> Signed-off-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
>=20
Hey Manivannan,

I've been testing this by adding support for the reset_slot() callback
in the dw-rockchip driver. Which has now fixed issues with sysfs issued
bus resets to endpoints. So feel free to use:

Tested-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred


