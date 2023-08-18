Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68A780727
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358589AbjHRIbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHRIbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 04:31:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5873A94;
        Fri, 18 Aug 2023 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692347460; x=1723883460;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=vipZbxRv4qljRLkY+1NySL3JI+RP0iWSLgGEc2HAtLQ=;
  b=WdZ1EM4uiLfJmX9bE2gOE5CxoWNvdblqLWkF9N+vK1h1J2toQARZxBTg
   3XXvj2OAMxtDUW8ELItuHIfQnF6ksmuINzPDoj/1ZSfZlpgJZ0Z+5+tLG
   D+PHxhCw8ftXzNQyMDwEMmf5RFYk2dZ3EHWRJhy55ZqNxX3A7rWUlILes
   mgDbFPeYrSzxN8Eviq3jbpoljNspW98MX5kSwtQnhYgVorbvuybBVUdeW
   WhfLHJCDvoYuzj3aQuhkLsSRCKcvEhlycXKIDUQEsxXg0sJ77+TZAlGd4
   aPHokIkAFTmAXmrvKuU9WFeTThaSw7Nl3oJc2RggMX+oLjO+c0aiVA4A4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375824933"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="375824933"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805070655"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805070655"
Received: from sidorovd-mobl2.ger.corp.intel.com ([10.252.53.164])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:30:56 -0700
Date:   Fri, 18 Aug 2023 11:30:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-2022-JP?Q?=1B$B2+=3E=2FGH=1B=28J?= <huangshaobo3@xiaomi.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?GB2312?B?wO6438X0?= <chenwei29@xiaomi.com>,
        =?GB2312?B?wbrOsMX0?= <weipengliang@xiaomi.com>,
        =?GB2312?B?zsy98LfJ?= <wengjinfei@xiaomi.com>,
        =?ISO-2022-JP?Q?=1B$B7'N=3C=1B=28J?= <xiongliang@xiaomi.com>
Subject: Re: Subject: [PATCH] pci/msi: remove redundant calculation in
 msi_setup_msi_desc
In-Reply-To: <3ebf5d8032ad418da4f24516cd23406e@xiaomi.com>
Message-ID: <cdbbe32-e255-8a94-5bd-412ecddf4b1d@linux.intel.com>
References: <3ebf5d8032ad418da4f24516cd23406e@xiaomi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-342068360-1692347375=:1737"
Content-ID: <166b3e19-cb1c-e786-2b19-6880a3fcdcb1@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-342068360-1692347375=:1737
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <3ea7e1d-559b-32d3-65ba-e92227f04c3e@linux.intel.com>

On Fri, 18 Aug 2023, 黄少波 wrote:

You should add () to the function name in the subject and use capital 
PCI/MSI.

> Whether to support 64-bit address status has been calculated before,
> and the calculation result can be used directly afterwards, so use
> msi_attrib.is_64 to avoid double calculation.
> 
> Suggested-by: weipengliang <weipengliang@xiaomi.com>
> Signed-off-by: sparkhuang <huangshaobo3@xiaomi.com>
> ---
>  drivers/pci/msi/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index ef1d885..304e889 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -303,7 +303,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>         desc.pci.msi_attrib.multiple    = ilog2(__roundup_pow_of_two(nvec));
>         desc.affinity                   = masks;
> 
> -       if (control & PCI_MSI_FLAGS_64BIT)
> +       if (desc.pci.msi_attrib.is_64)
>                 desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
>         else
>                 desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
> --
> 2.7.4

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-342068360-1692347375=:1737--
