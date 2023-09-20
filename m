Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A447A8321
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjITNTh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjITNTg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 09:19:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA72B6
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 06:19:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503065c4b25so6732288e87.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695215968; x=1695820768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOy+tw7JFth8FCqJzlba7saXfyCHBART6wBdyA2SClY=;
        b=USEuVSk3cOj6jhT0t03TmuNpomMFHoF6Q42AwTFDxZjmMulHlY82fcJWgRBJZFM9PP
         l5xH1stUSGaHTMEc+HuOEVTlf4x0UcGK+0ujiS5rVMuzy7t5K1MDtVf3AazbzdBxl8vX
         RadTyBleTtLIT50KDwBrWnJSNGkYaHdRCRpa4b4pD8Ydd23kriGk+viZuhIYrqUiG6Db
         plCK4UOmTd1GqE7ELrDW9DK7I9gQTRFZ1ykej1sejf9PW+K/3Ex5P1a1B/I6DaJ05RK0
         koZgWFDhqtgW/PDaKWa79TN8KCTpZvkHEvYNo6S0hclWUD4QAXT3Spo05KYGd76/EJFK
         5jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215968; x=1695820768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOy+tw7JFth8FCqJzlba7saXfyCHBART6wBdyA2SClY=;
        b=XywrtPPQMraY0BhmQw7e5eyqrhnpXrfKYgtaB1DI85CteHH/B2mxTnGkbYAoIloxTP
         thMayw5xKoUHHnkYTYRHAJvCtCcCofuPDN4gdKn09NCfBNtr1x5gVrI/gUmo6bai1/Kc
         pqtX0UAwTZXsv+hdPqU1xARJR4RCPcJAQhWR49Q/Silor6GRUnVjDpoggOkjT1Lokuzh
         PrmLOBLi+oiS77VvpT9ZqtvniJWl2HJVmikwA5t9yIjTZR5/gfReCW3lrbywXgCzIcE4
         djlQ7Ld6dmLprEuJXhwx0aMtgPH/iY5HaS8LRO6ATuoCh/g/Y7Uq+UqQA+5Sqx5P6BLW
         fhFA==
X-Gm-Message-State: AOJu0YyLkPfTDDTlWVlzQBWFoQzTUoWpiOrc3gALH2Ba8/qK7U432szF
        pOJcPPq7uWihqZ/Mnp5arArbWQ==
X-Google-Smtp-Source: AGHT+IHkbmDhplCmcpWceWrsHHknh/hic++9MQZmNTujBFNA0UUiPrM6aqLADYgkoKVyakt4MATTSA==
X-Received: by 2002:ac2:5e79:0:b0:500:92f1:c341 with SMTP id a25-20020ac25e79000000b0050092f1c341mr2288339lfr.54.1695215967771;
        Wed, 20 Sep 2023 06:19:27 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b005309eb7544fsm7205179eda.45.2023.09.20.06.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:19:27 -0700 (PDT)
Message-ID: <c53958d2-d7bb-c859-b4d1-37e7c61f6107@linaro.org>
Date:   Wed, 20 Sep 2023 15:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Content-Language: en-US
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
References: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
 <20230906172500.GA231799@bhelgaas>
 <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/09/2023 15:21, Havalige, Thippeswamy wrote:
> Hi Bjorn/ Lorenzo/Krzysztof,
> 
> Can you please provide any update on this patch series.

Krzysztof? You need to Cc him first... I mean, the other Krzysztof, or
whoever is needed to be Cc-ed.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Best regards,
Krzysztof

