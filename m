Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77DE6CD710
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjC2J4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjC2J4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 05:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4F126;
        Wed, 29 Mar 2023 02:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C88B82220;
        Wed, 29 Mar 2023 09:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F5CC4339B;
        Wed, 29 Mar 2023 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680083789;
        bh=zkY92zC9Rz4pACdynoNm0JfJDAh2xPYJPTf8xCupJis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIK1IItOArEibcIa2a2ybrl9Xs3r4ggpkFSTLonFGC0fKs27dNsK1eALrR3u+HYve
         jWjIHK8YMrdx4VXhKArSv3Im0TbDaF1JOzU76JNZROVrTOHZANzPKfv306wsBRwjsk
         eTkvf4ua4tM89O9B076FRBPlu6zvFsSSdsXZfD65QtIv7ihZ7kYdrTg4kHYkb36Sfx
         7GnJ49/+nwPVm5nTu1/cU8RuFNTVPaEwHQ1Q5eJ0ewhyJkWuI3mjMHibWLeNMPeqqZ
         unzNrcIKLHsNskedayvwDzsFm3l0LndKB09pW98+mQxxEP79VR9Uu1PHFGcALECoUb
         TZaSz8VrVpctQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1phSXr-0003Kr-Rq; Wed, 29 Mar 2023 11:56:44 +0200
Date:   Wed, 29 Mar 2023 11:56:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <ZCQLWzqKPrusMro+@hovoldconsulting.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 07:08:24PM +0530, Manivannan Sadhasivam wrote:
> During the system suspend, vote for minimal interconnect bandwidth and
> also turn OFF the resources like clock and PHY if there are no active
> devices connected to the controller. For the controllers with active
> devices, the resources are kept ON as removing the resources will
> trigger access violation during the late end of suspend cycle as kernel
> tries to access the config space of PCIe devices to mask the MSIs.
> 
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
> 
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
> 
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 62 ++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a232b04af048..f33df536d9be 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -227,6 +227,7 @@ struct qcom_pcie {
>  	struct gpio_desc *reset;
>  	struct icc_path *icc_mem;
>  	const struct qcom_pcie_cfg *cfg;
> +	bool suspended;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1820,6 +1821,62 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/*
> +	 * Set minimum bandwidth required to keep data path functional during
> +	 * suspend.
> +	 */
> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));

This isn't really the minimum bandwidth you're setting here.

I think you said off list that you didn't see real impact reducing the
bandwidth, but have you tried requesting the real minimum which would be
kBps_to_icc(1)?

Doing so works fine here with both the CRD and X13s and may result in
some further power savings.

> +	if (ret) {
> +		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		return ret;
> +	}

Johan
