Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0B636C1C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiKWVJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiKWVJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:09:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0731213;
        Wed, 23 Nov 2022 13:09:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92569B82479;
        Wed, 23 Nov 2022 21:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958DAC433D6;
        Wed, 23 Nov 2022 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669237751;
        bh=pl7Qiqa3fxBm6Q+/LK3Xnpo0DhZBZ76AOO6EJVopoXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjAogGXCl7hgXsWnZY97PqUFczkd2/EWuPp0xSd1ogZ48HbJBUcOSyjmatPjRCiMl
         u2QsbsBpsWUo6FQS9jNnS0nJymO/UZrePE1U2X8x4HFo7y7r0KdHaYV8vxSclEMlIo
         JDus8bYmd7liwPTBszcu1C63JWbpKh763yXht1CoJ+s6qKUDjl44O3kUwvcnqagjxg
         2nnjeO0bbwI9BJIZSYz1FyEsr5zxEDgC8iGim+il1kODAwo3v2vidw0dW5DYylspKB
         Vu0Mb0+VjJ67b4V+vIFTN+4ORdHKhvZdnV40/Wl0SBPwtbxGJ8Q6Apk5heAnv38klx
         1T6kT9u0u7kLQ==
Date:   Wed, 23 Nov 2022 21:09:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/9] PCI: microchip: Align register, offset, and mask
 names with hw docs
Message-ID: <Y36L8nnZw46mm8x/@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-2-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-2-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:54:56PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Minor re-organisation so that macros representing registers ascend in
> numerical order and use the same names as their hardware documentation.
> Removed registers not used by the driver.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 122 +++++++++----------
>  1 file changed, 60 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 0ebf7015e9af..80e7554722ca 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c

> @@ -137,7 +78,8 @@
>  #define ISTATUS_LOCAL				0x184
>  #define IMASK_HOST				0x188
>  #define ISTATUS_HOST				0x18c
> -#define MSI_ADDR				0x190
> +#define IMSI_ADDR				0x190
> +#define  MSI_ADDR				0x190

Trivial, trivial comment - I think it would look more intentional as:
#define  MSI_ADDR				IMSI_ADDR

Otherwise this seems grand to me, modulo the SoB issue.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

