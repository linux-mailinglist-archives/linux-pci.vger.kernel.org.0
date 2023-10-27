Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDE7D9DB0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 17:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjJ0P6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0P6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 11:58:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38089CE
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 08:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AF1C433A9;
        Fri, 27 Oct 2023 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698422321;
        bh=ommFfLMys0Fe109bn79ZIOWeURNbAOw1MVfdRBJEY1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pXXUUeD03ocZqRLT7SUJrjtR/EL2cA4iVgaQDw5kzDqvz3hJdEVbyzhQ4kPvszR9D
         2sMOxdUeaNAWOeg6oApCjcby7XWUlApK5PMcIuDOLWtV+e3+zxhNRUpZ932htIgOyE
         EbAl5TnCK48UZm5zZ1L2+lKDKdPBJxSUP4nS1qIPGTQAmb0mel8xUHswiSIIc9eboC
         2LVPIyVIJ/L/468yGVsDH/FHnwN/6mdXRjESSEcWJ7atJAuEeRsutHEL50qw0Aa34v
         UOWdaS5CmOLQqVLGm0pgVvNErCwPWVsW1y/WSnTA73KsFoH+HldU4UFNtQWO5oTwm3
         ve9a/yu7piacA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507c91582fdso3250474e87.2;
        Fri, 27 Oct 2023 08:58:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgrybHKNQo8OgS9aHP04mJnbh3gOopeyGgFBbxDnNN1QpBkrLj
        KcsyTxDa8j94boYOkVE6SU2pAw+qKn29N8RDNg==
X-Google-Smtp-Source: AGHT+IE/pzOVERpKm6tzpSOqkVPF05dduYZOaPE/qWFhCOyim5kGpTCIUSUUjslhqayndDWjnSiWjIY0tLbrxKxgjyw=
X-Received: by 2002:a19:5211:0:b0:507:99fe:28f3 with SMTP id
 m17-20020a195211000000b0050799fe28f3mr1958607lfb.34.1698422319972; Fri, 27
 Oct 2023 08:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231027145422.40265-1-nks@flawful.org> <20231027145422.40265-2-nks@flawful.org>
In-Reply-To: <20231027145422.40265-2-nks@flawful.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Oct 2023 10:58:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
Message-ID: <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory atu reg
To:     Niklas Cassel <nks@flawful.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 9:56=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> using:
>
> allOf:
>   - $ref: /schemas/pci/snps,dw-pcie.yaml#
>
> and snps,dw-pcie.yaml does have the atu reg defined, in order to be
> able to use this reg, while still making sure 'make CHECK_DTBS=3Dy'
> pass, we need to add this reg to rockchip-dw-pcie.yaml.
>
> All compatible strings (rockchip,rk3568-pcie and rockchip,rk3588-pcie)
> should have this reg.
>
> The regs in the example are updated to actually match pcie3x2 on rk3568.

Breaking compatibility on these platforms is okay because ...?

>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml     | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
