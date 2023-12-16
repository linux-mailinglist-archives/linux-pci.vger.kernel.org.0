Return-Path: <linux-pci+bounces-1090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED6815BDB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751F71F233C8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8C3528A;
	Sat, 16 Dec 2023 21:29:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97A35283;
	Sat, 16 Dec 2023 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3470496e2so15887495ad.1;
        Sat, 16 Dec 2023 13:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702762161; x=1703366961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z1YEGbMBuLA0v2EdVoA6UHG//mDgq0iVBKq8k5vnhY=;
        b=xMWxBgMJ8nEfoMzWLhk98Xzn0+1RSFL+4ZYgYzAaZHps9C8waatik2Th4jzHJ3rvGm
         DRXnd6gT35cnYl4aVAaJHXemivae9yycfFYN43WaqakMuXiQp6qGJX9MIWvNwlNQPUkL
         Q6CdJc12crQPS5MCeHHL6kqf65ICLksgrU7pY+UNawoHOgWpCWEKxu64yc8+hqRXVmAS
         cZKfULyChMY+5nKtalek10FpBeOLoS22T1UIIHzVYUppVTpn0GT9BF/mUCx8af9ZuMFf
         c+zJYXJ8uVlHEWjYS+mqf8e3gJ/IOQOyBrg6e5yfWI4RZlAv91H6wkERVh8vWIEehYTh
         2+PQ==
X-Gm-Message-State: AOJu0Ywd74DgVbnq553nohy7IVAKp652J3UAQBPZlcBuYxxxD+fXOsii
	g/mAyv3A7ZF1dCdOec9F7zk=
X-Google-Smtp-Source: AGHT+IFNFUKuifGm9kwkZTc8UZTIrh8binIwNbqamSOqM+PbE94RiW5kZXMakAE3KGNg54UI3C6fsQ==
X-Received: by 2002:a17:902:eb88:b0:1d0:265:6a2c with SMTP id q8-20020a170902eb8800b001d002656a2cmr16457609plg.11.1702762161181;
        Sat, 16 Dec 2023 13:29:21 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001c88f77a156sm16295157plg.153.2023.12.16.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 13:29:20 -0800 (PST)
Date: Sun, 17 Dec 2023 06:29:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_bjorande@quicinc.com,
	fancer.lancer@gmail.com
Subject: Re: [PATCH v2 0/1] PCI: qcom-ep: Fix the BAR size programming
Message-ID: <20231216212919.GA3302836@rocinante>
References: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025130029.74693-1-manivannan.sadhasivam@linaro.org>

Hello,

> This series fixes the issue seen on Qcom EP platforms implementing the DWC
> core while setting the BAR size. Currently, whatever the BAR size getting
> programmed through pci_epc_set_bar() on the EP side is not reflected on the
> host side during enumeration.
> 
> Debugging that issue revealed that the DWC Spec mandates asserting the DBI
> CS2 register in addition to DBI CS while programming some read only and
> shadow registers. So on the Qcom EP platforms, the driver needs to assert
> DBI_CS2 in ELBI region before writing DBI2 registers and deassert it once
> done.
> 
> This is done by implementing the write_dbi2() callback exposed by the DWC
> core driver in the Qcom PCIe EP driver.
> 
> This series has been tested on Qcom SM8450 based development platform.

Applied to controller/qcom-ep, thank you!

[1/1] PCI: qcom-ep: Add dedicated callback for writing to DBI2 registers
      https://git.kernel.org/pci/pci/c/a07d2497ed65

	Krzysztof

