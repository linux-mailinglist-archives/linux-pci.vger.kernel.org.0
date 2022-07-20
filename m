Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63F57BF81
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiGTVU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTVU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 17:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACC4C628;
        Wed, 20 Jul 2022 14:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0AD61CBF;
        Wed, 20 Jul 2022 21:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15C6C3411E;
        Wed, 20 Jul 2022 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658352054;
        bh=u8MLHFUIO2So23r5qskAjYyALsNtdftLbn/01S2bSXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QKVbyAiIDVdd3e3prco1N9yDfKHM6RB0yprLQ2uKVelIRlDEe8kzzqWWCs9OOxj0g
         7cqHL2jMDnbMyffp3b4JHgmtMLKoOdp2Mrd8qTnI4KBMgxbVsdtzisxvHLJarwWc9W
         M9BjORrfzJ7rOVWxlZ0DfjSH5wurvO+O889LZOG6kkcfF77c8jdTo7P7lEDZ5m+SR5
         xm3c5r+lMjUCEtS3ht7oQhWcFmZQM55qQTNZ5Od7m+Z3SFGb5vnU7Ih+yvHfratT2n
         7v4BQW39Q8H2a936h/Y3AUSRrz17MZ5IVq3ytptD6y79Z47AYRZeQkSHsOiTeV67FN
         y+UnjXavtec6w==
Date:   Wed, 20 Jul 2022 16:20:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <20220720212053.GA1659584@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519094646.23009-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This no longer applies on my pci/ctrl/qcom branch:
839fbdee4c08 ("dt-bindings: PCI: qcom: Fix reset conditional")

Do you want to refresh it, or should we wait until the next cycle?

Bjorn
