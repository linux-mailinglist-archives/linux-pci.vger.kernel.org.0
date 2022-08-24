Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42F5A02BB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiHXUaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiHXU35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 16:29:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE3B4B4;
        Wed, 24 Aug 2022 13:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09125B826A7;
        Wed, 24 Aug 2022 20:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAD1C433D6;
        Wed, 24 Aug 2022 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661372991;
        bh=dqhGz/nLmt6yUPkMB5rA5qXpiQ+1w7dwGL2hqByBBRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CpSScSEG6uPmSMHRKF5GulWRgs49MlGGCa/mmee7+PVobFiXEEjj4s7NNsjL7lbyk
         sEL/ZYKh9RndBrk8yJQPBgbwjbl3t/FxGq99v0LWW1+M1BIw9A2GwHbuR1kYNFeCv3
         7LNxCL4lRDjNIQtnNuiyQZoKfVF2EEfsSBJXP6w88OT8OAjB6zeDlFRz5auauDO94f
         0H1KudDibhtwJJle3OaUhrgiDyEKeSIfPH5vjCHjWFvaSIuGCpiDOKe58WWAeEaDjo
         uffmTJp21NhSVL5j69Tz+aWReWv4wBODbf+VA9WIjMVQjA3yq1OGqOp0tvGWSATDAS
         qs62ngq64V1oQ==
Date:   Wed, 24 Aug 2022 15:29:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v5 0/3] PCI: Restrict pci transactions after pci suspend
Message-ID: <20220824202949.GA2805069@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 03, 2022 at 04:58:51PM +0530, Krishna chaitanya chundru wrote:
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts in system suspend path by writing in to
> the vector table (for MSIX interrupts) and config space (for MSI's).

If clocks are being turned off while the PCI core is still accessing
the device, I think that means qcom suspend is not implemented
correctly.

> These transactions are initiated in the pm suspend after pcie clocks got
> disabled as part of platform driver pm  suspend call. Due to it, these
> transactions are resulting in un-clocked access and eventually to crashes.
> 
> So added a logic in qcom driver to restrict these unclocked access.
> And updated the logic to check the link state before masking
> or unmasking the interrupts.
> 
> And some devices are taking time to settle the link in L1ss, so added a
> retry logic in the suspend ops.
> 
> Krishna chaitanya chundru (3):
>   PCI: qcom: Add system PM support
>   PCI: qcom: Restrict pci transactions after pci suspend
>   PCI: qcom: Add retry logic for link to be stable in L1ss
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c            | 117 +++++++++++++++++++++-
>  2 files changed, 127 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
