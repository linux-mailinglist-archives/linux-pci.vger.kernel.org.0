Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD0529177
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbiEPUcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiEPUcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:32:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A431FA78;
        Mon, 16 May 2022 13:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F573CE1799;
        Mon, 16 May 2022 20:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE4C385AA;
        Mon, 16 May 2022 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652732147;
        bh=zUURAcddULKH97MeOKJwmTGU6utdU5/s7G9WrHiCTFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r9VTZLEOTfzAv7DGyZZZMdbM3HengP/kdytlM1Z3v4rr2rs5wT/+XXfWaONGuKAdk
         0Hkh+N+O3k81ITyO7C4CymO3qPbpFEH17ORbu9j/y1igx2xC7NhnLk7bot43sK5Py4
         aWfuWEW+uYhS6dYE01EC4d4QjlvHJB0T0HjA84jOTeu68oFevqwJ0K9EhzmMQGKYhk
         aYTqdMsAkD3i+VMZKcftkuPVmWFYAm6HzY6TqiTq7G9/REy9Z4bRzJEPi3YQadnBBf
         vmZ/5W3hJzj5otJ63XqXYWXL9JgYQ2xIScbJpKez9ly9Yo713dmniTjdYrv+wG8Qz9
         7bkb2WzqE49yw==
Date:   Mon, 16 May 2022 15:15:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during
 suspend
Message-ID: <20220516201545.GA1046888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm, since this is power management stuff
https://lore.kernel.org/all/20220513110027.31015-1-manivannan.sadhasivam@linaro.org/]

On Fri, May 13, 2022 at 04:30:24PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series adds support for notifying the PCI drivers like NVMe about the
> transition of PCI devices into powerdown mode during system suspend.
> 
> Background
> ----------
> 
> On Qcom SC7280 based Chrome platforms, the OS will turn off the power to all
> PCIe devices during system suspend for aggressive powersaving. Currently, there
> is no way for the PCI device drivers to learn about this situation. Some of the
> drivers assume that the power will be retained and some others assume that the
> power may be taken down.
> 
> We faced the issue with NVMe PCI driver, where the driver expects the NVMe
> device to be in APST (Autonomous Power State Transition) state for power saving
> during system suspend. So when the power goes down, the NVMe driver fails to
> bringup the device during resume.
> 
> Previous work
> -------------
> 
> We tried to fix this issue in a couple of ways:
> 
> 1. The NVMe PCI driver checks for the existence of "StorageD3Enable" ACPI
> property in the suspend path. If the property is found, the driver assumes that
> the device may go to poweroff state and shutdowns the device accordingly.
> 
> As like the ACPI based systems, we also tried to get the support in place for
> DT based systems. But that didn't get accepted:
> https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/
> 
> 2. Keith Busch proposed a module params based approach. The parameter when set,
> will allow the driver to support APST during suspend. Absence of that parameter
> will let the driver shutdown the device.
> 
> This also did not get accepted:
> https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/
> 
> Proposal
> --------
> 
> Christoph suggested to add a notification in the PCI/PM core to let the NVMe
> driver know that the device will go into powerdown state during suspend.
> https://lore.kernel.org/all/Yg0wklcJ3ed76Jbk@infradead.org/ 
> 
> Hence in this series, a "suspend_poweroff" flag is introduced in the host bridge
> struct. When this flag is set by the PCI RC drivers, the PCI device driver like
> NVMe can shutdown the device during suspend.
> 
> In the coming days, the usage of this flag could be extended to other PCI
> drivers as well.
> 
> Testing
> -------
> 
> This series has been tested on SC7280 IDP board connected to a NVMe PCI device.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (3):
>   PCI: Add a flag to notify PCI drivers about powerdown during suspend
>   PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
>   nvme-pci: Make use of "suspend_poweroff" flag during system suspend
> 
>  drivers/nvme/host/pci.c                | 3 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  include/linux/pci.h                    | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.1
> 
