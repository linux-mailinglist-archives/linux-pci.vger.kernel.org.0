Return-Path: <linux-pci+bounces-27082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B09AA68A4
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475B23A98FD
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDE2DC794;
	Fri,  2 May 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6+21MZN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691EE2DC76E
	for <linux-pci@vger.kernel.org>; Fri,  2 May 2025 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746152179; cv=none; b=B5H/RrA9W74z5LvIGAnvz36/bzhlqVUA68Z3+4kvMMsR+6aKiFNzfF/RPDksweLum+s5K4curfF6nQDxaJQMSIXPpX/GCghZ6hktOdzu3dUK5/3DjKjiig/IHhTkZfPg1/oDjpiv/+D8Z16XEu8WvRKhg7zbMeTbHfI//+uE2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746152179; c=relaxed/simple;
	bh=B9PwiHuBPBUyCYDYCJO2lT4E/VRcTPKF5VkULpjSOrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzpQalFMVcpNLFKIZmfnFrNRhfoWRsO898s6ZXLnaT7P4THbEG4MJApEYICwjL0PELdKYPXekVeAJS0cuU88k8kCjlFCBwpMA2PEO2p51U14AhuCWN3AFqk8RiA6fq3HAfIvcV1nGgUniDwm9Ie6Se/r4DXbNIfGpQ3fCSuqMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6+21MZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC9DC4CEE3;
	Fri,  2 May 2025 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746152175;
	bh=B9PwiHuBPBUyCYDYCJO2lT4E/VRcTPKF5VkULpjSOrs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=g6+21MZNhGA1ENbvpTwzzWab/6h4E+6KZGg2o36KkoBDvUSrkVCO6yExVHuWQHVjS
	 ruBPpVIICvWwL2LPLCXDcbQF4tXIX433MX97IBJnHRc1e5IYOnS7zz1fy/mCc6HaQl
	 W81S5i+X4HL/RIipBQk2MtO0vVZb3GlX6dRkSCQgghjG+FBpIy8O72oKwIy8zhVzPA
	 +PbLXNfc6T0aFsraAyS+ZEiTmB8qOWa0yK7osJQuSvZ4jIoKbl8HJeNyWwleEE6w4C
	 8S9NbdHinry8P5oUJlor1d6Xv62NkvFWY6QAWiCMumYeNO8qOVM4kT4lSTdrPtG6Up
	 knoUpvJK6pc4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C3C8CE092C; Thu,  1 May 2025 19:16:12 -0700 (PDT)
Date: Thu, 1 May 2025 19:16:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <8f61bd21-5dd1-47d6-8b63-1b1c94daf382@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250321223930.GA1172062@bhelgaas>
 <20250501220259.GA787711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501220259.GA787711@bhelgaas>

On Thu, May 01, 2025 at 05:02:59PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 21, 2025 at 05:39:30PM -0500, Bjorn Helgaas wrote:
> > On Fri, Mar 21, 2025 at 03:16:48PM -0700, Paul E. McKenney wrote:
> > > On Fri, Mar 21, 2025 at 05:01:15PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Mar 20, 2025 at 06:58:03PM -0700, Jon Pan-Doh wrote:
> > > > > Update name to reflect the broader definition of structs/variables that
> > > > > are stored (e.g. ratelimits). This is a preparatory patch for adding rate
> > > > > limit support.
> > > > > 
> > > > > Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> > > > > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > > > > Reported-by: Sargun Dhillon <sargun@meta.com>
> > > > 
> > > > What did Sargun report?  Is there a bug fix in here?  Can we include a
> > > > URL to whatever Sargun reported?
> > > 
> > > He reported RCU CPU stall warnings and CSD-lock warnings internally
> > > within Meta, so sorry, no useful URL.
> 
> CSD?  I guess knowing what CSD is isn't completely essential here, but
> I haven't a clue what it means.  Something to do with IPI and getting
> another CPU to run a function?  Is CSD an acronym for something?

Yeah, it is a bit obscure, apologies!

It is "CSD" as in the csd_lock() function, and it stands for "call single
data", as in the ->csd field of the call_function_data structure, which
is of type call_single_data_t.  All in the service of smp_call_function()
and friends, mostly in the file kernel/smp.c.

							Thanx, Paul

