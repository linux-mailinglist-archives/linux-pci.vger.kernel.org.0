Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C576EAF1B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjDUQat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 12:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDUQat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 12:30:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EB146C5
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 09:30:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso2769122a12.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682094645; x=1684686645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVr8lLzVps9ZuMV0XAHw4eg8z7YXbZGCdlhpUNWCutQ=;
        b=DwM7MXIKKSfaUMu1eJSCloBjXJpaWHmzbVeI7uMDb7pgL26Yroz/mrZnf+4gtrdE32
         zExJo/fxP73tyLq655HHLTKrCsFatO34nBhRbfiVIMhlyj/+r8Eh8yx8N2ZaXNRi8oAF
         IW2kt7uZzpCSSmxDo54dDanjtAMdz0KucVKX6OLZf8iP/KTVxB496RNWBL2q4r+SmEK5
         TcvtGvBBuW919Awdq2NozfHd2fEMp7na72TSuKyqiu8JdDpk42iHW1YO+ljs8J15VAIg
         TtU2RWkt0B0KOfnYkux1+LEVI3q2cepzBD1Brn1hT4Qa/4hYdAaJ1ygI60RyEZLy3GtJ
         aCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094645; x=1684686645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVr8lLzVps9ZuMV0XAHw4eg8z7YXbZGCdlhpUNWCutQ=;
        b=PY6fjjBLxNdCeXlRP0uzcMcbFOlC6dOEd42Bu+MvleMN9lUYp++UcO7MTxnEwNvlkl
         Qvfl0pwZBctBdf9CZB2V/1/FnDObEKB6h7aiobzjsJXLAr6ot4g0QV//o5PkCCnI/3iv
         Z3Z1laRX68CK0Jp4oJdCtTQyoV6kYK93dgKqa/l7N6EkNULEQpfXYX6QySxvcGLaSKir
         6jT/IXtM56K8gvp3YaLPanzgcdaNR0oCeVpELhTiCx3MFTlqqdLcVGMfhgDklj+tgo6k
         yXlghKqmXSwvP00oxC3+7iwBCjEX08k4J25a97Jzi+/1gE5nUd7597G8L6zgew7cJAum
         HG7g==
X-Gm-Message-State: AAQBX9cHLOaNPNjs717rF0U+EuuSE6FGuRzQe8zkdFa/GtlLvspjyAgn
        IRVoQgHbWA+WvrIg0dUxiWKODw==
X-Google-Smtp-Source: AKy350aa+VFT9KWufyYZvoi2qVl9Wo73hJiODISOMGd6i4if1G9OIE1Qj4FNQLJhsvAngpdIWqI+Pg==
X-Received: by 2002:aa7:c592:0:b0:506:c288:118 with SMTP id g18-20020aa7c592000000b00506c2880118mr5598942edq.39.1682094645408;
        Fri, 21 Apr 2023 09:30:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:687d:8c5:41cb:9883? ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fb0c000000b004bf999f8e57sm1963884edq.19.2023.04.21.09.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:30:44 -0700 (PDT)
Message-ID: <44e54d54-9a6d-ba49-c0db-f9de81743f64@linaro.org>
Date:   Fri, 21 Apr 2023 18:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 06/11] dt-bindings: PCI: Update the RK3399 example to a
 valid one
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        dlemoal@kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
 <20230418074700.1083505-7-rick.wertenbroek@gmail.com>
 <172c46b7-256e-b09d-3940-880fa8989b49@linaro.org>
 <ZEJW0giyXAlNMYTz@lpieralisi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZEJW0giyXAlNMYTz@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/2023 11:26, Lorenzo Pieralisi wrote:
> On Wed, Apr 19, 2023 at 10:01:25PM +0200, Krzysztof Kozlowski wrote:
>> On 18/04/2023 09:46, Rick Wertenbroek wrote:
>>> Update the example in the documentation to a valid example.
>>> Address for mem-base was invalid, it pointed to address
>>> 0x8000'0000 which is the upper region of the DDR which
>>> is not necessarily populated depending on the board.
>>> This address should point to the base of the memory
>>> window region of the controller which is 0xfa00'0000.
>>> Add missing pinctrl.
>>>
>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>> ---
>>>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml      | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> index 88386a6d7011..6b62f6f58efe 100644
>>> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>> @@ -47,7 +47,7 @@ examples:
>>>  
>>>          pcie-ep@f8000000 {
>>>              compatible = "rockchip,rk3399-pcie-ep";
>>> -            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
>>> +            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
>>>              reg-names = "apb-base", "mem-base";
>>>              clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
>>>                <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
>>> @@ -63,6 +63,8 @@ examples:
>>>              phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
>>>              phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
>>>              rockchip,max-outbound-regions = <16>;
>>> +            pinctrl-names = "default";
>>> +            pinctrl-0 = <&pcie_clkreqnb_cpm>;
>>
>> This is just example of the binding, you do not need to fill all
>> unrelated (generic) properties like pinctrl.
> 
> Should I merge it as-is ?

Yeah, go ahead. That was the note for the future that generic properties
are not always needed or even helpful in the example.

Best regards,
Krzysztof

