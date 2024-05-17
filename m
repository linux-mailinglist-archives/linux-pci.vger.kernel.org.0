Return-Path: <linux-pci+bounces-7631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC28C8AA8
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADFE1F25988
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563F813DB83;
	Fri, 17 May 2024 17:14:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D313DB8D;
	Fri, 17 May 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966040; cv=none; b=YKKFJE+uGj92QL8pxt1C9E8YGq0NK1oYJfdKAijU+kta5Gw5k+5N7ZHq1YHmGkkdFrcNmbs4benMUaGO4ZnTxCFLv1rCwmi4/jSMl+79WmDFv4V1mTIdMp+oZIojAt0/wTfFl5P69+NzWiHuCwDXv5SdYPqdMSpSmUW1cDoEEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966040; c=relaxed/simple;
	bh=ZLNgLIDYm7j4h60dVaUFv95BXShlTksFuGmvjb9HuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti6HE82JlVCnrBfNSZjIHqBEEGAZawCWx9a3Ojy5FBnkio8RfBkwem++C9VsXv+IDZDMLGCDAs5wygKEloKR6ls7sKPudLbCxxQXEqL4BLxWKdONs9yNvptY6ZkVU16ZlQJryeIq++41JrkSZd88PkOpe+U/U3OtDGf+ynuB6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed835f3c3cso17163965ad.3;
        Fri, 17 May 2024 10:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966038; x=1716570838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhjqz4NmkgFX3zGkCQAyczxx+lTvdju/sgqauMmpFCg=;
        b=ddwfm9wC5VYdkPCLUNtlyiujucSOsYwV2DRQc0SKBQr64qB0NduFtGTInegFmcm9w9
         T118YbKBByxlznuFQuB8jCwHD0yx1ZmSB4MoGE0DqPAbvcYxg3tX8oap/Vyj8UU/rkmF
         RDskGWZ7HKZz9kRLF1W8DAYyrK5zT9jDHctuCy4ALe6sJrpFUQc2DFdVz/tNpRWGHmxz
         1TVxXF0mC2fRaxmgB7aqYAKt8mXwLWBTqrtv7JIwTgBdoNA6QcPjCRAFbNpCrnh6NyY1
         B/UR9StGb/Rl0O1RnNfe9q4sq+JakMC+ur8isssks9emG530qh7Kj3ARms/NOCjeT0k7
         PO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVG4/OXtRghLM/YqShXItZb/Re1TJekIhcleUwkJgCiRmJysovXoyWxt93BFDlbEgNmAi8EAZulKCRxC1c1+sCzCShpkfJ3YHbuikbelCcpf48bDIPSrMh4LRQzdFBuTapMny3+yD8l
X-Gm-Message-State: AOJu0YwaP4takB3umcgaxnvt88HUBca4CPgGgfP9nhChzB+44unGt43J
	GiGWNNvP7lpTx+8XN+K5/Z0CRStZNUlW6cYS8+urAx5UJa0hSjv0
X-Google-Smtp-Source: AGHT+IF5DLp0eQI8CtaX9Bkdm3uAEdWlo8Lt6AFD/vLjUUOsmZ9BH4PO0R0yGTRgvEHq0Za0qrPWRA==
X-Received: by 2002:a17:902:7b87:b0:1ea:9585:a1d7 with SMTP id d9443c01a7336-1ef43e293d9mr212382285ad.37.1715966038218;
        Fri, 17 May 2024 10:13:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2563c0sm159246945ad.287.2024.05.17.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:13:57 -0700 (PDT)
Date: Sat, 18 May 2024 02:13:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4] PCI: dwc: keystone: Fix NULL pointer dereference in
 case of DT error in ks_pcie_setup_rc_app_regs()
Message-ID: <20240517171355.GF1947919@rocinante>
References: <20240329051947.28900-1-amishin@t-argos.ru>
 <20240505061517.11527-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505061517.11527-1-amishin@t-argos.ru>

Hello,

> If IORESOURCE_MEM is not provided in Device Tree due to any error,
> resource_list_first_type() will return NULL and
> pci_parse_request_of_pci_ranges() will just emit a warning.
> This will cause a NULL pointer dereference.
> Fix this bug by adding NULL return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: keystone: Fix NULL pointer dereference in case of DT error in ks_pcie_setup_rc_app_regs()
      https://git.kernel.org/pci/pci/c/b1d4d63d52a7

	Krzysztof

