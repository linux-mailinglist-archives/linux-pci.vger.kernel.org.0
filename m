Return-Path: <linux-pci+bounces-40448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC9C392A7
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 06:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06AB4E1C2F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 05:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D52C0F78;
	Thu,  6 Nov 2025 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REF7shGR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B69237180
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407175; cv=none; b=YJMxe9ZmPaffHVID2NGpwWB2Bh1pOWoj5TZVr+r29BUKw5dnT9hlok+7kFLUCz6Uqe/2bb0ZWBdFQ/rTJvRKMNRP+GNDKvTufZaLhN4j/aWPiXJJVi5lGyeu76hLwh+u5vgjCtHqsWozTA7K2ic6CKH7QYXC+J+aS6OuCIIRSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407175; c=relaxed/simple;
	bh=dYFY6jnUpiXgj5PLMHXwpCT3ul2RIVubhKiYN9VOHeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJTttxZtBUycbeauyDET5fWNdEJk1neohwbi+udiy+msfMMvugWSDJmewy/kYcS8TbT7ygDHa63oGT23l815HIbNOQD4Yq5VhsaUDfF4x6jrW/QSE/xD4O8V0I5IIY6z1Kcs5wcGofMsfZScrY7aozwkT3DGGxzpi9rHq4K5Grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REF7shGR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762407173; x=1793943173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYFY6jnUpiXgj5PLMHXwpCT3ul2RIVubhKiYN9VOHeE=;
  b=REF7shGRUpe44GtB7GE5tyOAXaP98i3vfGWOwDAr8gwFRNrCoqj424Bu
   B+Wj95apW+rfB7yTuv/pCibcU17nKOxU9EHga0ghHi1F8xSpjBx2XfrTS
   +yvRmDf97Wkub7Z2ZPNJC7LJDQOAeZICQJd+14Xd0EGMeIo/WR4/ICVhE
   AywNfli2AOE7sjupkKkPtO2MM+nCEXbELmYXLV7SRRTmTa4iVBEirZoqY
   +a9VnZNLpehMNC22nKMG7c69vuQieuelOtIDMXartPqT6mi2q0lQl0Unh
   WFOGxU52SW3+ACXuFSLOgCzpQe4huzVSDF2G1PVXUPZzfIrBX7e35DtPd
   w==;
X-CSE-ConnectionGUID: iWG/IN1MQJa21oW87n/Rkg==
X-CSE-MsgGUID: Hj6JOaw7TVSmgFaiToQI9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67149675"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="67149675"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 21:32:52 -0800
X-CSE-ConnectionGUID: jqEYUw3lRTKI+hbD6aQ68Q==
X-CSE-MsgGUID: HGY1AkkARrmqqoPM0QTaXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="192835393"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 21:32:50 -0800
Date: Thu, 6 Nov 2025 13:18:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	xin@zytor.com, chao.gao@intel.com
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Message-ID: <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
 <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>

On Mon, Nov 03, 2025 at 03:34:15PM -0800, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
> > On Fri, 19 Sep 2025 07:22:29 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > 
> > > Add basic skeleton for connect()/disconnect() handlers. The major steps
> > > are SPDM setup first and then IDE selective stream setup.
> > > 
> > > No detailed TDX Connect implementation.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Feels like use of __free() in here is inappropriate to me.
> > 
> > > ---
> > >  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > > index f5a869443b15..0d052a1acf62 100644
> > > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > > @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
> > >  	return ret;
> > 
> > > +
> > > +static void __tdx_link_disconnect(struct tdx_link *tlink)
> > > +{
> > > +	tdx_ide_stream_teardown(tlink);
> > > +	tdx_spdm_session_teardown(tlink);
> > > +}
> > > +
> > > +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> > > +
> > >  static int tdx_link_connect(struct pci_dev *pdev)
> > >  {
> > > -	return -ENXIO;
> > > +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > > +	int ret;
> > > +
> > > +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
> > I'm not a fan on an ownership pass like this just for purposes of cleaning up.
> 
> Yeah this needs a rethink. The session and the stream are independent
> resources. It can be a composite object that encapsulates both
> resources, but not tlink directly.
> 
> ...chalk this up to RFC expediency.
> 
> > I'd be a bit happier if you could make it
> > 	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);
> > 
> > but I still don't really like it.  I think I'd just not use __free and stick
> > to traditional cleanup in via a goto. 
> 
> I would not go that far, but certainly I can see that being preferable
> than reusing the existing base 'struct tdx_link *' as the cleanup
> variable.

The latest implementation internally is as follows. tlink_spdm &
tlink_ide represent independent resources though they point to the same
instance. I'm already comfortable about this code:

static int tdx_link_connect(struct pci_dev *pdev)
{
	struct tdx_link *tlink = to_tdx_link(pdev->tsm);

	struct tdx_link *tlink_spdm __free(tdx_spdm_session_teardown) =
		tdx_spdm_session_setup(tlink);
	if (IS_ERR(tlink_spdm)) {
		pci_err(pdev, "fail to setup spdm session\n");
		return PTR_ERR(tlink_spdm);
	}

	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
		tdx_ide_stream_setup(tlink);
	if (IS_ERR(tlink_ide)) {
		pci_err(pdev, "fail to setup ide stream\n");
		return PTR_ERR(tlink_ide);
	}

	retain_and_null_ptr(tlink_spdm);
	retain_and_null_ptr(tlink_ide);

	return 0;
}

