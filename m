Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE476F100
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjHCR6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjHCR62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 13:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147DB3A85;
        Thu,  3 Aug 2023 10:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A5461E4A;
        Thu,  3 Aug 2023 17:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E2C433C8;
        Thu,  3 Aug 2023 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085501;
        bh=287ZQ7o0i23bpSbt2VALlL9vYk9BAs90TLEhZHggUMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bGKaN6pVFjAUBrEkhFoFa74efS0oxwMwYad7lVBLVygWYa8VuNDkGTsmpwc5bGQqW
         xKpFZu+v3NyK4yk8oEBZlb7xps+1hjUuvrz3eYwwVL2yp5keMpUBGbCE7xOXi4ASeE
         EEG+xhAUrKbLT5QKNM1J+/9cAm8HFgQrQjjQHEQA4+037DhBLLCkY/8wVrLwWCKsTw
         xML8Pz7f/w0SH9P2QRLXMdZYynmRXSJxbxN9cCpyfaIafB9vQhS7zxUOVuPPrbb1pa
         Zj0LBfP/N5RJfU1ZHdWnxIp3nfJFoNqKZMe2c+RH2zc6rMoI/lWmb2c0vLd19EDVQ+
         oWKIMOVrUA72A==
Date:   Thu, 3 Aug 2023 12:58:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/4] PCI: qcom-ep: Update the D-state log
Message-ID: <20230803175819.GA103913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690948281-2143-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  PCI: qcom-ep: Print D-state name to distinguish D3hot/D3cold

("Update" doesn't give any hint about what the change does.)

On Wed, Aug 02, 2023 at 09:21:20AM +0530, Krishna chaitanya chundru wrote:
> Now that the state event is stored as pci_power_t, let's use the PCI helper
> pci_power_name() to print the state event.

s/let's use/use/

The main change is this, right?

  D3 -> D3hot
  D4 -> D3cold

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 22545ff..0c69a61 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -583,7 +583,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
>  		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>  					   DBI_CON_STATUS_POWER_STATE_MASK;
> -		dev_dbg(dev, "Received D%d state event\n", dstate);
>  		state = dstate;
>  		if (dstate == 3) {

Can this check for "state == PCI_D3hot" to be clearer?

>  			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
> @@ -594,6 +593,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  			if (gpiod_get_value(pcie_ep->reset))
>  				state = PCI_D3cold;
>  		}
> +		dev_dbg(dev, "Received %s event\n", pci_power_name(state));

Not really sure why this needs to be moved (the diff would be clearer
if it stayed in the same spot), but it doesn't look like it really
matters.

>  		pci_epc_dstate_notify(pci->ep.epc, state);
>  	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>  		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
> -- 
> 2.7.4
> 
