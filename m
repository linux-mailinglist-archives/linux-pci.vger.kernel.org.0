Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF276633A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 06:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjG1Ehs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 00:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjG1Ehr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 00:37:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0540926A8;
        Thu, 27 Jul 2023 21:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9703661FCB;
        Fri, 28 Jul 2023 04:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271AFC433C8;
        Fri, 28 Jul 2023 04:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690519054;
        bh=Wrr+fi81lXTM8ix9R0HRE/B8RUq6xTbYSME0lJU+aHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kzx1ir/L6I0TnoujSu//QL6r5dMAPjZwYeeON6HMOpN9rBesSQ+uDHgFb0r5K6sEd
         dtGVvauDXJzluB92YKouaopnxgNyk879la6ckOWMxH1BtAtfrbfQVmQFzQo1+oCR7m
         hTQ3rB99vLAy2qGzT+iNaSxbIx+2uHeFgl7V4x+qa6+4lUmTy5p3brsWjOTpi551ea
         VGnbcuWF3IC3GLrBTtinSOzomH0SNlJKyomle9FtkwZsPYWbaftrjscqospc1Z753T
         wtSyqeippOAi/cZfzzS5n7tq09upr6PG53eLiTN3pRPr8VdjNWQLKy2j8nLDHCH6Fr
         r0IosaHLo9CdA==
Date:   Fri, 28 Jul 2023 10:07:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 0/9] PCI: EPC: Add support to wake up host from D3
 states
Message-ID: <20230728043726.GJ4433@thinkpad>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 12:40:09PM +0530, Krishna chaitanya chundru wrote:
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

Please split this series into two. One adding D-state support and another
(dependant) adding wakeup support. We can try to merge atleast first one for
6.6.

- Mani

> ---
> Changes from v3:
> 	- changed the bool return type to int for waking the host in mhi ep driver
> 	 as suggested by dan and bjorn.
> 	- Changed commit logs as suggested by bjorn.
> Changes from v2:
>         - Addressed review comments made by mani.
> Changes from v1:
>         - Moved from RFC patch to regular patch
>         - Inclueded EPF patch and added a new op patch to notify D-state change.
> ---
> 
> Krishna chaitanya chundru (9):
>   PCI: endpoint: Add D-state change notifier support
>   PCI: qcom-ep: Add support for D-state change notification
>   PCI: epf-mhi: Add support for handling D-state notify from EPC
>   PCI: qcom-ep: Update the D-state log
>   PCI: endpoint: Add wakeup host API to EPC core
>   PCI: dwc: Add wakeup host op to pci_epc_ops
>   PCI: qcom-ep: Add wake up host op to dw_pcie_ep_ops
>   PCI: epf-mhi: Add wakeup host op
>   bus: mhi: ep: wake up host if the MHI state is in M3
> 
>  Documentation/PCI/endpoint/pci-endpoint.rst     | 11 +++++
>  drivers/bus/mhi/ep/main.c                       | 27 ++++++++++++
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++
>  drivers/pci/controller/dwc/pcie-designware.h    |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c       | 36 ++++++++++++++-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c    | 27 ++++++++++++
>  drivers/pci/endpoint/pci-epc-core.c             | 58 +++++++++++++++++++++++++
>  include/linux/mhi_ep.h                          |  4 ++
>  include/linux/pci-epc.h                         | 12 +++++
>  include/linux/pci-epf.h                         |  1 +
>  10 files changed, 190 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
