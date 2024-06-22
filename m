Return-Path: <linux-pci+bounces-9114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E789132F7
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896EA1C21131
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990114C596;
	Sat, 22 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+q0QeVr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35514A0A4;
	Sat, 22 Jun 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719051092; cv=none; b=WX9fwQKT+FApIT4mClPErLrEZp9t7lz4M2o3aILiBBdVUXZTH3nrQB2c1DRY903p/noAAlLhcpOgreX2blHsYShTYT3kG3e73zv7vn06on3mObC8Od6V2DG9DDpHPtP9DMf7k0ntjna8yZT+Dtg4Bs6gOHrje7J1aB/jjiLuHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719051092; c=relaxed/simple;
	bh=rnx3RZC11dVJlwD6hTQr41HzSK7kJvBsJ/oa76LMcdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTUOH4rlMN0rI9aZK92XUojdNczhQLrOJybbuBb8lG6mJm2fpLcOH9NCGuTtzrLgxK8RKlCdq9X6On0YKO3rBKdR8FVAYdvXdQqXFqll1395ngXMhRxDjaiDf5nrMiIdccIGBE2G8PZk9fHRFW4SB5rFnZHwvoqaTatiIrAxmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+q0QeVr; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so34246281fa.2;
        Sat, 22 Jun 2024 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719051089; x=1719655889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5B4zOxXEObeVuA7VINw2ILHjmpFBuMPZOmX3Ds+qSs=;
        b=c+q0QeVrQeIfyDpgx3qxc5Qah7a0I+w+p/4tf3BuZQsBr+Xo4krx9ZePxvDjL0AnoE
         9u7LYneLVw+wIMkgx0O3VTyOn2aAzZvI0b32GZHXjOAsfcuoQR8jzUyqPFAMVqXfITEc
         NHey6kQVjw3eBuXD5jxQU7/np/7kJIM4i0GmZU9TweMKNDWII1cQzz/fXDfm6P3GmaVv
         F6uzufedmbjA7EjQ/+1YchQdcs4Y2XlrZtGEAdj73S62inId8iIiFe5V7ITUUswcDpu6
         CTjD1nkfepKquszbFMF+oPN0Ri9q4sfQ32x9jjh9j/e5WtFzC3zkNDAOQZf9m5Rxf/gx
         Z77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719051089; x=1719655889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5B4zOxXEObeVuA7VINw2ILHjmpFBuMPZOmX3Ds+qSs=;
        b=v9d6Ng/mQnJ8y+lZfoLWNP+xy0fm4xwMiGXKX0f7tUPbN0dTD+GRUZ9y9KThmvWzIn
         kCt2Ex0ml1KXPK8Tn6LFlgjQbqTKcEn88jrorqLgtGnopNOqUR0BSKqTzxSIApjx+Ekz
         /5cExbiBxPkcl/Sa/jKca1tTPNxnlXqe1Cq3tAOhWPxGBYN0e5Z/GNIVHWljEbDtUnsk
         EPn5RfWr4NV9Z9rpaABio+rrH2EsQ1aJ0HuF4krD9kRZiikUnZw1jfxLn6LV9D7Ytebz
         Rh2PWbk/zlB3O2M2XPunKBMf7QairKbMGN/JuD9RQ3ZHSOZLxckLQh1vmCfVGUDL6lOJ
         LFsA==
X-Forwarded-Encrypted: i=1; AJvYcCXStJfa1VjiPaRKtUuNKZJ7X7hreG5URVgD9T7yZaZ4PydwM2P/OlUHgcvSgtnMggvFRBhG8JsEbih9Etem+aHDKVwDJlkMKxtJ08wOmLlVxCeVbzXhcwjbmKSHUzuXDEHwFZLgLgMWsrBCVCgnyfvaoTqt4RQm/lnM7zh/wy2PwuqxCQ==
X-Gm-Message-State: AOJu0Yx0sw8IrH48kgcxLlh7Gjvrza1vCxyiT4+UXVvlNrirMNwh580+
	btFEg1f5bayFBur/n0XmL3Y5R45nD02g6CUGxs5E70wNgogFczSp
X-Google-Smtp-Source: AGHT+IFNzs28ZoOZIPvpiDZrpqmyjo0o+8lqMGI8FW5cgkZ5MV2b6u4cUf/TVXL5AP73TGF6oPyDMw==
X-Received: by 2002:ac2:4823:0:b0:52c:d56f:b2cc with SMTP id 2adb3069b0e04-52cdf82574bmr414339e87.58.1719051088434;
        Sat, 22 Jun 2024 03:11:28 -0700 (PDT)
Received: from comp ([95.165.92.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd64390d6sm454917e87.238.2024.06.22.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:11:28 -0700 (PDT)
Date: Sat, 22 Jun 2024 13:11:27 +0300
From: Alexey Lukyanchuk <skifwebdevelop@gmail.com>
To: minda.chen@starfivetech.com
Cc: aou@eecs.berkeley.edu, bhelgaas@google.com, conor@kernel.org,
 daire.mcnamara@microchip.com, devicetree@vger.kernel.org,
 emil.renner.berthing@canonical.com, kevin.xie@starfivetech.com,
 krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
 leyfoon.tan@starfivetech.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 lpieralisi@kernel.org, mason.huo@starfivetech.com, p.zabel@pengutronix.de,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
 tglx@linutronix.de
Subject: Re: [PATCH v16 00/22] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <20240622131127.0f63bc4c@comp>
In-Reply-To: <20240622121403.7effa777@comp>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
	<20240622121403.7effa777@comp>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

SOZ, I forgot to add email to tag, sorry
Tested-by: Alexey Lukyanchuk <skifwebdevelop@gmail.com>

On Sat, 22 Jun 2024 12:14:03 +0300
Alexey Lukyanchuk <skifwebdevelop@gmail.com> wrote:

> Hello Minda Chen.
> 
> I applied your PCIE series patches to v6.10-rc3 and v6.9.0, works like
> a charm - thank you!
> 
> So Tested-by: Alexey Lukyanchuk to all series.
> 
> Hovewere i had to fix some minor issues, you can view the results
> here:
> 
> https://github.com/skif-web/linux-starfive-vs2-mainline/tree/strafive-visionfive2-pcie-2
> 
> Hope it helps.
> 
> Hopefully to see this series being eventually applied soon.


