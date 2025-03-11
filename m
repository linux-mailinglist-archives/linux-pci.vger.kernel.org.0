Return-Path: <linux-pci+bounces-23406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53361A5B9B7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 08:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872827A1512
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB62222CD;
	Tue, 11 Mar 2025 07:25:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB21EDA03;
	Tue, 11 Mar 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677950; cv=none; b=VKith56fFXnfN9fMTC4Wr35TWlb/7ElTCmu5QmiF4KVSiMsjjW2U2c3h3Ltty4kCcDHAY0fawwCU+V7He9z17p74IyN24jq6JzQkLC9FEAA1Jar0w0AoubkWkzLkmmZ0zMD2IuaIsZYQhEM52HX5TRKlam+5SPJi8FkyPOOns1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677950; c=relaxed/simple;
	bh=QRkNwDyV70SBx+F0V9Vg4Rh30RuzgUMBM7/jeP1lkAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7hAKWpJXANvL8cXuIgI7G0A9i92UybJwAn0tQmoJN6amAlCrXDY+GyhnTqypZVmy8xG6meq0fHk2fZ42HFEVjN81UcNito0N0iuv8LV0Qo+iEXb4r9Ot6MvgvtgrPqhB565O4YXcqGXeO+5gSHa0duU3apb2od85ot5S84HRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300f92661fcso1924411a91.3;
        Tue, 11 Mar 2025 00:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741677948; x=1742282748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amwnjhquihQlw3rFST7jVWbfUF1Yah8j1kpH8njxrZY=;
        b=CRa60Xsmtve9Dz9FFIggb9oj/DCECmy6woNddEtLFsg9sMosJA7HSe+C2t4rMtSugJ
         BnNHQGIkmCWi5UbIdQzQejhw1rof+bYh+BtCPJ4nguCICRPJ4Sb5N3ZOtoaI7cPAHYVQ
         Z/N3RtPaHZh9syBSHjvcjv5vKKjMekVuG6meaoAMwbuR7DPC4IU8xQEZrf5hOd0XL7k5
         OTS3C9EG0MFCkbvKpivheRSRNK22PLSb18nktGKe3qJBQ/Z8BwgXjXLWoTnuYR1TIbeD
         DChYb1xs81kQmoQ5zAHZjwFOyOlawcZXfY0rXrvzdTPMcUbrsx0pxxvOc6GLoP7AZSTJ
         e/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUHpKTZiSJd+gzxpnyQsgAUzQ6A5wW+cOobF4weAQHX14+yZ3Fb8OfOWKXYhH9l5qUbdp+DGnNLjM2TZQ==@vger.kernel.org, AJvYcCUqOaTU5OpyuK7oIPpvLZP2O1mAALRkvJVWBISZRmWpSXisLFZ4saUc8shEp5yzw5myQrZTpLyVZ72dgQ0=@vger.kernel.org, AJvYcCWrk976T67y4l2zeaZhrjpJ0QZ82RLX5eEx+xeoF5X+xQKvu4/Iu3ZBXG2x30IM3lyQox0YeuXDZoEt@vger.kernel.org, AJvYcCX6IaZWBgifcCCdYKvMIsisgL2sjGQW0DNz5rHaYShEkGKsgsXEF4dlXbD8h2l39RS+PjYjfzqY@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOi0V8+BSIMQgvDJ9+GDrUKsxd7lunBKyLBqvbc0L6M/hqJ9P
	bko1Msqz51EhS1VSB0sQzSmRUxueJhyRaLB+vn2kwWIIdyaRkPlm
X-Gm-Gg: ASbGncvpX4uqEYnOk18FJO8nSaW2mn2uHTAY1PnJkMvHpb+gT9d7OB+kTcssdAOoaUj
	xzgwyyjswqO1tSeNoFS96XV97qpSu0sL1oObIbY48g5rqtz66KjmZb5bnLrfcjQM2NeFzIXmIt9
	sjta2RPH4q7PlAFv/WxY2Z39snFXR/elHFqAWAuTNV79ZkkfoYQmpVbtUbxaRI0AvLx4aAlUAIj
	AtgOYohbfwz2D+lut9NKVFnPAqYZisXBM5JVafTvfNMUEGnVeoXdojmNgm3IHZZsCjxKBJgoWk8
	Bjv1mxpTyI0+IyTJr7rIQPx6ExUwhm0O6lq5jJTPxW8xWIZqJNlaQL/idPcOp3Y0JfrEXOdvWOT
	9FqU=
X-Google-Smtp-Source: AGHT+IFHY5f+4sJatR6BI17Adi4AuhVFX9pxsgEfHSvv5C3l/7gBr81/pwoEGMGBCuJ7SqKtWyZgYw==
X-Received: by 2002:a17:90a:d450:b0:2ff:5ed8:83d0 with SMTP id 98e67ed59e1d1-2ff7ce91ff0mr28909573a91.16.1741677948459;
        Tue, 11 Mar 2025 00:25:48 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301034433e9sm909027a91.1.2025.03.11.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 00:25:48 -0700 (PDT)
Date: Tue, 11 Mar 2025 16:25:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311072546.GA277060@rocinante>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
 <20250311051806.smcu4o4dxpngimth@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311051806.smcu4o4dxpngimth@uda0492258>

Hello,

> > > Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> > > expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> > > already reuse this macro since it accurately represents the link-state
> > > field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.
> > 
> > Can you confirm for me that the following use the correct macro?
> > 
> >   333-static const struct j721e_pcie_data j721e_pcie_rc_data = {
> >   337:	.linkdown_irq_regfield = LINK_DOWN,
> >   
> >   341-static const struct j721e_pcie_data j721e_pcie_ep_data = {
> >   343:	.linkdown_irq_regfield = LINK_DOWN,
> >   
> >   347-static const struct j721e_pcie_data j7200_pcie_rc_data = {
> >   350:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> >   
> >   362-static const struct j721e_pcie_data am64_pcie_rc_data = {
> >   364:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> >   
> >   369-static const struct j721e_pcie_data am64_pcie_ep_data = {
> >   371:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> >   
> >   375-static const struct j721e_pcie_data j784s4_pcie_rc_data = {
> >   379:	.linkdown_irq_regfield = LINK_DOWN,
> >   
> >   383-static const struct j721e_pcie_data j784s4_pcie_ep_data = {
> >   385:	.linkdown_irq_regfield = LINK_DOWN,
> >   
> >   389-static const struct j721e_pcie_data j722s_pcie_rc_data = {
> >   391:	.linkdown_irq_regfield = J7200_LINK_DOWN,
> > 
> > I am asking as some use LINK_DOWN, so I wanted to make sure.
> 
> Yes, the above are accurate except for J784S4 which is fixed by this
> patch. LINK_DOWN i.e. BIT(1) is applicable only to J721E which was the
> first SoC after which the driver has been named. For all other SoCs, the
> integration of the PCIe Controller into the SoC led to BIT(10) of the
> register being used to indicate the link status.

Sounds good!  Thank you for letting me know.

> > Tht said, the following has no .linkdown_irq_regfield property set:
> > 
> >   355-static const struct j721e_pcie_data j7200_pcie_ep_data = {
> >   356-	.mode = PCI_MODE_EP,
> >   357-	.quirk_detect_quiet_flag = true,
> >   358-	.quirk_disable_flr = true,
> >   359-	.max_lanes = 2,
> >   360-};
> > 
> > Would this be a problem?  Or is this as expected?
> 
> Thank you for pointing this out. This has to be fixed and the
> "linkdown_irq_regfield" member has to be added to match
> j7200_pcie_rc_data. I will post the fix for this.

No need to send a new version.

I will update the branch directly when I pull the patch.  Not to worry.

Thank you!

	Krzysztof

