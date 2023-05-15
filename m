Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6F702595
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjEOHBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjEOHBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A6B6;
        Mon, 15 May 2023 00:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71833612B4;
        Mon, 15 May 2023 07:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9242C4339B;
        Mon, 15 May 2023 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684134060;
        bh=B6gZLaOczooVV49cVdQgxVZpzjPdFzf9quJfF9D6WF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLKwlOc8aSY4mMyC+OZTSbNu1d4vsoi+MtOkqpid4XLA6AZnPPnPkBGJUAWErFvCl
         PkuoksEnXkYZe71koSsZaWk+jSAJGn2YTYeNqDuKJsC/YlAo2Ef0gz1t7VH1VD17bw
         qWDzO33PhPc/wGVMyhfBUJaChzPDES+ZmKOR818zrRrGRywsdWtRx5vkIbqdmEYpob
         W5Kl7SF2/Nugi0us+sMMptAql/seF/T0MeTsbip2ue89So3/7Ntub9hP7FFHRhish4
         Xn/vGT7LJWXG98lzb99NXb1YVt8/daMckAOwAo2+1l7/DL8puiiQ6GDQjOBtK4K/9O
         4gheg6/TuWQbw==
Date:   Mon, 15 May 2023 12:30:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Add support for MHI Endpoint function driver
Message-ID: <20230515070053.GE5143@thinkpad>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 10:16:16AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds support for Modem Host Interface (MHI) Endpoint function
> driver and few updates to the PCI endpoint core.
> 
> MHI
> ===
> 
> MHI is the communication protocol used by the host machines to control and
> communicate with the Qualcomm modems/WLAN devices over any high speed physical
> bus like PCIe. In Linux kernel, MHI is modeled as a bus driver [1] and there
> are two instances of MHI used in a typical setup.
> 
> 1. MHI host - MHI implementation for the host machines like x86/ARM64.
> 2. MHI Endpoint - MHI implementation for the endpoint devices like modems.
> 
> MHI EPF
> =======
> 
> The MHI Endpoint function driver (MHI EPF) is used on the MHI endpoint devices
> like modems. The MHI EPF driver sits in between the PCIe EP and MHI EP bus and
> carries out all of the PCIe related activities like BAR config, PCIe Event
> handling, MMIO read/write etc,... for the MHI EP bus.
> 
> Below is the simple representation of the setup:
> 
> 
>                  +----------------------------------------------------+
>                  |                  Endpoint CPU                      |                   
>                  |                                                    |
> +------------+   |   +------------+   +-----------+   +-----------+   |
> |            |   |   |            |   |           |   |           |   |
> |            |   |   |   MHI EP   |   |           |   |           |   | PCIe Bus
> |  Modem DSP +---+---+    Bus     +---+  MHI EPF  +---+  PCIe EP  +---+---------
> |            |   |   |            |   |           |   |           |   |
> |            |   |   |            |   |           |   |           |   |
> +------------+   |   +------------+   +-----------+   +-----------+   |
>                  |                                                    |
>                  |                                                    |
>                  +----------------------------------------------------+
> 
> The data packets will be read from the Modem DSP by the MHI stack and will be
> transmitted to the host machine over PCIe bus with the help of MHI EPF driver.
> 
> Test setup
> ==========
> 
> This series has been tested on Snapdragon X55 modem a.k.a SDX55 connected to
> the ARM64 host machine.
> 

Lorenzo, gentle ping on this series.

- Mani

> Thanks,
> Mani
> 
> [1] https://www.kernel.org/doc/html/latest/mhi/mhi.html
> 
> Changes in v3:
> 
> * Fixed the probe function of EPF_VNTB driver
> 
> Changes in v2:
> 
> * Rebased on top of v6.3-rc1
> * Switched to the new callback interface for passing events from EPC to EPF
> * Dropped one patch related to notifier
> 
> Manivannan Sadhasivam (7):
>   PCI: endpoint: Pass EPF device ID to the probe function
>   PCI: endpoint: Warn and return if EPC is started/stopped multiple
>     times
>   PCI: endpoint: Add linkdown notifier support
>   PCI: endpoint: Add BME notifier support
>   PCI: qcom-ep: Add support for Link down notification
>   PCI: qcom-ep: Add support for BME notification
>   PCI: endpoint: Add PCI Endpoint function driver for MHI bus
> 
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +
>  drivers/pci/endpoint/functions/Kconfig        |  10 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 454 ++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |   3 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |   3 +
>  drivers/pci/endpoint/pci-epc-core.c           |  52 ++
>  drivers/pci/endpoint/pci-epf-core.c           |   8 +-
>  include/linux/pci-epc.h                       |   2 +
>  include/linux/pci-epf.h                       |   8 +-
>  12 files changed, 540 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
