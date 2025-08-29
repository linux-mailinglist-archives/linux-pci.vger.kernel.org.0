Return-Path: <linux-pci+bounces-35126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3EDB3BFB1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328E81C24E63
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7432C32A;
	Fri, 29 Aug 2025 15:42:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995132C30C;
	Fri, 29 Aug 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482130; cv=none; b=JF3enBLzJZ5euzxX33qEDyhXASBqjjctwVWDwxzqNeB9KPgZdkvZXqY6L5F8mC2OfO0pg0xvtyJ5kDU0ZSvRBJpWCE3dFisXpBXGGY1ZNPB7NRgJKGN/Pp45Lqf+CdsqRKpQK30GpNVDG6pjMbic4rPgmt4l+s9siXgBuYb8zkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482130; c=relaxed/simple;
	bh=eYjsxP4CtdFD112YUmWcX956VSfxQ8Mc5PddTXb+cKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbxCeewc6aGLKZPJQ6TWZoE5AxU16rWRr5bosjZHobDY+0G73xr6VbcyB3ZBDygrme51TZauHl0tQ+7mSrBGNrjaqosKv43Dxuhwcc4djGlrZtoZkixZT4yk01YqhL5yXhvb5MfXW6nS1OaCf8hDV65v2i7LhEA0jkqvoyDyXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD2Wj0pQfz6GFK4;
	Fri, 29 Aug 2025 23:39:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD87314033F;
	Fri, 29 Aug 2025 23:42:05 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 17:42:04 +0200
Date: Fri, 29 Aug 2025 16:42:03 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v11 07/23] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20250829164203.00005381@huawei.com>
In-Reply-To: <aK8bY0epS6OStdfr@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-8-terry.bowman@amd.com>
	<aK8bY0epS6OStdfr@wunner.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 27 Aug 2025 16:51:15 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Aug 26, 2025 at 08:35:22PM -0500, Terry Bowman wrote:
> > The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> > accessible to other subsystems.
> > 
> > Change DVSEC name formatting to follow the existing PCI format in
> > pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.  
> [...]
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1225,9 +1225,61 @@
> >  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
> >  
> > -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> > -#define PCI_DVSEC_CXL_PORT				3
> > -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> > -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> > +/* Compute Express Link (CXL r3.2, sec 8.1)
> > + *
> > + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> > + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> > + * registers on downstream link-up events.
> > + */
> > +
> > +#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
> > +
> > +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> > +#define PCI_DVSEC_CXL_DEVICE					0
> > +#define	  PCI_DVSEC_CXL_CAP_OFFSET	       0xA
> > +#define	    PCI_DVSEC_CXL_MEM_CAPABLE	       BIT(2)
> > +#define	    PCI_DVSEC_CXL_HDM_COUNT_MASK       GENMASK(5, 4)
> > +#define	  PCI_DVSEC_CXL_CTRL_OFFSET	       0xC
> > +#define	    PCI_DVSEC_CXL_MEM_ENABLE	       BIT(2)
> > +#define	  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)     (0x18 + (i * 0x10))
> > +#define	  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)      (0x1C + (i * 0x10))
> > +#define	    PCI_DVSEC_CXL_MEM_INFO_VALID       BIT(0)
> > +#define	    PCI_DVSEC_CXL_MEM_ACTIVE	       BIT(1)
> > +#define	    PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
> > +#define	  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)     (0x20 + (i * 0x10))
> > +#define	  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)      (0x24 + (i * 0x10))
> > +#define	    PCI_DVSEC_CXL_MEM_BASE_LOW_MASK    GENMASK(31, 28)  
> 
> Is it legal to use BIT() in a uapi header?
> 
> We've only allowed use of GENMASK() in uapi headers since 2023 with
> commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
> 
> But there is no uapi header in the kernel tree defining BIT().
> 
> I note that include/uapi/cxl/features.h has plenty of occurrences of BIT()
> since commit 9b8e73cdb141 ("cxl: Move cxl feature command structs to user
> header"), which went into v6.15.
> 
> ndctl contains a bitmap.h header defining BIT(), I guess that's why this
> wasn't perceived as a problem so far:
> https://github.com/pmem/ndctl/raw/main/util/bitmap.h
> 
> However existing user space applications including <linux/pci_regs.h>
> may not have a BIT() definition and I suspect your change above will
> break the build of those applications.

Probably not breaking existing code, as it would have to actually use the
define to run into problems.  However, it's still a an excellent point
as adding register definitions that can't be used is not helpful.

Jonathan
 
> 
> Thanks,
> 
> Lukas
> 


