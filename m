Return-Path: <linux-pci+bounces-16256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02F9C0A69
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E4628398A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B02144B1;
	Thu,  7 Nov 2024 15:51:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B12212D0A;
	Thu,  7 Nov 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994707; cv=none; b=D8E+PYHRspeDxur/U6zubMBF22iSA42RAeO/VI+L0+hUgPnZiSlTv2szejTHhrvd8QCvymgqZx/52FuwRDbYYotOIxkWwtS4d9AA+ARbfjj5bDFzmflxMJz5VEFSTva/BkREx6LYIH9wIX1oR0b+VNvUVbWC7dCdRcWKIVcDki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994707; c=relaxed/simple;
	bh=JBCbyGpHifILsR5zwpFwW6YVuy+DOgR5psjt/C5H+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZLse5e/m1WwZrAmJE6GxT/9dA9b7yAlp5ILOPuW3yaICEK6GsGboVKHV7X+8ErFsgPQOdS4DLtFG6d894wyiramTlAJCW/J4vdOUgqxyyOv5MLfgObhABIDQGdnj+1mFL6BfyA89j0aqo4xANDCUTpv8fHt0MDYgyf0yS60y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbcd71012so13062275ad.3;
        Thu, 07 Nov 2024 07:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994706; x=1731599506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9NhJb+I4bTmcgAw+kIq6z6voIYV2ULWb+V9qVrjjB0=;
        b=LpEnavfIpoLZAHya2boEUGzt/TNToOXV6ztB+o9Ovxp+CNDOnoPIHmlIxQ0/L9CjKF
         U4ZZ7pt8Gf4mTShJWK8YeIgHUKvDfNWSgEjni/YVrbFiO3DzgQpVCtFE/d0jLOl/YwJH
         izCBRmFzguCzfctoNleq+aK5Fv18yPB9K1P4TUP2FFMbhYtVNon2Puio46PBTRI6HKEV
         5FQQMaaPkm4ghR2itJe32jaN/NpYKB7MN0hq+R4YGunum9svv1CHDnjmt3OFrkKLRpKX
         p0/h3F2vCzmvVykFyo5TEdKqNJr571uybDIL+ZiUQt+zK/4c/HbpCcWuGO5T7VGsL1yM
         vyww==
X-Forwarded-Encrypted: i=1; AJvYcCWeqh/4oCJrfiCRpfljy2DVbkAtKWsbMHTdQY+YyCROO/YG+kGKlhBjeXx4ODyD5V+/bkB2UAbJlmaXqG8=@vger.kernel.org, AJvYcCXnpZr3e+0PkX/fVYo1jYL3hfr7DbMd6+FoBTy8zAa3XW7FiQDdZW71ZOkOIyYx96CtcKnkZ5K+Gv96@vger.kernel.org
X-Gm-Message-State: AOJu0YzVF7zNakYDIzAFCiCK0FT/SdP70P1C9DLJowQSnrdcZssZbMAl
	z1sEA2GUVBpcvmeyGV3nWMDPb7ZN6Z0Je+Hpgah6DUniFcACrH//Kx8mBEv0+v8=
X-Google-Smtp-Source: AGHT+IHnweMolaV2847a3ZQj9C/f/36UY00gUp5/lxxYk1TyR7otOR6IyNHX0MWvdqNR0mQnnK+moQ==
X-Received: by 2002:a17:902:7786:b0:20c:79bf:6793 with SMTP id d9443c01a7336-2111aec8486mr239229975ad.3.1730994705711;
        Thu, 07 Nov 2024 07:51:45 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5c5d6sm13570965ad.217.2024.11.07.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:51:45 -0800 (PST)
Date: Fri, 8 Nov 2024 00:51:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	u.kleine-koenig@pengutronix.de, cassel@kernel.org,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <20241107155144.GB1297107@rocinante>
References: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>
 <20241106154945.GA1526156@bhelgaas>
 <20241106160520.GD2745640@rocinante>
 <4fc87e39-ae2f-4ac9-ace3-26b2b79e2297@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc87e39-ae2f-4ac9-ace3-26b2b79e2297@ti.com>

Hello,

> > Added Cc for stable releases.  Siddharth, let me know how to update the
> > commit log per Bjorn feedback, so I can do it directly on the branch.
> 
> The existing commit message could be replaced by the following:
> 
> ------------------------------------------------------------------------
> commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
> Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
> device data ("struct ks_pcie_of_data"). However it failed to set the mode
> for "ti,keystone-pcie" compatible.
> 
> Since the mode defaults to "DW_PCIE_UNKNOWN_TYPE", the following error
> message is displayed:
> 	"INVALID device type 0"
> for the v3.65a controller. Despite the driver probing successfully, the
> controller may not be functional in the Root Complex mode of operation.
> 
> So, set the mode as Root Complex for "ti,keystone-pcie" compatible to fix
> this.
> ------------------------------------------------------------------------

Done.  See the following:

  - https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/keystone&id=5a938ed9481b0c06cb97aec45e722a80568256fd

Thank you!

	Krzysztof

