Return-Path: <linux-pci+bounces-30181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEDFAE062F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1760F3BDD38
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D52459F1;
	Thu, 19 Jun 2025 12:48:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC82264DD;
	Thu, 19 Jun 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337290; cv=none; b=n5+oe1sfqyk6FasUpAXEC1uLssYIwo9B0T2PedA1Yxg083ziCxEPe470WLAwcGPVNM1h01hTMpLQPzYPO5kyoD0tFZw6iQZ/azzOrMFxvpaaif8GiZf2Aex8/qVCq/k05XeJH1kky1/XH5QKWsHrPb0SZ90MhjKRv9MmaxsuB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337290; c=relaxed/simple;
	bh=YPBcfanuB90YKI8TPFHCaI34/Yp2+h2LvdXi0kDJkeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/8FPnm/ckliGbMvM7ZzQ9A6/ymrNylGABFOjhzRf5aihDrss+00wAPGrxoYKuNsye745eeIrpXZuV/z/69hQf26+7n2P9N2I4olUrwlsAYjamoJattYiKx1PZ7K8vKhtssSD1levxbzcMzuLlCYL6YrQXUP88FbjRDWXgyy4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 05D142009D10;
	Thu, 19 Jun 2025 14:48:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F28BF3A080B; Thu, 19 Jun 2025 14:48:04 +0200 (CEST)
Date: Thu, 19 Jun 2025 14:48:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <aFQHBL0oWo6GTSQG@wunner.de>
References: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610114802.7460-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jun 10, 2025 at 02:48:02PM +0300, Ilpo Järvinen wrote:
> When bifurcated to x2, Xeon 6 Root Port performance is sensitive to the
> configuration of Extended Tags, Max Read Request Size (MRRS), and 10-Bit
> Tag Requester (note: there is currently no 10-Bit Tag support in the
> kernel). While those can be configured to the recommended values by FW,
> kernel may decide to overwrite the initial values.
> 
> Add a quirk that disallows enabling Extended Tags and setting MRRS
> larger than 128B for devices under Xeon 6 Root Ports if the Root Port
> is bifurcated to x2. Use the host bridge's enable_device hook to
> overwrite MRRS if it's set to >128B for the device to be enabled.
> 
> The earlier attempts to implement this quirk polluted PCI core code
> with the checks necessary to support this quirk. Using the
> enable_device hook keeps the quirk well-contained, away from the PCI
> core code.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://cdrdv2.intel.com/v1/dl/getContent/837176
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Patch looks perfect to me and could go in either through pci or tip.


For the record, link to previous attempt to solve this:

https://lore.kernel.org/r/20250422130207.3124-1-ilpo.jarvinen@linux.intel.com/

Thanks,

Lukas

