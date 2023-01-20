Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E825674F92
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 09:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjATIi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 03:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATIiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 03:38:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543679EA7
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 00:38:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so3394053wmo.5
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U3TgdA82LxZWCE4+m1jGd3NaCMDAXUGABeqPXGna/o=;
        b=enmoSn61zyXL8cPCpDjOCLpP7urcbyXG0wvJZNa61KlEPp2Qr0alH/VcMx9wlnjAQl
         Se41ciDg3Na0iub20x1k3j22CfxCCb5CfcHeFBm2mluIMuodFJa9W/jgiMdPIwEo7W0O
         Yw6Yz+DDdNa5FvGpWE8CvUSsDNwDdLuMOaiIe2uGbZlN2HoFgeckWUyI79n3pe0Oyd7c
         yNeKUm1TyZfmWYQZQXi6iCkQUSzbjF/QpMOLDEhzVG3q0rMf0hXFiXwgYiMCN2FCkz6z
         o04CTqAL7BGUlLDFsShXpOFycdMlFdORjkcTa062+TLjm6yJM6qgGCcwqkCAuGpRQLAu
         IcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U3TgdA82LxZWCE4+m1jGd3NaCMDAXUGABeqPXGna/o=;
        b=AUgniP07UxonTGzQkNPCo3/zJ5evgsLquczY+1iqbPNcvVUIXmlfgGNc175R3wmbfX
         iXFnOZrQO+Ij5UrDFaMVPUVJi0LFE22JTj0szSr+fDdb+3pvUZB/N3sfgHFwki5JMNr8
         qGMQVkWD6VgMH2R+yu7kHT4Cpv7+4YpWLW3nwCcosaKlGsAsb8xRfniU9i34xYxKzJzb
         G8GKbxW74IXKN4XF19svtoXvlGwRUS5VA1TbmcG1nzLldvBTI3i6w3z2sQ+v3yybmGfL
         4dMPP0uryW8DFHgabkrz1razDLk3/w5ROTyLiXCGWjSrSVCPJy+tRR49Guc7QzXNKIEX
         NJvA==
X-Gm-Message-State: AFqh2krmp6hjj/MqSj8a3b8CCKHTkXxe17rC0JuIIW89nT9O/xqIynWH
        vsiUCjNIu+3GpNPjABgWMthPZQ==
X-Google-Smtp-Source: AMrXdXuVAhh8YyYXK40k+0ZhTOgLDM6ArYVXzHtNDVno2/52aEWEuAoyxxYVnGQS2teBvPJJItLKkQ==
X-Received: by 2002:a05:600c:3ba5:b0:3cf:7925:7a3 with SMTP id n37-20020a05600c3ba500b003cf792507a3mr13285155wms.24.1674203902394;
        Fri, 20 Jan 2023 00:38:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c028200b003cf6a55d8e8sm1550522wmk.7.2023.01.20.00.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:38:22 -0800 (PST)
Message-ID: <ba338259-e5b4-2a15-9305-b74c04f23d48@linaro.org>
Date:   Fri, 20 Jan 2023 09:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add SM8550 PCIe support
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119112453.3393911-1-abel.vesa@linaro.org>
 <20230119112453.3393911-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119112453.3393911-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/01/2023 12:24, Abel Vesa wrote:
> Add compatible for both PCIe found on SM8550.
> Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> 
> The v2 was here:
> https://lore.kernel.org/all/20230118111704.3553542-2-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * changed the subject line prefix for the patch to match the history,
>    like Bjorn Helgaas suggested.
>  * added Konrad's R-b tag
> 
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 77e5dc7b88ad..85988b3fd4f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
>  
>  /* 6 clocks typically, 7 for sm8250 */
>  struct qcom_pcie_resources_2_7_0 {
> -	struct clk_bulk_data clks[12];
> +	struct clk_bulk_data clks[13];
>  	int num_clks;
>  	struct regulator_bulk_data supplies[2];
>  	struct reset_control *pci_reset;
> @@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[idx++].id = "noc_aggr_4";
>  	res->clks[idx++].id = "noc_aggr_south_sf";
>  	res->clks[idx++].id = "cnoc_qx";
> +	res->clks[idx++].id = "cnoc_pcie_sf_axi";
>  
>  	num_opt_clks = idx - num_clks;
>  	res->num_clks = idx;
> @@ -1828,6 +1829,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },

This does not match your bindings. Basically, this is very similar to
other models but bindings suggest otherwise - several new properties,
optional existing properties.

Best regards,
Krzysztof

