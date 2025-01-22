Return-Path: <linux-pci+bounces-20234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15236A18FDA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA8E1888B07
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083B210F76;
	Wed, 22 Jan 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRKq4au9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184574502A;
	Wed, 22 Jan 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542207; cv=none; b=BE8dkdX6dIXQQ551W4P8KoTI9qjI7iy4lDpg4rAYMWjab1js2MHEtbjj2MYscXO7Emy2iO6CCDlFyZ3MKXqLz5cLh/9eTbByV3ZILwGfr6vTl2lr32UJFe1GHN+yv0cgO3W9z3t2MEkfJQPKwC/5pfmV6qVNdjUS0qrlHadCI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542207; c=relaxed/simple;
	bh=nXM97R+sdgLXsa+8UoXUjsk+7aYyJNXAg6yhNH6HoK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF/5PjmmHZNKPSfQppzFOgzo1UKlK4Oiko73oQhBVIAS9OHP+ffB9hWPj7XDq5RGWGhquoDvSRNa2RHLeK+M6JPRrm1Val0rZGipvjqJcQZJVNT5O7OYrWyGipKRIXlGVPSUpz9l1pdeTHXs1yqGvmkO/wLz1+uJ/ENnRPQkHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRKq4au9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C3C4CED6;
	Wed, 22 Jan 2025 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737542206;
	bh=nXM97R+sdgLXsa+8UoXUjsk+7aYyJNXAg6yhNH6HoK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRKq4au9IJeGlrPZ5NZftJ56cpGRjYsj+W6Ebsw4FiEFmi6+7g4S6E/Xuc0K7xdv2
	 AnGlpOV7YXWNMW7Y+oNI8P62e8FnwxavDzoe6zHvTWajiv9AmRMNeM5R18CwFf39IA
	 gO5IWFfr8tkRScqOf8Ky51U6NooXBKGyYqjWFQwGQqBySas+dCvvIx2OEEY9SpRGW/
	 lFOcTVjuY9cJHncp9bAkzQg3c9lud/v9ho7BLH7GSPU9ixjczYeSo2fY0yYpm2oUyL
	 DXs9B7/9yyLMwaAuCxjNvDXTAeGK3LUmVUduI1DA85VzbZr9GiRC/TaEIT6y0Vp5sc
	 UnDw7LKQi0GTQ==
Date: Wed, 22 Jan 2025 11:36:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 2/4] Add debugfs based silicon debug support in DWC
Message-ID: <Z5DKOHiPd-yc7MCc@ryzen>
References: <20250121111421.35437-1-shradha.t@samsung.com>
 <CGME20250121115206epcas5p42ce605e6c8500fd2cdfea83a82b101a5@epcas5p4.samsung.com>
 <20250121111421.35437-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121111421.35437-3-shradha.t@samsung.com>

Hello Shradha,

On Tue, Jan 21, 2025 at 04:44:19PM +0530, Shradha Todi wrote:

This is the suggested format of your new feature:

> +
> +struct dwc_pcie_vendor_id {
> +	u16 vendor_id;
> +	u16 vsec_rasdes_cap_id;
> +};
> +
> +static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> +	{PCI_VENDOR_ID_SAMSUNG,	0x2},
> +	{} /* terminator */
> +};


You might know of the drivers/perf driver which also exposes RAS information
for DWC. That driver uses the following format for supported entries:

+struct dwc_pcie_pmu_vsec_id {
+	u16 vendor_id;
+	u16 vsec_id;
+	u8 vsec_rev;
 };

+/*
+ * VSEC IDs are allocated by the vendor, so a given ID may mean different
+ * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
+ */
+static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{} /* terminator */
 };

See:
https://lore.kernel.org/all/20241209222938.3219364-1-helgaas@kernel.org/


I think it would be a good idea for your feature to use the exact same
format for supported entries, so that entries can simply be copy pasted
between the two drivers.

(Considering that both of these drivers are simply exposing the RAS
information in different ways, having an entry in one of the two drivers
should mean that that entry should work/be applicable for the other
driver as well.)


You might also want to add support for Samsung in the drivers/perf driver.


Kind regards,
Niklas

