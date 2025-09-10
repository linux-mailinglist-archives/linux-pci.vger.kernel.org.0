Return-Path: <linux-pci+bounces-35822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEEB51BBC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491861C21EBE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3F8261B81;
	Wed, 10 Sep 2025 15:34:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BA1E9B35;
	Wed, 10 Sep 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518448; cv=none; b=jkAV8qetjo4M6eHTytnVrtVEAUVBd04hsH8/Q4ijkPP/MnButrsEuYfpGlKgEmQkQerPeoIfrNlD+gqI8OuJDOYzPEcJ/l5Cdp7p5jUxhcVkOGyeVZI2mUo/odqw+EAUfEbV34vNcRBP0vU52itzPe3l08CqY6nuSswQD4DlV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518448; c=relaxed/simple;
	bh=Sv7roDT6usIvwyk5ZedLVq8hKq6aL3E/4rmb1800EwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdPPGrhHM2tAmlcTqiQMyC/jTUEZbnbwxKOCr8to/2lYXzROJjTfuqoYzhHFeGMz8+1FJNWJL2ZsMdb9T1Xc69QdluIwQZCO760SOTdeqYXXHlFMOBRzyuO8KaYk1ukE5zgF42CqesomGPfB5cITaVcnf6RTFRn4KaQGwC1ZKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D25072C064E1;
	Wed, 10 Sep 2025 17:33:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A8C7B531EE7; Wed, 10 Sep 2025 17:33:55 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:33:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Message-ID: <aMGaY-d9Xl427hqh@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-10-terry.bowman@amd.com>
 <aK6101l5vMZA3MUs@wunner.de>
 <910f6bda-4f18-47a9-9150-8489685c857d@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910f6bda-4f18-47a9-9150-8489685c857d@amd.com>

On Wed, Sep 10, 2025 at 10:26:19AM -0500, Bowman, Terry wrote:
> On 8/27/2025 2:37 AM, Lukas Wunner wrote:
> > On Tue, Aug 26, 2025 at 08:35:24PM -0500, Terry Bowman wrote:
> >> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> >> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> >> Type' for CXL device errors.
> >>
> >> This requires the AER can identify and distinguish between PCIe errors and
> >> CXL errors.
> >>
> >> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> >> aer_get_device_error_info() and pci_print_aer().
> >>
> >> Update the aer_event trace routine to accept a bus type string parameter.
> > aer_print_error() has a pointer to the struct pci_dev and you've added
> > an is_cxl bit to that struct in the preceding patch.
> >
> > Is there a reason why you can't just use that dev->is_cxl bit, in lieu of
> > adding another is_cxl bit to struct aer_err_info?
> >
> > If so, please document it in a code comment or at least in the commit
> > message.  If there isn't, please use dev->is_cxl.
> 
> [..] the
> actual device bus state can change between capturing the AER status and
> handling/logging. An example is a training HW error. Caching the 'is_cxl'
> will allow the drivers to properly identify the error bus type for
> further logging and handling.

Thanks for the explanation.  Could you document this in a code comment?
It's not obvious at least to me.

Lukas

