Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9187D6419
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 09:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJYHxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJYHxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 03:53:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9499;
        Wed, 25 Oct 2023 00:53:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7AEC433C7;
        Wed, 25 Oct 2023 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698220408;
        bh=n7geoxZluBkHjmKnM8s/P2+FzK4sT5UeQFEuduBhZmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6kq3+WINzCpXHPmzwRaIy8oZqnFEdP4qiZRJOfhu+DTqpNrF0gj1ewL4kKPDb8YU
         9C6ZV6myHtv2eYbE80UZFwkgs0Ix4SDZ/gGqNVok0oteF8/e9zo6Qcjw9JMAPH6HCZ
         HEy+CoEPZttoRrATy6kHg4o7Ew1oQT/NfhmxltfOLp7OzDWl942b9y46xMyf4JGj0o
         /hGUUoenoli7WMUkFCYlKfFcEf3BTS6VMH9qmz4h+OFymg4HCy1oQTaECcoxyCl+J1
         +uaJmA+Pt8H++XDmZDd2443w1c0leTOPPSfEv5QMtS8lXRDE/2f5A7gXhLrre6J/1D
         j3jzSWFpJLsWA==
Date:   Wed, 25 Oct 2023 13:23:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/5] PCI: qcom-ep: Add support for SA8775P SOC
Message-ID: <20231025075317.GC3648@thinkpad>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1697715430-30820-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 05:07:07PM +0530, Mrinmay Sarkar wrote:
> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> driver. There will be some change specific to SA8775P so adding new
> compatible string.
> 

What are those specific changes?

- Mani

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 32c8d9e..4c01c34 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -858,6 +858,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> +	{ .compatible = "qcom,sa8775p-pcie-ep", },
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
>  	{ }
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
