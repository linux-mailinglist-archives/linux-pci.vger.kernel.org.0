Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C854CD0A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiFOPby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354552AbiFOPb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 11:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F62632;
        Wed, 15 Jun 2022 08:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04405616B5;
        Wed, 15 Jun 2022 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20695C34115;
        Wed, 15 Jun 2022 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655307081;
        bh=r+yRrxHClzv1P38azR8w13O3Oa7kVO4IL+igkr/tjqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NsRoNoq8fE3qubujywO1GcEOTOQeZqx6h1IKN9ZdyW1BfyjX8+3S9GHfirXsE52Zk
         poqn+5/PPTm0kG4HgW0EbqyJssvgQUfkjUdfoVoQYmO5jrET8HQHq20D9vqx404hZs
         eyztWGEjNJ7EZYyLa2Dr3JY2xNe1O3Zaw5UbDHAzEczTRMa1u1rUiqDCySwh4Ow6tL
         RcQy/emi+IQy9h2d5B4kZD2vGXPxcfGbmQBtwvgN1p86y4nd1ZYkhVSMVrnIuvjvqv
         nRFYEy2X4GTfz0CI0GmNS8PPBycVtoYixfiKfThx8DlVuim19gfzF6lmKFZWZkPPiN
         xbw7eQaRXz9Pw==
Date:   Wed, 15 Jun 2022 10:31:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v10 1/3] dt-bindings: PCI: Add support for Airoha
 EN7532
Message-ID: <20220615153119.GA940910@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615125335.96089-1-nbd@nbd.name>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 02:53:33PM +0200, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> EN7532 is an ARM based platform SoC integrating the same PCIe IP as
> MT7622, add a binding for it.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Applied patches 1 & 2 to pci/ctrl/mediatek for v5.20, thanks!

I assume patch 3 for:

  arch/arm/boot/dts/en7523-evb.dts
  arch/arm/boot/dts/en7523.dtsi

needs to go through an ARM tree, right?

> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 57ae73462272..684227522267 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -7,6 +7,7 @@ Required properties:
>  	"mediatek,mt7622-pcie"
>  	"mediatek,mt7623-pcie"
>  	"mediatek,mt7629-pcie"
> +	"airoha,en7523-pcie"
>  - device_type: Must be "pci"
>  - reg: Base addresses and lengths of the root ports.
>  - reg-names: Names of the above areas to use during resource lookup.
> -- 
> 2.36.1
> 
