Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3A67D082
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjAZPnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjAZPnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:43:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A6312063
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:43:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so1431954wms.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaZrQvVMTexBK48seT2psGxItVIS/L4zE3c6J55k3h8=;
        b=jp04WqjEyYm+E2Tkc2ENfbxkh/4b4cMWFdtsFMHJIToG/9FZmnDZ/gC0vYolLvjzDN
         LTsDQVL579z+vKzZnxymlDvwLVEDgBe9ase7OQTz1ZNpwI+PTJjQK0bRFenOMnVGsT9O
         6QnmSFMr33MFNEGur7/bmTMkkk8b5NA6aWyz9oYUKymdP84Niq5uq2VGeLubsuEHQJji
         6UG2BA315Q0TT+gPUNNzXsBiKmUDjw5ZCKIfVrV1qLeU85jiDVZJBCjTvp2Xy25j7vQP
         N5pKbQbsQTnporgM+/+gREkjUb008iRxWJGISmoBYaD9UB1E5yY+2er2c/np+gzEu0XX
         6XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaZrQvVMTexBK48seT2psGxItVIS/L4zE3c6J55k3h8=;
        b=qsbALNHnFqDJRe8rFxoCLQK9DFBm7CU8vhpGRFhgcsf3yyZB3ZZonlfDsizFm5OSu8
         gmhwjAFC3jTB7zDWMqasbNDwRwxRk+e8GMRRg/bEOek8AhlxM9Eq0VbBzCBPlDGRbRLl
         rNUWU7jL40Ojp3mhjcTWNS7DkHXlYjKYJv6QdyLlkoG9kPVpdA4TE4cjZbFVcZrBCYGg
         ZM+BYalQv+XW0PMstdICzZOhGgZaC9ALNmJ1xKH+hZP5mXw06ul9CKl9l6RnOxfPk8ae
         +b43ZJUwI7voda3862GDITsCh5R8gDLqhMc+niHI23QvojqqkUdKwPXFgPWkCcetNpX5
         kB4A==
X-Gm-Message-State: AFqh2krrlzCbwb+1lM5jS+DaV1H4Uk9njMSK9m2hCdLA/hWjQBk+j8Pp
        FdBQi0f0LwODfIEHru0weCVctQ==
X-Google-Smtp-Source: AMrXdXssH15/vKnONbR1ylH/B9IaLwcgbhlzvUsooXAZkMdME223Pi73mbSr4a1nFyzzO0iOryMlCw==
X-Received: by 2002:a05:600c:4395:b0:3da:2829:2935 with SMTP id e21-20020a05600c439500b003da28292935mr35895070wmn.11.1674747785757;
        Thu, 26 Jan 2023 07:43:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ip6-20020a05600ca68600b003d04e4ed873sm4909786wmb.22.2023.01.26.07.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:43:05 -0800 (PST)
Message-ID: <f8aab3ce-f48d-3e7f-933e-abc7bd4dcc52@linaro.org>
Date:   Thu, 26 Jan 2023 16:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint
 controller
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-6-rick.wertenbroek@gmail.com>
 <6a54a51b-cf1a-c601-275f-00f825fcec5d@linaro.org>
 <CAAEEuhpOjSUhiQFxKwkhiwDNtmRzzUXmGYKMuHWePJF-Q7R9dQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAEEuhpOjSUhiQFxKwkhiwDNtmRzzUXmGYKMuHWePJF-Q7R9dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/01/2023 16:30, Rick Wertenbroek wrote:
> On Thu, Jan 26, 2023 at 4:23 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 26/01/2023 14:50, Rick Wertenbroek wrote:
>>> Added missing PCIe endpoint controller entry in the device tree. This
>>> entry is documented in :
>>> Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>>
>> There is no such file
> 
> Sorry but the file exists see :
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt?h=v6.0.19
> It also exists in 6.1 :
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt?h=linux-6.1.y

It's some old tree. It could have existed in the past. But it does not
exist. Don't refer to non-existing paths.

Your code needs then rebasing if you refer to some old trees. Please
always work on latest maintainer's tree. Optionally on linux-next.

Best regards,
Krzysztof

