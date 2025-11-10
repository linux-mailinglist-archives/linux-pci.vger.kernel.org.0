Return-Path: <linux-pci+bounces-40705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B0C46ACC
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DBA1887810
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890F30C361;
	Mon, 10 Nov 2025 12:41:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F08217F55;
	Mon, 10 Nov 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778517; cv=none; b=MFaIKwZi4G9dM6Zv0bffcnKq/8YGJuniu0px6/xdtvU3ozJbcHozcVLrAsl5eErLTaFRyvd4Z2MsO0BzJ5WJOS9IWkc57hrA7wg7no+Jg3bEgFmDNImT4wD3iDCoIQ4Xb655yG1SVdqWNcyoC/z/2IlD8VUxhYLK9MeOIQrul50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778517; c=relaxed/simple;
	bh=rOEMtbbUyW+Eslmgmwt2fk+00r5/HDm24f1e/jESj+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4yUb+/2zevFDaRzeWFfRChAC7Jl6z/TM59jZXNXgCCHeCiM03Vyc0ovbeIO9f1ZGPDMGPP3m9aLFLum8TUUyrq7ugcO8rkur8f28au+EWokdHqeHK41EHRgNGgNfody/SW0rCQRtzGwO9eRnBUJfSYp+wJH5SmQe3lFAosOEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D7E642009199;
	Mon, 10 Nov 2025 13:41:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C3CCB15C2; Mon, 10 Nov 2025 13:41:45 +0100 (CET)
Date: Mon, 10 Nov 2025 13:41:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
	krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <aRHdiYYcn2uZkLor@wunner.de>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>

On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the

Please use the latest spec version as reference, i.e. PCIe r7.0.

> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
> 
> This property should be used to indicate the T_POWER_ON for each Root Port.

What's the difference between this property and the Port T_POWER_ON_Scale
and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?

Why do you need this in the device tree even though it's available
in the register?

Thanks,

Lukas

