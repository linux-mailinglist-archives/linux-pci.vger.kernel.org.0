Return-Path: <linux-pci+bounces-35861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10795B5275B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 05:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E557BD181
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 03:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56ED221FC7;
	Thu, 11 Sep 2025 03:45:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7823D7D4;
	Thu, 11 Sep 2025 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562305; cv=none; b=Jtf1X7AaDTMlmt5n5Ei2o3gM6LOqSOau8/4dwtDWP9Tads1/UF8JOap2mhtjqmWdTFQWv8U0He9f9o+KQmOUoFAYrAdvh0XVnWKJC9wx06GwLO2ohXgrZXZwzX/8Y/JAi01OUq5sC8DY7TwhkFB161tnGdQ0tkL8ZbV9/Ko2G7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562305; c=relaxed/simple;
	bh=mK6CIu5Uu2i1yzCLpH5ZIdGXcRymGnnPqRJ5jLbp3EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqpqnfCCUQFxYr0UJCMqO2GgTY2UO6kddq+dJLTn+jSKVDqrnk7eeFke+FNn8cv7yYlidXSz0bLCNJcOksINx+f+CB15UkfbdNxc+Jo0Cojwz2R9Q+Vi9mQfAj3mLzc6qJvwK6S0P3nvyMr/ErPH41O2XfXnhfGoJvjIQUqhpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 667622C0666D;
	Thu, 11 Sep 2025 05:44:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4BA77440FD6; Thu, 11 Sep 2025 05:44:53 +0200 (CEST)
Date: Thu, 11 Sep 2025 05:44:53 +0200
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
Subject: Re: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <aMJFtZHJBOLLMHIX@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-21-terry.bowman@amd.com>
 <aK67_CP7l7c7CSPp@wunner.de>
 <f1ddffe9-e1ea-45b5-9042-e9aa6ce41e34@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ddffe9-e1ea-45b5-9042-e9aa6ce41e34@amd.com>

On Wed, Sep 10, 2025 at 10:57:17AM -0500, Bowman, Terry wrote:
> On 8/27/2025 3:04 AM, Lukas Wunner wrote:
> > On Tue, Aug 26, 2025 at 08:35:35PM -0500, Terry Bowman wrote:
> >> +++ b/include/linux/pci.h
> >> @@ -2760,6 +2760,17 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> >>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> >>  #endif
> >>  
> >> +#if defined(CONFIG_PCIEAER)
> >> +pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
> >> +				      enum pci_ers_result new);
> >> +#else
> >> +static inline pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
> >> +						    enum pci_ers_result new)
> >> +{
> >> +	return PCI_ERS_RESULT_NONE;
> >> +}
> >> +#endif
> >> +
> >>  #include <linux/dma-mapping.h>
> >>  
> >>  #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
> > Would it be possible for you to just declare a local version of
> > pci_ers_merge_result() within drivers/cxl/ which is encapsulated by
> > "#ifndef CONFIG_PCIEAER"?
> >
> > That would avoid the need to make this public in include/linux/pci.h.
> 
> The move of local merge_result() to exported pci_merge_result() was requested
> by Jonathan Cameron:
> https://lore.kernel.org/linux-cxl/20250627120541.00003a14@huawei.com/
> 
> I believe the intent was to make reuse of the PCI merge function to keep the
> PCI and CXL UCE flows somewhat similar.

That's not my point.  My point is, can you avoid declaring the static inline
in include/linux/pci.h if you move it to drivers/cxl/ and encapsulate by
"#ifndef CONFIG_PCIEAER"?  I'm only referring to the static inline stub.

Thanks,

Lukas

