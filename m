Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F70E7C5230
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjJKLfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjJKLfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:35:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6DAF
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2023 04:35:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9338e4695so86836881fa.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2023 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697024106; x=1697628906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Qapw6Vwkgw3j/x2kavvMeUiB4u4WXfkqK2WO2XBHoI=;
        b=JIVG3Drt2z4AnTJ3x0xy7WyfBYoiidfhfy2Y+m3CDu/qK4SJFhTiJLW7ibElrsF4Yk
         CVucgTkIS0LunzZZzb4kYO8KdcqcS4bfU9H3UkGa4N/BKepGUGPpbmsJKVg7TNr8+vB5
         VmEos5nVcLmmjTb1uDm9XlfiQrzI8DB0eTb4qEtR9ytDIuBeCRsnDFao2AQ16TFH/mNT
         15jRwCGmv6mYo8yUFcmr2Id/x9QNLPPRmiFbHHCMkJVkTqq//QJ5HTQf2wj24u3pnS2i
         VIUYyahktkcCg6N7YYRZcuEiWpQWtSkOWMgWzzVRgrlrRgW6elIfYpbcH2BEUzzaxgUB
         UtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024106; x=1697628906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qapw6Vwkgw3j/x2kavvMeUiB4u4WXfkqK2WO2XBHoI=;
        b=N+uZnc04BnTo1mu6fdkuxNThiyRxtvNThbJmkBHwbVI1IxmK3gLAXbuEbBFpYo+5yq
         z4k8LJ08jIsL5nVxM1Acx1hzUM2rZGsQ1713Va8nSN6k76EXKjbARMyNibeMgbwLHT2l
         tnqkXSDKHe3t2gOPC91qba1R6KU9sJ7jv4nEx6Wel1vBhg4WZ86FxpsChBQtXKTBS4jd
         GCR7P8Z3WbAROHGeFudUSaxbnIed3W3m6oc/tSVfLIwvaWj3vBlN8O5wbuCf3ya0K4fE
         Wtme950On6VjY6hwxVrljQyBWJKyAww5JOZZWdDCeXsbZlMkz5dE8LReC0Ryn4pBktS0
         CTzg==
X-Gm-Message-State: AOJu0YwR61L07m+AfJqt6VQVnNXo7KcsJX8WXNirpB2HOnjw5nz39hhM
        hgkuYzvYEWy5oWwz7tAZhfUt6g==
X-Google-Smtp-Source: AGHT+IF5GLRI9qQunLWRzrMod3FWnDE+uoxeFzNq35YPTOaf98ygydLZmEYH1BWul8Cf/WIu46bWag==
X-Received: by 2002:a2e:9e53:0:b0:2bf:fa62:5d0e with SMTP id g19-20020a2e9e53000000b002bffa625d0emr18110256ljk.2.1697024105878;
        Wed, 11 Oct 2023 04:35:05 -0700 (PDT)
Received: from [172.30.204.240] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c5-20020a2ea1c5000000b002bcbb464a28sm2882350ljm.59.2023.10.11.04.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 04:35:05 -0700 (PDT)
Message-ID: <7297b408-06e8-41f3-a732-64c3cc3194e1@linaro.org>
Date:   Wed, 11 Oct 2023 13:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] arm64: dts: qcom: sa8775p: Add ep pcie0 controller
 node
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-6-git-send-email-quic_msarkar@quicinc.com>
 <20230921094823.GE2891@thinkpad>
 <ca898b48-78e0-4bc7-c88c-a33338e7e47a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ca898b48-78e0-4bc7-c88c-a33338e7e47a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/11/23 12:44, Mrinmay Sarkar wrote:
> 
> On 9/21/2023 3:18 PM, Manivannan Sadhasivam wrote:
>> On Wed, Sep 20, 2023 at 07:25:12PM +0530, Mrinmay Sarkar wrote:
>>> Add ep pcie dtsi node for pcie0 controller found on sa8775p platform.
>>>
>> It would be good to add more info in the commit message, like PCIe 
>> Gen, lane
>> info, IP revision etc...
>>
>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>> ---
[...]

>>> +        max-link-speed = <3>;
>> Gen 3?
> there is some stability issue with gen4 so going with gen3 as of now.
> Will update once issue is resolved.
That's something that should have definitely been mentioned in the 
commit message..

Please try resolving this first, if it ends up requiring bindings 
changes (missing clocks or whatever), it will be a pain.

Konrad
