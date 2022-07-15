Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D98576316
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiGONvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGONvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 09:51:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93A7FE5B;
        Fri, 15 Jul 2022 06:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0422B82C6E;
        Fri, 15 Jul 2022 13:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6864EC34115;
        Fri, 15 Jul 2022 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657893107;
        bh=xYedmqGMctnUXEDc/PAZZ+61FbVfXucK13vS2m5RINU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rvf7FizhpDT2XZSqEN2uAHDeuyFCsC+9OcDI2hKMYDPbYWekFCNT1Y4QJjn687HrY
         UPMF9qHyUqkL+Pi/adJ1D1UowiGO7Ou85JS1c08bEV83Ypf/kgP+BcPULTudScSOFz
         9iRevHEUvG6zR4xEU8NsM8bdyEZZY/4q0+Y2T8rjvbzofsIAjvofb5BlAiNjo8gVmD
         Ja4lRfAzc51LUBGzY5Na+L1AZ9O7sjV9/dmL4PZSGQhMcNfnvZwjExTZ6B3dcIu6rN
         77Awg9WDU+HwYs/Shuy4t1k8vz6v0nVLXKh9YkQAvDspR4zzkThQWyoDvAslH4Jk2O
         0g9jQkCdQvy3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oCLjV-0006Qo-0S; Fri, 15 Jul 2022 15:51:53 +0200
Date:   Fri, 15 Jul 2022 15:51:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: qcom: Restrict pci transactions after pci
 suspend
Message-ID: <YtFw+ezt6s/yXaLY@hovoldconsulting.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657118425-10304-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:10:25PM +0530, Krishna chaitanya chundru wrote:
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts in system suspend path by writing
> in to the vector table (for MSIX interrupts) and config space (for MSI's).
> 
> These transactions are initiated in the pm suspend after pcie clocks got
> disabled as part of platform driver pm  suspend call. Due to it, these
> transactions are resulting in un-clocked access and eventually to crashes.
> 
> So added a logic in qcom driver to restrict these unclocked access.
> And updated the logic to check the link state before masking
> or unmasking the interrupts.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++--
>  drivers/pci/controller/dwc/pcie-qcom.c            | 36 +++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f3..2a46b40 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -29,13 +29,23 @@ static void dw_msi_ack_irq(struct irq_data *d)
>  
>  static void dw_msi_mask_irq(struct irq_data *d)
>  {
> -	pci_msi_mask_irq(d);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

When rebasing you'll notice that struct pcie_port has now been renamed:

	60b3c27fb9b9 ("PCI: dwc: Rename struct pcie_port to dw_pcie_rp")

Johan
