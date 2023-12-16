Return-Path: <linux-pci+bounces-1087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70D8155AC
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21B3B23291
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F57F2;
	Sat, 16 Dec 2023 00:44:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1A4A0B;
	Sat, 16 Dec 2023 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f055438492so854260fac.3;
        Fri, 15 Dec 2023 16:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702687476; x=1703292276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCDBVhy+Wa1UFd5gjt0W6RUH305mNMdwUaXK1ehoNrI=;
        b=Ojay8f7DndQaNeHGJhfXQy83nraxQjdGz+wjv7OWHOY9OF9ifHDQaUu7AJLn0gnP5u
         sU45w8oUbOUfMn/4g79EidSnCBgY/q5DjCW5rV5Fjdl6gngruK5v+vRNP9x1tE7UIq2h
         oFWit11REtL5szvzoIxf2RIk2nRyKp3z1P4KCydWj/7msP+PgBytOjmjmi58mHV9CIQu
         jOSmImPBIF94QDaPnOq1fLBIIx755AEuiG6T9XHDFO7lBXIhKxslWnbh1riEo/st/x0A
         RVU6YSQF4Jh4IJxBYIlWd2V8/n+/bs4N6wdrFCWHwJWrSAL7Qj9FbH42pU12OzBbtb9H
         VmIw==
X-Gm-Message-State: AOJu0Yy6Y1gjk50dQ7Y4869EYwpjbaRKK4YGyfpfaHCkRDODd4nSUDln
	fHmoC0dKheLWs2p+SZoCIvU=
X-Google-Smtp-Source: AGHT+IGqPedME8QW5t9KEziGhH1cqzOqN9FXW+QGKtYfsIrZnbHoWh63kuMMwBFOpXK4UxcJ7an9cg==
X-Received: by 2002:a05:6358:3106:b0:170:6675:a50a with SMTP id c6-20020a056358310600b001706675a50amr14530188rwe.36.1702687476524;
        Fri, 15 Dec 2023 16:44:36 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id st5-20020a17090b1fc500b0028b11757032sm3614383pjb.29.2023.12.15.16.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:44:35 -0800 (PST)
Date: Sat, 16 Dec 2023 09:44:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH 0/3] PCI: Convert to platform remove callback returning
 void (part II)
Message-ID: <20231216004434.GG1570493@rocinante>
References: <cover.1701682617.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701682617.git.u.kleine-koenig@pengutronix.de>

Hello,

> back in March I sent a series[1] with the intention to convert all of
> drivers/pci to .remove_new(). I missed these three drivers because my
> coccinelle script didn't handle __exit_p. (The drivers don't use
> __exit_p in the mean time since the follwing commits:
> 
> 	200bddbb3f52 ("PCI: keystone: Don't discard .remove() callback")
> 	3064ef2e88c1 ("PCI: kirin: Don't discard .remove() callback")
> 	83a939f0fdc2 ("PCI: exynos: Don't discard .remove() callback")
> 
> .)
> 
> There are no interdependencies between these patches.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.

Applied to controller/remove-void-return, thank you!

[01/03] PCI: exynos: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/4fbd8b788258
[02/03] PCI: keystone: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/93d61d3aa996
[03/03] PCI: kirin: Convert to platform remove callback returning void
        https://git.kernel.org/pci/pci/c/a5eee68931fc

	Krzysztof

