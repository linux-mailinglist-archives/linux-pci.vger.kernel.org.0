Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9D773E02
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjHHQZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjHHQX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602EA5EF;
        Tue,  8 Aug 2023 08:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFC5625D3;
        Tue,  8 Aug 2023 15:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739F2C433C8;
        Tue,  8 Aug 2023 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691509781;
        bh=PUAWonAUPbtW2YJxANM18kHRL54qijZd61xXDG7EdtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Co+Az8nrKuQemD9Hz1qRzv4qPtBes76iELh6VLqx6l/qlo5Dwv/Xtch1YbXDDR7G7
         xf6Nfye0WYpGVEKA1iDIVOMaloU7LBFqjzfoGIrNU2DL/evE3KDs/Nj4ULTtAwdwf3
         kHjm5TTuzx7+/piJij9Y+gpYaOuWKUOE07l2rpLPWriQeJSCTJ8TYagvSTw6YGprWH
         12tjXJV3bj/cmdeHDDsVk7WAQxuMNIW+nNqvkqKyr998HwSPUDP/AxyDSSpavuM+CX
         xxQ7hTl6nrRM/4/Uc9F+WDwPi7zfE/nQOdFewyMB9fGVyiv5Xcsm2dPQdDH1e9hRgt
         krg455JAeafCw==
Date:   Tue, 8 Aug 2023 10:49:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, bharat.kumar.gogada@amd.com,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: xilinx-nwl: Increase ECAM size to
 accommodate 256 buses.
Message-ID: <20230808154939.GA313654@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808103733.93707-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 04:07:33PM +0530, Thippeswamy Havalige wrote:
> Our controller is expecting ECAM size to be programmed by software. By
> programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
> ECAM region which is used to detect 16 buses, so by updating
> "NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
> ECAM region to detect 256 buses.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>

1) I'm still concerned that this adds a revlock with the corresponding
DT change.  Is that acceptable?  Should it be mentioned in the commit
log?

2) Lorenzo or Krzysztof, if/when you apply this, please drop the
period at the end of the subject line.  I've mentioned it several
times to no avail.

> ---
> changes in v2:
> - Update this changes in a seperate patch.
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index a73554e..b515019 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -126,7 +126,7 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_VALUE_DEFAULT		16
>  
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
