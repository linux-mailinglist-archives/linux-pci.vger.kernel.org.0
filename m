Return-Path: <linux-pci+bounces-37789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E1BCBF86
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D661B4E5B04
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E3239E80;
	Fri, 10 Oct 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfePWmk3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202641531C1
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082488; cv=none; b=M/7/pW1YTMuAQYtWouAEOon4QG9N0H8XiAXsSTnr2d+/Mnt3ZbqsaU7MbhHEWcnufkPoQ5pRGmtrAH2mC/lyZRq0cfsxYJtZTLTsvJmUhh1JtSTkL3O7Z5xRtbirat1ZPZh1nyVTKTP3SE4h54r6fziQGeKPr+EaxyOmInz1cJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082488; c=relaxed/simple;
	bh=QR+79gInbBZ5CxZA6OjrYv3Y8tlDpMYUPUR117w2zXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZyM3GkKz9DA9ymNhwEaiJNSXoa7Qh/I/I1nw6ZfBiJoavMsqcKXP3eFkisFlnLMRtrIRbkH8+Cb4OdpRTs0Traha/GHJgbgHwKV5fpjW638oU1Bj3JKYRYPsGp73AV2mU95yBBLILI3UOhDa2vpdAXjQKWwyPNnoPZsyx4UoRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfePWmk3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760082487; x=1791618487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QR+79gInbBZ5CxZA6OjrYv3Y8tlDpMYUPUR117w2zXw=;
  b=HfePWmk3e0XFvNdoWKTvegGwOfLy8+Rx/MDVCxmaN6otYIsjTzBwaM6T
   zMeOz9jnjzlcBOLsoKW4WrE0bpEMCnH9rWngtrV+PJUBJrqG+2emPugtQ
   Tu9uxaAlG7amy4NDYl3qBz4brw4g1Ms/jPMWXh4ni/jNkKRaSGEQpADw4
   axY+meD+ooc37hmNXsKfbuXYIN/xoPHGHMCzLO75ws1GdXCH4ubrHBmFS
   z66pfEVs2jTKoLuO75yMLooVe7roPfYkQCfz1ahlJoeawJelPQXSamHRD
   4AlV0MLpwvPQR9uOlMm5McKKMfL2+JHQHtSofJo4TADlE3fjL0breRDos
   g==;
X-CSE-ConnectionGUID: aSO9F2cAR02RapAnnav0BQ==
X-CSE-MsgGUID: TQuMgeVmQ0SzjmSDmS8oSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62398543"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="62398543"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:48:04 -0700
X-CSE-ConnectionGUID: 0TZkgInARuqoVsBgMAxh3g==
X-CSE-MsgGUID: 5QCkOTztRsuMm5SdW/rXRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180931670"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 10 Oct 2025 00:48:02 -0700
Date: Fri, 10 Oct 2025 15:35:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, xin@zytor.com, chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 09/27] ACPICA: Add KEYP table definitions
Message-ID: <aOi3L/Kv1s9Jw/Eo@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-10-dan.j.williams@intel.com>
 <aOPVKpkZK9nFOo49@vermeer>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPVKpkZK9nFOo49@vermeer>

On Mon, Oct 06, 2025 at 04:41:46PM +0200, Samuel Ortiz wrote:
> Hi Dan, Dave,
> 
> On Fri, Sep 19, 2025 at 07:22:18AM -0700, Dan Williams wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Add KEYP ACPI table definition defined by [1].
> > 
> > Software uses this table to discover the base address of the Key
> > Configuration Unit (KCU) register block associated with each IDE capable
> > host bridge. TDX host only gets the max IDE streams supported from KCU,
> > it doesn't access other parts since host won't directly touch the host
> > side IDE configuration, TDX Module does.
> 
> Can you share more about how the TDX Module knows about where the KCU
> register block is? Is the host VMM supposed to explicitly "donate" that
> MMIO region to the TSM before TDH_IDE_STREAM_KM?

No, host VMM doesn't tell TSM about the KCU region. BIOS assigns the KCU
regions, it tells host where is the KCU by generating KEYP, it tells
TDX Module the same info by generating another info table.

Thanks,
Yilun

> 
> I'm asking that question to potentially align the RISC-V TEE-IO spec [1]
> with a similar KEYP based implementation, as I think it is simpler.
> 
> Cheers,
> Samuel.
> 
> [1] https://github.com/riscv-non-isa/riscv-ap-tee-io/blob/main/src/07-theory_operations.adoc#root-of-trust-spdm-session

