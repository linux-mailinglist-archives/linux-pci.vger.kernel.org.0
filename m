Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222566CBD70
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjC1LWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjC1LWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 07:22:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4A172A
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 04:22:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so48169001edd.5
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680002548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzwHQ2Duk/kqF5BJ0fG5L6Cu8NMF103H5aRIBgcczb4=;
        b=htrzrsE7hmfkJgnGa64UdAmCTFbDjwVjX1/ZK7rzlfJ4rum1twPXjx2IcPP12VND9T
         0DKpttfDZeCJAjZF9hf9sirzt1D7GiaNIvC2Ms0GGq/MedlyTFbot/1vxF4CxC0kFUot
         lJYlci1bOkm1cjOAaW76KTfxGYDZpTUwaWI6CqiqlLyD64vI1f8N1ETCWOZvAh6jSSal
         1PbzRamEOc4x30/OWIqrzOivLgt4Uzhb1hguorghfB6U/5sNzMn2YAbgBBqg+Tdtf4hr
         dXV/1WfiU6mwe/scWd/TkMX5uL4+EeTzYs24kk9cDqFNzkUiCS1rn8BmpwTCA4wE1eLy
         wDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzwHQ2Duk/kqF5BJ0fG5L6Cu8NMF103H5aRIBgcczb4=;
        b=H1y278B1y+QwrYxpMo3QGneIDBfX1IKPuEAac3/+FnNEYcs3WPr123PcS0tGiODcxr
         RMkcGvd8HiihVvkP9TBNhs9xfBdBZR6vmjNGpINRlTh6+X+8ztCnJ4EOnR0TYHYidia0
         Btc3gTEXb9l9BvBGTWpvos7OKFh8rrRsDtN3VdYXNiA9rX3CgCL6pFd/Ysp/Fs3smEtb
         FifnmZbH61iVVMkXlfoGpaGix8gbDpqlpbTYN9gy7a1qj1giduhn2ZNHZyiPdHVSS78F
         4faEH7cNoJY/uPnWs40ePd8YVpwoAals9LjyRa+1ZKIlGA8mdgwWuoGRE5eF8CHT9YaF
         vs1Q==
X-Gm-Message-State: AAQBX9f4c43lB/k3b0KD1ozCChT1wPYC8EqxFJ9vpLfccmnNqvgu5Gyy
        j9N/Uz1dZJ/iecjvYrxfTv1Z+w==
X-Google-Smtp-Source: AKy350aGvcc3WcYuz9u6zfbZBRO4GkfWN+fYq58at9mlFg8RR/uitQlgp2yla6cyxnFnFhXLJw2AWw==
X-Received: by 2002:a17:907:86ac:b0:92b:eefb:b966 with SMTP id qa44-20020a17090786ac00b0092beefbb966mr21203353ejc.0.1680002548506;
        Tue, 28 Mar 2023 04:22:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906079600b009333288d0ffsm13778637ejc.194.2023.03.28.04.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 04:22:28 -0700 (PDT)
Message-ID: <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org>
Date:   Tue, 28 Mar 2023 13:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org> <ZCLF6ZRH528pu/r3@orome>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCLF6ZRH528pu/r3@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2023 12:48, Thierry Reding wrote:
> On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
>> On 27/03/2023 18:14, Sumit Gupta wrote:
>>> For Tegra234, add the "nvidia,bpmp" property within the Memory
>>> Controller (MC) node to reference BPMP node. This is needed in
>>> the MC driver to pass the client info to the BPMP-FW when memory
>>> interconnect support is available.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 935d63d181d9..398d27bb2373 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -58,6 +58,10 @@ properties:
>>>    "#interconnect-cells":
>>>      const: 1
>>>  
>>> +  nvidia,bpmp:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle of the node representing the BPMP
>>
>> Why do you need this multiple times? Both in parent and all external-mc
>> children?
> 
> We've had nvidia,bpmp in the external memory controller node since
> basically the beginning because we've always needed it there. For newer
> chips we now also need it for the memory controller.
> 
> Ideally I think we would only have this in the MC and have the EMC
> driver reference it via the EMC's parent (i.e. MC), but that would break
> backwards-compatibility. Reaching into the EMC's DT node from the MC was
> another option that we discussed internally, but it didn't look right
> given how this is also needed by the MC.
> 
> One thing we could potentially do is deprecate the nvidia,bpmp phandle
> in the EMC and only keep it as a fallback in the drivers in case the
> parent MC doesn't find it's own in the DT.

Yes, deprecation would answer to my question.

Best regards,
Krzysztof

