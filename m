Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0174B369
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjGGO5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGO5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 10:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E02108;
        Fri,  7 Jul 2023 07:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4BF618E5;
        Fri,  7 Jul 2023 14:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3741C433C8;
        Fri,  7 Jul 2023 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688741826;
        bh=yeNvbti/TUF1YMHu4YqtkoMPEnaprwjXfYPh/fxnHI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NwKc2++oblIOWW2LODeugXzaADYwiuZQyWP7UO/CK+APHEhdELFMnIiVqb0guxrso
         5aQNy9+Vr+I3wQ4L6jLkFGj0mVezOyVD6TRN9Kqu+AHPy7uFtMUfTbfPXOb40ABMEL
         JXz8EF43WVsCVKfjj/jLRNxadwtdfuVlKT1NXCINWG/CfoliR4gPdj4Qh6YKXGKGRk
         r8lwYvRHSex9ZyMvQdBSDmIFcXBg1sKoye1oArWHHAOfRjiAr3J3AIUUWqLXpqBkhA
         0twL0G/bS1wnfK4ayUcsa657doHbWq0XYmA7wX1D7wI7h9li97C4vPlQoeeZCFWvDc
         KcaDfzpH7BK/Q==
Date:   Fri, 7 Jul 2023 09:57:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v3 0/9] PCI: EPC: Add support to wake up host from D3
 states
Message-ID: <20230707145703.GA139553@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688727836-11141-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 07, 2023 at 04:33:47PM +0530, Krishna chaitanya chundru wrote:
> Here we propose this patch series to add support in PCI endpoint
> driver to wake up host from D3 states.
> 
> As endpoint cannot send any data/MSI when the D-state is in
> D3cold or D3hot. Endpoint needs to bring the device back to D0
> to send any kind of data.
> 
> For this endpoint needs to send inband PME the device is in D3 state or
> toggle wake when the device is D3 cold and vaux is not supplied.
> 
> As EPF doestn't know the D-state of the PCI, added a notify op whenever
> device state changes.
> 
> Based on the D-state the EPF driver decides to wake host either by
> toggling wake or by sending PME.
> 
> When the MHI state is in M3 MHI driver will wakeup the host using the
> wakeup op.
> 
> Changes from v2:
> 	- Addressed review comments made by mani.
> Changes from v1:
>         - Moved from RFC patch to regular patch
>         - Inclueded EPF patch and added a new op patch to notify D-state change
> 
> *** BLURB HERE ***
> 
> Krishna chaitanya chundru (9):
>   PCI: endpoint: Add dstate change notifier support

"D-state" to match the other patches.

>   PCI: qcom-ep: Add support for D-state change notification
>   PCI: qcom-ep: Update the D-state log
>   PCI: epf-mhi: Add support for handling D-state notify from EPC
>   PCI: endpoint: Add wakeup host API to EPC core
>   pci: dwc: Add wakeup host op to pci_epc_ops

"PCI:" to match the rest.

>   PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
>   PCI: epf-mhi: Add wakeup host op
>   bus: mhi: ep: wake up host is the MHI state is in M3

"Wake up host ..." to match previous history of the file.

"*if* MHI state is M3"?  (Not "is the ...")

>  Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
>  drivers/bus/mhi/ep/main.c                       | 28 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
>  drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c       | 36 ++++++++++++++-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c    | 28 ++++++++++++
>  drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
>  include/linux/mhi_ep.h                          |  4 ++
>  include/linux/pci-epc.h                         | 12 +++++
>  include/linux/pci-epf.h                         |  1 +
>  10 files changed, 192 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 
