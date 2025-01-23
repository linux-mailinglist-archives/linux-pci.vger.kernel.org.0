Return-Path: <linux-pci+bounces-20269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D76A19F35
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 08:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591C61697BE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7820B7F4;
	Thu, 23 Jan 2025 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ThqJFKEY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76120B7F7;
	Thu, 23 Jan 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618072; cv=none; b=O9pMVbpDqQNU/LlnjYOY3H8QTy8pXAeXt1Ka9M7SId+GOn6fXdSq0Bto/UHfsEtVkJ+Oi4RvnqJ/bbWsCiUFZzdgSqaoy8jy5HmfkkBtTTGJ0ZpCGS2Roj4hQKrB6yOfi8RF+6JB7GxTyIuX1pHFvFT3ZqM3YpNbtDW+bxyfWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618072; c=relaxed/simple;
	bh=A12lfXcvcN2s65HoEcoW2XNgZeuA9GNGD5x2iTGNbT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT72fIqnz9Pmwk4RBeqjMwaaBmTqGhihOh2fQ2eB8l+QOY4NDN6SHzr8WTq//dVnrgwK1FsPfa9WXLrXTz583AfaPh4A4EHHaXXgYbdC54aedpHENmlphH6/g1XYtaf8md1WuhzBmcxOLZsyZIGydS3QRGgKOoRYmtDYmiact/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ThqJFKEY; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50N7eqkF334185
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 01:40:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737618052;
	bh=A+QvJTJJzZOZxGo1UNItFpwgwpy8gVwzinFEFXYyTUc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ThqJFKEYEorOjb8uu3Td7Rf5zCtEvj6QmXqFW1wr/48AuyqhUy5BpMEEn1L+lNZ7s
	 80IDUVIegIcmCbQP4r0hPoRGgoSsmvVf7ADgG8XdDCwubUuI+7GbSnlJvrKliW/Cds
	 7ZmLfzTYnw0P1dB7Nx/Qx/BfYGz9LQNbaeQvW2to=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50N7eqkG028938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jan 2025 01:40:52 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Jan 2025 01:40:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Jan 2025 01:40:51 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50N7eoap094952;
	Thu, 23 Jan 2025 01:40:50 -0600
Date: Thu, 23 Jan 2025 13:10:49 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <bwawrzyn@cisco.com>, <s-vadapalli@ti.com>,
        <thomas.richard@bootlin.com>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] PCI: cadence: Add configuration space capability search
 API
Message-ID: <vj5skjgz4li2vit3xpr3ysldrcvzoglfycemki3yrzg4ocrrkc@isk7ytysgih7>
References: <20250123070935.1810110-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123070935.1810110-1-18255117159@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Jan 23, 2025 at 03:09:35PM +0800, Hans Zhang wrote:
> Add configuration space capability search API using struct cdns_pcie*
> pointer.
> 
> Similar patches below have been merged.
> commit 5b0841fa653f ("PCI: dwc: Add extended configuration space capability
> search API")
> commit 7a6854f6874f ("PCI: dwc: Move config space capability search API")

Similar patches being merged doesn't sound like a proper reason for
having a feature. Please provide details regarding why this is required.
Assuming that the intent for introducing this feature is to use it
later, it will be a good idea to post the patch for that as well in the
same series.

> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 80 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h |  3 +
>  2 files changed, 83 insertions(+)

[...]

Regards,
Siddharth.

