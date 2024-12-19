Return-Path: <linux-pci+bounces-18759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767069F7757
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC661675C7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8DE2206B1;
	Thu, 19 Dec 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nPVx6af0"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B138F9C;
	Thu, 19 Dec 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597251; cv=none; b=Uz4BPXpu9dHOqBI/S6PRAiNm5I4nJkjxFFHoN1NmW3UhqaUURqnKLtw3E3ggjYRX30B7FkQAmMdKSDNuFAFa4i2R1xn0CGnNrEdP99r/XaPrmTspH2WEz7jNVA0weaXbrkmzd9L8hZu1xTxkBGVGam6+sestHjzZXfu9hParA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597251; c=relaxed/simple;
	bh=aH8hOxMWNri6n3AXLm5XKm/x7VG/KuqeWG7WSEnl1aA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktJXl/+RzeXtyDozi/y+zPC6Ga24K7yrbGcQlNUIkHFA5n1ymDd+wFftpqP8cClogrDn0L4wLGMtqcfCAfVT4a75SSAVpIEGd5dc8d16jVu/Xn91Jvj6O04ye48gn7U/TofoOZtkfvmtEh7dbqj3rUHFoqukeDTn/z0s1NX0RRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nPVx6af0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8Xnpd010288;
	Thu, 19 Dec 2024 02:33:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734597229;
	bh=xoD16qMVMhh1M8zTCF94gkmnIDqAYF1G6HVP1TZxgHM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nPVx6af0mmAWxr0GTu/ad7uUpB6Xz7adboq8s2dcWi/r8bll7nYz9MYfVqRf2dIIL
	 w22wk51Xh6rsueBRZ4/KhAlHcDM3s9JF8VZuXg+yKJlUs3hnPSWb9HPrN/Icxctvau
	 +QOAyfYieLQ+KPTQvCQAX7t2NpaAiBbxYF2SrMiI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8XnFV098299;
	Thu, 19 Dec 2024 02:33:49 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 02:33:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 02:33:49 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ8XlwT096020;
	Thu, 19 Dec 2024 02:33:48 -0600
Date: Thu, 19 Dec 2024 14:03:47 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <s-vadapalli@ti.com>,
        <thomas.richard@bootlin.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rockswang7@gmail.com>
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Message-ID: <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
References: <20241219081452.32035-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241219081452.32035-1-18255117159@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
> If the PCIe link never came up, the enumeration process
> should not be run.

The link could come up at a later point in time. Please refer to the
implementation of:
dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
wherein we have the following:
	/* Ignore errors, the link may come up later */
	dw_pcie_wait_for_link(pci);

It seems to me that the logic behind ignoring the absence of the link
within cdns_pcie_host_link_setup() instead of erroring out, is similar to
that of dw_pcie_wait_for_link().

Regards,
Siddharth.

