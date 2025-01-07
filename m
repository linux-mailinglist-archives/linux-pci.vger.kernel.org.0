Return-Path: <linux-pci+bounces-19517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B9A05527
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137FD1887CE4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82F1ACDE7;
	Wed,  8 Jan 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2QoVOIL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174E1A2544
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324433; cv=none; b=glnJjB5d06uo4wkvZCGG3RS1dh8M39qddxczUHVOctNxrPTFNbwI193WqfsJqNnBx00cmIB13x05nqCeXgjSIsggX7RaLJTID5lgCI12/ITf2uAfnmh/m0v3R+KJUfz75HWI1j9Ltz+93wD6ZiJg91IUbAQ3V63D62K2T3smnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324433; c=relaxed/simple;
	bh=Qrig+2WRbeLJ7X9pjWW5VY7wN4QWxSYejSzEJVqLhHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIMadtdNGfbmBPpZL7Kt10EDXxHtY9dITKli6Ey/wdn4SUyWsgW8oG7IK/cuJr7huYwvgp0P3IzAFeFHDGiLG+picmDnFbDLeHHAhJia3KW+QCVATV+ExMpkRbkFTLKbn5SbdDv2BryjFhfRdZqVp8QWW7KgwPO9dizSDulCou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2QoVOIL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736324431; x=1767860431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qrig+2WRbeLJ7X9pjWW5VY7wN4QWxSYejSzEJVqLhHc=;
  b=f2QoVOILD1v8UtnSAbeQB/SvbjDDUZjh64KxOEZ+aJxIg2ymP5BIOtwf
   mYg3M4EHbPJZwqSR3JHAANNkc2Aglxa7FTVo+jvK46IssEGV5SWR2OH5O
   /gCreiz2oKegiqPl/F1GqZ/zVNB3Y5oAqCJla+zIe1lujP7ZNG2kT20JI
   l7HvC/VVjkx6HcXsCcHWEK5uFEYUq/sZZ602PwMh122PaVWM0dTeqwNLL
   3y4iKMXFrNEpbfrd9WIxVsDdL7LZ9HhJbslDwwOKuq0Ymgz+q9zMWmiob
   c0SC9ZHzgZZ9kpcRZ1HFGaZzdoNEl6jdDDhKaD5BRGNNHmGvd96V9pWEl
   g==;
X-CSE-ConnectionGUID: 01kcFSjRRauk+KBEqhV2fA==
X-CSE-MsgGUID: CCYVLR+MTcaPdxgYXZFKKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36422010"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36422010"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 00:20:31 -0800
X-CSE-ConnectionGUID: us/pXiBeQtaLkONx4oLKPA==
X-CSE-MsgGUID: 99MfGIcSQY+a7X0G+natVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="102938144"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 08 Jan 2025 00:20:29 -0800
Date: Wed, 8 Jan 2025 04:19:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <Z32MUFBIyp0IKyzC@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ay10oz0kz.fsf@kernel.org>

On Tue, Dec 10, 2024 at 08:49:40AM +0530, Aneesh Kumar K.V wrote:
> 
> Hi Dan,
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> > +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> > +			 enum pci_ide_flags flags)
> > +{
> > +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> > +	int mem = 0, rc;
> > +
> > +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> > +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> > +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> > +			ide->stream_id);
> > +		return -EBUSY;
> > +	}
> > +
> 
> Considering we are using the hostbridge ide_stream_ids bitmap, why is
> the stream_id allocation not generic? ie, any reason why a stream id alloc
> like below will not work?

Should be illustrating in commit log.

"The other design detail for TSM-coordinated IDE establishment is that
the TSM manages allocation of stream-ids, this is why the stream_id is
passed in to pci_ide_stream_setup()."

This is true for Intel TDX.

Thanks,
Yilun

> 
> static int pcie_ide_sel_streamid_alloc(struct pci_dev *pdev)
> {
> 	int stream_id;
> 	struct pci_host_bridge *hb;
> 
> 	hb = pci_find_host_bridge(pdev->bus);
> 
> 	stream_id = find_first_zero_bit(hb->ide_stream_ids, hb->nr_ide_streams);
> 	if (stream_id >= hb->nr_ide_streams)
> 		return -EBUSY;
> 
> 	return stream_id;
> }



> 
> -aneesh
> 

