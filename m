Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24A7495BE
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjGFGjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjGFGjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 02:39:02 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D919B2
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2023 23:39:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e292cf214so530553a12.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Jul 2023 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688625540; x=1691217540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubpoaC9EzMplfQrBSeEcb7LUnfn7d45sUTFt95vzvBc=;
        b=CQAv2r9jw5Vw9NsORpehoSIOxspn0nGUVtog4W4gS/FAyNPsXCCuel9cngxv3TafTT
         +ZBa9AA0N/rxkymEGOMDH+S5onhIAtQTdLoEAJMSJ7bGvGvUb3BSF0ABWRVbrsR14pjw
         ul4F/dN1SVMWUYwYsRmppzMlm6dHhSAi+AcJrNkBcS7rtpdjjrQm5GMtdtvK/ras3XLH
         C8wJ03F2x1hpoQ2VPDqtq89tKjQiQLT+uC8Vwg+oy4IfylklYNIVvMHJMYrX3A98zU2J
         l6ttWevu95ZeGROAk4cgc0UH8zakCbUFTb+G7QOxQCZOIniLH0ljJvotq2iHdDI6Stas
         P+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625540; x=1691217540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubpoaC9EzMplfQrBSeEcb7LUnfn7d45sUTFt95vzvBc=;
        b=DbpCvXJgDjS4pXhgANRG233B2LMzUKBrG4NzKRMeiNUj724rvGVxNGfY/O+G01CypY
         OEmYpdYr3ErrWMAXZU63OTXOJuJtQmSTtDKOb4cadgCzBrG2SmiCt9dQgRRfYrmCFdiY
         C1arTZEdZKmRghGjR8qBNyZ+BzyoBoe/3oH8cAXvZoKLizTCE16cURTP0XvIsPYHGe8j
         CzL2lt7hMYz7qo9UPlJqLb4lqik/edW5U5z3IEhWPIu65RjaY5wtndvprv8HNKMH/sIh
         yBavbwjWtuPxXbsw8QCSB+S3MXtmi1g2crjh9yKlnvIziaPE+YOTSWTxbbM/dk+mr37+
         GxIQ==
X-Gm-Message-State: ABy/qLb2CIERHLg/fxGqJlXNfNQyCF2Grl+WiSf5p9cm+TRU8O20J0oN
        Yo8tzaIqzv9ikUY7jQjJJJgldg==
X-Google-Smtp-Source: APBJJlGdk6m02V0kX8E+G3wiBzfjjWJX4q5mx5yIhxxnI72FPFBQh7N6W0jmb66+UCh2kWaVXY/jNA==
X-Received: by 2002:a17:906:729d:b0:988:b58d:5e0 with SMTP id b29-20020a170906729d00b00988b58d05e0mr738996ejl.16.1688625539940;
        Wed, 05 Jul 2023 23:38:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b0096f7500502csm381433ejd.199.2023.07.05.23.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:38:59 -0700 (PDT)
Message-ID: <9d5c1411-e56e-fa56-c8f2-808e0c403d9a@linaro.org>
Date:   Thu, 6 Jul 2023 08:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/6] arm64: dts: qcom: sa8775p-ride: enable pcie nodes
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-7-git-send-email-quic_msarkar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688545032-17748-7-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/07/2023 10:17, Mrinmay Sarkar wrote:
> Enable pcie0, pcie1 nodes and their respective phy's.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index ab767cfa51ff..4a39294259fe 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -443,6 +443,74 @@ qup_uart17_rx: qup0-uart17-rx-pins {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	pcie0_default_state: pcie0-default {
> +		perst {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

