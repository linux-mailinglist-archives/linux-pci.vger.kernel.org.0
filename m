Return-Path: <linux-pci+bounces-32156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CAB060FE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA982500B63
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0011729ACF0;
	Tue, 15 Jul 2025 14:10:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F29AB09;
	Tue, 15 Jul 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588636; cv=none; b=FU0AjIO7N/76XXlcHgy9ShrRuIk/kWb4JDyn1QL4tjYUVZYUuwKSNg57OzFtw7/1aIKgBrhOfzXeyFWta3CZP9E2EDp91yIw4n7obxHFdH3g1FQQslV330F4odRachexXLHPxEb/+YzhmSV0SBehi+HX/J1/ZnkdFrkMUB0eojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588636; c=relaxed/simple;
	bh=iD/43DSr/7nxLqoPW/jtBDYANh3C1sCegNgMfFUNBTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKDx35YMQ2FcjgxPO76SnW26rCCiTleMy34NjAbDo23tSzUD14OY6KzatkD0BAdbCb+jwBGwR24B7NI9kHudQ9GtrCXa+3tLXBrRF2D18xWCHU4yb3KGj6RRDrHs82OuthbwXHYhmcZETG/TJIkYYQabKyyeaUhLD/ow+Ncjnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3a604b43bso916376066b.0;
        Tue, 15 Jul 2025 07:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588633; x=1753193433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tELAcnZVNd8b1stwXqZxFS8cE4bNgApGcuDGoeyxKzk=;
        b=P2lrGf27P+hpLqESTREm/PTApBd+tR9UuP48KExVIsCGhXahoF7lNlneFRR/674LqU
         qTVGLBpe9eFgKjEggCMG5SkItDFbImtYFOZtucaZAutJ0lg+bOVqfuassqJbT8BU4eF8
         M0O/j8M7AHbZVNLee4ndUw5I2+d03YpMlDRyoUC/kySUB3rAWiUhUi8X/3X3fjVdiqoT
         e6OBwF/Jd7JkmW0I4U4sOBRQHZJ07CL2u/FjcEE2Epuv1EY/c1bnYPCfWDSrP0hz9qdU
         0atwJOLtC68BObVYMXLcQC8dFNi/Nvjms0x2MJMfEsavl1CX3bOYZ+lyIkP42ovAzj8k
         ++AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE3gCwh5hcvvFDWGkaTNyhPHv+X85pTIn3QgdkLZ694f3GsWIgJTRCw1wdufSxh9GY4GVkjlvwOh8m@vger.kernel.org, AJvYcCX30yeo2+SLcrjUKi6+s8tEVnNm9vykys7vkXWA3axLwNp6d7Z9MjKG9TEPBUPpHX3ATYbogX8R1Aol@vger.kernel.org, AJvYcCXlNi8F7mzazk6oBwltw7rYCrtB7I2UMp6SH5wgJ5JUurh9tRNmZcC81dVB5KJOw8IVcKcblZ4qZC5IIiTn@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0PmT6thJ2io4+Z+GGsrVhX5cMhcjMTros1ER0i2bRu83StpJ
	ZsYy6yQ1Y4VAQu4m2nNaof0w41v/DuGzm5++hjrTzQVoQw0P00vTb3hvumpylg==
X-Gm-Gg: ASbGnctVRCetTfr6k9xuisOa5wK6S4EtlVwlYRDlvEYX3vvxYpTw8W1fbM8Bf9SlmP9
	rGE9rgMdRgL6yMXSdRkdFfGJ80jNbPe0JYOXdQKMg6eA+uBFSFqIc5m8+mk/pA7qmfWsbCBEwAc
	Wur9G67LpiSgtaak/4QnbKoaqeGJ6z96Dhe4L5wu0ZYuAkK11XLNWWrMG4FH9WDfN3Ps+nGYsRk
	vxVZULUBmyGfdq7Uhd+ymX57m5xYwldHsyStQOpQCDp56ZZO9qQJAuAg0RIxx341DCbzqgSC4Im
	pJdHH8YNLILh0NXv6vk00IaUMm6I243c0ujUIOcWcU+SJ/2YyowCqAv9rubefBg1l219oF/Y4wm
	jIsQZvNwDI7wKfsfR6r1z1iM3
X-Google-Smtp-Source: AGHT+IEbyl1a/QSsIQLOHzGok9IQBsWgH6iuwWhFnpACxKR9fLabguJ1GjnLGBVzOQT1BEOKFXRITA==
X-Received: by 2002:a17:907:1b0b:b0:ae3:5e70:330d with SMTP id a640c23a62f3a-ae6fbc109bamr1654095266b.12.1752588632995;
        Tue, 15 Jul 2025 07:10:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eeae5fsm1014433766b.64.2025.07.15.07.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:10:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:10:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sascha Bischoff <sascha.bischoff@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 18/31] arm64: smp: Support non-SGIs for IPIs
Message-ID: <7mhnql75p3l4vaeaipge6m76bw4wivskkpvzy5vx3she3wogk4@k62f5hzgx5wr>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>

Hello Lorenzo, Marc,

On Thu, Jul 03, 2025 at 12:25:08PM +0200, Lorenzo Pieralisi wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3b3f6b56e733..2c501e917d38 100644

> @@ -1046,11 +1068,15 @@ static void ipi_setup(int cpu)
>  		return;
>  
>  	for (i = 0; i < nr_ipi; i++) {
> -		if (ipi_should_be_nmi(i)) {
> -			prepare_percpu_nmi(ipi_irq_base + i);
> -			enable_percpu_nmi(ipi_irq_base + i, 0);
> +		if (!percpu_ipi_descs) {
> +			if (ipi_should_be_nmi(i)) {
> +				prepare_percpu_nmi(ipi_irq_base + i);

I am testing linux-next on commit 0be23810e32e6d0 ("Add linux-next
specific files for 20250714") on a Grace (GiCv3), and I am getting
a bunch of those:

	[    0.007992] WARNING: kernel/irq/manage.c:2599 at prepare_percpu_nmi+0x178/0x1b0, CPU#2: swapper/2/0

	[    0.007996] pstate: 600003c9 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[    0.007997] pc : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))
	[    0.007998] lr : prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1))

	[    0.008011] Call trace:
	[    0.008011] prepare_percpu_nmi (kernel/irq/manage.c:2599 (discriminator 1)) (P)
	[    0.008012] ipi_setup (arch/arm64/kernel/smp.c:1057)
	[    0.008014] secondary_start_kernel (arch/arm64/kernel/smp.c:245)
	[    0.008016] __secondary_switched (arch/arm64/kernel/head.S:405)

I haven't bissected the problem to this patch specifically, but
I decided to share in case this is a known issue, given you are touching
this code.

I would be happy to bissect it, in case it doesn't ring a bell.

Thanks
--breno

