Return-Path: <linux-pci+bounces-44538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13674D14515
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 167353019681
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D73793D1;
	Mon, 12 Jan 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZMamZvt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6311306B12
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238521; cv=none; b=CTdyak64WAAaJQEsWQDr5LqcbdOeGnhwxXl8/UGnzl21+AyXsd9OKuD4yKaCi03ButtDgXpoITubaYRs4y8Sem/XhPjTTw1IET8Iy2WSBjI6m4ELYg7/lD56UCX+e6PUigPlIZSv3wc/w3iQ5oAoVNaxmZIkxjh43NRAaKXgLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238521; c=relaxed/simple;
	bh=ZVKExw7EeAuIEN57ZUXQi5RwuqCyZZyZeIGK74Kyw5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVTUFirtrTyGGYI9ltB7ub6xxV1a+/hG+dn1bqVMG2DaKbRsEEp2uMledTx4FqqEj0HAIL4gYkhtpm0OJh9FUETwKLpaU4S37zSG7ICdzPRX2B6NUUY/pB0tu94nFHpghByHqcHtVq1FiAx+OlSCt1TyT6VONKLOkmPkzS7ouWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZMamZvt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1531093b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768238519; x=1768843319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6+1oU8x/upnU/kZthxqKgjcVbxBdN8e9Rqe8YgOE50=;
        b=iZMamZvtumhidl6Dvr0UgtoBK8VdrOFSQktQbGR+xAHZIY52yynsXGK+bJHdrxBZl5
         tw6nqH7gXs7Am1IdX8cIGpTZdg052x25SreLLplkOgNvrYQjzlrK3RZlORAwC7PqpNmi
         lRFGLdKHftBfqpHU0BbgpaAgISj9I/RhHdI25wqiI5Gck8OWIwoyS5ThZc4dAowKXhml
         99mzQ500ZvbbnfxM5J6IDb4k+rFX2M1K6sCcevqV70lThtMzlOthspjQChm/d2U4Ta2I
         2C23Ly7PCtlCR2ERyI9aw0R1/vTgKjCBhcbmph6wK37nSyEB+KyyP9emIZ+kTdxj7bi2
         E1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238519; x=1768843319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6+1oU8x/upnU/kZthxqKgjcVbxBdN8e9Rqe8YgOE50=;
        b=GcEQ+dlxN9GO4ea+bGQxIqfUnE5i+VpxiBmP/Y8jDkDoKccOrLxuHZx/m0GtyjdJiH
         ISYCEtpQXWGjhTsnewOEryIDu7HcUM667SkAbMElmLewMsoUkf0omm9Z6Kr7pk20+m7o
         C0MIvQKPCmo/+Eoy65NjH08v1ipMxQaiddSRzxJYYWe+FIaLhB4wCTAAUCtGEtXbyQ+b
         nPOBi9WF4IRV2NbbqUNX5DyjfNgqnLhNZIrOpWUag5FKX4gUsWhnr1eYTUkH/pyJfIeE
         s9JshwPkWJtDNDOuFuLBA4NeMC7Bo4yd0o6tXukH2pZXOKI2lMRNwa+UNew3HXTeX3a1
         7f5g==
X-Forwarded-Encrypted: i=1; AJvYcCV/wuXKBFtn/SF4k5u1C1s8IlHoyA9UZ6L2Ope6+KRpx8DIw1dW1epWVKSJhGOmqHPXPz7QNtLbsrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZ/8wm+5GJkMKKwYXkNYdAGeE4FUZEtWWI6qLO4IExmf5xQgf
	yTP4yaawHzEU1vVZY0yiPSXdkWK1T2dkVV9lOoMEphkWfDw4YiXAEqpXZWk+OQ==
X-Gm-Gg: AY/fxX4q/j2BrHny4f1jH5k7Bx5029wj7gVd1WtCYOuSNCVZEjrTmi4JGQX3GXPDJqt
	Mg91xpKagTialr/wNfsjo+7v4bMTWHU4Wy6qHWybeobTUsBaVEymriRFhINYqOxq6TIDDJY0q0p
	HT203K7PmtzCVnZH+8YfqaBz3xRGiPlhbSKoQI8NbcujUewPAprC/QJWkyLY9wONaFAMtuT/5Il
	Gg2sHfDCbe9fbMUQmEjRbHvEHfx5osRcLRKsY12mKnIwxK/CBgrvqU3klra3pXI1H42L4lMPcld
	Knty7wSoPSMUzLeBnlVqj4wENpXSnumTjS7AXwMl5k2wqdZxsHRorpNE3yTYYyC+7muD1qHwB7f
	JXpGBjrj24h1HI7G5502YPx4JubGtCm0+RCQW7jTw+RKgxpyFVTOyVVVBi9aPk4hy55ka+Yv1E5
	TSlylNzreFjaROTpnn
X-Google-Smtp-Source: AGHT+IFmhkreN/BSQ8+J8r2WGSwLWJs67pXcLD+Cso3fr6xQcomt1pNNtgnErREYjljqVgVJcJTdSw==
X-Received: by 2002:a05:6a20:3951:b0:35f:e2c8:247 with SMTP id adf61e73a8af0-3898f8fba76mr15661463637.32.1768238518985;
        Mon, 12 Jan 2026 09:21:58 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f096:5c52:f599:118c:bed2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c59b0bf72afsm5692383a12.28.2026.01.12.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:21:58 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rakuram.e96@gmail.com
Cc: bhelgaas@google.com,
	dan.carpenter@linaro.org,
	error27@gmail.com,
	jirislaby@kernel.org,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	sai.krishna.musham@amd.com,
	tglx@linutronix.de,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error message
Date: Mon, 12 Jan 2026 22:51:49 +0530
Message-ID: <20260112172149.8239-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 20251223184003.32950-1-rakuram.e96@gmail.com
References: <20251223184003.32950-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 at 00:10, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
>
> The INTx devm_request_irq() failure path logs an incorrect IRQ
> number. The printed 'irq' variable refers to a previous MDB
> interrupt mapping and does not correspond to the INTx IRQ being
> requested.
>
> Fix the error message to report pcie->intx_irq, which is the IRQ
> associated with the failing request.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202512230112.AaiGqMWM-lkp@intel.com/
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> Testing note:
> Compile-tested only.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command using for testing:
> ~/project/smatch/smatch_scripts/kchecker ./drivers/pci/controller/dwc/pcie-amd-mdb.c
>
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 3c6e837465bb..7e50e11fbffd 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -389,7 +389,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>                                IRQF_NO_THREAD, NULL, pcie);
>         if (err) {
>                 dev_err(dev, "Failed to request INTx IRQ %d, err=%d\n",
> -                       irq, err);
> +                       pcie->intx_irq, err);
>                 return err;
>         }
>

Hello, 

Gentle ping — any feedback on this patch?

Best Regards,
Rakuram

