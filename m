Return-Path: <linux-pci+bounces-40636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8383C42EFC
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 945B34E1ECD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3033E7;
	Sat,  8 Nov 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cB0oPqUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024EC18C2C
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617571; cv=none; b=GzVt5Xb83zKmK5hsk8W8fZelXDb/oclh3KC9bzI4w7GKcqaAcoBeTsQYwx5SuLm90RsuH6N9CwI1xmuB5NNswiEYn1YMxZP5WijORiSgPGr5N4gzKi5tMa4DwhH5rxtWZaBmu06euibBLELQ4S+E5c4f4i1j5PBSgcSkYvoXMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617571; c=relaxed/simple;
	bh=SWz6gu02dAtpWz/P4x1Pdt/Zmtr9UNLsVuK+uxaYo8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu1e7+lKBR/5M+SZYRkmXK+6MHcZBFrX6kCbf/uLYMjC8M4MKcS7B9Xfx2719/l4dLpFznnGCkNjn6UIjXx6kMpZAThGrdTCUIVPubH3zdXcMvHQ5QIE6smz7OLMWNWy3b5mTMdNT0a2MKhOJ+Ccy8Tdvlknb4ni1oGlN9M9HZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cB0oPqUg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762617569; x=1794153569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWz6gu02dAtpWz/P4x1Pdt/Zmtr9UNLsVuK+uxaYo8E=;
  b=cB0oPqUgvicAv21Xi/qwm5BnpIcNgyrneUgAOeVvuLEK3jkCWEo212uw
   yw401bMJAQ5scY9hKWe/unax62TJmClXO4cYI7Zn6BooGpLU7KOQkufB+
   0kEwl/9FSPadEF8v+zlTu0qiwXJNJ2Oz7ifyn/xZnDtIWJH1k5k2m2vtC
   vhQtLpmvh6qCNDkFij4xURjJE+sTPoMlidbTBLHbGzwdGkmCiu5xPkYp/
   ku9/n7/3y2uDz6ON+N2raWc/axAw8kTJ+7dsR/99LSKLO4IdbhbG/lztY
   qxDjvevHfT/Oa/HGT4bUHo71QFPy7JTKoWdMh7Eur9wpMDTK5CGPYlmd0
   g==;
X-CSE-ConnectionGUID: /RaYSduBR9igPg+bHTTX6g==
X-CSE-MsgGUID: d2cvIAQbSRKWaHLdC4kT3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64653946"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="64653946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 07:59:28 -0800
X-CSE-ConnectionGUID: 9NqH486MSDuIM0JxyZtFcQ==
X-CSE-MsgGUID: LP7DwtGvQoyG4GswHFHnkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="187601444"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 08 Nov 2025 07:59:27 -0800
Date: Sat, 8 Nov 2025 23:45:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 1/9] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <aQ9lhQSB8t1VGZ8v@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-2-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-2-dan.j.williams@intel.com>

On Fri, Oct 31, 2025 at 02:28:53PM -0700, Dan Williams wrote:
> A "TSM" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. The
> name originates from the PCI specification for platform agent that
> carries out operations for PCIe TDISP (TEE Device Interface Security
> Protocol).
> 
> Instances of this core device are parented by a device representing the
> platform security function like CONFIG_CRYPTO_DEV_CCP or
> CONFIG_INTEL_TDX_HOST.
> 
> This device interface is a frontend to the aspects of a TSM and TEE I/O
> that are cross-architecture common. This includes mechanisms like
> enumerating available platform TEE I/O capabilities and provisioning
> connections between the platform TSM and device DSMs (Device Security
> Manager (TDISP)).
> 
> For now this is just the scaffolding for registering a TSM device sysfs
> interface.
> 
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

