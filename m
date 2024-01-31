Return-Path: <linux-pci+bounces-2865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B9843875
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 09:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B07DB21E0A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9655C32;
	Wed, 31 Jan 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnTZpY74"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8875810E;
	Wed, 31 Jan 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688284; cv=none; b=NTWx9wVAPKem5mjsjttr/f1sX4lcYtgY9Hz35lyVOKSNQ6PLs1tQc38wML/qEogTthiO0s86BDDACsGu/Rm/F0/WbS2we/iJLz5hHxnMRmhDofUR7GNejSkwZYN53lbIMQVV6oXGSE1zYy4Ximh6z13R3c7bwwqui9B+lL0nj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688284; c=relaxed/simple;
	bh=2wy6IAqZWDlhSg8xSyQOwMuys/jiy/qt5c8fR9V26Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L284JjzBbHxyhZq69nKJiZdO6e48f6qiPPYQj3K/pWqQWxLR17Euqi3vaJkK22dZVpoVWZCoM09uIN00CERQ2md+y0IL9cgzkc7cuhKMWuJgbdbw4mdQOUlJ+p5RVFPEudBih56zRc9hLTTJBpf/nZV/NTcB1JDpMohpWstvBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnTZpY74; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706688283; x=1738224283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wy6IAqZWDlhSg8xSyQOwMuys/jiy/qt5c8fR9V26Dk=;
  b=RnTZpY7441tr9SUQhtUa7Lb/Y82sOq51hxnSFNIIUU1Qxw/tkujLmFlI
   0/0fox3fx85baQM+EZkPLLVsAP0LbNy5juv4GXwI28VJnMcgO2wiuaaeq
   9Pjqwn4f/WIgjzUURa+O04Ryo2y/NzBnAP0pyo9mPQ9hMe72bxd2peZXv
   T3IMLANiC6GpXuq5W1o13T+en8ze1olub9kXzETdkYpIQXSoG2jj1vSPq
   jGqfhFV7rFlXAzMQNla4KqACBIN0+iks3TblBFqRnrgvho9kSikcskWHS
   TA8rpNw8phoXA9Eyd7YGO1yznAAljWV3S0ZUaDYU5Zxw+2f+lHhhxJhgT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17059012"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17059012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3992171"
Received: from nixos.sh.intel.com (HELO localhost) ([10.238.2.93])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:04:33 -0800
Date: Wed, 31 Jan 2024 16:04:21 +0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-acpi@vger.kernel.org, chao.p.peng@linux.intel.com, erwin.tsaur@intel.com, 
	feiting.wanyan@intel.com, qingshun.wang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Shiju Jose <shiju.jose@huawei.com>, Adam Preble <adam.c.preble@intel.com>, 
	Li Yang <leoyang.li@nxp.com>, Lukas Wunner <lukas@wunner.de>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI/AER: Store more information in aer_err_info
Message-ID: <ojv6nqi55o4q3aazf34w7yjriagup3h5dmim7k67xuv6t7xdjr@m3bjyroi4jfq>
References: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
 <20240125062802.50819-2-qingshun.wang@linux.intel.com>
 <6ecb7bbf-0eba-4cea-b9b8-05fd092b7d01@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecb7bbf-0eba-4cea-b9b8-05fd092b7d01@linux.intel.com>

On Tue, Jan 30, 2024 at 06:26:39PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/24/24 10:27 PM, Wang, Qingshun wrote:
> > When Advisory Non-Fatal errors are raised, both correctable and
> 
> Maybe you can start with same info about what Advisory Non-FataL
> errors are and the specification reference. I know that you included
> it in cover letter. But it is good to include it in commit log.

Good idea, thanks!

> 
> > uncorrectable error statuses will be set. The current kernel code cannot
> > store both statuses at the same time, thus failing to handle ANFE properly.
> > In addition, to avoid clearing UEs that are not ANFE by accident, UE
> 
> Please add some details about the impact of not clearing them.

Makes sense, will do.

> > severity and Device Status also need to be recorded: any fatal UE cannot
> > be ANFE, and if Fatal/Non-Fatal Error Detected is set in Device Status, do
> > not take any assumption and let UE handler to clear UE status.
> >
> > Store status and mask of both correctable and uncorrectable errors in
> > aer_err_info. The severity of UEs and the values of the Device Status
> > register are also recorded, which will be used to determine UEs that should
> > be handled by the ANFE handler. Refactor the rest of the code to use
> > cor/uncor_status and cor/uncor_mask fields instead of status and mask
> > fields.
> >
> > Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 10 ++++-
> >  drivers/cxl/core/pci.c   |  6 ++-
> >  drivers/pci/pci.h        |  8 +++-
> >  drivers/pci/pcie/aer.c   | 93 ++++++++++++++++++++++++++--------------
> >  include/linux/aer.h      |  4 +-
> >  include/linux/pci.h      | 27 ++++++++++++
> >  6 files changed, 111 insertions(+), 37 deletions(-)
> >
> > ......
> >
> > @@ -1213,38 +1233,49 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
> >  	int temp;
> >  
> >  	/* Must reset in this function */
> > -	info->status = 0;
> > +	info->cor_status = 0;
> > +	info->uncor_status = 0;
> > +	info->uncor_severity = 0;
> >  	info->tlp_header_valid = 0;
> >  
> >  	/* The device might not support AER */
> >  	if (!aer)
> >  		return 0;
> >  
> > -	if (info->severity == AER_CORRECTABLE) {
> > +	if (info->severity == AER_CORRECTABLE ||
> > +	    info->severity == AER_NONFATAL ||
> > +	    type == PCI_EXP_TYPE_ROOT_PORT ||
> > +	    type == PCI_EXP_TYPE_RC_EC ||
> > +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> 
> 
> It looks like you are reading both uncorrectable and correctable status
> by default for both NONFATAL and CORRECTABLE errors. Why not do
> it conditionally only for ANFE errors?
> 
> 

My initial purpose was the value will be used in aer_event trace in
PATCH 4 under both conditions, but I can also add checks here to reduce
unnecessary IO and remove the checks in PATCH 4.

> > +		/* Link is healthy for IO reads */
> >  		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> > -			&info->status);
> > +				      &info->cor_status);
> >  		pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK,
> > -			&info->mask);
> >  
> > ......
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index add9368e6314..259812620d4d 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -318,6 +318,33 @@ struct pci_sriov;
> >  struct pci_p2pdma;
> >  struct rcec_ea;
> >  
> > +struct pcie_capability_regs {
> > +	u8 pcie_cap_id;
> > +	u8 next_cap_ptr;
> > +	u16 pcie_caps;
> > +	u32 device_caps;
> > +	u16 device_control;
> > +	u16 device_status;
> > +	u32 link_caps;
> > +	u16 link_control;
> > +	u16 link_status;
> > +	u32 slot_caps;
> > +	u16 slot_control;
> > +	u16 slot_status;
> > +	u16 root_control;
> > +	u16 root_caps;
> > +	u32 root_status;
> > +	u32 device_caps_2;
> > +	u16 device_control_2;
> > +	u16 device_status_2;
> > +	u32 link_caps_2;
> > +	u16 link_control_2;
> > +	u16 link_status_2;
> > +	u32 slot_caps_2;
> > +	u16 slot_control_2;
> > +	u16 slot_status_2;
> > +};
> > +
> IIUC, this struct is only used drivers/acpi/apei/ghes.c . Why not define it in that file?

You are right. Whenever we need it elsewhere, we can move it to the
header file anyway.

> >  /* The pci_dev structure describes PCI devices */
> >  struct pci_dev {
> >  	struct list_head bus_list;	/* Node in per-bus list */
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

--
Best regards,
Wang, Qingshun

