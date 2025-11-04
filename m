Return-Path: <linux-pci+bounces-40267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F066C3293A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E619D18C22F6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3433E34A;
	Tue,  4 Nov 2025 18:10:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F433F8A5;
	Tue,  4 Nov 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279859; cv=none; b=m9+WtB0q+mt+HGizLWqztM1x0QAfJrv3Llby8MLuiK76kexqOwCxk6SQskWIoyfKRKyOch15JV2Bfa1H69De+frYgjSQ/EZWW0k+oxS6/zVjDYelJmMcOmRLvHb5dIG/puQAcFv6ZpoVpX91pjob7SnV3elZM4TkMVYAjM+x4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279859; c=relaxed/simple;
	bh=XuUiG47ISv44Sp1JnJsqzc9DQGp2Ng5Oj3Rl+aDtfiA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo7aOhBIsfLSsbhIDpVWsp6AFO7EI9yS3eD2dVF2OVLmq9bShMFHHJmc2enKD+WADvTQd5914EafL9FakFJXo6ut7Npt2Tz6pw90IaKzOo8EEw4Wu50kF9GuBLkdXcn6gexVvquAfim/nnoOiRdsKvSas51CcW3XEEZY1LMSLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1Ghq4mpczJ468g;
	Wed,  5 Nov 2025 02:10:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8630F14038F;
	Wed,  5 Nov 2025 02:10:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:10:54 +0000
Date: Tue, 4 Nov 2025 18:10:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 10/25] cxl/pci: Update RAS handler interfaces to
 also support CXL Ports
Message-ID: <20251104181053.00003587@huawei.com>
In-Reply-To: <20251104170305.4163840-11-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:50 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
One additional comment inline.

> ---
> 
> Changes in v12->v13:
> - Added Ben's review-by
> ---
>  drivers/cxl/core/core.h    | 15 ++++++---------
>  drivers/cxl/core/ras.c     | 12 ++++++------
>  drivers/cxl/core/ras_rch.c |  4 ++--
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index c30ab7c25a92..1a419b35fa59 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
> +#include <linux/pci.h>

Similar to earlier. Not setting what is no here that is pci specific
that wasn't before.  Maybe a forwards def of
struct device is needed? 

>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -148,23 +149,19 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> -void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>  #else
>  static inline int cxl_ras_init(void)
>  {
>  	return 0;
>  }
> -
> -static inline void cxl_ras_exit(void)
> -{
> -}
> -
> -static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
> +static inline void cxl_ras_exit(void) { }
> +static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	return false;
>  }
> -static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
> +static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  /* Restricted CXL Host specific RAS functions */


