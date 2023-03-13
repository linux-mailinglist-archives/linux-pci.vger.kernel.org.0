Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B06B81B2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 20:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCMTWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCMTWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 15:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0917A92A;
        Mon, 13 Mar 2023 12:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0E761485;
        Mon, 13 Mar 2023 19:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03846C433D2;
        Mon, 13 Mar 2023 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678735354;
        bh=xloF61o2oaP2wxsxK/UCLpA1px478uUYtlJUSP3p3wI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mOms/h7OJaE/+Fnx3Qdk2zFHKdn1Wpj70Ile+RaZ1l8OQEG6xYteoTLDyBFeC3wS/
         GEKSFXitecos6JJZaennsicCa6wiyt24VVm+qf4zBcbhyw4IfzXoYM7q7uWMShrQDa
         gbYOmpealLRevVsEXROYRuuVVOAcFqTELeQWiOzRdgwxVEDM0sKNOocZlyzxOZ5t5p
         EVA5Q3HsVM+IPoDj3uU8qDseMGkHHHZc7/xrLGlg5SnvV59Oh/mxGQd6dbVcYKt6I9
         Ykzs9EchN8LEQIN3tO9xzw7+SzzpaBJbwKp5kRMoEvfWdzlnFL7dHIbwcbcE7tADhb
         HQOjZL3AlCzXg==
Date:   Mon, 13 Mar 2023 14:22:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] PCI: dwc: Add support for Marvell AC5 SoC
Message-ID: <20230313192232.GA1528301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-1-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:08PM +0200, Elad Nachman wrote:
> ...
> Elad Nachman (5):
>   dt-bindings: PCI: dwc: Add dma-ranges, region mask
>   PCI: armada8k: support AC5 INTx PCIe interrupts
>   PCI: armada8k: support reg regions according to DT.
>   PCI: dwc: Introduce configurable DMA mask
>   PCI: dwc: Introduce region limit from DT

If you repost for any reason, please capitalize consistently ("Support
..." (twice)) and drop the period at end of subject to avoid
unnecessary line wrapping.
