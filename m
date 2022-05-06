Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840E51D270
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiEFHon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389631AbiEFHom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 03:44:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEA5DA4D
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 00:40:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so11163641lfg.13
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yq4oJMCDfCqiuSYPrGiR7TdBoQ/AyiNCejA6X9Nl+ck=;
        b=dorWGvetxsGHiee41vHh66trGajA/WXxHaOioCCMFnhLOgLF6l/cV99tZXnLtV0BmF
         PAsja2Dl0CXAnTSrT8yRsPGa8iwAuT7/H0jCoSLoJK0PUwnFDF3AxxSA3VEP9tTesybY
         uWRbNG+JjmP4NPtPDHx+m+AMyuxsnnamZV+64uujGSzZuB0cM8FTs8OKJMk6AzZ81kjz
         Eeq7kxVE1d7YbJ9WH112miBPug2PYTcYjktR+s4LrHHqKqBHoQmdBmixBynslQX2oXjo
         TCBV73G4ZQmlwajOcDRSjW5PX5vxI511uB6+496bT30FVQovW+CKnrK2lg05xmQ1PFog
         Y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yq4oJMCDfCqiuSYPrGiR7TdBoQ/AyiNCejA6X9Nl+ck=;
        b=ZeuxX0aCslbEhypnn4p+2ep0wa1ztLY3LtOsVprXK9kP1WS4ZKdPZwuMSLz7Jb/xxX
         XhH6fqO3fvDdpJe3cB1ik9aCYHzQyvh79HQbvxLgHtTJYLQhf+amL0a1BukUrRcv3WDy
         bcAOm7VKOgmtl2+Bgn7f+QJHPzaHKqlMWxYtFNV1MOjAzcG9SzkFxcf9VBeLWq6J57a3
         iTvfMFRCw2+OGrOfUOs2rvdNkGYyIDJPEvAo8ELonMXXaD+lOrGSjPRW7TdZDEV9yA8C
         910bdqDDNkrMbctj4JXcqQsv/mrb5xt+q49Q0oyeDe3myk3COjrWUzZmI1b27FuzLX/1
         wWzQ==
X-Gm-Message-State: AOAM530Ivw+xny7EE2m1A+WvhKmzkyKciPmUYUSC570OiwKjLO7doVtC
        CfvNN+rCXCIE+a2QJu2Sz16DQck0SB8CNQ==
X-Google-Smtp-Source: ABdhPJx6qUi9SRLbyFFX1g/1yaeZbkNDkB/nwXSfN7TIJM0D6xR1485+MD2fKPk/lbQ9P98gpQLvnA==
X-Received: by 2002:a05:6512:2386:b0:473:a4e3:d4aa with SMTP id c6-20020a056512238600b00473a4e3d4aamr1639490lfv.448.1651822858278;
        Fri, 06 May 2022 00:40:58 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bt24-20020a056512261800b0047255d2113asm570118lfb.105.2022.05.06.00.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:40:57 -0700 (PDT)
Message-ID: <b334a2e6-69ae-690d-8560-25f8a1319e5c@linaro.org>
Date:   Fri, 6 May 2022 10:40:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 5/7] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-6-dmitry.baryshkov@linaro.org>
 <YnRA//LbCW+IVi3o@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YnRA//LbCW+IVi3o@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/05/2022 00:26, Rob Herring wrote:
> On Thu, May 05, 2022 at 04:54:05PM +0300, Dmitry Baryshkov wrote:
>> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
>> separate GIC interrupt. Thus to receive higher MSI vectors properly,
>> add separate msi_host_init()/msi_host_deinit() handling additional host
>> IRQs.
> 
> msi_host_init() has 1 user (keystone) as it doesn't use the DWC MSI
> controller. But QCom does given the access to PCIE_MSI_INTR0_STATUS,
> so mutiple MSI IRQ outputs must have been added in newer versions of the
> DWC IP. If so, it's only a matter of time for another platform to
> do the same thing. Maybe someone from Synopsys could confirm?

This is a valid question, and if you check, first iterations of this 
patchset had this in the dwc core ([1], [2]). Exactly for the reason 
this might be usable for other platforms.

Then I did some research for other platforms using DWC PCIe IP core. For 
example, both Tegra Xavier and iMX6 support up to 256 MSI vectors, they 
use DWC MSI IRQ controller. The iMX6 TRM explicitly describes using 
different MSI groups for different endpoints. The diagram shows 8 MSI 
IRQ signal lines. However in the end the signals from all groups are 
OR'ed to form a single host msi_ctrl_int. Thus currently I suppose that 
using multiple MSI IRQs is a peculiarity of Qualcomm platform.


> 
> Therefore this should all be handled in the DWC core. In general, I
> don't want to see more users nor more ops if we don't have to. Let's not
> create ops for what can be handled as data. AFAICT, this is just number
> of MSIs and # of MSIs per IRQ. It seems plausible another platform could
> do something similar and supporting it in the core code wouldn't
> negatively impact other platforms.

I wanted to balance adding additional ops vs complicating the core for 
other platforms. And I still suppose that platform specifics should go 
to the platform driver. However if you prefer [1] and [2], we can go 
back to that implementation.


[1]: 
https://lore.kernel.org/linux-arm-msm/20220427121653.3158569-2-dmitry.baryshkov@linaro.org/[2]: 
https://lore.kernel.org/linux-arm-msm/20220427121653.3158569-3-dmitry.baryshkov@linaro.org/



-- 
With best wishes
Dmitry
