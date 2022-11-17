Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B199562E540
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiKQT2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 14:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiKQT2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 14:28:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0586CA2C;
        Thu, 17 Nov 2022 11:28:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB85362236;
        Thu, 17 Nov 2022 19:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B4FC433D6;
        Thu, 17 Nov 2022 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668713319;
        bh=HOl8/azR2DkS805B126Ow1wy6Jroxnl2BedCTVb2AyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oflaetPRDJHWM3uzIexOk/hc6ssLxggm4/yUCpR9sU4GfDncIv4vDL9yLNkuiNWF2
         m4RwGbd444Lpj42MfdKzwP9wG1FD9AOBQoRKu5MSiKcuZOO6+vu4Hb8DhruCSnEeq3
         4iYxp6gcJpAg9X6SZmmPDgeSp9Sd6AZfzgQjGZYo303TU4Oup01CLL39ZAxi1yMsQQ
         K72UJX5cQfdu7vnd+f4evmYZXO+x/mZk9fephWKKava9vaZsb4Cxr3o7Xjk7fI8MIY
         ZIW9DslKQg5OzjUkIOZjWwrOufjLQXC/ef6Aor44EmHlgg2PF8HLxMoMhx+Jy5ueBB
         SR7lKhMBYQUeQ==
Date:   Thu, 17 Nov 2022 13:28:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: qcom: add support for IPQ8074 Gen3 port
Message-ID: <20221117192837.GA1203269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116214841.1116735-7-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robert,

If you post a v2 for any reason, capitalize the subject line to match
previous history:

  PCI: qcom: Rename host-init error label
  PCI: qcom: Drop unused post_deinit callback
  PCI: qcom: Sort device-id table
  PCI: qcom: Clean up IP configurations
  ...

On Wed, Nov 16, 2022 at 10:48:39PM +0100, Robert Marko wrote:
> IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
> Add compatible for Gen3 port which uses the same controller as IPQ6018.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 77e5dc7b88ad..97e8510c53fb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
> +	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -- 
> 2.38.1
> 
