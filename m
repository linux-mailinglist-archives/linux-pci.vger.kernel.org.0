Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6446B97FE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 15:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCNOa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCNOaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 10:30:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E78ABF5
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 07:29:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd5so28939402edb.7
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678804181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElHjwIeT7npoxRMCw2nu+jmWqBva4+bKaapSz/mECSU=;
        b=TwVSJKTA35/n7SvFYUMIlB1ti+ObmERDISpugC0l5FukjPltxsLMTim+fYoqzITV48
         Trw+IaBTNH1Tc9uawQC+HZo+5oPJTqFty35G1Umuv/dmjPrqA7Eqneu1dZxeABPqSIRD
         0f2MjRjrXYt7GZEGmmhaPIVxnGU/zIf6NCHbYcuZXxOkybmaJvexGSBxykK//oLP3mPE
         5NK/nUYaWU/eyPRFiOcLoaP2qNqxVsCFrGcsGYdmIXXdLU2b9X7Pw9KMtNQM3D8xMqkt
         mJvuya1ZYDXNI2zXQb+o408sxCZy1cUeWmQTOZO9EjYw5CFdtzAhPMdhEg8f4Sqa6N5w
         Hc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678804181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElHjwIeT7npoxRMCw2nu+jmWqBva4+bKaapSz/mECSU=;
        b=FG61sNlQsyJTAGKZQJSdMeDaofna3kFwkqldIYCKVeHdq2KOEG95z3dsgKSx94EiL1
         YWRTRiZ4GeXFVp89Qk47pclzjqAH88NGphHYm6h44OCZCVbg71bpHo1SC0N1i5Fc4sht
         DFGPX8lJKgbtotSRO2lxfPRu7XPRu0GkiZjQ4gvD+8cy56Xm6gIoTcO/B4eQrdZFRVgs
         bKxPZMjWWoCJzmXlxQKE1e59DS4aLbsdvI2M3J5MQPLcR58KKKQzTG55UETSHBjDl2Ma
         TLgFZVmWDxPbOd5ee/2q5teJBGUnf3EwctFWQnmJ3eHijgajIuyAjFF0UJ8GIdih7zT+
         vhmg==
X-Gm-Message-State: AO0yUKX9nb6lrXLQvMsWTaQgA2N9CZ88IgdrT1wHwybb1lebjLvda7H+
        0O4tJCD43M/wYqHXYOBLynmXLQ==
X-Google-Smtp-Source: AK7set8BTJKzs7H5rL6iH9MVtKlcHgRUHKBlpQX+UW1cWD83NcyG/8r94I7ANT1OFh2CKPgR9hQNTQ==
X-Received: by 2002:a05:6402:202e:b0:4fd:c862:b3b7 with SMTP id ay14-20020a056402202e00b004fdc862b3b7mr2490284edb.20.1678804181215;
        Tue, 14 Mar 2023 07:29:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id s23-20020a50ab17000000b004f1e91c9f87sm1147798edc.3.2023.03.14.07.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:29:40 -0700 (PDT)
Message-ID: <9756a5ae-a5f9-c2e0-1bb4-cdcc4373b891@linaro.org>
Date:   Tue, 14 Mar 2023 15:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 1/3] dt-bindings: PCI: dwc: Add rk3588 compatible
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
References: <20230314135555.44162-1-lucas.tanure@collabora.com>
 <20230314135555.44162-2-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314135555.44162-2-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/03/2023 14:55, Lucas Tanure wrote:
> PCIe for RK3588 is the same as RK3568.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

