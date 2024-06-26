Return-Path: <linux-pci+bounces-9272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6D917A6B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BE5288B23
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D11115ECF3;
	Wed, 26 Jun 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AK+b1Wvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC021B950;
	Wed, 26 Jun 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389122; cv=none; b=eQpHBfQbcFMdLF/Jrwh+/xNMZuOswwUk4wcic/gXQGKz2ziWgtHDZb4cXye5zMfcV0fUr96B314lNEoEiSyPbM7MpL5YlgKsyIpRCMzq3nv+we97IO/Cc8MsdtuFSYxhfNCn9MZrUGcdtLBza3R/UYEu6SH9kiv1/YsnJ+n0gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389122; c=relaxed/simple;
	bh=NO2nQcZ2MsfPLNVnNwfif2tORQe8GnNPQW2GK3n7VjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax9djth2f8J1fP0KD0/VuUE4AG+YOCmCaX7OiLZSX6CyAXXUJNstEsZXcMBc5syklqxCbvSLd7bXp50mAS8GvZNaaSJaMtReWoTXKPUNFm3An43IPVVcgkcDuOol7CaNT2BAqtLyGkDAMWS7cRS3OJzFliF210R94VuZMSnACXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AK+b1Wvh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719389121; x=1750925121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NO2nQcZ2MsfPLNVnNwfif2tORQe8GnNPQW2GK3n7VjM=;
  b=AK+b1WvhYTo8PRmK2/J1k7WfehJyTjsZyMTuqLs3EFyprtWEfBcIJoX1
   +b3R9DSWd0Oa/4x4t2TQ5fVZoAVx9I5uy4pIQ6yyE3/z4mPkn25yt4GQ/
   NrnF8FtOJKrHeZKWJsXN8d26pwpNQhqkf1z8aceLd8vxDkitwF8x9FEIf
   VFhplnY20IYf82RxYf6fml3U21baqBVkUtNvQZ+FsOn5IrN3kwjdpdlVw
   Nx6wpoUVzOXjerzQZr8/B8CzIzSkOnOPfANfBxxKgJGm+a0wgdEOqbEbT
   TdAI99cyBfMMEyY6hTC+oealae7gLasEanZ91pt+hc1L/ZVI0kKWcgmnZ
   w==;
X-CSE-ConnectionGUID: FP75FpkcS8y2D6u0fhg86Q==
X-CSE-MsgGUID: ED1w7JQpRm6g3YDzqGvHIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27132179"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27132179"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:05:20 -0700
X-CSE-ConnectionGUID: F2bi56lXSEWfITxcBWA8oQ==
X-CSE-MsgGUID: RZXiS4OFR1SI2qKYnXRyEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="43739987"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jun 2024 01:05:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id AD8CF346; Wed, 26 Jun 2024 11:05:17 +0300 (EEST)
Date: Wed, 26 Jun 2024 11:05:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240626080517.GZ1532424@black.fi.intel.com>
References: <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>

Hi,

On Mon, Jun 24, 2024 at 11:58:46AM -0400, Esther Shimanovich wrote:
> On Thu, May 16, 2024 at 5:16 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > I suggest trying on more devices just to be sure it covers all of them.
> 
> I tested Mika's on additional devices, Lenovo ThinkPad T490 (JHL6250),
> Dell Latitude 7400 (JHL6340), Lenovo Thinkpad Carbon X1 Gen 7
> (JHL6540) and the HP Elitebook 840 G6 (JHL7540) and the patch worked
> smoothly on all of those devices. It looks good to me! If you have any
> specific types of additional devices you'd want me to test this on,
> then let me know!

Thanks for testing! I don't have any additional devices in mind.

I will be on vacation starting next week for the whole July. The patch
is kind of "pseudo-code" in that sense that it probably needs some
additional work, cleanup, maybe drop the serial number checks and so on.
You are free to use it as you see fit, or submit upstream as proper
patch if nobody objects.

If nothing has happened when I come back, I can pick up the work if I
still remember this ;-)

