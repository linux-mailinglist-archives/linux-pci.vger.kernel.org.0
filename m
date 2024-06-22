Return-Path: <linux-pci+bounces-9113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93F9132DB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C4728438E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCCD14B09C;
	Sat, 22 Jun 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6o4K8ZJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26C14B078;
	Sat, 22 Jun 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719047648; cv=none; b=SLl6xs5a2FofvpCG0npQASTvMukNZe9i4+699UI4YAogAnskrKtOy6Q+eTOtA8ro8If33mD3aWQQNE/MlCrtDEf8e730eJajk5TqL5tmHY0somYtY1Wmt583sDMFFSGDJ1oO0Dw+9GXCEoT2ZaLLCh6DTqcoFcHbDUtmx7LlHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719047648; c=relaxed/simple;
	bh=RRqQl8uo5OtW4jawNXSK5YjGDnMPsH/r+7OC+raT/cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=J7mJCN8QlerVDAZ33a3Ri6EYwyz3RUPGXdTYwEhdGIOPV4Y538uWja9hkYMxyc95gQNANhAQiRnt9Mby119YHtvmjnvMKPJCn3evx7/LYcyW15wyc7LM7jOhSjjlfge8DxGHuZDeoZACbi6kvK+Xqg6dBl5u9OpqumqI/8IRClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6o4K8ZJ; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5295eb47b48so3454490e87.1;
        Sat, 22 Jun 2024 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719047645; x=1719652445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRqQl8uo5OtW4jawNXSK5YjGDnMPsH/r+7OC+raT/cg=;
        b=d6o4K8ZJu57LdjhY/tAj8wrNDbsFRKE/o8NquaDh3AOvJvQor8b045q4LCyV/OGAAW
         Z18hUTcnTdW3+if/mftaG1N+AG1qLsHq48fhqmw4h/NaA0/NTrJMqUVzUxDXIVrizsE0
         /s7QV8RtUftXFf983jGatUzWeidGkYnuNYRA13w2G5shSZwdUnszo0Cd9z6RRB+a7lSQ
         cGPejdAcXk5YKS3T5xpriSv/2gAI0y+RI1/JiZr2EFyy8qxp2WvnR6w1NPAI0C0Bnx9F
         DzlU+gaM2bQh0ndE1DNRgNlmv3b3qftL0KvdF7kMtbfW6rfWuvzZ+BV1OGojPpd9Chjo
         Kbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719047645; x=1719652445;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRqQl8uo5OtW4jawNXSK5YjGDnMPsH/r+7OC+raT/cg=;
        b=MYILWqXGOpn2Wrtm5E4Ww1wk5zp7ca/pv5fkpf7W5IqIQH2HJi8uTc5/+qV7RcsF3F
         PwF2mNpsaBmB/n9eI8c+Ezp1B+J2s2EjzHbegovbahs+AGErdS30GEvEDZpBo17FbO8Q
         rH9cTFrH6+jg/Nwjs8wT/nSnA+yEl/wQ/bnWwVyDS5SwynkctkILXMeIoneYWXxArWId
         /pkASytAKTck+AFY2N4z4Ylk4AEV4+FVysU3QvrB4xEgDbvUGB9zYsOUO+/zk+87d8Si
         Yiki7dYhGPL/+XvLl+zzLaRExd9nok4Sjuy0mS05XAOdqW5QhRqPsp9qzlNZ6BZUcLpv
         YfKg==
X-Forwarded-Encrypted: i=1; AJvYcCVePJC/cpH0lJbd6SEOLitXOgmlucDLn4cbXIoAEvCADrEFJX6LHGLKgFTb8ZhxtVqkZ4Bh5ngjpf1aXWsxfTvv4ljvcx3ZRveL21YJmO4NSyoCcwoWOlsUe+2yBqcIHDIgUOMECmSR/136qp9VdcES/JlKqc/twcmop7fzVHCZk2Eh6w==
X-Gm-Message-State: AOJu0YzUyDdiRx9h57193y7HuQ+hAtHq7sfiU+NpCni/nNWGHkF+0zSN
	DZSw/Zithvid3M336d52NeohnryUMKaqJqUL68Di3lk3EQrnenil
X-Google-Smtp-Source: AGHT+IHJGOCTYSjWGWICe1a7Ey23OXHw285FjRTgowpE0FVV64ic6M/3PuuUaM6lyNhVILMGR8S5RQ==
X-Received: by 2002:ac2:46d4:0:b0:52b:8c88:2d6b with SMTP id 2adb3069b0e04-52ce061077fmr39891e87.11.1719047644689;
        Sat, 22 Jun 2024 02:14:04 -0700 (PDT)
Received: from comp ([95.165.92.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd76516f3sm409314e87.151.2024.06.22.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 02:14:04 -0700 (PDT)
Date: Sat, 22 Jun 2024 12:14:03 +0300
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
Message-ID: <20240622121403.7effa777@comp>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Minda Chen.

I applied your PCIE series patches to v6.10-rc3 and v6.9.0, works like
a charm - thank you!

So Tested-by: Alexey Lukyanchuk to all series.

Hovewere i had to fix some minor issues, you can view the results here:

https://github.com/skif-web/linux-starfive-vs2-mainline/tree/strafive-visionfive2-pcie-2

Hope it helps.

Hopefully to see this series being eventually applied soon.

