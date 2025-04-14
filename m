Return-Path: <linux-pci+bounces-25787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBCFA87703
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 06:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD0F3ADC6A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608515DBB3;
	Mon, 14 Apr 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJzZJG8s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580933FF1;
	Mon, 14 Apr 2025 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744605637; cv=none; b=cHdD6EZ2z3CO+hvgaRaYjkGhZl6UqFzIbTdIn5wpA2F1Fy9I5U1lHhaeq+wf3kXKdNXnnf9QDPbGIi7xmhkDjMrTxncvk+u4hCxwfgDrsQ/oW433oIQrYcPaHJ71CFQ87kQ22g76MqpzZV4Yo996LEi2G6Dt6n9wgrI6sIupKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744605637; c=relaxed/simple;
	bh=A7JKFKVW0H5TSbaaBUozxi7yn7fXcWsDMRyipQS4UoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWwLhCBhzpNQCSgZd051zv165YMzn9jKcY2LarGrEk2V5nZULTdnNj49HrgdmWx39da8DqCy1367wZ0IrY15RFy/hScX7O2PI0nZjBgarHtSiguPZj7vVNbQsEWLGb3TK49cvY11uM9BrgnPEYcR2RcYdp2AHz6YHdQE+sNJyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJzZJG8s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744605635; x=1776141635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7JKFKVW0H5TSbaaBUozxi7yn7fXcWsDMRyipQS4UoQ=;
  b=YJzZJG8sFVfvM4WXUXjbcC3UNOYwdHduf/3iHLVN7Pdq1BzAVuVP/RDC
   hCom7FtOHmRRhw+TABz7Oc+j8obTLrzRK1/QWUEd/oqc0uZNJpfZIs4Hy
   iPJqPCcdW/2Y0L4C83sRZeXFHupgRFu6bfGU9WmchGJ4oUZ7dKo2CvzoB
   Wb2YY8BKl1GaV4O4bSA3fCbiXnx9YPrTpXv4dqSFRT/HyWgBWCB2JbCj6
   i2WjJTdLT6Lb1p+lAnj6YR8avnw8nM94xlGit9lI/luk4CNFX5k2rmHU2
   Mx3iYniYYWq/Pem+ZkdDIgAqI75/pQiit+/fIOydQ7iG2blFy9zk3GU8M
   A==;
X-CSE-ConnectionGUID: n8cLujOyRjmAlopae4bXIA==
X-CSE-MsgGUID: /kwiauHjSU+HxE2nsaLLrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56707838"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="56707838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 21:40:33 -0700
X-CSE-ConnectionGUID: V/lhlWbfShaq6N/6j7/e1Q==
X-CSE-MsgGUID: IFzxS2gfSBKX4zgChg4XIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129679250"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 13 Apr 2025 21:40:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 59A4A214; Mon, 14 Apr 2025 07:40:29 +0300 (EEST)
Date: Mon, 14 Apr 2025 07:40:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alistair.francis@wdc.com,
	wilfred.mallawa@wdc.com, dlemoal@kernel.org, cassel@kernel.org
Subject: Re: [PATCH v2] PCI: fix the printed delay amount in info print
Message-ID: <20250414044029.GD3152277@black.fi.intel.com>
References: <20250414001505.21243-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414001505.21243-2-wilfred.opensource@gmail.com>

On Mon, Apr 14, 2025 at 10:15:06AM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Print the delay amount that pcie_wait_for_link_delay() is invoked with
> instead of the hardcoded 1000ms value in the debug info print.
> 
> Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

