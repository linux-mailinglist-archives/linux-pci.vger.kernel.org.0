Return-Path: <linux-pci+bounces-37785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74BBCBAFE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 07:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57CE8353C16
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 05:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFF846F;
	Fri, 10 Oct 2025 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBil4LyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34F4207A
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072472; cv=none; b=DvuCxGsEAj3/XFWafVx+DaXXY+qmgBKGP18QTmk6K42ynCoMZOnwWq2EgIq4Sg5hRUjoSuAUuKUTvwRIjJvEoqB5KG9PLewMfYooq8He5CnSUi3UwnEwanUoiFc4MsfXk2L9iBTsRjBT09RYZX3jTLrXCc2cbyJ69MKARDUMkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072472; c=relaxed/simple;
	bh=3cnwdrJOwxkyJQe55hTvzk1zWVrendZOcMWkOmDMTZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlcU9D4a51OPc2oRwODPCBBoVETPsSm3SrZAohX/+o+9RcOhrMe5SKbRM3RExMFMmShvMg8C69f7FPwMHI6UJG9En8Gix5pl1zBNrxponNDM+tWdFQsd2Ls6867ZPc9XhfRFSfODJKuqur4qOo9HSWZEWBVVUuYsDvSNLDgKpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBil4LyQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760072471; x=1791608471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3cnwdrJOwxkyJQe55hTvzk1zWVrendZOcMWkOmDMTZg=;
  b=FBil4LyQpb0eS8tkkL52ZLFWU/a0nioM9a2OZIrwzhxSAyRHD2xxlCxs
   WgzGYrCijmMKF1/8GZWAgb1lmSOVp7QipDF9SbsaUw36R2z9ovtLRjTRU
   8agX00J2G0BTvUSZtitBe4IEyk3XxBfteVGT9M0T0+wsdpCixYlhvTXXF
   E0O4TC4Z+CBSg5SnCEtBIA+SfQ0oiR1wHbMbVGGlF7Fh+t7aA0vza5Ylz
   gd4j2Z2S5/kJaWqb8Mk5WGwpn9FYkXyovdjNxtrS9Wd8G7Aa03OMfqpVQ
   rwEHre/ITMkPHfxZdIfaIVitRpfH86aW3HQzPHF0q/Dz8yeUJ4I4in9N+
   Q==;
X-CSE-ConnectionGUID: 9R3XcyIrTjK04+/VqSpksA==
X-CSE-MsgGUID: ZoVQWyOgTseSSqdRTLpwyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79733361"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79733361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 22:01:10 -0700
X-CSE-ConnectionGUID: WUpT8L4SRQiUwNxPsMm76g==
X-CSE-MsgGUID: Fv7Ita3jQmeNKt7wlPgS5w==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 09 Oct 2025 22:01:08 -0700
Date: Fri, 10 Oct 2025 12:48:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Message-ID: <aOiQEc9+LYwNsFLH@yilunxu-OptiPlex-7050>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
 <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
 <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>

> > >> Out of curiosity (probably could go to the commit log) - for what kind
> > >> of request and on which platform we do not know the response size in
> > >> advance? On AMD, the request and response sizes are fixed.

For TDX, the maximum response size are decided by guest, that's because
GHCI says guest should allocate request/response pages big enough for the
GHCI call. But guest may not know the actual response data size generated
by host.

> > > 
> > > I don't know. Given this is to support any possible combination of TSM
> > > and ABI I took inspiration from fwctl which is trying to solve a similar
> > > common transport problem.
> > 
> > If guest_req() returns NULL - what is it - error (no response) or
> > success ("request successfully accepted, no response needed")? The PSP
> > returns fw_err (which I pass in my guest_request hook), does this
> > interface suggest that my TSM dev should allocate a sizeof(fw_err)
> > buffer at least, and if there is more - then
> > sizeof(fw_err)+sizeof(response)? I thought TDX does return an error
> > code too, surprised to see it missing here.
> 
> As we talked about on the CCC call it sounds like at least TDX also
> wants to pass an explicit FW response code separate from the response
> buffer, so I will fix this up to not follow fwctl.

Now the API looks like:

 int pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
                       void *req_in, size_t in_len, void *req_out,
                       size_t out_len, u64 *tsm_code)

I understand the out_len should be the maximum response size decided by
guest, then I need an extra parameter actual_out_len.


Another thing is, the req_in/out bufers are user buffers passed in from
QEMU, but IOMMUFD does't have to copy them. We could offload the work to
TSM driver. It is because only TSM driver knows/cares the actual valid
data size in these pages, it could do copy_from/to_user() in most
efficient way.

----8<----

 int pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
-                     void *req_in, size_t in_len, void *req_out,
-                     size_t out_len, u64 *tsm_code)
+                     void __user *req_in, size_t in_len, void __user *req_out,
+                     size_t out_len, size_t *actual_out_len, u64 *tsm_code)


> 



