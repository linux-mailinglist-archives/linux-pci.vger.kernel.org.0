Return-Path: <linux-pci+bounces-29847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB67ADABED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDFB3B1652
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FFE1DDC0F;
	Mon, 16 Jun 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zfhLJJAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08864522F
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066164; cv=none; b=omwzHf8Pn/IiyhRmcgCP18Q/Lv1rwOpPVFPFzTEOdQ0uuCORtdeEdSyhibNUmhD6AvONVLM25CFK85FzM2Or8Id3Zg0Pbjbj8n442VbGH9tPDKshS5qLwLD3MWCF3lh4kXbk9HFGJWx0DuXvoD6zRn+yjPYdxb2V24T9es3VeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066164; c=relaxed/simple;
	bh=/lndhu9yGBe6TW5IJXLYk+C23E2rwVBACMXteTZseA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alzA74oqHzgWxnKdl5VnmWr5qxY2wwgHOnil539MvBIEaV676kwY232gHHBOVlcZpilULcm/Zl9ZXxN4ZDhcijchfN3KsfyrRk1wQo5q2yJ8TqPU90e46ENlIVOKC6+O6RfNN0cNMcx1CUhoYIGM10pxfGOyMkvsHgadyGdPzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zfhLJJAS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b82f3767so1818331e87.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750066161; x=1750670961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lndhu9yGBe6TW5IJXLYk+C23E2rwVBACMXteTZseA4=;
        b=zfhLJJASk9uRG1em0/TbG22s4hKFheHRdOB/LmQ8+XBMAkYikRChtPhTyEpIt4/gp2
         aQz9y+vYAs/QTSh94jT5JNCecnVpEaEdOzioSAXTmbt0YsfKzRHrxOl2q6MRQ9MzXeih
         uiVAG2hlmSv1oKjgoapMoRMj/o0TpHImgaV616053GXkiWdc0lgDbV9U1Ile6LBf+ARt
         ZEV6QjjsBjKp6dSsoZeFu0hJAG0CGsPOBQIBQxs0ksmOBIShSjW7O6Mk5AoyQ33yRpnR
         uvRs+AjDGeayMEZ/IQUTInnlqmDSy7imOjxvFTz77wJTcAb8WFvdmrzxkyBQEFNsA6Va
         SlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066161; x=1750670961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lndhu9yGBe6TW5IJXLYk+C23E2rwVBACMXteTZseA4=;
        b=IQOVqO72ySfahSeqHOWGAV4L2CRg01B49PI+tvZz8t+JLJsGtOLRpnTf0WK9ENxD0Q
         W0TpUDozuZ0cAOOinLendIPIAMvs1P0IRJRu82DT9CfM50WfWDE6QqfInrVnOirhcluO
         Th5Y+C8tEHtQULVrKlkZr/AkLC8m6UPug984EfGcXgqjSEg2MjH64ovQEhSYe541BjDF
         KF8BpYiywbG9xXwRW+lhJa1wgwZiApGviMtKPotYV72/DzjV0T2WT7bh/xj3t5cX8de8
         +kmxSqjqqbcr+3yp8qmHtgtJCezpjaX9Ng9wbEL9Ea87/tU2MIOS4eX3vrKlVEheJ/Q5
         dX5w==
X-Forwarded-Encrypted: i=1; AJvYcCWHSyc8/jucyAh2VGNFNlx/5vxWNpd56g7H/RUo91BJAWKy/QfVr/+AxcxBKFycg0jwa9oiXx0LLK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+JLkPnpxDyIfgiM+RjXmDRF5/p9k3ibU0CKmnV5Tl4mijNMP
	gju7t4yJTmEcYYJJc2ilukbRApR24uYzWh1jkJhNx09SgTwtyEsbm0an1qnDnvyTDfUO2SUKxSv
	/1wsDgF2dFU8oTRlCNGdiAyz4JXFJ07cgdUjboGikww==
X-Gm-Gg: ASbGncueX6S5POEIn/AeXpTYQPUMyLHnXHSPF58EzIDk67argfIMWuwhEkE23AsuxtA
	4TMPBU7nvDUjeftf6VWxZh6MgNf1fHEKp0ctSATNLvD3rQLuWTk+FRlD7WPbjdAfQf7FPPeZgea
	CbyTANKHTf6ToI/bJkdhXSpbj1MmwSBmCbIXncmF55Mgv8xobPpwS/wChx8KO42ujK1wGMz96oM
	ig=
X-Google-Smtp-Source: AGHT+IGMxjIEHlU79k9xl0MB3VY8QpIujRZlki13HAtbUrVMtpOaF6xL9wF9B9gST0OonaZabCgNc4iKjM7QCrtDCcw=
X-Received: by 2002:a05:6512:1246:b0:553:2ff8:5e0b with SMTP id
 2adb3069b0e04-553b6f1a1f5mr2047128e87.42.1750066161069; Mon, 16 Jun 2025
 02:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616053209.13045-1-mani@kernel.org>
In-Reply-To: <20250616053209.13045-1-mani@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Jun 2025 11:29:09 +0200
X-Gm-Features: AX0GCFvBWNqrCYLkvyDb91OTPM5YHcglS8DHVJx53aZIUV0kN6F-iSKI34_nORM
Message-ID: <CAMRc=McN9mZXZfj65XAj_UFnCcMe46XMQzmHcUs+X6DKgxtpyQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Jim Quinlan <james.quinlan@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:32=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> independently of CONFIG_PWRCTRL. This creates enumeration failure on
> platforms like brcmstb using out-of-tree devicetree that describes the
> power supplies for endpoints in the PCIe child node, but doesn't use
> PWRCTRL framework to manage the supplies. The controller driver itself
> manages the supplies.
>
> But in any case, the API should be built only when CONFIG_PWRCTRL is
> enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> fixes the enumeration issues on the affected platforms.
>
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pc=
i_scan_device()")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=3D-+H_PKAxXRU78svPMR=
HDKKci8AGXAUPg@mail.gmail.com
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

