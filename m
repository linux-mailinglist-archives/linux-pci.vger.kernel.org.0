Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E157DDC41
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 06:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjKAFUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjKAFUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 01:20:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD6AB9;
        Tue, 31 Oct 2023 22:20:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BF7C433C7;
        Wed,  1 Nov 2023 05:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698816007;
        bh=IR8T015GjC2W1ZHwd6MH/vDDHExF6SvoDshzi+eVuYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PT76iVfuRLaaMW2JFu5mmEn8P9JpLjoFNwzbqBWHecWDq/N9KB09bvG4z6+eNaD5V
         u9S9MPTkqwPu+X1+eHPj7Pgo35yk/zfhHh+a+69Q204JQq1YTnbdu6q3qPLyQqUFOq
         woECxfMac5Nfyv3IK+Fk7/PH4mWGvB8NCMIKvzOekY8Gna48GZE0tklOcYsIg2YzAc
         xDyZSnD4EC0UG109TFUiylJdlBr4ks+uu9hh/d+9S/TRm1NOmkiVSDIbf5oHjkEohZ
         LJv1vM1mncf3CXzJpgTPCuPdYyvDXrskWjgBZ46q0ChHluEyr/phclg45QekXB+QP/
         U2JbRW5XnJWyw==
Date:   Wed, 1 Nov 2023 10:49:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v6 2/4] PCI: qcom-ep: Add support for SA8775P SOC
Message-ID: <20231101051947.GE2897@thinkpad>
References: <1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com>
 <1698729108-27356-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698729108-27356-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 10:41:46AM +0530, Mrinmay Sarkar wrote:

"s/SOC/SoC" in subject.

> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> driver. Adding new compatible string as it has different set of clocks
> compare to other SOCs.

"compared to ther SoCs."

> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 9e58f05..3a53d97 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -875,6 +875,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
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
