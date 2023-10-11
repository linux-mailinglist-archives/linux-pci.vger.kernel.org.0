Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5512F7C5753
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjJKOuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjJKOuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 10:50:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A094;
        Wed, 11 Oct 2023 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697035806; x=1728571806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MtsQbyKwcjRJIzA/Fgz2m2QCnrrr+NVDrlseLOUGxUI=;
  b=RQkotTUgWgdNdb7xLrxYd5jQkZgnUoykrXIGXnWBNFc023vKS64mbDOd
   G9a7PVaPbbcI6b23MpoZDixnFezmMQTFHNCAXj+NIVjd+cm4M+nhPzi9k
   q4bFTO1v/nr59ORJaVqvtLKlDyb9BpkZ++LgEYesQVlvBY45xgAOgCtY8
   kKqx5IMFT/PxPs3T3l2w+kGXgdFhUZ7g2+2MqU0TeT8GIO+inD4KHzPmJ
   rLj3vssf7UOCOSAXyRN4iLjl0iugMBiPfk/Bk0xqCfy6ono+UYJmV+FL2
   ZIgQX5BCutRKQJozm3fzPooRt0D3wdzsqTafyyII866l/UZMNKuesHJ+c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="6245382"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="6245382"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783259405"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="783259405"
Received: from gears-pc1.amr.corp.intel.com (HELO [10.251.3.56]) ([10.251.3.56])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:50:05 -0700
Message-ID: <078c247a-ce72-49d4-88a5-b22e814843dd@linux.intel.com>
Date:   Wed, 11 Oct 2023 07:50:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] PCI: Use FIELD_GET() and FIELD_PREP()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231010204436.1000644-1-helgaas@kernel.org>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/10/2023 1:44 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() and FIELD_PREP() to avoid the need for shifting.
> 
> These apply on top of the PCI patches from Ilpo's series:
>   https://lore.kernel.org/r/20230919125648.1920-1-ilpo.jarvinen@linux.intel.com
> 

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Bjorn Helgaas (10):
>   PCI: Use FIELD_GET()
>   PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
>   PCI/ASPM: Use FIELD_GET()
>   PCI/ATS: Show PASID Capability register width in bitmasks
>   PCI/ATS: Use FIELD_GET()
>   PCI/DPC: Use FIELD_GET()
>   PCI/PME: Use FIELD_GET()
>   PCI/PTM: Use FIELD_GET()
>   PCI/VC: Use FIELD_GET()
>   PCI/portdrv: Use FIELD_GET()
> 
>  drivers/pci/ats.c             |  7 ++---
>  drivers/pci/pci.c             | 53 +++++++++++++++++------------------
>  drivers/pci/pcie/aspm.c       | 31 +++++++++++---------
>  drivers/pci/pcie/dpc.c        |  9 +++---
>  drivers/pci/pcie/pme.c        |  4 ++-
>  drivers/pci/pcie/portdrv.c    |  7 +++--
>  drivers/pci/pcie/ptm.c        |  5 ++--
>  drivers/pci/probe.c           |  8 +++---
>  drivers/pci/quirks.c          |  2 +-
>  drivers/pci/vc.c              |  9 +++---
>  include/uapi/linux/pci_regs.h | 15 ++++++----
>  11 files changed, 81 insertions(+), 69 deletions(-)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
