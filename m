Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1B77FB06
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353258AbjHQPlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353249AbjHQPlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 11:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC230C5;
        Thu, 17 Aug 2023 08:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95500632DD;
        Thu, 17 Aug 2023 15:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354CC433C8;
        Thu, 17 Aug 2023 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692286861;
        bh=18AW8aCpKWfO2c6tMGdoqGVFmQfyQI0jgGVvrDkG5kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jt176z36Jy+9PRJ4BevwMHGC4aCdaGehM1YRljgK7vDqSkB6eZ9T5CIoNCFZZaZo9
         r1hAMtJ7xbGz7P4f9dKLj6kemFSzPT5OU9vRvjoJkGAsztoV54NSUJH1icpNSh7Mv5
         oN9Zmh3cpXiGuciORDfuvUoaNarLjHdhX81VaYHbHsPQmI/D/9UrpCbEQeclcuVpty
         kbpc2KyV7QcEaZR25PJZi8agQ9yVAZ0r2ZikGPKGfO5OrvtjLt4QO4Q+Y2T3IShLfj
         mU4pfxqs+pL7uw99e2hqdh6jJlfOS+7VTSz2REZkrkJfg1/FIgv562E76ABJ4nM31L
         JV78O0LKzi/+Q==
Received: (nullmailer pid 1140695 invoked by uid 1000);
        Thu, 17 Aug 2023 15:40:57 -0000
Date:   Thu, 17 Aug 2023 10:40:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Kevin Xie <kevin.xie@starfivetech.com>,
        linux-riscv@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/11] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <169228685644.1140409.12427674208274594176.robh@kernel.org>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-10-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-10-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 14 Aug 2023 16:20:14 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe controller dt-bindings.
> JH7110 using PLDA XpressRICH PCIe host controller IP.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

