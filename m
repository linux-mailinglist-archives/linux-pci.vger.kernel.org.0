Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D71612A90
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 13:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ3MXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 08:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3759EBF71;
        Sun, 30 Oct 2022 05:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60FF60EC6;
        Sun, 30 Oct 2022 12:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E3C433D6;
        Sun, 30 Oct 2022 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667132583;
        bh=PkPNPWozikAPhvR0KibrZ8002oXWFo6wATuSNybm2nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HZeJiVcZH0CSaQdE6La5tDj0iZDToDwbsg5/FykgFJALf2MUAp8m8C74zP4NwhIug
         BgTjpNkCmw7WR+IqZ6FP53b68ab468y5OM9F7trEzWtuNm3QmgYtxe5owXp5HTjctp
         wx5mRFMw8tnHaWpbclxRnOjAbNc9B75JHVHjkZvnAbohRg815haoO94O7qvCLy/P4t
         xhHoPq5Dx9WrqBqF0fciLY6OI78sN/gShOzZGecD9cFpLnXBpSmY0jDsm1cj3mRvsA
         Tzg59Nn0i1iAOH4PpRhUMO+22fAO708ZeyDxPYzYQE0WJkW6pLfaKx2fnicYd+fuQU
         lpLGOqUEPRf0g==
Date:   Sun, 30 Oct 2022 07:23:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/7] PCI/phy: Add support for PCI on sm8350 platform
Message-ID: <20221030122301.GA1022001@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 30, 2022 at 12:13:05AM +0300, Dmitry Baryshkov wrote:
> SM8350 is one of the recent Qualcomm platforms which lacks PCIe support.

I guess the "platform" (the hardware) has PCIe, but the current driver
doesn't support it?

> Use sm8450 PHY tables to add support for the PCIe hosts on Qualcomm SM8350 platform.
> 
> Note: the PCIe0 table is based on the v2.1 tables, so it might work
> incorrectly on earlier platforms.

I'm not sure what this means in terms of applying this series.  It
sounds like "this series might break earlier platforms".  That
wouldn't be good, so I assume it's more subtle than that.

I guess "v2.1 tables" refers to "PHY config tables"?  "PCIe0" appears
mostly in [6/7] as a 1-lane Gen3 host.  "v2.1" and "v2_1" don't appear
at all.  I can't quite figure out what symbols in the patches these
refer to.

Bjorn
