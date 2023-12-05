Return-Path: <linux-pci+bounces-443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF31804D71
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBA71C20AB4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E663E469;
	Tue,  5 Dec 2023 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="RPil/7n2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4533FA
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 01:18:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a06e59384b6so738518466b.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Dec 2023 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1701767895; x=1702372695; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyyV7FDLLTugfQIqaxP8FNjfHS3S4eEzbgCWNE04/AY=;
        b=RPil/7n23NNJXri+OQNHPb6RQpSGWxkcEW7Y6g1+BnhYoYY1U9ue3/xYWdKY2DSp+h
         wI9duNOfEYRAWDigjv7cHSX1mAeAry/dT1q+rSrbRqPtx05XJzCOCuHUWI4el2GVWsoV
         ZYuD0/S2WUQDVo2H01Agpqa2XhBa2yS7ESwjQxfyoxxqPEreqn58fTZpboO6x1lwNCGF
         y+FGwletCLLutyN6WPvAxsDNFqqa5FkmpDZSJxOiaCG7P92M6422P/OKErICoX7FcAeV
         7xAqCgVLiL7xXqVolUYXiQeHnzFxwme0oKIHHH7JfgEfOG9zelp7BhVAhuJSzD2ep14A
         4IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767895; x=1702372695;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyyV7FDLLTugfQIqaxP8FNjfHS3S4eEzbgCWNE04/AY=;
        b=VEY1BDcN8W20k738znmIWN9tVfqwzPR0fSbLDE8HqtJhp+GDwai4SMkqE5ifuFDJa7
         ipjWmufZNS8dOZqRkSVt6Z11lN8HKdR6LKjEpNSoohQiAa+/1AMRsgT/VKUfMJ+jy0u+
         JDsjt3nH3euJXfftPUMSLdCqG2q81JONl370WSqyv0xjOE1L/ecg6VxYQC6gmpcn4fkc
         oBizTCy49akpkE/Mxnr8eTLsx3pBVy9mM9TyYIzNy9Vr8wVOaBZ/Z2Z0r9W7rLS4l8nM
         5eCJDo3/5Ra9qPk9EBFCUavq3CK4zYrL3GfbI6O4d5vsNlAjY6j+Ip/SWw/nM2PbTdDa
         19TA==
X-Gm-Message-State: AOJu0YxWyBiiHSKPbMsfAdNaOmhpOV1yxT8NPQKRmMPHkYfB3ewMvlDw
	86M4E2jYLZr4OF247/k0Wr0C0w==
X-Google-Smtp-Source: AGHT+IGqyRUTu9WLUc6nH2xCm42ZpYmhyLu5VkZd6XTvkBxqfK7IGfbNYY1unAPGXa7vSv96T8dnMQ==
X-Received: by 2002:a17:906:243:b0:a19:a19b:c732 with SMTP id 3-20020a170906024300b00a19a19bc732mr3544020ejl.130.1701767895199;
        Tue, 05 Dec 2023 01:18:15 -0800 (PST)
Received: from fedora (p549451d5.dip0.t-ipconnect.de. [84.148.81.213])
        by smtp.gmail.com with ESMTPSA id js22-20020a17090797d600b00a1b32663d7csm3271996ejc.102.2023.12.05.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:18:14 -0800 (PST)
Date: Tue, 5 Dec 2023 10:18:12 +0100
From: Damian Tometzki <damian@riscv-rocks.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <ZW7q1LEvEpVxoI4l@fedora>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <c4154501-5b93-4eaf-8d2d-690809d26c57@starfivetech.com>
 <20231204212807.GA629695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204212807.GA629695@bhelgaas>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.7.0-rc4)
Organization: Linux hacker

On Mon, 04. Dec 15:28, Bjorn Helgaas wrote:
> On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> > ...
> > Please check this configuation.
> > CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> > CONFIG_PINCTRL_STARFIVE_JH7110=y
> > CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> > CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> > 
> > BTW, Maybe you can reply e-mail to me only.
> 
> There's usually no benefit to replying off-list.  The list archives
> are very valuable for future maintenance because they help us
> understand the reason things were done a certain way.
> 
> Bjorn
Hello together,
the main problemwas was  to find the rquired CONFIG_* options for StarFive
Board. It would be great to have an CONFIG_ Options with all required
Dependencies.

Best regards
damian
 


