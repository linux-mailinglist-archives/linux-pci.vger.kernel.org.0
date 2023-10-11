Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCC77C5121
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJKLKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjJKLJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:09:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDB30EF;
        Wed, 11 Oct 2023 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022449; x=1728558449;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ckRPG2JUL38SKDbKOkmm+WWH+26uhzkNuPJSIGu2OfI=;
  b=lqcBP6lncMJm/+0NWtG8xJFua7MybbFIPUA7pTo1pTef664IZPekJvaz
   Mw3kb1zjuf0k3q8wuDCB1dTAUimR1X0u75C76ypx7vCsg/el/b3S7OJ21
   RorMVF0GelwpA1O1+bqPtCEDgjkJ7qLpYbmFS1cJ3OXjneiJhY+p8AWih
   9PJYdRUNCgE+VApfIIlxJx5FTpTQGFdFi3gSGRMKL2X13Fu6jWtBt214I
   VTpyRyXf6BGlyegA21Zkx7zTEFZi1yFt9/T3g92cTaMt2XgQa9j4kzmEt
   xFdsoI4h56Ex8vRicATow4CqsPiMaHZr2WOD7qTfmeHgANFMf0YmxXe71
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369698095"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369698095"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788961825"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788961825"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:07:20 -0700
Date:   Wed, 11 Oct 2023 14:07:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, 3chas3@gmail.com,
        brking@us.ibm.com, dalias@libc.org, glaubitz@physik.fu-berlin.de,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, kw@linux.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
        lpieralisi@kernel.org, martin.petersen@oracle.com,
        mattst88@gmail.com, Netdev <netdev@vger.kernel.org>,
        richard.henderson@linaro.org, toan@os.amperecomputing.com,
        ysato@users.sourceforge.jp, Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH v3 0/6] PCI/treewide: Cleanup/streamline PCI error code
 handling
In-Reply-To: <20231010223530.GA1005985@bhelgaas>
Message-ID: <667e1068-20c3-938f-2d87-fb1d6c44a45e@linux.intel.com>
References: <20231010223530.GA1005985@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1666151866-1697020845=:1977"
Content-ID: <98898f16-3a16-7cb9-26e4-d9e9776916fe@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1666151866-1697020845=:1977
Content-Type: text/plain; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <64336ba8-d7c9-4fae-879-59b88302220@linux.intel.com>

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> [+cc Tadeusz; updates to quirk_intel_qat_vf_cap()]
> 
> On Mon, Sep 11, 2023 at 03:53:48PM +0300, Ilpo Järvinen wrote:
> > As the first step towards converting PCI accessor function return codes
> > into normal errnos this series cleans up related code paths which have
> > complicated multi-line construct to handle the PCI error checking.
> > 
> > I'd prefer these (the remaining ones) to be routed through PCI tree due
> > to PCI accessor function return code conversion being built on top of
> > them.
> > 
> > v3:
> > - Return pci_generic_config_read32()'s error code directly
> > - Removed already accepted patches
> > 
> > v2:
> > - Moved ret local var to the inner block (I2C: ali15x3)
> > - Removed already accepted patches
> > 
> > 
> > Ilpo Järvinen (6):
> >   alpha: Streamline convoluted PCI error handling
> >   sh: pci: Do PCI error check on own line
> >   atm: iphase: Do PCI error checks on own line
> >   PCI: Do error check on own line to split long if conditions
> >   PCI: xgene: Do PCI error check on own line & keep return value
> >   scsi: ipr: Do PCI error checks on own line
> > 
> >  arch/alpha/kernel/sys_miata.c      | 17 +++++++++--------
> >  arch/sh/drivers/pci/common.c       |  7 ++++---
> >  drivers/atm/iphase.c               | 20 +++++++++++---------
> >  drivers/pci/controller/pci-xgene.c |  7 ++++---
> >  drivers/pci/pci.c                  |  9 ++++++---
> >  drivers/pci/probe.c                |  6 +++---
> >  drivers/pci/quirks.c               |  6 +++---
> >  drivers/scsi/ipr.c                 | 12 ++++++++----
> >  8 files changed, 48 insertions(+), 36 deletions(-)
> 
> Applied all to pci/config-errs for v6.7, thanks!
> 
> I made the tweaks below; heads-up to John Paul and Tadeusz.
> 
> Oh, and weird experience applying these via b4, git am: the
> Signed-off-by was corrupted on these patches:
> 
>   https://lore.kernel.org/r/20230911125354.25501-7-ilpo.jarvinen@linux.intel.com  https://lore.kernel.org/r/20230911125354.25501-6-ilpo.jarvinen@linux.intel.com  https://lore.kernel.org/r/20230911125354.25501-3-ilpo.jarvinen@linux.intel.com
> 
> It looked like this:
> 
>   Signed-off-by: Ilpo JÃ¤rvinen <ilpo.jarvinen@linux.intel.com>
> 
> Not sure why this happened; maybe one of the mailing lists screwed it
> up and the order of arrival determines which one b4 uses?  The ones
> from linux-alpha look like:
> 
>   Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> 
> which I think corresponds to the bad rendering.  I think I fixed them
> all.

Thanks for letting me know. It seems that copies of the same mail

https://lore.kernel.org/linux-alpha/...
https://lore.kernel.org/linux-pci/...

do indeed differ for some reason. I'll probably have to experiment to see 
if I can reproduce problem with the linux-alpha list.


-- 
 i.
--8323329-1666151866-1697020845=:1977--
