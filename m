Return-Path: <linux-pci+bounces-35082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E05B3B3F3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 09:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265A8A02D66
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69C263C91;
	Fri, 29 Aug 2025 07:10:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A96263F30;
	Fri, 29 Aug 2025 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451422; cv=none; b=QfA4OrqE2pr3Sj0NrkwHTv9b2O13fq9z4q4o2g/O9Nl4cFqYRUKH+X8Y3oy9Csee1Pnvh8IEA/67WoNAdYEmutOzVlF9Ntp+cwSJVftOPy4aRIKuIcJKeW7NfVoD+HjzrFwnCXSarve92qiChJ++5wmPJzTX5XkrWp7KeVBT5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451422; c=relaxed/simple;
	bh=xkaohoyWC9Dcsn/GhSagA55YbxD+rE5VVBzH3vzgPqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0/oxIbcYsZnjbDDqL7I8q5sSZ1N7ZxB1/CapP9w06hx8IG9wXc9CPzs0laFJzDULqXDsQngp30PLERje2K6hpB1nCTfIZr+mentGFiCueWtMatkJ7Etc7yGClR90MvdvKU0+RQESx1bBlakZuK/uNKELOW/WP2Zi3GHSNVP+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id EB59B200D267;
	Fri, 29 Aug 2025 09:10:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E169338CB62; Fri, 29 Aug 2025 09:10:09 +0200 (CEST)
Date: Fri, 29 Aug 2025 09:10:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
Message-ID: <aLFSUQq20b0EAT8H@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-19-terry.bowman@amd.com>
 <2312cd83-9faa-458b-9960-72760c769101@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2312cd83-9faa-458b-9960-72760c769101@intel.com>

On Thu, Aug 28, 2025 at 05:43:31PM -0700, Dave Jiang wrote:
> On 8/26/25 6:35 PM, Terry Bowman wrote:
> > +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
> > +{
> > +	struct pci_dev *pdev = err_info->pdev;
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> 
> So this function is called from the workqueue thread to consume data
> from the kfifo right? Do we need to take the device lock of the pdev
> to ensure that a driver is bound to the device before we attempt to
> retrieve the data? And do we also need to verify that the driver bound
> is the cxl_pci driver (and not something like vfio_pci)? Otherwise I
> think assuming the drv data is cxl_dev_state may cause crash.

In v10 of this series, there used to be a cxl_pci_drv_bound() function
to verify that the cxl_pci_driver is bound and not some other driver.
That function was called from cxl_rch_handle_error_iter().

It seems this is gone in v11?

Thanks,

Lukas

