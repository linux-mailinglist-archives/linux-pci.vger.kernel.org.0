Return-Path: <linux-pci+bounces-45149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31001D39C6D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 03:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CBAF30012CE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 02:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA223D7E3;
	Mon, 19 Jan 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/oIuiWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F824A046;
	Mon, 19 Jan 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790347; cv=none; b=PCKIwOwS9TJlzMelfQfIrzkeWyUakHqR+IREZBhkyyYIpBaj6knH8wLFdkGZGG7cKb4EaCu3Q65ea3XQL1+ATonOwoJHo0mXGWddAn0ZewgXgaI0yqtMMiz/oPm+ckqee7FLzRad3Qd5+BJ1fo5lM7jrbqezAXn7Z/YFbPbw9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790347; c=relaxed/simple;
	bh=sdMleTLpQANshSTk1fuirSrLsZLtb8pFq+98lNyNt9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMZarwSWUxQ9TLx781Dvc3d0Ego8grrqlktHGxYJdE9KnQV22Pbfaabh7Ch06ikqg9ZfFhzqbVgIEvgZgwrcH828EHO3ugFoYpPcp6D3LurR+PlbxxZj6ZkVxjsEgC5baMsJTLVRh2Y2rRwtnWydMZUbaWgLuFXVeVtflN0W4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/oIuiWc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768790346; x=1800326346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdMleTLpQANshSTk1fuirSrLsZLtb8pFq+98lNyNt9E=;
  b=R/oIuiWcLJLYMDdwJflQTPwq47LhusoRzvtT4yCD2184NRNH2Z7FyBH3
   YpZs+WgpDtqFYVMMSZTTdTfoMYwmqsJhgVGtuU+rUZ9pJRdXyI0jJkOQn
   JHRpQ1+7W4tDUDlwUIs68kgeEufsnvtfUL+36Q14C2PbUM/tAyQfHsJi4
   iEHJmubzfPjGtKyfQCPyict2DPoPtscEtlrG9gbdf+tXFxB/UMJy5WaqQ
   7biyfdQ4e5w7W1WFwX3iSbmMU4MzNn4iOyTRnln0HH93QTtbQArFI+B5U
   VpFYOp+Bqbvjk4S/YKa8TGYMjirrPjSaLyp4FzasR9CG01tbGjy0iyddX
   g==;
X-CSE-ConnectionGUID: vTrXwuLpRO+d7TOHQRDPEw==
X-CSE-MsgGUID: c2NwmfJ7Ti2Lc6dNxXJzLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="81113489"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="81113489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 18:39:05 -0800
X-CSE-ConnectionGUID: FzvMluOgSpWMu33VAV1bZA==
X-CSE-MsgGUID: kTS9VI7pTZutZAQUx/FyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="236437867"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 18 Jan 2026 18:39:02 -0800
Date: Mon, 19 Jan 2026 10:21:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: helgaas@kernel.org, dan.j.williams@intel.com, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI/IDE: Fix using wrong VF ID for RID range
 calculation
Message-ID: <aW2VH/CJQY7384jw@yilunxu-OptiPlex-7050>
References: <20260114111455.550984-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114111455.550984-1-ming.li@zohomail.com>

On Wed, Jan 14, 2026 at 07:14:55PM +0800, Li Ming wrote:
> When allocate a new IDE stream for a PCI device in SR-IOV case, the RID
> range of the new IDE stream should cover all VFs of the device. VF ID
> range of a PCI device is [0, num_VFs - 1], so should use (num_VFs - 1)
> as the last VF's ID.
> 
> Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

