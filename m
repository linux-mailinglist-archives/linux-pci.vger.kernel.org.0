Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407FB624062
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 11:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKJKvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 05:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiKJKvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 05:51:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714EE27CDE;
        Thu, 10 Nov 2022 02:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F04961215;
        Thu, 10 Nov 2022 10:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A4C433D7;
        Thu, 10 Nov 2022 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668077494;
        bh=IMm20rn9TBxywBBLQYqPLk5C1JXu1UtC6qBbO6BkG7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAfn31a7x766F5utthngYHX9rXLGAi+vBKgdMAyYnr2R+inntRzT0VprnLqHWIXOP
         KbCpJzDhGdNjHYFUqABN0l6gnQG9wE1cyr4zBS88ndMb2Wzfq+09hjtQTELDJrG+u1
         yvj33Htr52XPKMiPmB+x/2kvXEV1QrBWXA2G9G8DopQbBeJWqXFzdzFf5ujSjFrp/2
         FmEf4A7zzkBoQdLqlOYfWeoSP6x2Dk+cU/YRN2H10cuq2uFSEhwKmlC6XlR7F2A3Wt
         wEIYK30+66Z6Gid2sF6SKQSs7JS3pMk4C+v3sfWcWf6g1dh7ZAVq4VbeTj6wvNB5Eu
         obmM9q5j77igw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ot59G-0003Xi-G9; Thu, 10 Nov 2022 11:51:07 +0100
Date:   Thu, 10 Nov 2022 11:51:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
Message-ID: <Y2zXmv8d9PIkO2/7@hovoldconsulting.com>
References: <20221110103345.729018-1-dmitry.baryshkov@linaro.org>
 <20221110103345.729018-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110103345.729018-9-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 01:33:45PM +0300, Dmitry Baryshkov wrote:
> Enable PCIe0 and PCIe1 hosts found on SM8350 HDK board.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 0fcf5bd88fc7..58a9dc7705a5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -222,6 +222,22 @@ &mpss {
>  	firmware-name = "qcom/sm8350/modem.mbn";
>  };
>  
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	status = "okay";
> +};

Looks like the required regulators are missing from the PHY nodes.

Johan
