Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D097146BF
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjE2I6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjE2I62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 04:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC559D8;
        Mon, 29 May 2023 01:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E671E61300;
        Mon, 29 May 2023 08:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0BFC433EF;
        Mon, 29 May 2023 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685350703;
        bh=wR2hupE+ysuek8cAwPxALkAEl2LcA5S8vkp6/pMNfbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxzRJX6kbyd0LFx1UtdFrkskKWVhvGRaGHacPuAogkNsvqIl0K40BDMwLdxsdJ9Wf
         rePsw9TWtT7IummX1dnElFUHaHtWNirpCYePb6QdjtlFUNa0tmu38ilFgl82DYtx2X
         e9zi0v2fVu8sGhzmss9zWUqANO+CiXLCKL2O338DO5Ld/sBDq6GhlEcZ71WKF6lICW
         uebi14y5gKMPVfljbMmW3PBU96hn3R9MD7Sb4Z8wLw4097QsaO+6sZfPI90Qul6QQV
         c4ObkMf00MMh6ZCdTusYxgskHxjZ/5BuHSre5dJQOrZTRKP9rbrGw6gJdmNXaR9kti
         bEhDxW2H8xzIg==
Date:   Mon, 29 May 2023 14:28:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, bhelgaas@google.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 0/8] PCI: qcom: Do not advertise hotplug capability
Message-ID: <20230529085810.GD5633@thinkpad>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
 <ZGsvXbiWK383zoaQ@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGsvXbiWK383zoaQ@lpieralisi>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 11:01:17AM +0200, Lorenzo Pieralisi wrote:
> On Fri, May 19, 2023 at 08:01:09PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > The SoCs making use of Qualcomm PCIe controllers do not support the PCIe hotplug
> > functionality. But the hotplug capability bit is set by default in the hardware.
> > This causes the kernel PCI core to register hotplug service for the controller
> > and send hotplug commands to it. But those commands will timeout generating
> > messages as below during boot and suspend/resume.
> >     
> > [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> > [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> > [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> > [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> >     
> > This not only spams the console output but also induces a delay of a couple of
> > seconds. To fix this issue, this series clears the HPC bit in PCI_EXP_SLTCAP
> > register as a part of the post init sequence for all IP versions to not
> > advertise the hotplug capability for the controller.
> > 
> > Testing
> > =======
> > 
> > This series has been tested on DB845c (SDM845 SoC) and Lenovo Thinkpad X13s
> > (SC8280XP SoC).
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v2:
> > 
> > * Collected tags
> > * Moved the HPC clearing to a separate function and reused across different
> >   configs
> > 
> > Manivannan Sadhasivam (8):
> >   PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
> >   PCI: qcom: Disable write access to read only registers for IP v2.9.0
> >   PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and
> >     v1.9.0
> >   PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and
> >     v2.9.0
> >   PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
> >   PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
> >   PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
> >   PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 73 ++++++++++++++------------
> >  1 file changed, 38 insertions(+), 35 deletions(-)
> > 
> 
> Some patches are signed-off twice, FYI, I can fix that while
> applying.
> 

Sorry for that! I used b4 to apply these patches and that added additional
signed-off-by tag for all patches. Since Dmitry also requested to remove his
gmail tag, I can spin another version once we sort out the comment on patch
2/8.

- Mani

> Lorenzo
> 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
