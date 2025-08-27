Return-Path: <linux-pci+bounces-34889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81EB37C49
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F9F175FAC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38822EBDC7;
	Wed, 27 Aug 2025 07:54:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505B2ECD2D;
	Wed, 27 Aug 2025 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281260; cv=none; b=L0qsHS0Xuz4g5mT6nZjAgCYAQOFcwmOfKpm0tDHWLEUGbXHUCWw6FN0yHbMK/OTGEFdz7o3/3uLfxlNoAoJ+ne+rSoJSy48BzTTf1czBPqh5Yh4EwNo1gzAJqPaNgWOpmXSAPYAv6QSKWqOpTLDzK1SOCbm8xRkiVfBakKjA/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281260; c=relaxed/simple;
	bh=U/6nLJjBIaEbkQsC76qhbdVg7wW/2D5bpJawSb98KZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiNUZOAFqO6wq2pLROdpSin4xPEbUpck7qs+whDpx2PvbtrPzK1kVxw1e8/+/V2KV1yM80RcDiRfbRJnVqxfJIZdFm0YAIejYMSEbvQyhnQNHTsL1xRpnCeIg1WHmXhdO705W+n2ddv4N34/2E7C0idWwZY4ua/NFm+n7aX6XPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0252A200B1CD;
	Wed, 27 Aug 2025 09:48:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ED7124E06E7; Wed, 27 Aug 2025 09:48:01 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:48:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 16/23] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
Message-ID: <aK64MYnLrTDYHTnm@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-17-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-17-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:31PM -0500, Terry Bowman wrote:
> +++ b/include/linux/pci.h
> @@ -868,6 +868,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic. Is CXL specific */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };

Please update Documentation/PCI/pci-error-recovery.rst as well with
this new return value.

Thanks,

Lukas

