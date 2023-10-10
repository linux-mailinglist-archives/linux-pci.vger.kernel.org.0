Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BD7C4436
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJJWfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjJJWfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 18:35:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC568F;
        Tue, 10 Oct 2023 15:35:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5256CC433C8;
        Tue, 10 Oct 2023 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696977332;
        bh=ssq0zxln5LGIGMEn14IniQ5liilnaehkBxG//1dVx6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sqIUgpWHd7XBjB1O2AqFtnyDdA5pJd4VE+4oolqSLLoTlefiP3YHE+dikhcDtJO89
         O4slDCwY6wOXHB75bgZR3J1syc4U2WGbfwWAU0sdY+7b7FsQ3KLWNQMChGyUYjRPm+
         v5JtaKNlV/36V/Mr6EnXMoniAdQ2MOCETzLGF1I1ZDmplZx6zbEqoW3l9+u0PW+2dA
         S+pvBlNx+Crz0kwQwxCSbH6mNn6jZKQzyE/cAM8iFlezlf5FFfjUv8d0tvm0XlzG6y
         28ZJFKzYSj963s1mGgJvVw3/FgVLlQWJHh6eo4VCbFF2KQLde/aZYDQnLiTJ8/d4a3
         OEQNOyQSatyzQ==
Date:   Tue, 10 Oct 2023 17:35:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, 3chas3@gmail.com, brking@us.ibm.com,
        dalias@libc.org, glaubitz@physik.fu-berlin.de,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, kw@linux.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
        lpieralisi@kernel.org, martin.petersen@oracle.com,
        mattst88@gmail.com, netdev@vger.kernel.org,
        richard.henderson@linaro.org, toan@os.amperecomputing.com,
        ysato@users.sourceforge.jp, Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH v3 0/6] PCI/treewide: Cleanup/streamline PCI error code
 handling
Message-ID: <20231010223530.GA1005985@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Tadeusz; updates to quirk_intel_qat_vf_cap()]

On Mon, Sep 11, 2023 at 03:53:48PM +0300, Ilpo Järvinen wrote:
> As the first step towards converting PCI accessor function return codes
> into normal errnos this series cleans up related code paths which have
> complicated multi-line construct to handle the PCI error checking.
> 
> I'd prefer these (the remaining ones) to be routed through PCI tree due
> to PCI accessor function return code conversion being built on top of
> them.
> 
> v3:
> - Return pci_generic_config_read32()'s error code directly
> - Removed already accepted patches
> 
> v2:
> - Moved ret local var to the inner block (I2C: ali15x3)
> - Removed already accepted patches
> 
> 
> Ilpo Järvinen (6):
>   alpha: Streamline convoluted PCI error handling
>   sh: pci: Do PCI error check on own line
>   atm: iphase: Do PCI error checks on own line
>   PCI: Do error check on own line to split long if conditions
>   PCI: xgene: Do PCI error check on own line & keep return value
>   scsi: ipr: Do PCI error checks on own line
> 
>  arch/alpha/kernel/sys_miata.c      | 17 +++++++++--------
>  arch/sh/drivers/pci/common.c       |  7 ++++---
>  drivers/atm/iphase.c               | 20 +++++++++++---------
>  drivers/pci/controller/pci-xgene.c |  7 ++++---
>  drivers/pci/pci.c                  |  9 ++++++---
>  drivers/pci/probe.c                |  6 +++---
>  drivers/pci/quirks.c               |  6 +++---
>  drivers/scsi/ipr.c                 | 12 ++++++++----
>  8 files changed, 48 insertions(+), 36 deletions(-)

Applied all to pci/config-errs for v6.7, thanks!

I made the tweaks below; heads-up to John Paul and Tadeusz.

Oh, and weird experience applying these via b4, git am: the
Signed-off-by was corrupted on these patches:

  https://lore.kernel.org/r/20230911125354.25501-7-ilpo.jarvinen@linux.intel.com  https://lore.kernel.org/r/20230911125354.25501-6-ilpo.jarvinen@linux.intel.com  https://lore.kernel.org/r/20230911125354.25501-3-ilpo.jarvinen@linux.intel.com

It looked like this:

  Signed-off-by: Ilpo JÃ¤rvinen <ilpo.jarvinen@linux.intel.com>

Not sure why this happened; maybe one of the mailing lists screwed it
up and the order of arrival determines which one b4 uses?  The ones
from linux-alpha look like:

  Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

which I think corresponds to the bad rendering.  I think I fixed them
all.

Bjorn

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index f59e5b9a6a80..ab9e791070b4 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -50,7 +50,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 				int top_bus, int current_bus)
 {
 	u32 pci_devfn;
-	unsigned short vid;
+	u16 vid;
 	int cap66 = -1;
 	u16 stat;
 	int ret;
@@ -64,7 +64,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 					     pci_devfn, PCI_VENDOR_ID, &vid);
 		if (ret != PCIBIOS_SUCCESSFUL)
 			continue;
-		if (vid == 0xffff)
+		if (PCI_POSSIBLE_ERROR(vid))
 			continue;
 
 		/* check 66MHz capability */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 81f3da536a3c..f5fc92441194 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5430,7 +5430,7 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 
 		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
 		ret = pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status);
-		if ((ret != PCIBIOS_SUCCESSFUL) || (status == 0xffffffff))
+		if ((ret != PCIBIOS_SUCCESSFUL) || (PCI_POSSIBLE_ERROR(status)))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
 
 		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
