Return-Path: <linux-pci+bounces-7148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872068BDD7D
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42907282DBB
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330714D2B6;
	Tue,  7 May 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsEaum78"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7913C9A6
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071933; cv=none; b=kUZ/YUZVltP2nTE/1TnegK7royv34YeQlLMDLS/Kp43uo65aSWhlezf3KyBjdArhcS3r4CI3bIpOQ9V95hWN8zOC/VfAzg7KzKx8Oqbit08MusmtmG+ns5cs7vt1OqPG18xQz8wbG1ZflE4v958CDzIkOWu531j9S51zxu1IBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071933; c=relaxed/simple;
	bh=YDDzOdcxhTiQfsbJYeFw5DFyxUfvoEDo0yDosAFBDBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkXxdT7AThr6sff0ESl63oBYiYg4Rn6sE2TJNbO9iU21LhCbBcKQTMFDSI5SM4ryLJ7PGaKm6mCkx9HsY5RCshE81o3G8zlzs6yITzY2ekNGR4R860yTgEiigp3Em53NasEf7IGJezUFKKel7DvWE0cRIcTqaJVPNZS+DoICANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsEaum78; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715071932; x=1746607932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YDDzOdcxhTiQfsbJYeFw5DFyxUfvoEDo0yDosAFBDBQ=;
  b=BsEaum78kW7r0sNDkoY804YWqW0JEPNVpTquRdapgEXt5ztobPE21czh
   wa9ZkCRybUxoiGsM2m97ky8OKo53UgEBhOV9PEtC0a005EsOpflNB6N3L
   2Zr0ahlSTmf79e6OFqgFwkitoYO7xBcd9D3dP472g40gVTVyhXYyUmrcd
   VqdF8u8XbEgBBndebHimZ6x5I+qaWcyGfzG7SrO+onQFzo7PAuqwJzA1h
   +m82PH33R1Lo6tiQGQiyPmHhELsv3bJI1zC067MAFxNGwj+mJG80QlJAn
   +i/MpMl6vdyH01Md+PkVph2Yj6sZJGCiJqc9c5Tvp9c7wBzru1c1vWLbc
   g==;
X-CSE-ConnectionGUID: lhdV0kQGRIKXY6zTSlkU+w==
X-CSE-MsgGUID: tOKU1IB0RVOEvTdLGfRzFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11007016"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="11007016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 01:52:12 -0700
X-CSE-ConnectionGUID: 1caxfnooSt2BK66PvHEAsw==
X-CSE-MsgGUID: PR4NKLnhSbC+qI+EE9NQtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="59308698"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 07 May 2024 01:52:09 -0700
Date: Tue, 7 May 2024 16:46:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <ZjnqZRPaijFxO9rh@yilunxu-OptiPlex-7050>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
 <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>

> > > +
> > > +/* collect TSM capable devices to rendezvous with the tsm driver */
> > > +static DEFINE_XARRAY(pci_tsm_devs);
> > 
> > imho either this or pci_dev::tsm is enough but not necessarily both.
> 
> You mean:
> 
> s/pci_tsm_devs/tsm_devs/
> 
> ?

I don't think the concern is just a renaming. My understanding is, we
already have a struct pci_tsm embedded in struct pci_dev, we could loop
and find all TSM capable devices by:

	for_each_pci_dev(pdev) {
		if (pdev->tsm)
			pci_tsm_add/del(pdev);
	}

A dedicated list for TSM capable devices seems not necessary.

But my concern is about VFs.  VFs are as well TSM capable but not
applicable for tsm_ops->exec(TSM_EXEC_CONNECT), maybe not applicable
for tsm_ops->add() either.  One way to distinguish PF/VFs is we only
collect PFs in pci_tsm_devs, but all TSM capable devices have
valid pci_dev::tsm pointer.

TSM capable devices in Guest should not been collected in pci_tsm_devs
either.

Thanks,
Yilun

