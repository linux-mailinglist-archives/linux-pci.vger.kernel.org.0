Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA586FDB3D
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjEJKDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjEJKDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 06:03:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF965AA
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 03:03:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so13407952a12.0
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683712992; x=1686304992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0majpBkyS2aFzWG7SE7moqn6AIoCkj/rt6LzV5c31k=;
        b=wSA4cWyECI9ESBPCUpOqkJOKSNqvla+5SCFviWz/3ikVlE5zhsebW9My1UbTjEnf9c
         2+h4Pc2ICaDX2uHgyDZsj22hbDxOAJ9yRqVBZXB/wYIVxl80IurWKLjPxK0AI0DpkGqq
         NfxieBL8QIyR9M7H9tYL1+hUXDSJgZ1NyI5u2fGJCS/6+ZW1vAI7sFkmlgbzl3y1+sjQ
         sd9BobBixIp66YZ+zMAAnT9+yjI+rWIVyUoeECRYQlk0/mRAV2nuhZod0STjZkfF/DOU
         Htc5qmT2vRrDJyPKgPoOaNT8w3lEKM1KCsXi6Wfmrr6ePLGTf0aMuxR1zcFYKU8ZKY2H
         oE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683712992; x=1686304992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0majpBkyS2aFzWG7SE7moqn6AIoCkj/rt6LzV5c31k=;
        b=UGl6JsNJJpiyenB+xG1AW/tSBl1z5LyyLxi/2kbI3HeL6aSK+HFiLdeZwRxz4VK3j8
         vGVDWhucSaFNgMJ7fmOidh7DDr+3BK6qLTVLsgpn2okJQmFIS/4uf33IKNz6Vhlwcyri
         dLuswdkKWnhRWQZAwca6OGBF+oFIr3RJFaJsZYtctiuPDG0uD6Hu0ng0AMZrjrwz4IJo
         kZfS0iF8HqhF0tOHQZShjBNi2DHGjhYXUMqX7RrpRWvX8S9YIZkZ4CKq9OWX7iADLFoX
         owDrdNUF6qNxxrmbHXuDCAqOwvxRJIzeNNmuqWSPV0I/Rayl0Dt0J+/9wThhY0KEgDFZ
         dkyw==
X-Gm-Message-State: AC+VfDzRL0wqr1iSf0J8yYTPyDnA4x6ZtEXbVCD1uN+Mx8u1/Hvx7T+c
        mwkD1btmcGZLbezD0/bJ9pakGA==
X-Google-Smtp-Source: ACHHUZ5xhIQdbdlL3jEWxxbj+ODC30FCqswOBYSzRljZLIpB5LfNHpRAbEo7JOU8Etn7PS2EMENT7w==
X-Received: by 2002:a17:907:2d9f:b0:969:e55f:cca2 with SMTP id gt31-20020a1709072d9f00b00969e55fcca2mr6215038ejc.38.1683712992235;
        Wed, 10 May 2023 03:03:12 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id d1-20020a170907272100b0094bb4c75695sm2463311ejl.194.2023.05.10.03.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:03:11 -0700 (PDT)
Date:   Wed, 10 May 2023 12:03:09 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        linux-renesas-soc@vger.kernel.org, marek.vasut+renesas@gmail.com,
        bhelgaas@google.com, robh+dt@kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>, mani@kernel.org,
        jingoohan1@gmail.com, kw@linux.com, fancer.lancer@gmail.com,
        devicetree@vger.kernel.org, kishon@kernel.org
Subject: Re: [PATCH v16 18/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20230510100309.e3ggidtc35xi7jde@krzk-bin>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 May 2023 15:22:30 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 

BTW, you keep not-ccing me. Since long time. I don't understand why. I
don't have the emails in inbox, so I won't be responding to your
patchset.


My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb: pcie-ep@e65d0000: reg: [[0, 3864854528, 0, 8192], [0, 3864864768, 0, 2048], [0, 3864866816, 0, 8192], [0, 3864875008, 0, 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.example.dtb: pcie-ep@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'addr_space'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/patch/1779260

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
