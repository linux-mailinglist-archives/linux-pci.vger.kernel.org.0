Return-Path: <linux-pci+bounces-128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C057F4778
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD64B20DCB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873224D5B2;
	Wed, 22 Nov 2023 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWDJrgxg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691719D;
	Wed, 22 Nov 2023 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700658891; x=1732194891;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ytXM2Pyec8Qp9LaXAdCOR2oRjgWxjhxu7pHl5+cR+4w=;
  b=gWDJrgxg80wFyJAk7gJGbfT82zmjo81huAQZm5G/euUldKp1KN5uBeha
   Hx5Th8g/7mj3eQrPgGdbEDqz600AGAFfQIasm14Dppa9qtw2iGbmLMJ4A
   qAPq0HkdlDw7lbuJ8/aJ4DjbSHJd6ALMT4CnXcKwZ/glhgzatAoX5jUQh
   Ke2Ortwcefv6o5qLbZ1PzF2gjai1IPoN9SlF11HYhTchSl1EPR9uDxj5w
   MVV7VaSmDpkYvbPGxUjzt/CbniyKK5l8TbXUJ4QBs2dNOBhkJdwOFn+LE
   wdZDZwYYKH3nJEixOHTi5/eZf2J78CiAO+VuRy1LB9C+ygccCywXdmN7A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390908483"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="390908483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857728170"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857728170"
Received: from johannes-ivm.ger.corp.intel.com ([10.249.47.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 05:14:44 -0800
Date: Wed, 22 Nov 2023 15:14:41 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com, 
    helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org, 
    Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com, 
    robin.murphy@arm.com, chengyou@linux.alibaba.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
    linux-pci@vger.kernel.org, rdunlap@infradead.org, mark.rutland@arm.com, 
    zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 3/5] PCI: Move pci_clear_and_set_dword() helper to
 PCI header
In-Reply-To: <20231121013400.18367-4-xueshuai@linux.alibaba.com>
Message-ID: <f2a31d7f-3acc-fbe8-2684-c61f355f1036@linux.intel.com>
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com> <20231121013400.18367-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Nov 2023, Shuai Xue wrote:

> The clear and set pattern is commonly used for accessing PCI config,
> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
> In addition, rename to pci_clear_and_set_config_dword() to retain the
> "config" information and match the other accessors.
> 
> No functional change intended.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/pci/access.c    | 12 ++++++++
>  drivers/pci/pcie/aspm.c | 65 +++++++++++++++++++----------------------
>  include/linux/pci.h     |  2 ++
>  3 files changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6554a2e89d36..6449056b57dd 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> +
> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> +				    u32 clear, u32 set)

Just noting that annoyingly the ordering within the name is inconsistent 
between:
  pci_clear_and_set_config_dword()
and
  pcie_capability_clear_and_set_dword()

And if changed, it would be again annoyingly inconsistent with 
pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
into the hierarchical pci_config_read/write_*() form for would touch only 
~6k lines... ;-D

> +		pci_clear_and_set_config_dword(child,
> +					       child->l1ss + PCI_L1SS_CTL1, 0,
> +					       cl1_2_enables);

Adding clear and set only variants into the header like there are for 
pcie_capability_*() would remove the need to add those 0 parameters.
IMO, it improves code readability considerably.


-- 
 i.


