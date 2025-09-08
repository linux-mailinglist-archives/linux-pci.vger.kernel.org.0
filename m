Return-Path: <linux-pci+bounces-35637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD64B484DA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C23A8622
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1B2E3AF1;
	Mon,  8 Sep 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="irxHTRSu"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD0747F;
	Mon,  8 Sep 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315644; cv=none; b=F9TNicPCMzBP/gaBxh0rkBSjsn6Bn7QUXuLfgPFqB1LO9ykfyXb7osZoxHdgnUmmnsMp8cxZmbD9uOXKrKSrn/crtNUIAWs/dK8FcezzX+HUaVaowsfi4PIY4Q1XaPLW2YsTGYkjLkDvuD01ODY7StW2crSfCUsi+vEdS3BBnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315644; c=relaxed/simple;
	bh=T6RhibH8am5mfVMsJE9WUUoRQfTWtXFnIXYdTwd2xts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXWM+2IrAW90hPcKzUeln3ocGtMeGL6EStMZxxGzriSV8fulFIlKByUh2B1FRfu7+hRf6jGtuDt91JBwjbOFAE5GjNl65p5KF0H3tZ/vkVZ3W9XQqe1iufb06KtwwXUUd3qx8KbvtARwQvN9Q/Hvtl6inJ6mQlhEu+QNQiW9vOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=irxHTRSu; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5887DPKv3737891;
	Mon, 8 Sep 2025 02:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757315605;
	bh=INGtYHjQfpr0I5BpFzHQqufbow0F/EqArjbMwO9sRLw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=irxHTRSuhFggDIGqPEk3fMSzFmzFNJ1qxO+PSh9Lz7t0kFo9qPudWy2jApW0RHuyY
	 B6KucuhyE3Knxbp9Rz4PrVUFYWRU9h5uq5EEQHfP9aHZfknneXTOtkd7U6O+Mu5hHC
	 0wE1BS43NS3GTJN9B4sRrC+XHYS0He3YPYdkocJQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5887DPNw2822048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 02:13:25 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 02:13:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 02:13:24 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5887DN9T485025;
	Mon, 8 Sep 2025 02:13:24 -0500
Date: Mon, 8 Sep 2025 12:43:23 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <fan.ni@samsung.com>,
        <quic_wenbyao@quicinc.com>, <namcao@linutronix.de>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <quic_schintav@quicinc.com>, <shradha.t@samsung.com>,
        <inochiama@gmail.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <18255117159@163.com>, <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH 00/11] PCI: Keystone: Enable loadable module support
Message-ID: <5825153e-833b-4aed-bbd5-e0f58e922aa0@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
 <2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 08, 2025 at 09:09:08AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 03, 2025 at 06:14:41PM GMT, Siddharth Vadapalli wrote:
> > Hello,
> > 
> > This series enables support for the 'pci-keystone.c' driver to be built
> > as a loadable module. The motivation for the series is that PCIe is not
> > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > does not need to be built-in.
> > 
> 
> There are concerns from the irqchip maintainers that unloading an irqchip
> controller is a bad idea. We had a lot of previous discussions on this topic.

Ok, I wasn't aware of this. Thank you for pointing this out.

> 
> But I would certainly welcome the idea of building a controller driver as a
> module (tristate) and prevent unloading it during runtime (by keeping it as
> builtin_platform_driver).

I will update the series to retain 'builtin_platform_driver' while
enabling tristate support. Since the intent of the series is primarily
to convert the driver to support being built as a loadable module, and
unloading it is only a secondary requirement which is optional, I agree
with your suggestion.

> 
> > Series is based on linux-next tagged next-20250903.
> > 
> 
> No need to base your patches on top of linux-next. Either do it on top of -rc1
> or pci/next.

I will keep this in mind when I post the v2 series.

Thank you for your feedback.

Regards,
Siddharth.

