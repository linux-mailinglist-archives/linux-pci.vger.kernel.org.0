Return-Path: <linux-pci+bounces-2796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34258420E3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36227B21547
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8166089C;
	Tue, 30 Jan 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd+UIPQc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869760885;
	Tue, 30 Jan 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609621; cv=none; b=r0EtmyxDyOlGMiwJyRK1IXG79+PAOI52cL5RUPjLNqre4CgXAymcrFV9rq3uKJ/O6ZD3wNl6riVs/tBAQM0tx4wNFH6hUL9HxGKxEH01B0W3deUSjfLn7b7x/yUTXy55fw26u2MqMefEHDPTtFYkhu6Eqqw6JgEFrpmRSM8/wD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609621; c=relaxed/simple;
	bh=PBHyE/70hNgy03hBgSuUnxkVHspsZdCRdFN/IU+Qe0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TduT4+so9qkdc44DQYPWf52bRIpajJJfAxFkbRhpSpGzlAsBXDsnTxuIJjvdqyP89JtJk2OReH04ATBR3ezogeIxGv7msvA+xbzZY1GTRtqO158lOXg7iQm1C+iwXFLc0XV3hEc6JBagihOM8X8qM3+vD7CCAVhIqcgc+1UcN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd+UIPQc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706609620; x=1738145620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PBHyE/70hNgy03hBgSuUnxkVHspsZdCRdFN/IU+Qe0U=;
  b=Nd+UIPQcaw0QGlsDhF8RWVCua0RcB+4FL2LnZEQzbjNhB6l3dLSP5msG
   wJE48E0boCAaEyygo3PRjWLthEroC6ONFY03yiet29e9Big6KqzuB6cPw
   N6nt0DvBRviRckFV6Q+OkCkQhzb4MK4YkmhRq6ZHzeCULLQZE59rTPH5F
   cjlI/bbAPyKSal1GP37KXQTdrqgFoPOhm6CMUeeV8X03Qocy+CBabyIHo
   N9jyCVK+fJWqZc5TJCC4+WEXIHixWPgjRarqU0Vfic3tAcf8OoTwR1rRc
   k8KMKUWhIdwGrnSTwRgQUNc4WJ8R0TQNA8Q0tIs87DN5fwNJTVr87yQcL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9903473"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9903473"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931396166"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931396166"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2024 02:13:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 3B759DE; Tue, 30 Jan 2024 12:13:35 +0200 (EET)
Date: Tue, 30 Jan 2024 12:13:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <20240130101335.GU2543524@black.fi.intel.com>
References: <20240130095933.14158-1-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130095933.14158-1-jhp@endlessos.org>

Hi,

On Tue, Jan 30, 2024 at 05:59:33PM +0800, Jian-Hong Pan wrote:
> Some systems, like ASUS B1400CEAE equipped with the SATA controller
> [8086:a0d3] can use LPM policy to save power, especially for s2idle.
> 
> However, the same controller may be failed on other platforms. So,
> commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
> controller") drops LPM policy for [8086:a0d3]. But, this blocks going
> to deeper CPU Package C-state when s2idle with enabled Intel VMD.

Tiger Lake really should support this with no issues (as are the
generations after it). I suggest trying to figure out what was the root
cause of the original problem that triggered the revert, if possible at
all, perhaps it is is something not related to LPM and that would allow
us to enable this unconditionally on all Tiger Lake.

I'm pretty sure the platform where this was reported suffers the same
s2idle issue you are seeing without this patch.

