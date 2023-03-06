Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F436AC468
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCFPHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCFPHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:07:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27F234CB
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:07:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec29so9054768edb.6
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678115257;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNCMCCJvA2lBH9AQZq82JaqBkNnc4Fk7SX9dh1mZFDE=;
        b=n8KD370ehXIp9BWjTZrIEe7SIXN1Ruc+QA8Sy1gDlPeFvejxDEeZZ3jhaptaFDMyUN
         gxhANY6uCJfWUuX9JO56+4eS8LBE8axdcU8zmdoj0Jow0YrLGTljgpUlgPS+utIR3ARZ
         sCL6QUb9+MOAVIIzucarsYPkx6eXOVgJFrG0SxBU/xO7MUaiYWiuZGT2N7e2+GlcuhHl
         mW+8sBnwOHZFEt44JSRZ2SQcba53FKcmos3awHH/HfbTFzOsMD8Fnioq4Rae5swkx1rI
         rFibEprIqP924HwutX+eBeEew5FQAeyMUEbIsuRCYpCl6IDWpYQTTB7mDOmQqGkHPOOW
         eLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678115257;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNCMCCJvA2lBH9AQZq82JaqBkNnc4Fk7SX9dh1mZFDE=;
        b=KpS2amLvxF98n0JZ9v+Na23XVjejw7qr/UnloXBDSNsJOQTqrK0OeMSCD6kDciHUfW
         4SJnsS2v/wlwuFc91vqgamcF3poogMudQO6ZQM+NxQ9CdAEM7oFPRrFHPUoKbSbk2O+E
         lcMDTxynqFwVHMZHCoMDmV4ceO/oIgEYFkwmrbC8Im8ewHkGgTQEs2a5ym/mHW53SWnj
         DGZ+R0YxiHePCsfD2LuEKKifEYjW0HiRTtVVRIG1HoA+yc7OfKfWRyskse6mM0Kj8uOm
         Zc1KScjxF204DxvGcjK9xNpeFquKGMpOChtsqkDM3cVgcnkNsiw82siE8NWFqIR4wNwN
         Pojg==
X-Gm-Message-State: AO0yUKXWYpL1xjWXxBpZXT1DkAKFrYuNfxAmfCBmjYunawoawe3Uk17c
        2J8y9L5qguZri0tyOBQ49a/f9Q==
X-Google-Smtp-Source: AK7set+6I3VosaTXUccYCOjwEcFmdFe+U57axCZnhCtUf+bZm7rvBuvWkHa/5us9zvfNvpjAGaT2ow==
X-Received: by 2002:aa7:ce05:0:b0:4ac:bab1:feee with SMTP id d5-20020aa7ce05000000b004acbab1feeemr9330933edv.24.1678115257066;
        Mon, 06 Mar 2023 07:07:37 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:c1e7:5006:98ac:f57? ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id bi23-20020a170906a25700b008d356cafaedsm4658146ejb.40.2023.03.06.07.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:07:36 -0800 (PST)
Message-ID: <22525720-9def-27de-cf41-8fd8165d6e01@linaro.org>
Date:   Mon, 6 Mar 2023 16:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v2 0/9] Tegra234 Memory interconnect support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
In-Reply-To: <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/03/2023 16:05, Krzysztof Kozlowski wrote:
> On 20/02/2023 15:05, Sumit Gupta wrote:
>> This patch series adds memory interconnect support for Tegra234 SoC.
>> It is used to dynamically scale DRAM Frequency as per the bandwidth
>> requests from different Memory Controller (MC) clients.
>> MC Clients use ICC Framework's icc_set_bw() api to dynamically request
>> for the DRAM bandwidth (BW). As per path, the request will be routed
>> from MC to the EMC driver. MC driver passes the request info like the
>> Client ID, type, and frequency request info to the BPMP-FW which will
>> set the final DRAM freq considering all exisiting requests.
>>
>> MC and EMC are the ICC providers. Nodes in path for a request will be:
>>      Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>
>> The patch series also adds interconnect support in below client drivers:
>> 1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
>>    added per cluster OPP table which will be used in the CPUFREQ driver
>>    by requesting the minimum BW respective to the given CPU frequency in
>>    the OPP table of given cluster.
>> 2) PCIE driver to request BW required for different modes.
> 
> No dependencies or ordering written, so I am free to take memory
> controller bits, I assume.

And not.. NAK, since you decided to ignore my comments. Really, we do
not have time for such useless ping pong.

Best regards,
Krzysztof

