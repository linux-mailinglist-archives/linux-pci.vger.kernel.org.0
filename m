Return-Path: <linux-pci+bounces-24368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F539A6BDF2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D71891639
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64EC1662F1;
	Fri, 21 Mar 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO4FG6Yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D95CDF1
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569569; cv=none; b=Q7NiPpfuRctDqK4ClDV9tiymcjhhqwT/e/Ydfl2rkU0ii60zSOsF2DIm37yn3/0/GkI04+QuZufb2YBFJhG7XfBpPiqKg0gxDLYtEmHv45D5rvzKhQcqKjBoHcPsLdgMn0E2J6M/nP7DRQRdQV2auOLNq/4jxHoC5vHjlKb+kGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569569; c=relaxed/simple;
	bh=oLftrqio5fkri/zIWaa3scXSmMi9+HhojhmXMO/3Pnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aTFjzeiwceRfW8Ltiv4fgNI6wm1sD41Tqz5eM632zXYB4e6ZG8BAnwliYK2OCNlOtDgf11DF/ozKNiI0OuzFCYD22uT33E+Zpj6lmAGrINXeVsWFuHEW+TN+5bm0P0+xhT5LOBXqG3VsQdoKFupBR//8SHjag5XGFvOfpQ5irt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO4FG6Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22577C4CEE3;
	Fri, 21 Mar 2025 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569569;
	bh=oLftrqio5fkri/zIWaa3scXSmMi9+HhojhmXMO/3Pnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cO4FG6YbWF8GYgLJjTW1s6GafubRKO8lerLlzYHhBWX9CwpuT0irJntGoiq/udjy2
	 XOCs9h7/2AsgYsu9QsRuGxTJfH2F+T1eGqFHmwwCyCH8Bd203i+CsVmJE2cjIObT3g
	 VBPXonib7zJ0pgmzL4Nh1KRYV6hUSeIyjZCXIV3VybGtJYd4bb1fNHyvguO3RL+aOi
	 ANNp+0CByR5/xm1f8oSVHak7oJCAFykwMK9vDsJPBkuz+mwh7/0kdhx5/yfIUMG/tZ
	 oWoUFdCu3Z5p1VcsqKREBOqVEGJvA0JiGeId060YySY2OwxWQe604fXb80g1oyJ63F
	 L7KkIQDfDbiaA==
Date: Fri, 21 Mar 2025 10:06:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Liu Xinpeng <liuxp11@chinatelecom.cn>,
	Darren Hart <darren@os.amperecomputing.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
Message-ID: <20250321150607.GA1124679@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457b32f0-b020-4a0a-a557-0ef8201cb6f8@oracle.com>

On Fri, Mar 21, 2025 at 02:56:16PM +0100, Karolina Stolarek wrote:
> On 20/03/2025 19:17, Bjorn Helgaas wrote:
> > Maybe there's CXL magic that I missed.  It looks like Terry's series
> > changes some of this path.  And GHES also currently uses
> > pci_print_aer().

> ... But still, the question is if going with the
> new format that matches what's in AER a bad or disruptive thing. I'd like to
> try going in the direction of using one way of reporting AER errors, if
> possible.

Absolutely, I agree 100%.  The choice between native AER and GHES is
made by the platform, not by the OS, so I think it's crazy that we log
them differently.  We just need to include information about any log
format changes we make to help users adapt to them.

Bjorn

