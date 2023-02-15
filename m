Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE1697EAB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBOOqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 09:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBOOqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 09:46:44 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3511392AA;
        Wed, 15 Feb 2023 06:46:37 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id y17-20020a4ade11000000b0051762fdf955so1920763oot.3;
        Wed, 15 Feb 2023 06:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBEXT/3oqd86oxSyfqYLg0yKXT/8DtJ6xnwvUSvOxQA=;
        b=nwBdgSbQAxYNe6c+6rFk+4+hqmSyuPczecYrJVdqRDrMjuWBLZtI+1n5kOjDzR0MKT
         gS4aBq7aQN6rxNeh3riz070+HpUYar77MCavTQAceSxhTfUs7bbOuePQBKyhAAJoOS7e
         4bLdeNwp0t06fDzH4nuI7LgYz2jxULytopF7BFXgiTm7D9e8C5fdZBURqpJDiVH5nO46
         YPYysYEp9Cna3RgFENqwm8M8Q8ngd4F+rRxo6NWDV66dGveA3kRW1hAoLhjm+jKz8F3S
         8HU9rtUH5JGsk8dBm15DUwdst+/+vTdw9+HeZsQAoxKAFxuCx4+xhLf0QL411Xilf597
         7k1w==
X-Gm-Message-State: AO0yUKXgxTugT1G0nF/Yu9MucBZKmfJAa8KW6a5S0UZo3TdA7uB31wqv
        l/WZ9KpXt9DwMzfnUPef/g==
X-Google-Smtp-Source: AK7set+nN7gkSQK+tRLQHH367Wqkb9kKJmX6EWSzGmfUhKKFWebxk59RzxP5ZE1l3qKxhAHmuKo+EA==
X-Received: by 2002:a4a:45d8:0:b0:502:a732:f8f5 with SMTP id y207-20020a4a45d8000000b00502a732f8f5mr1315351ooa.5.1676472397168;
        Wed, 15 Feb 2023 06:46:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b18-20020a4aba12000000b004f2b4891329sm7011448oop.23.2023.02.15.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:46:36 -0800 (PST)
Received: (nullmailer pid 125959 invoked by uid 1000);
        Wed, 15 Feb 2023 14:46:35 -0000
Date:   Wed, 15 Feb 2023 08:46:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, andersson@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, agross@kernel.org,
        marijn.suijten@somainline.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: Fix msm8998-specific
 compatible
Message-ID: <167647239530.125903.1170051353603969134.robh@kernel.org>
References: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 14 Feb 2023 10:12:02 +0100, Konrad Dybcio wrote:
> In the commit mentioned in the fixes tag, everything went well except
> the fallback and the specific compatible got swapped and the 8998 DTSI
> began failing the dtbs check. Fix it.
> 
> Fixes: f86fe08ef00f ("dt-bindings: PCI: qcom: Add MSM8998 specific compatible")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 - > v2:
> 
> - Use the correct commit in fixes
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

