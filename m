Return-Path: <linux-pci+bounces-38554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5DBEC859
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BD294E04A8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18C258EF5;
	Sat, 18 Oct 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZAdy+WS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AA1E5714
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760766729; cv=none; b=N4kBvINdPJC03Mv086HO6F5ln5XTLp8EHP7Xgulxq38Ltnvi6ThWw5fXbRw2a+M31hcbB0B1CyKys/mWWaGfUoWjdaEgUwdoE6NhqbxIMaUxgV7rXxMMBU4D/QsYau++q0zNVAEsT297BRcJgEaQLu/WgBvRh2E6R+XvBzsE43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760766729; c=relaxed/simple;
	bh=eIKgZColoDsxoJovuWfQsmtEvniT3pu5LZJ9r62QCEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ln4/tGdgGrSPB+W696ARDEAMRu8Z2dKot8JsB94wSCri9FWKgYtuByh+LwOMsV0Y/3qnPw1qLwBymzD4jtv+dOza7BTt/KBMZV4MvniSxETAJpJpyg/kC3rwr6JuJPXZ9usCOIjeh2lQr/fSQSvNGlSu50nWsRccvlCUieE3Vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZAdy+WS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4aed12cea3so436083966b.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760766726; x=1761371526; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkVWF0ngwpu5gjmUkFjpcBqAffFGeLSngYlAxMCWNV0=;
        b=lZAdy+WSkHRQUXIXpgAXhSFobDE+XeGaG7+SxB+E/eeAdxGAGeINA1qi3Dr4q2jJIH
         kjdsuomuJLPp8lJsVfQP5KomuCsX1h1+xg/4YyNo5JMgNGjDtnHa3kcAI8DLGitTI2hf
         qjzqXPkYqwNa01PWhuTvqk1CA9j/3fLAQO6ZLlZsTT1823Yew9YsU88WTwBHshG4tX7k
         7/T1GutpDPrnkALAzzdUBw8TwTx+yhPHKOq91dixVjC8/i4joGDONkaMlOUaBmRMUBdl
         +01BQTeEBVzaapfgNI1W66dICFRL+XZNIJ2A5CUpb4ruDHC/MgZ4mrbUqWZwUdOKK8Hl
         bzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760766726; x=1761371526;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkVWF0ngwpu5gjmUkFjpcBqAffFGeLSngYlAxMCWNV0=;
        b=HAmZz9FcF73tuu79bS8jZxFpDPI97uz2NMBEciQEs36kkzk42GKwQSQk3nQJFK95iV
         pLF8lSkbrytOonm1TC07Z0fOBVK4UfvqXn8CvjxeQVqZPk4455KAd0Jz5+kHRU9sYAQ9
         s9WdmXGixkjBeRWdvY3MNdOKhxZ/c17j4XPwAHl5PKIKbS2l8rb+07GpdIgsJUoUEaQW
         P892SJcrTknJuvSxxM5SGifwqIrAWVsmS+xPupWbHSHuV0d0TbHsOlZI0pfe+YOETkXD
         D/0NP4Osel3mnL8JrDEYxmWd1ewiZ07u5CD49WizrnvOcWQDNiRa7Sbiv3My8YCWY1lJ
         YUhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1UK0E2jNRBiSncTAVgJfVRdl470Db5qeluwf7j67RQQhtRNPhafVgHqo2dbeilmTg5j/IGvAlB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPyRVow4Lt8ZTRCcPkQl/3Vo1LRsxyQjf+ASsM3W/BhQ8rA5Z
	1V9zgp093fY7rG0S4TruLxCEQvwUJ6upZvIzpY1ZdbTbsJbK2x6FNpZshKLewLjQ5NStHiaxofz
	PFPPnT2YS+GvsnHC7wPrQTB9Pa6g7TeI=
X-Gm-Gg: ASbGncu0usHpsD59v3JLvc0IOFwb5DmDPLxEco/vW23onI4/ueQF4FQsEc94u5l8yzP
	t1bUnBYMhK2x6G36ffJ3jEeTu48zuRlDlZYpt8wd6KxSBQPzTTyhNd2qMKHbIsmJEKXd9oAS68j
	gKLvPeSbuo2kuQM7m7FN8IoiV8cnw3Wuki3sP2MeiGmZT3J7VHX/GGOdKQTSU8osS/QobCSe50Z
	xUCxcmEpMjhTXoB6+1C3Oy3splM3KTo67qSGj49JE4vf+SS7IB54whc3yw=
X-Google-Smtp-Source: AGHT+IHuqMvBUAMmL2+i6khAnSMhUO84EZpiF6pSY+Ggw9UrirqcHM0DEhpRmnuNAVMZheRxglA2Cg7yTmFpgfufuzs=
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id
 a640c23a62f3a-b6474b37113mr708732666b.32.1760766725511; Fri, 17 Oct 2025
 22:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905112736.6401-1-linux.amoon@gmail.com>
In-Reply-To: <20250905112736.6401-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 18 Oct 2025 11:21:49 +0530
X-Gm-Features: AS18NWDdHdJKGAdSzak2dkZBd_DEUB1KqNHSK63I8rxE-Co_iHsMbvelUCu7ZEc
Message-ID: <CANAwSgSYvTJ=8hv_BrrF1v7u3hq5AB_BSfT7wj0-LQF87dQMUQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Fri, 5 Sept 2025 at 16:57, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Replace manual get/enable logic with devm_regulator_get_enable_optional()
> to reduce boilerplate and improve error handling. This devm helper ensures
> the regulator is enabled during probe and automatically disabled on driver
> removal. Dropping the vpcie3v3 struct member eliminates redundant state
> tracking, resulting in cleaner and more maintainable code.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++--------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
If we compile the kernel with phy and regulator as modules,
I observe this message.

[   25.473960][   T55] platform 3c0800000.pcie: deferred probe
pending: platform: supplier regulator-vcc3v3-pcie not ready
[   25.474071][   T55] platform fe0a0000.hdmi: deferred probe pending:
platform: wait for supplier /i2c@fdd40000/pmic@20/regulators/LDO_REG9
[   25.474124][   T55] platform regulator-vcc5v0-usb-otg: deferred
probe pending: reg-fixed-voltage: can't get GPIO
[   25.474171][   T55] platform fdc20000.syscon:io-domains: deferred
probe pending: platform: wait for supplier
/i2c@fdd40000/pmic@20/regulators/SWITCH_REG1
[   25.474218][   T55] platform cpufreq-dt: deferred probe pending:
(reason unknown)
[   25.474264][   T55] platform regulator-vcc3v3-pcie: deferred probe
pending: reg-fixed-voltage: can't get GPIO
[   25.474343][   T55] rockchip-pm-domain
fdd90000.power-management:power-controller: Timed out. Forcing
sync_state()
[   37.744968][ T2415] psi: inconsistent task state!
task=2280:(udev-worker) cpu=1 psi_flags=4 clear=0 set=4
[   37.849725][   T50] fan53555-regulator 3-001c: FAN53555 Option[12]
Rev[15] Detected!
[   37.990008][ T2216] SCSI subsystem initialized

Thanks
-Anand

