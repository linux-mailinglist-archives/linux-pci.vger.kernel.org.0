Return-Path: <linux-pci+bounces-3173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0A584BBBF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A11C23002
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08246FB1;
	Tue,  6 Feb 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbH/xjJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4CCA4A;
	Tue,  6 Feb 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240217; cv=none; b=W+NRZ+NbhvI6LkVxj25VuVzbT6bhH9pEyLGEyYuHKp8kyj0CisKCFo3AfoSS34wZtBlDHyTkollysPsYrt66B6rULPmCtx4BO2wsJ5XVIy8DiM9YRN34EW6q3ZiDFJqUG0njBOHACavmpRRg9whkJEW+vs5ebUcJ3iT9F5L3A1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240217; c=relaxed/simple;
	bh=po8vFxWrgnIMI30IcGK3wKjOx+diDmMTZZJBoYh+eQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ptp/Ub1Vh+vRM3vexZNK4ipHEDE4MBnoiODARqM4nuUtT/wjZ76mPTUIrQIrF+NnmC6p2iZs6KhXvKQInMbbFWjvX9gXMgBQ/zzosX3e0m+o4wVJzj3LBZJ2llRSs9BwTTv91vEvUg1DrR7Ikdkklf/tDOvTariT/aj0KJcAzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbH/xjJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C145DC433F1;
	Tue,  6 Feb 2024 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707240217;
	bh=po8vFxWrgnIMI30IcGK3wKjOx+diDmMTZZJBoYh+eQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VbH/xjJYNUgcSHYX8q6R3XOgMBMYdLFz0wwh7u9in+aDxvfieDaQsfcKyvc8IJljm
	 b4KjHmApQTFpV3dO3iDbgzIq452iChe4Hlh+NbWkOfvbUZAwcqMJKOmdrdWJDvx820
	 yGKAU6o3UzpUqJtxSEDdVVdgjfhrjOOzt539Zz72GbRfzqXZni2RnBmRWm0weRDqIa
	 abarX5VsT/PfIoUpx71JSSklbKAA2HtBv69vFwRwxqV13L9xCWMblKCxtAmGpAIqwi
	 8sqKs24ZwA9C+e3TEvivW9S6Jps4z6qQAk8w70V+oieQDehciCMb6nvmk5plKPIwiL
	 i1EveBd1FnZ6A==
Date: Tue, 6 Feb 2024 11:23:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com,
	erwin.tsaur@intel.com, feiting.wanyan@intel.com,
	qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Adam Preble <adam.c.preble@intel.com>, Li Yang <leoyang.li@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/AER: Store more information in aer_err_info
Message-ID: <20240206172335.GA872811@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2rfnevhnhylik4r6smr56uunsxweo7s5elo65sjhiztvxnr6bq@5fcyv22zxyyp>

On Wed, Feb 07, 2024 at 12:41:41AM +0800, Wang, Qingshun wrote:
> On Mon, Feb 05, 2024 at 05:12:31PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 25, 2024 at 02:27:59PM +0800, Wang, Qingshun wrote:
> > > When Advisory Non-Fatal errors are raised, both correctable and
> > > uncorrectable error statuses will be set. The current kernel code cannot
> > > store both statuses at the same time, thus failing to handle ANFE properly.
> > > In addition, to avoid clearing UEs that are not ANFE by accident, UE
> > > severity and Device Status also need to be recorded: any fatal UE cannot
> > > be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
> > > not take any assumption and let UE handler to clear UE status.
> > > 
> > > Store status and mask of both correctable and uncorrectable errors in
> > > aer_err_info. The severity of UEs and the values of the Device Status
> > > register are also recorded, which will be used to determine UEs that should
> > > be handled by the ANFE handler. Refactor the rest of the code to use
> > > cor/uncor_status and cor/uncor_mask fields instead of status and mask
> > > fields.
> > 
> > There's a lot going on in this patch.  Could it possibly be split up a
> > bit, e.g., first tease apart aer_err_info.status/.mask into
> > .cor_status/mask and .uncor_status/mask, then add .uncor_severity,
> > then add the device_status bit separately?  If it could be split up, I
> > think the ANFE case would be easier to see.
> 
> Thanks for the feedback! Will split it up into two pacthes in the next
> version.

Or even three:

  1) tease apart aer_err_info.status/.mask into .cor_status/mask and
     .uncor_status/mask

  2) add .uncor_severity

  3) add device_status

Looking at this again, I'm a little confused about 2) and 3).  I see
the new read of PCI_ERR_UNCOR_SEVER into .uncor_severity, but there's
no actual *use* of it.

Same for 3), I see the new read of PCI_EXP_DEVSTA, but AFAICS there's
no use of that value.

We should have the addition of these new values in the same patch
that *uses* them.

Bjorn

