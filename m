Return-Path: <linux-pci+bounces-24879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B138A73CBA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE123B844A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559F219EB6;
	Thu, 27 Mar 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPr/f8sE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CE1A3150;
	Thu, 27 Mar 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097761; cv=none; b=pBiyFYdrMo//g1LvPjMBhpo825EFc8ImBkf+m6oNjg/M47+TPEv0+QM1si5mH+aaZnQsi9dPOuayd1bWWpM/U8c3PBKJz/rcJCxIWvyVXcR0JR8ppYiy+UVXf7JsncPVkLn3sWJIbF9V6KpDDpwG9nZqndLZFB48y6JNOwxYcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097761; c=relaxed/simple;
	bh=O8pI+MMS3knvZUJCiDN0yAntRL5g+pLumMSu3lVOfDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uA0gUlP2LbjKrvN2Ct4dXvjFIpNyUYiZJZoV4I4C47qgQWDCwHDN/ORNqUqDgXCtg5cZD0ZTQDXEVTFpetK7ZhsETRF59N8BYfHqekaXiYFyXVeebDjfKNtYfFfQjE1ZWfXcgnotXuT7MYfIrk6C5cSAF6JatA0j3Ov7kxUmFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPr/f8sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A148C4CEDD;
	Thu, 27 Mar 2025 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743097760;
	bh=O8pI+MMS3knvZUJCiDN0yAntRL5g+pLumMSu3lVOfDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BPr/f8sECzBu3UVIwKgdpiczyIr0nbgShfIBE2wbEf4Npe6Xx22SX51L1sCP5xMwX
	 hAzdzd/44SjLW2D7wz2JzpH5fqcuCw7gx+XU7AdtolWuXHbbQcLu48CFDVcFei3KiK
	 kNAZVUYq1d6U9r49W++HIhG6ymjB9BEfkAVOh9AInV71z/V4+rCPcnZa9mDJ/DgS+N
	 8i0tPXZJ7oBi5AE0CMNJKkj29LILlntvCZtyPVGpiBeta6PFq1rYZxNGkafeyarXYn
	 Ne8SLeXvFk+yH6aRZJto75sSEC+tqcon/gmjuT9P3A9fL79PqgEGESwUm3RZ/hC/oQ
	 trm4sVdwWiUtQ==
Date: Thu, 27 Mar 2025 12:49:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report
 CXL or PCIe bus error type
Message-ID: <20250327174919.GA1437572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327b4da6-07d8-4f44-a3f0-32b4e5460719@amd.com>

On Thu, Mar 27, 2025 at 12:15:10PM -0500, Bowman, Terry wrote:
> On 3/27/2025 11:48 AM, Bjorn Helgaas wrote:
> > On Wed, Mar 26, 2025 at 08:47:03PM -0500, Terry Bowman wrote:
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
> >> +++ b/drivers/pci/pci.h
> >> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
> >>  struct aer_err_info {
> >>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> >>  	int error_dev_num;
> >> +	bool is_cxl;
> >>  
> >>  	unsigned int id:16;
> >>  
> >> @@ -549,6 +550,11 @@ struct aer_err_info {
> >>  	struct pcie_tlp_log tlp;	/* TLP Header */
> >>  };
> >>  
> >> +static inline const char *aer_err_bus(struct aer_err_info *info)
> >> +{
> >> +	return info->is_cxl ? "CXL" : "PCIe";
> >
> > I don't really see the point in adding struct aer_err_info.is_cxl.
> > Every place where we call aer_err_bus() to look at it, we also have
> > the struct pci_dev pointer, so we could just as easily use
> > pcie_is_cxl() here.
> 
> My understanding is Dan wanted the decorated aer_err_info::is_cxl to
> capture the type of error (CXL or PCIe) and cache it because it
> could change. That is, the CXL device's alternate protocol could
> transition down before handling but the CXL driver must keep
> knowledge of the original state for reporting. But, the alternate
> protocol transition is not currently detected and used to update
> pci_dev::is_cxl. pci_dev::is_cxl is currently only assigned during
> device creation at the moment.

Sounds like there's always a race here if the CXL/PCIe type isn't
captured as part of a hardware error log register.

Bjorn

