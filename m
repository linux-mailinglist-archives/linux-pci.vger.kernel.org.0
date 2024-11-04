Return-Path: <linux-pci+bounces-15975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD79BB8AE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 16:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4301F22411
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE71BFE03;
	Mon,  4 Nov 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpmUVtKy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D661BD014
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733160; cv=none; b=I0WP2XchmLLUSJ+Ev7rtnLCGTQzFORD/AOqOpFdvZGdNX14hqnvNDVjP9AJ/2ABq2moHlQZcz0PDjNMKvNRp0FGonO5oRhlrinakAwaGmtaG/sY4T3aQK800LnaxFwS9qE6yRHZnc2vrKKkhRxwNeOaZAD2GLp2OBaBS3Oxd9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733160; c=relaxed/simple;
	bh=qkGrV1uyjS9Cqhj5IWzafZBjQzq/m8MRer83C1OFZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUyWSnUruhIUzNpI9I0/HQsJE3nNBYbFekPPTedSZdCJEPcsEsZQok2nAJ/H2aaZ5VnRCvpUaECVUWE3a4NIvt1flPyCYCXRezrXbJ9+BtgGsCgzciCo8KU3l3v+En+s4bP4fneLfiET9qde3Vz/u960J1lthIQzZnyOrifhhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpmUVtKy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720be2b27acso3521329b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730733159; x=1731337959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JKuo9CTAykduP5fMt3ym5ibpLBBhoEvoUSqeN+sce8=;
        b=UpmUVtKyNKUmfAJKW13lSHgkHtyNOaFbf6h31ac5uLFdRgGuu+OMyIjEWmBlrr1tYZ
         bX18hs9oRwEjueRk043e0MDvW0NmQlOCDQweOebz53rUFf0sxrE66QKLK4T3/EWS1naU
         7JAuJDGSw7LHAO5rTA6RzP4KX8AaNNFb0q4DnoyoFKai4DZohEK8NtkjGL7R3JQpUp0j
         G5CFCWH7UFfChS5pkFqhoisOUYOabztlCDg4BQseMf/4k4evcgj0O+T5rNbHbJYb72r+
         UqTuaEBr3CCe4ARPkA0E3SuASQOiZrNLjr1D1nWR/8ebRI5uHbmPVJpCXMiNpFtbOHCv
         0Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733159; x=1731337959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JKuo9CTAykduP5fMt3ym5ibpLBBhoEvoUSqeN+sce8=;
        b=meVIeA+svH699vNz4PKmUTHiXD70FjC1Y87bsaZpIJbARGnmzdP2Fa24SRyUKf7pKj
         l/gVlG/QeLWBiL+ahwy1RFVcSho14n8PqAtxSyUtHk9EOmduzSPA4CN5QbVc3X4mfctc
         NkHy7A+81H+/bXi0JXjFdU9CPpsAdlR4RLOuAMvsBbr9BXCgUUedjbhyM0m8iN93Yc6p
         ZFhxEkLeYGFkHwDtz+L1OUGzrzT31U/idWBw70A1p7PjdPDJ2X+oP4srTQ8yKsly774U
         DNbHBE1MrXUmWAetTIkzU1VY2jSxB9eTSTY+wZpcThmLcozRF1gPaIN6IzyLIbx31i9R
         AvZg==
X-Forwarded-Encrypted: i=1; AJvYcCXd4CS9GcLSmWAcGqtSLr1PglfzbBqPS3KCeRQr/ykT7fS4VbIc0Z8dGcKYhk69ckjNqWj5mqkSqlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTbktizdaYpUBXIrY5xJVLMgi0C6LvBw9siXz0FTZ5Hr7VERf
	O647xbacHn/1gPhcRR8HYCrCRA8tpUcT+oDZb3Wt+Cv+09WxWb49OZO4HzjVIw==
X-Google-Smtp-Source: AGHT+IEGoyeuH2l+G925Avh2F986QTf6nNmEZxSYqlhaBxmXN61/88Q3SSZ9ynilZvc+TeUuYfyKeQ==
X-Received: by 2002:a05:6a20:7f81:b0:1db:dfc8:9d8f with SMTP id adf61e73a8af0-1dbdfc89d96mr3916387637.44.1730733158828;
        Mon, 04 Nov 2024 07:12:38 -0800 (PST)
Received: from thinkpad ([2409:40f4:3049:1cc7:217b:63a:40ce:2e01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452991f0sm7076953a12.13.2024.11.04.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:12:38 -0800 (PST)
Date: Mon, 4 Nov 2024 20:42:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Stefan Eichenberger <eichest@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241104151230.bxsdu4fcf6fssx4e@thinkpad>
References: <20241030103250.83640-1-eichest@gmail.com>
 <20241101193412.GA1317741@bhelgaas>
 <20241102120403.GF2260768@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102120403.GF2260768@rocinante>

On Sat, Nov 02, 2024 at 09:04:03PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> > > PCIe device is connected. Upon resuming, the kernel will hang and
> > > display an error. Here's an example of the error encountered with the
> > > ath10k driver:
> > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > [...]
> > 
> > Richard and Lucas, does this look OK to you?  Since you're listed as
> > maintainers of pci-imx6.c, I'd like to have your ack before merging
> > this.
> 
> If things look fine here, then I would like to pick it up.
> 

LGTM, feel free to pick it up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

