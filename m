Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA344659805
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiL3MNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiL3MNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 07:13:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBCBE07
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 04:13:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z26so31506317lfu.8
        for <linux-pci@vger.kernel.org>; Fri, 30 Dec 2022 04:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOV4608QXvjceJ4orI18C2FMI82fRREo3ytAKFrDAno=;
        b=oKfWKWbyNwZodxgmd7818YAECzl/XyC2dFCzkj/S2x0O2WO3uO/ZQrtF3roTdI+gOC
         Y5oZV2aG9isdrkBf6/w01OUplJH6tNL97VgSLhxTd30ng5UsYQ/q6hVTadLEENw0kHEW
         +qISic/+E4+a027OBf7uO2nDbWo1WGtxjyPCVwirKtEIJCSqK3FkUBGiU5ZWtLbcvfcg
         0dmjM+z8SSh3IOSgtXAi4mN3WZyJ4RHh8YvTJj5o6D1AR3ihFtkqJtremVVtYhf9GOs2
         DuFOLoe9YSwL36RbFHGZ9DLT0kYqRa1aer3ZEa/jRFqLj2osPXUp5B2omNiGo1ZQowFO
         Dmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOV4608QXvjceJ4orI18C2FMI82fRREo3ytAKFrDAno=;
        b=a08uYmXp8kbDSi5Coo48fZ9sn/37cC+bY5DIdNbgPGcVMsLqaktAf/bUwt8RLXf7vU
         lgN1VHhKavTj63/wkJL/Gvxo/2zlHqDjOK16BkJSil27fqdaj3FNib+iENpsnIXeAi/m
         aeLI8XNAtlnyeRXd2j5PPV0JyBo04QkGzf+Ipwdt53mRvbAigKhTdzq2atRct6R1veT4
         BETmghz0LLVjAiATC2ys3T5mdPDvGIg+D7JTp1wUnkDSHipWSl2/kM+yfmGPgMGGzHl3
         f3txFld8I7Yz8fSIFwxlPP4ig6+v7Aj3HjBx4b1Pfj2sCcQi2F1Qyiq8jO0cZBvNiOXF
         I3xg==
X-Gm-Message-State: AFqh2kqKpPK2Qg7cJpr3q4gGBnE4WzaDrJRhxBLLELBaqldvjYPTmEHH
        tiaS0ZzYGcFTWCiAhv3f2jZIEQ==
X-Google-Smtp-Source: AMrXdXusvA7Bqp0kTD6ocUkCT45Y8k7XajNQ/mNEXARtiL/stEyuuSH+ZWkdiQok1QaZKKe0pfCC2Q==
X-Received: by 2002:ac2:430c:0:b0:4cb:10ad:76bd with SMTP id l12-20020ac2430c000000b004cb10ad76bdmr3410731lfh.64.1672402394062;
        Fri, 30 Dec 2022 04:13:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w5-20020ac254a5000000b004b4bb6286d8sm3429914lfk.84.2022.12.30.04.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 04:13:13 -0800 (PST)
Message-ID: <9dfbb21c-b430-193b-a51c-56cc9827eaa1@linaro.org>
Date:   Fri, 30 Dec 2022 14:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: (subset) [PATCH v4 0/8] PCI/phy: Add support for PCI on sm8350
 platform
Content-Language: en-GB
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
 <167239965740.745771.6371707855803359101.b4-ty@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <167239965740.745771.6371707855803359101.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/12/2022 13:27, Lorenzo Pieralisi wrote:
> On Sat, 19 Nov 2022 01:32:34 +0200, Dmitry Baryshkov wrote:
>> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.
>> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
>>
>> Note: the PCIe0 table is based on the lahaina-v2.1.dtsi file, so it
>> might work incorrectly on earlier SoC revisions.
>>
>> Dependencies:
>> - phy/next (for PHY patches only)
>>
>> [...]
> 
> Applied to pci/qcom, thanks!
> 
> [3/8] PCI: qcom: Add support for SM8350
>        https://git.kernel.org/lpieralisi/pci/c/a39fb9fabdb7


Thank you! Would you also pick the patch 1/8 (dt-bindings: PCI: qcom: 
Add sm8350 to bindings)?

-- 
With best wishes
Dmitry

