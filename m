Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD777DDCAA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 07:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjKAGbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 02:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjKAGbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 02:31:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B8FC;
        Tue, 31 Oct 2023 23:31:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290B6C433C8;
        Wed,  1 Nov 2023 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698820261;
        bh=Tf1WPErRBjYtbexKIcjo7Q56h19eb/MEk0UqAcX+kSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDCNle0sCyh4rlmoh9NwgJwrhorc2EbSBIBmIxnZsdYIMmMiVbh4gKjdYdGm1Nitt
         LMAVpVY9evvjDs+FXTeK2ZU7W2KqoWeM8Wjv34FeN6pY7ZGYLnpQSxWpbve2nJwMdT
         aZJPWyTZqqeiyYJOY2XK+dh5aFWjDKeLjV15kR3dZ2TU/6KXyjdG/m1JPI7e9Q2Wh4
         EiMyWuTe3dgrUTRXb7eqoJlIpxItwGSHoUD9U5yXeiQK2uB5uJWC1/uC7rZ3JzgyFu
         AaBwFvCdwO/+LLlqQv2zs61/L8EU/Nf9wKOs7I+V3RXE/bzfc8q9qgxok8/7r33k2i
         gcudMdIgQe0FA==
Date:   Wed, 1 Nov 2023 12:00:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 4/5] PCI: qcom: Return error from
 'qcom_pcie_icc_update'
Message-ID: <20231101063041.GG2897@thinkpad>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-5-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1694066433-8677-5-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 07, 2023 at 11:30:32AM +0530, Krishna chaitanya chundru wrote:
> Return error from the function if the icc path is specified in the
> dt and icc_set_bw failed or link is not up.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e2f2940..ca6350b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1357,22 +1357,21 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
>  	u32 offset, status, bw;
>  	int speed, width;
> -	int ret;
>  
>  	if (!pcie->icc_mem)
> -		return;
> +		return 0;
>  
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>  
>  	/* Only update constraints if link is up. */
>  	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> -		return;
> +		return -ENODEV;

Why would you want to fail if the link is not up? This will break the driver if
device shows up later.

- Mani

>  
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> @@ -1392,11 +1391,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  		break;
>  	}
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> -			ret);
> -	}
> +	return icc_set_bw(pcie->icc_mem, 0, width * bw);
>  }
>  
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1529,7 +1524,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	ret = qcom_pcie_icc_update(pcie);
> +	if (ret)
> +		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
> +			ret);
>  
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
> @@ -1596,7 +1594,10 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		pcie->suspended = false;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	ret = qcom_pcie_icc_update(pcie);
> +	if (ret)
> +		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
> +			ret);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
