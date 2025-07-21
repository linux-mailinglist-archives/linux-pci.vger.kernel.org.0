Return-Path: <linux-pci+bounces-32622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9BB0BD96
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB83170898
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869A280A5A;
	Mon, 21 Jul 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j+v6Ue7B"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186623BB48;
	Mon, 21 Jul 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082497; cv=none; b=r0b/kniUdAPk4DCzEqOg9ySOb+mDim9ju0FDuTWAmPrep0YOa33ce82GOYTjOAQoTZ2TMylq/wMDs4ZyM6q4dk/j2wRX+3dfAtPfYsPEdTKEM72blMOPUnuty5T9RiJui3VaCNxaed+0ImOABC3e9s60TW16veKko/9M51ygJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082497; c=relaxed/simple;
	bh=2oaGPuuDj0uRoNLZedS/V22QFQi9DwxfT2TGmhogcQg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4hWmpLDlEB4N+H82WsZPhSemhH/Te37BozNK+1HvNS+SUx+73IZfpXLdaWX9nkElV7nb6beRnYLHUHNIMg+kFN+LSx+3iJDNW99X2N4628pzi4tuTXTtvC+8p0pYVjeAhbO542qC+hWcaPH9Xt8jGI1ZkbiTHP5eG/urwwT+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j+v6Ue7B; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56L7L8OZ752519;
	Mon, 21 Jul 2025 02:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753082468;
	bh=Pzzj8GjdEcvknYctYdwrrCPn6t7CVQ+ZlgbfQZ6H/f4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=j+v6Ue7BX+/w4cxYeYVTxgnSHIQ5WQ69WF2IJcL9ZB5aK6MYNQgR+mUM8RullUQMu
	 w+WDJWSFl2wfwCMNEzsIzxcFfL29cJKYvV3fu5XA+l53HIL+K0DrKJg9CrCFR/BLvr
	 I1HR4R4Owy3C4clDneFh2BWpedm04C13z7vEATSs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56L7L8lk107316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 21 Jul 2025 02:21:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 02:21:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 02:21:07 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56L7L6gT3438091;
	Mon, 21 Jul 2025 02:21:07 -0500
Date: Mon, 21 Jul 2025 12:51:06 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: <huaqian.li@siemens.com>
CC: <s-vadapalli@ti.com>, <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <helgaas@kernel.org>,
        <jan.kiszka@siemens.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <kw@linux.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <nm@ti.com>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v10 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
Message-ID: <7eb6b36c-da94-4363-9ee2-d3d38ec46a22@ti.com>
References: <20250721025945.204422-1-huaqian.li@siemens.com>
 <20250721025945.204422-5-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250721025945.204422-5-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Jul 21, 2025 at 10:59:42AM +0800, huaqian.li@siemens.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> from untrusted PCI devices to selected memory regions this way. Use
> static PVU-based protection instead. The PVU, when enabled, will only
> accept DMA requests that address previously configured regions.
> 
> Use the availability of a restricted-dma-pool memory region as trigger
> and register it as valid DMA target with the PVU. In addition, enable
> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
> VirtID so far, catching all devices.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

