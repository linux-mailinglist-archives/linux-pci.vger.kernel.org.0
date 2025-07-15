Return-Path: <linux-pci+bounces-32178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96CB06418
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10DB581599
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58426738D;
	Tue, 15 Jul 2025 16:14:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEC274FE7;
	Tue, 15 Jul 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596097; cv=none; b=oeUgLNo/bLs6eOa4g4+5TM4EBxVhRYTm7gGeTWs9wyn4tTqmZLefiTDSrcnlCQUGJ4DGhjqwUr6WQf33UGdtDpKqgnxGwTFDWg39AfD9g+05/Sh9Ev46nJWQGPAj0Oz4bm8kROLdJ5OXZXtIDq5RcHc7eo1uTAg9E8/C/hq1MxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596097; c=relaxed/simple;
	bh=iIyYfpgrKOknNnGK/+bP3mYgAK/Ir55T/njOFK0stMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1R+Suv3RqVufp40w3hinytnxyIWchQ6739qiHkVe1NUhhkkle9rkFvSsDMwDBhRMrsmaPhtO6mzH8fFzEU3CzPGDuw9JVqqLwhSgyYl8q48w97py8bfc7lEKS0SDc5adHX5aZcuX5TE6T9McPdnjCoQGIwuLnwEs9frndd3F/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0c4945c76so909597566b.3;
        Tue, 15 Jul 2025 09:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596093; x=1753200893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/BWaekXetU83aXLszdrOHzTcPZ86/9kj05RU+QM+Og=;
        b=F7FCMRg1XHvG3JwRg0Kmnda4LmoI3dyDW+rC5UPc7P5Jfdy8OUJ5x7FZV05N74RkI9
         3w/dRQPajxC+m6z4uc+tMrMfnbEA/UUss4HVozStB1Jf8lA+I1dg2LfesJltw1WX/GEd
         +HS4TUypKDMG6wR0yZXU26YRG4FNZ6kQNgA01UL6xwYccC4O+IDvLvL3tRna14274RAH
         alF+d+WW0MPg+sf4OraBqEGH4/vC0I1OMBMFNiZaZQwc3jM1f9Lt8oqnZtm4ain85rCd
         wqYbrn3cRXc7YbQrKCLZGFD1Xak1+bEfL+pverSrB2HElNhZKuE1aG91yqKbH7Pkmt3H
         PaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8E8EsnzTWwmyAAb0QH5QVk6dt/bzvQUd7W3fDsmlehwG8ETpgoNoKDzTrNCMAqEAuhKf+KHlF5AUfjxF1@vger.kernel.org, AJvYcCVSNgwO9FMYdhR3KHxn8axio+dyzloJ0dzM06NoRwPwH9kLdcBRLw4MharWi9blWsuD0kOoXqfmDoQ3@vger.kernel.org, AJvYcCWuvZxS9Q0jIGtkRDv/Om3gUPzdkWXUPnV1SH3p4WF6g7Y+g2O7b2pXXjq2FOM7SZMas6jZS+LD1eV4@vger.kernel.org
X-Gm-Message-State: AOJu0YwRN7qwqaUn6w6N+KVsIvE7kLDwmzjgJKqLK9wYJHZ4u6gEtPP/
	RkT4LUObiq2BIguPkbcm9SnafokTaXoQ3brKIJ81an16/LdLF8wSXqRO
X-Gm-Gg: ASbGncuS+S+g3aPDcC0D+nyoL2JvSECmFfXyXzQ4SgZncXzq0WRNu+sAboorV13tCn0
	i6nvdAdzaVIYozEtVPXdi0kt8EdWuoz6rgyz/WbX2Zly9OTU7/KdJMMjUcdFUKdscGRB3Acgtku
	J1LCEWymh8pHneXg+RpqPfeHkiA4IJihiRumOmYwefeXNBPfHBuH8mQrSL1niq/dcv4UHqbTdmV
	1aKH3YoHsYVT6yvE8gI1fCvgcew9vmCHdzA45+BXvbGaB3M3tVbPLR8BPT+W+XzkDQVbemH5cL8
	FS4Bh9Bzu/6JBbbvJDLT8j1jKYG4ll0w/WeAQcevchNOuhuZd/qBynRx6/bnl1ZUK0G3VFzT94M
	SQgtTvAWXWiw5
X-Google-Smtp-Source: AGHT+IEvOc8+OszJCyE/oEuX+OBcQTQBoSLU9a3OzY1TExv2Ip6GqBTNIFxBnwqU31lZn7voNTRXjQ==
X-Received: by 2002:a17:907:7f26:b0:ade:3dc4:e67f with SMTP id a640c23a62f3a-ae9c995530amr10284866b.9.1752596092658;
        Tue, 15 Jul 2025 09:14:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826651csm1026354766b.101.2025.07.15.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:14:52 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:14:49 -0700
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
Message-ID: <sy2u3iyyfqk7ynccsb4lpbkto6pmkhamnlkkhf3mmh5dr47iyf@wmygyxypb26v>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-18-12e71f1b3528@kernel.org>
 <7mhnql75p3l4vaeaipge6m76bw4wivskkpvzy5vx3she3wogk4@k62f5hzgx5wr>
 <aHZm8BsqV1ighJ+2@lpieralisi>
 <aHZ81Kah1Uaa184N@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZ81Kah1Uaa184N@lpieralisi>

Hello Lorenzo,

On Tue, Jul 15, 2025 at 06:07:48PM +0200, Lorenzo Pieralisi wrote:
> On Tue, Jul 15, 2025 at 04:34:24PM +0200, Lorenzo Pieralisi wrote:
> > Thank you for reporting it.
> > 
> > Does this patch below fix it ?
> 
> FWIW it does for me. I think you are booting with pseudo-nmi enabled and

> the below is a silly thinko (mea culpa) that is causing the IPI IRQ descs not
> to be set-up correctly for NMI and the prepare_percpu_nmi() call rightly
> screams on them.

Thanks for the quick reply. I don't see that warning anymore once this
patch is applied, so, the patch fixes the warning.

Regarding NMI, you are correct, I am using `CONFIG_ARM64_PSEUDO_NMI=y`
and `irqchip.gicv3_pseudo_nmi=1`

> If you confirm I hope it can be folded into the relevant patch.

Feel free to add "Tested-by: Breno Leitao <leitao@debian.org>", if
pertinent.

Thanks for the quick fix,
--breno

