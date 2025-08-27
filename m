Return-Path: <linux-pci+bounces-34884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44711B37BEE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF107C203A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47E318149;
	Wed, 27 Aug 2025 07:38:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E47319843;
	Wed, 27 Aug 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280289; cv=none; b=lqVrMtfRTBlSFGJlWh81MSHLcIoxsxfB/WdicpYJU88WJFzXtQDcBqR9FKWH2OY5Pe4tn0mM+jPXTY1ASKvYdCojeMsj979ZlDhoDhdkTzbmK4ZxXWCki1D4dd3M3VxSWwwubMPN4g1yhlEDDKOuiwTGNEJzNYGEARbcrIspXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280289; c=relaxed/simple;
	bh=ap0C57PbChuMn0G/knf5MeLYtL70gkjNi81KbQ2s+Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4z3h8u5Nd76Kd+0E2U/jgEzuQuI+98dg5CusUsDOCl8fND7J/aiKG4LwZ2+srE7z2vhjXhvxCTSgdpNWPyVKYUSsdVrgFvQ3OP2EVQatYNBDOoLi8/yU5nAQ4R/nYWIyWkJnQbcLtiDxrOPXq4//JZtroiQRmJnknD+DfFxB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B9B062C06669;
	Wed, 27 Aug 2025 09:37:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B24E2244BB2; Wed, 27 Aug 2025 09:37:55 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:37:55 +0200
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
Subject: Re: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Message-ID: <aK6101l5vMZA3MUs@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-10-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:24PM -0500, Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.

aer_print_error() has a pointer to the struct pci_dev and you've added
an is_cxl bit to that struct in the preceding patch.

Is there a reason why you can't just use that dev->is_cxl bit, in lieu of
adding another is_cxl bit to struct aer_err_info?

If so, please document it in a code comment or at least in the commit
message.  If there isn't, please use dev->is_cxl.

Thanks,

Lukas

