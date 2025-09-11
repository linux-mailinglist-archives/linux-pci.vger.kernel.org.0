Return-Path: <linux-pci+bounces-35862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D35B52768
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 05:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDA1C83B61
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C122688C;
	Thu, 11 Sep 2025 03:48:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E4218AD1;
	Thu, 11 Sep 2025 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562492; cv=none; b=rFVxeYQR+sypk/yy30AChz2Epy/ZuZpjlGTv1kTGZjusT8Zc5eH9wqPYSMc1d/85BJ0lqVscUh6hZNjQ75JdqCpHNO97DzQ0en1AnA05TqlELybiv7g0w6LxlAAkS0adG5WXXvwfldMo+xFfL2hCxjZI1ncSzPSEnlOc8k5bnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562492; c=relaxed/simple;
	bh=Ag5jh444z9eEyHz80mrnhWfWK2OXj5k5TJ+SQtCMlWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6jMadYC7QJtgyX0vMfKybCdw6aL55xwVtREL5eP0CjnxeY/dYZjBt2D0YsKv72n3hYTo33vyo84yifDMBfOoRfvyfzkRJz91QKqCc544aLq8GgNZmgeB4wboal3Nvl9kLcJjjxBFCoWP85pUww+yVrBKqQIbPQGo1tHiGBF69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CFB2B2009D20;
	Thu, 11 Sep 2025 05:48:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B310B467C3E; Thu, 11 Sep 2025 05:48:00 +0200 (CEST)
Date: Thu, 11 Sep 2025 05:48:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Alejandro Lucero Palau <alucerop@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <aMJGcDMBUPPAom4d@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-9-terry.bowman@amd.com>
 <43c373b4-6ff3-418c-93a0-f679375f117e@amd.com>
 <9714dd6a-28c1-4c2a-8558-9f3d7e3f01b0@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9714dd6a-28c1-4c2a-8558-9f3d7e3f01b0@amd.com>

On Wed, Sep 10, 2025 at 11:24:20AM -0500, Bowman, Terry wrote:
> On 8/28/2025 3:18 AM, Alejandro Lucero Palau wrote:
> > On 8/27/25 02:35, Terry Bowman wrote:
> >> +static void set_pcie_cxl(struct pci_dev *dev)
> >> +{
> >> +	struct pci_dev *parent;
> >> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> >> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
> >> +	if (dvsec) {
> >> +		u16 cap;
> >> +
> >> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
> >> +
> >> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
> >> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> >> +	}
> >> +
> >> +	if (!pci_is_pcie(dev) ||
> >> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
> >> +		return;
> >> +
> >> +	parent = pci_upstream_bridge(dev);
> >> +	set_pcie_cxl(parent);
> >
> > This recursion is confusing to me.
> >
> > Is it not the parent already having this set from its own pci setup? Or 
> > maybe do we expect that to change after a reset and this is a sanity check?
> 
> Right. The upstream parent bus state is already set but could change after
> reset.

Please add a code comment as this is non-obvious at least to me.

Thanks,

Lukas

