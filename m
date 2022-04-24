Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9A50D59E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiDXWSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 18:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXWSg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 18:18:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570E644F1
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 15:15:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so13190939pfm.5
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a94ygyO51sV1vySNBgzFK1fAmeNRwkA40gE431DNjw0=;
        b=qCnGnBRIvOsy3+kYvqTJIWtB5AGeFFiyAB41IHuR0+F7NTytPaH0U1xbjI0A8Ylagu
         UoiXr5Wllahjoy4iUFJ8yKQMEsjWh6bJS/caztgTOz3JWCo8n1Xgsk+eV4LzelEDLwnJ
         zG7XApy80RYgeTZh8PyxWpx+R3wQW7oYkL7jc6bdFqAjbvxt8HlJ406di1/nFAvGLBGP
         qj8lkeqaokvfXWTznRm/cK1eco0vgroO4o+f9bsp2NVsBIjnok7nSE3dCxMCDTbXxkl4
         HhJWsbaBGxz2rPnDheLASc1X9uAfjz6jWPSob+tJmyrmTCyTnwOcxVWYLrmXTV3Hr1j5
         QaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a94ygyO51sV1vySNBgzFK1fAmeNRwkA40gE431DNjw0=;
        b=qeAGNOWNspLS2KFCeaUbwF19unLYoWRvJOZVzs+lexbwBTO/Ln+5y8clvqsw8YWYv0
         qiSQ/JqxdNHwgOrIPHy4dB0698ObL9V/2VJy0z/rfgg5Mg55P5PabOxpv9RzRFHAhvkD
         l6eijlImRQQ4pSi3NQZ10q7NnABvh6WwgwZVuQQRp8e18CQywfaOPk7tJe+8uXSA0zjw
         ypfTR/dkiJdoCh/uIwiJ8wEbUONvx1Ro6KxWmCCH1FzGLXvc7beGd0Sx2nI5rKkjOv2C
         oRV0zTo/UVfAmSlwDu8s0pYSCVST1OQq3Aru2Q/PSs8Lrlr30W9EyZ60yoPklUmy5HWv
         onGA==
X-Gm-Message-State: AOAM533UJaVhF5TcpBDaBzas56aahPlGMEXu06lrTb/4eQhvhWBHjJ0M
        hDK/L2QUpa3UY98w+tulo+AD2lRVS3j+y/Xy1UbrSQ==
X-Google-Smtp-Source: ABdhPJzV6moQD8qbpX8+5uEd53juTovRQ747gv7hTJDyB4u4ZUygoiLmPGd+WCvoFOwIi97ILxMqtCnNrEHgw+fCgA8=
X-Received: by 2002:a05:6a00:8c5:b0:4fe:134d:30d3 with SMTP id
 s5-20020a056a0008c500b004fe134d30d3mr15819477pfu.3.1650838534294; Sun, 24 Apr
 2022 15:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740406489.3912056.8334546166826246693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e9de480061ad425e9603cf71db5c610d@huawei.com>
In-Reply-To: <e9de480061ad425e9603cf71db5c610d@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 24 Apr 2022 15:15:23 -0700
Message-ID: <CAPcyv4i5vseE1+bDYYa33AcHs6r=b380hUKC5u_=NEpX8bR1SA@mail.gmail.com>
Subject: Re: [PATCH 8/8] cxl/pci: Add (hopeful) error handling support
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 18, 2022 at 2:42 AM Shiju Jose <shiju.jose@huawei.com> wrote:
>
> Hi Dan,

Hi, thanks for taking a look at this.

>
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: 16 March 2022 04:14
> >To: linux-cxl@vger.kernel.org
> >Cc: ben.widawsky@intel.com; vishal.l.verma@intel.com;
> >alison.schofield@intel.com; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; ira.weiny@intel.com; linux-
> >pci@vger.kernel.org
> >Subject: [PATCH 8/8] cxl/pci: Add (hopeful) error handling support
> >
> >Add nominal error handling that tears down CXL.mem in response to error
> >notifications that imply a device reset. Given some CXL.mem may be
> >operating as System RAM, there is a high likelihood that these error events
> >are fatal. However, if the system survives the notification the expectation is
> >that the driver behavior is equivalent to a hot-unplug and re-plug of an
> >endpoint.
> >
> >Note that this does not change the mask values from the default. That awaits
> >CXL _OSC support to determine whether platform firmware is in control of the
> >mask registers.
> >
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > drivers/cxl/core/memdev.c |    1
> > drivers/cxl/cxlmem.h      |    2 +
> > drivers/cxl/pci.c         |  109
> >+++++++++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 112 insertions(+)
> >
> >diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c index
> >1f76b28f9826..223d512790e1 100644
> >--- a/drivers/cxl/core/memdev.c
> >+++ b/drivers/cxl/core/memdev.c
> >@@ -341,6 +341,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct
> >cxl_dev_state *cxlds)
> >        * needed as this is ordered with cdev_add() publishing the device.
> >        */
> >       cxlmd->cxlds = cxlds;
> >+      cxlds->cxlmd = cxlmd;
> >
> >       cdev = &cxlmd->cdev;
> >       rc = cdev_device_add(cdev, dev);
> >diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
> >5d33ce24fe09..f58e16951414 100644
> >--- a/drivers/cxl/cxlmem.h
> >+++ b/drivers/cxl/cxlmem.h
> >@@ -117,6 +117,7 @@ struct cxl_endpoint_dvsec_info {
> >  * Currently only memory devices are represented.
> >  *
> >  * @dev: The device associated with this CXL state
> >+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
> >  * @regs: Parsed register blocks
> >  * @cxl_dvsec: Offset to the PCIe device DVSEC
> >  * @payload_size: Size of space for payload @@ -148,6 +149,7 @@ struct
> >cxl_endpoint_dvsec_info {
> >  */
> > struct cxl_dev_state {
> >       struct device *dev;
> >+      struct cxl_memdev *cxlmd;
> >
> >       struct cxl_regs regs;
> >       int cxl_dvsec;
> >diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> >bde8929450f0..823cbfa093fa 100644
> >--- a/drivers/cxl/pci.c
> >+++ b/drivers/cxl/pci.c
> >@@ -8,6 +8,7 @@
> > #include <linux/mutex.h>
> > #include <linux/list.h>
> > #include <linux/pci.h>
> >+#include <linux/aer.h>
> > #include <linux/io.h>
> > #include "cxlmem.h"
> > #include "cxlpci.h"
> >@@ -533,6 +534,11 @@ static void cxl_dvsec_ranges(struct cxl_dev_state
> >*cxlds)
> >       info->ranges = __cxl_dvsec_ranges(cxlds, info);  }
> >
> >+static void disable_aer(void *pdev)
> >+{
> >+      pci_disable_pcie_error_reporting(pdev);
> >+}
> >+
> > static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >{
> >       struct cxl_register_map map;
> >@@ -554,6 +560,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const
> >struct pci_device_id *id)
> >       cxlds = cxl_dev_state_create(&pdev->dev);
> >       if (IS_ERR(cxlds))
> >               return PTR_ERR(cxlds);
> >+      pci_set_drvdata(pdev, cxlds);
> >
> >       cxlds->serial = pci_get_dsn(pdev);
> >       cxlds->cxl_dvsec = pci_find_dvsec_capability( @@ -610,6 +617,14 @@
> >static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       if (IS_ERR(cxlmd))
> >               return PTR_ERR(cxlmd);
> >
> >+      if (cxlds->regs.ras) {
> >+              pci_enable_pcie_error_reporting(pdev);
> >+              rc = devm_add_action_or_reset(&pdev->dev, disable_aer,
> >pdev);
> >+              if (rc)
> >+                      return rc;
> >+      }
> >+      pci_save_state(pdev);
> >+
> >       if (range_len(&cxlds->pmem_range) &&
> >IS_ENABLED(CONFIG_CXL_PMEM))
> >               rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> >
> >@@ -623,10 +638,104 @@ static const struct pci_device_id cxl_mem_pci_tbl[]
> >= {  };  MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> >
> >+/*
> >+ * Log the state of the RAS status registers and prepare them to log
> >+the
> >+ * next error status.
> >+ */
> >+static void cxl_report_and_clear(struct cxl_dev_state *cxlds) {
> >+      struct cxl_memdev *cxlmd = cxlds->cxlmd;
> >+      struct device *dev = &cxlmd->dev;
> >+      void __iomem *addr;
> >+      u32 status;
> >+
> >+      if (!cxlds->regs.ras)
> >+              return;
> In the cxl_error_detected () may need to return PCI_ERS_RESULT_NONE
> for the following cases, if exist,
> 1. if (!cxlds->regs.ras),

Yes, but given that the RAS capability is mandatory for CXL devices
then I think the driver should just fail to register altogether if the
RAS register are not found / mapped.

> 2. if any errors would be reported during the dev initialization.

This can't happen. The err_handler callback process takes the
device_lock() which ensures that any initialization that has started
completes before the callback is invoked.

>
> >+
> >+      addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> >+      status = readl(addr);
> >+      if (status & CXL_RAS_UNCORRECTABLE_STATUS_MASK) {
> >+              dev_warn(cxlds->dev, "%s: uncorrectable status: %#08x\n",
> >+                       dev_name(dev), status);
> >+              writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK,
> >addr);
> >+      }
> For the uncorrectable non-fatal errors, if any, may need to return PCI_ERS_RESULT_NEED_RESET
> to trigger the slot reset to prevent more serious issues later. For this case the state would be
> "pci_channel_io_normal".
>

Ah true, some pci_channel_io_normal recovery conditions still result
in reset, will fix.

> >+
> >+      addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> >+      status = readl(addr);
> >+      if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> >+              dev_warn(cxlds->dev, "%s: correctable status: %#08x\n",
> >+                       dev_name(dev), status);
> >+              writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK,
> >addr);
> >+      }
> >+}
> >+
> >+static pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> >+                                         pci_channel_state_t state)
> >+{
> >+      struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> >+      struct cxl_memdev *cxlmd = cxlds->cxlmd;
> >+      struct device *dev = &cxlmd->dev;
> >+
> >+      /*
> >+       * A frozen channel indicates an impending reset which is fatal to
> >+       * CXL.mem operation, and will likely crash the system. On the off
> >+       * chance the situation is recoverable dump the status of the RAS
> >+       * capability registers and bounce the active state of the memdev.
> >+       */
> >+      cxl_report_and_clear(cxlds);
> >+
> >+      switch (state) {
> >+      case pci_channel_io_normal:
> >+              return PCI_ERS_RESULT_CAN_RECOVER;
> >+      case pci_channel_io_frozen:
> >+              dev_warn(&pdev->dev,
> >+                       "%s: frozen state error detected, disable
> >CXL.mem\n",
> >+                       dev_name(dev));
> >+              device_release_driver(dev);
> >+              return PCI_ERS_RESULT_NEED_RESET;
> >+      case pci_channel_io_perm_failure:
> >+              dev_warn(&pdev->dev,
> >+                       "failure state error detected, request disconnect\n");
> >+              return PCI_ERS_RESULT_DISCONNECT;
> >+      }
> >+      return PCI_ERS_RESULT_NEED_RESET;
> >+}
> >+
> >+static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev) {
> >+      struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> >+      struct cxl_memdev *cxlmd = cxlds->cxlmd;
> >+      struct device *dev = &cxlmd->dev;
> >+
> >+      dev_info(&pdev->dev, "%s: restart CXL.mem after slot reset\n",
> >+               dev_name(dev));
> >+      pci_restore_state(pdev);
> 1. Do we need to call pci_save_state(pdev) here after the reset? though pci_save_state(pdev) is being invoked in the
> cxl_pci_probe().

The save state after probe is sufficient, it does not need to be
snapshotted again as far as I can see.

>
> >+      if (device_attach(dev) <= 0)
> >+              return PCI_ERS_RESULT_DISCONNECT;
> My understanding is that pci_disable_pcie_error_reporting(pdev) would be called
> in the disable_aer () in the reset,
> pci_enable_pcie_error_reporting(pdev) may need to call here after the reset?

After the device is disconnected the driver needs to be reloaded to
recover AER operation.

>
> >+      return PCI_ERS_RESULT_RECOVERED;
> >+}
> >+
> >+static void cxl_error_resume(struct pci_dev *pdev) {
> >+      struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> >+      struct cxl_memdev *cxlmd = cxlds->cxlmd;
> >+      struct device *dev = &cxlmd->dev;
> >+
> >+      dev_info(&pdev->dev, "%s: error resume %s\n", dev_name(dev),
> >+               dev->driver ? "successful" : "failed"); }
> >+
> >+static const struct pci_error_handlers cxl_error_handlers = {
> >+      .error_detected = cxl_error_detected,
> >+      .slot_reset     = cxl_slot_reset,
> >+      .resume         = cxl_error_resume,
> If the FLR (Function level reset) supported, please add the corresponding callback functions
> reset_prepare(..) and reset_done(..).

No, FLR does not recover any of the errors reported via AER.

>
> >+};
> >+
> > static struct pci_driver cxl_pci_driver = {
> >       .name                   = KBUILD_MODNAME,
> >       .id_table               = cxl_mem_pci_tbl,
> >       .probe                  = cxl_pci_probe,
> >+      .err_handler            = &cxl_error_handlers,
> >       .driver = {
> >               .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
> >       },
>
>
> Thanks,
> Shiju
