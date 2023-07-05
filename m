Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD626747FAB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEI2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjGEI2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C41716;
        Wed,  5 Jul 2023 01:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E116149A;
        Wed,  5 Jul 2023 08:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8BAC433C7;
        Wed,  5 Jul 2023 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688545723;
        bh=cHGda5V9pCsTD1y90nW+7+XhO6NjjTFPn6JL/uh9/QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9QoCJ6HBYGoU35mzpGaJGjN5PZX4OhgXcW6j125fWzLg/p53rilSADbcEv5wdkoq
         fpdUd4X+A2pY47BICfAQMEY1MVUtUc9V1SMtzRG8YgOlabaho/q4OE/xM+S2GStRbc
         KgUH9wfxb9Ymtsl2K1oAou3FoWSjlliCanIflFzbTcpEX8VsWLCb9ftrWzztPd2zx+
         2Ddy+yDSGZzBWxcUh+oDeAL4EaeL2Eb39e3fHfoSeq8OUhdJjkU+1eQnTLlfxqdKMg
         hQjSaHHV4+YyYHpzSxhXpCpmYPeXEsraa0ICvfPBn1uJA2gEdBFFqUJNdfyK7KcZDz
         AZmsRxsKo5QGw==
Date:   Wed, 5 Jul 2023 13:58:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 3/6] PCI: qcom: Add support for sa8775p SoC
Message-ID: <20230705082826.GC11854@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-4-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688545032-17748-4-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 01:47:08PM +0530, Mrinmay Sarkar wrote:
> Add support for sa8775p SoC reusing the 1.9.0 config.
> 

Add information about the controller version, DWC version in commit message.

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7a87a47eb7ed..59cc028d3a3e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1624,6 +1624,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},

Same comment as patch 1.

- Mani

>  	{ }
>  };
>  
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
