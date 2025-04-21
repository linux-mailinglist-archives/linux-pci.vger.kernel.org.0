Return-Path: <linux-pci+bounces-26330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCAA94E5E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E33A599B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4620E6E3;
	Mon, 21 Apr 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRCPV8bv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAD19E99C
	for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226052; cv=none; b=ZV+PJWqkVKnK17WVayBusAE1LYIA2y7ItmBmM9HrVDLXDMgexCwVku0ft0vUkzSrGuUbOmtoSTd0hHJn11RUb7Ga5MHq2LoTgjtPcfRR4f+NbvJTMZ8ZFdx2jrfgiPdb2/LhQkC9HFYI+2hzaVnXxe43Nk4GVbTXk1HEo4NUC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226052; c=relaxed/simple;
	bh=cn+6RgyhJyrOchkn6Kud6JEzYKcCVkqWUi6B/Ufas2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qyjKRXVE/F6x1RCpKXic413EMXOAAAy+65SSTvTYfwheix5Qzk6xA19c4fpI/A/SdWgRk+8gyzGrAy+zjVDyZ0TmWoVhsAC5SvSX/1Bsgl1sspvRUq2Sl/bBiOIeq0UIGGCHVSOF3qoK43mv+3m1tGAvuhLKGXcc11yN+qufT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xRCPV8bv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c336fcdaaso40848315ad.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Apr 2025 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745226050; x=1745830850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouxcv+1YvuOkFG0jn+K0SUmzYu0kHcqjiq9UZ3JDI9g=;
        b=xRCPV8bv7Dln033MHYLb8EKfQjp8ZBVRXsfy8JMBxINlH8RFatJASwA7mrXt+WgGqh
         VZxtyNrpqV6zX9Ax3zI8f/yHV1dBgIz9wjnnXmz7kawi7CDNgUeWY974UclPePrPvQ5c
         6fbHGjFxvHMSxeQz2f4OvZYZvFXD2kx9ORp4FH3A76AFS3Gb47lspJZAJMTCozrmlbHJ
         EKdA7yru7p4QPIonBfymU6R299LPK8eY7LJKkz5lMg/IRI9/6GD4huh28xyBdHqevAZm
         i32J8+G2Ez4mNsn4an2ZRJ6iABYuciY1ugyTPzyJbE66o3mr68JJqUN8iz8VgXgGF44k
         2Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745226050; x=1745830850;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouxcv+1YvuOkFG0jn+K0SUmzYu0kHcqjiq9UZ3JDI9g=;
        b=vi1FccljqHK6e7hl+BjFyMfhW6qMSZQqHFidHGp6443g+ZKzZZmPFkPyX13DgqfxXN
         kvJVbeeTBVSqNH3UGCLLIcak7ruJroPXUbrMRIkJVjrjzCrvWbR8NMnhyfDQXBZu63gl
         4SdSFRTQTmPv68sHIDH237qBOSofy+9qMYLs+n4W28+bBVZzNfSwP/j5ip7i1hmCFc6f
         3870DXd1Z4wKdC9dcQgGljs06a5VGjFjoWov5S4rYS3QW17Uo9QYL3xHW+QugWScW1W/
         0rd4ugeWWKz9B39S4GHhnPH+JxrNajGQq/vRw86sgc/m4IuNvvraGtBtKUZZRa/SPImk
         ESjA==
X-Gm-Message-State: AOJu0Yxe4rF3OvnKph4KA864lEvHFtbSBAh8a3gnZNZTm+Vvma9+arly
	9R9FevXVW8V0emsHaYvWQtwTlZeYjVi+TGSOn89EDununLuNELhd4Dmi9djSQQZPQJJ5OS70Q+w
	=
X-Gm-Gg: ASbGnctfZBlVOUFow8wK+uFN8WSxnv8Dxyx8uUfdLdf28n13UcoScRlvc/5F1qjrba9
	Jd6DFOBwULnliXiKjwCIS4AYXsfz4A1JrmgcaJGOMI+/am1thY4n11ORF2I7hIRXnqgEYEL7Md8
	dRF818aDeZondaFTWNFtUCQRlD+n9Jh9nsDAnrCDV7GLDWVWNf5PbbiOJ4f/paazF60QWgVDl9n
	OWriubJP5E03TvUHMoHTWU/TotsF3UGUaSF9U5KyQsDO+HtlXDoontrwdx9ADemvyGOqznpK1TJ
	+rEUMekbGUZ8vTxIbrDC5tqQcuJIPHuCA8x+82zDy+xaUy21iZHbqzU=
X-Google-Smtp-Source: AGHT+IHiH+ZKaGvLzhdCRmqt8PauvespnoNN+FTbSbWKbr7BrL2gDOrlx85PNmYsb8mZdnhuym89Hg==
X-Received: by 2002:a17:902:e5cf:b0:223:6657:5003 with SMTP id d9443c01a7336-22c53611037mr177515125ad.32.1745226049715;
        Mon, 21 Apr 2025 02:00:49 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.74.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db1273edbsm5278363a12.8.2025.04.21.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:00:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
 bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, 
 18255117159@163.com, cassel@kernel.org, 
 wojciech.jasko-EXT@continental-corporation.com, thomas.richard@bootlin.com, 
 bwawrzyn@cisco.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 srk@ti.com
In-Reply-To: <20250417124408.2752248-1-s-vadapalli@ti.com>
References: <20250417124408.2752248-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v4 0/4] Loadable Module support for PCIe Cadence and
 J721E
Message-Id: <174522604280.13504.6844455381479495318.b4-ty@linaro.org>
Date: Mon, 21 Apr 2025 14:30:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 17 Apr 2025 18:14:04 +0530, Siddharth Vadapalli wrote:
> This series enables support to build the PCIe Cadence Controller drivers
> and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
> Modules. The motivation for this series is that PCIe is not a necessity
> for booting the SoC, due to which it doesn't have to be a built-in
> module. Additionally, the defconfig doesn't enable the PCIe Cadence
> Controller drivers and the PCI J721E driver, due to which PCIe is not
> supported by default. Enabling the configs as of now (i.e. without this
> series) will result in built-in drivers i.e. a bloated Linux Image for
> everyone who doesn't have the PCIe Controller. Therefore, with this
> series, after enabling support for building the drivers as loadable
> modules, the driver configs can be enabled in the defconfig to build
> the drivers as loadable modules, thereby enabling PCIe.
> 
> [...]

Applied, thanks!

[1/4] PCI: cadence: Add support to build pcie-cadence library as a kernel module
      commit: b51c6fee0a06b71e9bf610f4b294426d0a1f1b51
[2/4] PCI: cadence-host: Introduce cdns_pcie_host_disable helper for cleanup
      commit: 23c498ea9abd7bed7d0f8c1c5f63459100b01028
[3/4] PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
      commit: 5f8c840aa407588a7eae89af1301ba19c307aab7
[4/4] PCI: j721e: Add support to build as a loadable module
      commit: 7a68d4ab59fa66ebbd9b8abdbffcaf748e109ad7

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


