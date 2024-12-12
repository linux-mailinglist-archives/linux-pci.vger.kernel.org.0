Return-Path: <linux-pci+bounces-18217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83F9EDF3E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 07:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA81652C0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2E18732B;
	Thu, 12 Dec 2024 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LL71F2nz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7981885AA
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733983818; cv=none; b=BJh5rFf7JSMUiLPP2sbFVgMuOj0QUpKyPpCooUa/CPQ7FoJ7nfiNUQW7gHCRv6FP7LVJyblivUqi1Bj78hHhozVyIzia3/RPfmmptO17C9Vu0g0hqy2FsTm0A2HcA94534kLDnXsW9q9Iztt5BrNYlDSyfYp0MJQLBeZNG3pksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733983818; c=relaxed/simple;
	bh=4L3wYQ7p00o+SJ1pcrtMRGb0kP0Ba263qdOirPTWMNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbBlfiy4gvHea8O+aeSamyoHcaoaqk6TQT9T4HnAevkfDmRVkRJT59ZE7s7azlUmTDfI4Py0QHhJIkl8R0NpFAFair9PwWrJDK9bwPN2j3iT3vBQcQ3cZS7rjA1xPMv2xhpjvatNC9Dfu5JYmDMGEHWpw1Zo0ez5maxBgbQp6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LL71F2nz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733983816; x=1765519816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4L3wYQ7p00o+SJ1pcrtMRGb0kP0Ba263qdOirPTWMNI=;
  b=LL71F2nzwN0Q4YLR4X+Ym4MCWIpQWMSXTFaicK7ACET8Uza4/vW29hW3
   CYbG5arijsxmh9390JVfJK+S4Uug0JnnasCC4VIL908Z3NDQE6m8oOVbK
   7H3WcEGeD0L/SHJPss24S5M6Slq1rsWaAqvb02CrQbXxr5sLP9aHcU8f9
   4Z86dWoqAwAjID6RtOBw9rKnqJXOyUr8ySTglFJQHH6c9k0wChlR3h3Dc
   gShTiZa4uZrcvc9bePpYKkDRVpM7fsnhsfwhGI9g77o7dOwMyhkiyvDmn
   4EUHO4wC1dqAUdSJ+usKGh9srb6dA1dLeAg4VI7SpVRE1KbvbtEJ4d4mk
   g==;
X-CSE-ConnectionGUID: krntlqCeSWK9op1LD7cxOA==
X-CSE-MsgGUID: XjJntHOPSsemQ27RzwlhzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34294198"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34294198"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:10:15 -0800
X-CSE-ConnectionGUID: jF59xCHxSvqKKRzK5PIr8w==
X-CSE-MsgGUID: 2sSef9seTWyLNRlQJZvwCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96010304"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 11 Dec 2024 22:10:13 -0800
Date: Thu, 12 Dec 2024 14:06:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <Z1p9f6HHkjlOw5Fc@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>

> > +/* Selective IDE Stream Capability Register */
> > +#define  PCI_IDE_SEL_CAP		 0
> > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> > +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf

PCI_IDE_SEL_CAP_ASSOC_NUM_MASK is better?

> > +/* Selective IDE Stream Control Register */
> > +#define  PCI_IDE_SEL_CTL		 4
> > +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */

These fields are more likely to be written to the register than read
out, so may need other definitions.

I think generally _XXX(x) Macros are less useful than _MASK because of
FIELD_PREP/GET(), so maybe by default we define _MASK Macros and on
demand define _XXX(x) Macros for all registers.

> > +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> > +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> > +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> > +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> > +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> > +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
> > +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> > +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> > +/* Selective IDE Stream Status Register */
> > +#define  PCI_IDE_SEL_STS		 8
> > +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> > +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> > +/* IDE RID Association Register 1 */
> > +#define  PCI_IDE_SEL_RID_1		 12
> > +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> > +/* IDE RID Association Register 2 */
> > +#define  PCI_IDE_SEL_RID_2		 16
> > +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> > +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
> > +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> > +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> > +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> > +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
> 
> 0x000fff00 (missing a zero)
> 
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
> 
> 
> 0xfff00000
> 
> 31:20 Memory Limit Lower – Corresponds to Address bits [31:20]. Address bits
> [19:0] are implicitly F_FFFFh. RW
> 19:8 Memory Base Lower – Corresponds to Address bits [31:20]. Address[19:0]
> bits are implicitly 0_0000h.
> 
> 
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20

I don't think _SHIFT MACRO is needed, also because of FIELD_PREP/GET().

> 
> I like mine better :) Shows in one place how addr_1 is made:
> 
> #define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
> 	((FIELD_GET(0xfff00000, (limit))  << 20) | \
> 	(FIELD_GET(0xfff00000, (base)) << 8) | \
> 	((v) ? 1 : 0))

This Macro is useful for SEL_ADDR_1 but not generally useful for other
registers like SEL_CTRL, which has far more fields to input. So I'd
rather have only _MASK Macros here to make things simpler. This
specific Macro for SEL_ADDR_1 could be put in like pci-ide.h if really
needed.

Thanks,
Yilun

> 
> Also, when something uses "SHIFT", I expect left shift (like, PAGE_SHIFT),
> but this is right shift.
> 
> Otherwise, looks good. Thanks,
> 
> > +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> > +/* IDE Address Association Register 3 is "Memory Base Upper" */
> > +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
> > +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
> > +
> >   #endif /* LINUX_PCI_REGS_H */
> > 
> 
> -- 
> Alexey
> 
> 

