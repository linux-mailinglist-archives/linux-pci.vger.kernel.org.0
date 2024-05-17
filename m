Return-Path: <linux-pci+bounces-7600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491CA8C84EB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBBCB230CC
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBF3AC36;
	Fri, 17 May 2024 10:33:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5563AC10;
	Fri, 17 May 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941984; cv=none; b=SfQKpvMK+ex4c1I31kT2bsFyBc+tH6h/v+MQCxfrnVzXCpZqlNrdX18xdREOIBxK6m06XKFqWC3H701vpu0k2uQm35s9gb+zMJQa9+WQH6D2N5RNCAYoyD4tjY2rldJIsxjFAvho7ygn6XPG7KnrHE6o+cBAcyNd5VUySU5oFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941984; c=relaxed/simple;
	bh=ldokVU4SZo7FLsD4Kh9lvfBnprFteHzsvp5juKH2918=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9HqoCbIHY6CBZ9eAogi3UmE0ldTZFh6TWnyDZ04TtEfK9S4lfy9oBMkWUo+gzyRlqdokEPzilu+HZzSYoP7YJpSgCnjofqDTiDNhZ53tGm3RJCutumrDlH6g4HzhorwmCFWi7J3akai8+/eHHviGE/iE9DWkfIksUXjAHSCSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-61be599ab77so705912a12.1;
        Fri, 17 May 2024 03:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941982; x=1716546782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDIPIdC2iTjzKLbwvmV/+5e+WmlfPcTjMVAMaXQ/WwI=;
        b=OI1WnjG8+O4//ObJZaovWgGktG/1rwzKpQR7ZWgROix1eehNI5qNWnpkyC8lRDiApS
         yjPzy0ykPL3ygbcfPIkr28fxCAD7TXpz/pAJv0eLAARQkisuls0wVEwuWL2q62S9Qt8N
         atkItbVJAYqhY6sIRW3cwKEh5UvvvDtfX2kpQqdyOdjg1nxkW42A2a40inEhUCHNL00C
         IEAFRdYEv0AzZh3tPTUeFBdnfHZEkaxNtB8W/82ijbkRqsrP+ywYOf2vz1eMnx/9VP0/
         uatI9jB3+gE+OHm8wobdVHfLKe2A1XwDG0Xyuw7EDaZOATJ9gOnM0yqZf7K0IOxtyD8L
         TnmA==
X-Forwarded-Encrypted: i=1; AJvYcCUlyfwiNSWqmdcEUtplRP5EaIT5P3geDgRfSWAb0Rl3TqgcTM5EcPiBKz0lJIfzHmch7FEDqKxk/w4WSZ5XTu3SvCSQLm/lGNlOk+W+0O6wnM0ABm+0hhEdGxDJ0YApWX/Jx5S3rGf5hDRGjjlezT8x7ZJOl25DuiJOdDDeHTrOoaKaF2PgTB6b
X-Gm-Message-State: AOJu0Yx9ttX1VhlX7+1oEPngIcSa+2J25zh6l7dBELMi7F2lwocDt1GB
	ZcpPvd9UxJiQex1fu8z+X+QUEJNE7OopED7xG7qxesBAroDEBiUr
X-Google-Smtp-Source: AGHT+IFdJYh9/lHcJdEZ9+GNkqPpVVIC8MX9s01wASr7Zz3IKnxbdD8ZeSDf+NW5rHJJFamD4ZR48Q==
X-Received: by 2002:a05:6a00:4f86:b0:6f3:e6ac:1a3f with SMTP id d2e1a72fcca58-6f4e02ad970mr25536537b3a.11.1715941982000;
        Fri, 17 May 2024 03:33:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm14847336b3a.96.2024.05.17.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:33:01 -0700 (PDT)
Date: Fri, 17 May 2024 19:33:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 0/7] PCI: rcar-gen4: Add R-Car V4H support
Message-ID: <20240517103300.GI202520@rocinante>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

> The pcie-rcar-gen4 driver can reuse other R-Car Gen4 support like
> r8a779g0 (R-Car V4H) and r8a779h0 (R-Car V4M). However, some
> initializing settings differ between R-Car S4-8 (r8a779f0) and
> others. The R-Car S4-8 will be minority about the setting way. So,
> R-Car V4H will be majority and this is generic initialization way
> as "renesas,rcar-gen4-pcie{-ep}" compatible.
> 
> About the firmware downloading, we can get information from
> the following wiki page:
> https://elinux.org/index.php?title=R-Car/Boards/WhiteHawk&oldid=581944#PCIe_firmware
> 
> For now, I tested both R-Car S4-8 and R-Car V4H on this driver.
> I'll support one more other SoC (R-Car V4M) in the future.

Applied to dt-bindings, thank you!

[01/02] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
        https://git.kernel.org/pci/pci/c/5220b11a5beb
[02/02] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
        https://git.kernel.org/pci/pci/c/c037263db4ce

	Krzysztof

