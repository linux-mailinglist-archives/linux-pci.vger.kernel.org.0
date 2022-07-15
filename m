Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098F5766B5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGOS1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOS1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 14:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CE67CA2;
        Fri, 15 Jul 2022 11:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A5C6232B;
        Fri, 15 Jul 2022 18:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F95C34115;
        Fri, 15 Jul 2022 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657909638;
        bh=GLrIOUKfTCEiitR+k/dayuHMYy8E4I2pvFk24p8afZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jfZGg70EGZ58zaDDn8ZKKNJ8DPyDu0cAcpK/AV7rGjYSqpmQotBcWt0MgwPOkhep0
         pAYxNSAtmitca9ADEZoaQJ0IJD3UrZ5iPwUfV3JOSWUl6i/cvE261pirar6sgIjY1t
         iT6n2bxgn81JNrPKzAMPg+MHWDVbgmtelLQe0pycRpH5zQn7IIDq3h86fb0WmjpmBD
         uNK96PLwO+cq3NzoacPSPLbZbf2ajetQ8iela16p3uWFLra+7JAGgnmpp5f2S+wPt6
         CKIJ9hC+1Sq0bRYCkqw8svNte0bM0tC948wdr87usqzTnRIYj49UFYk+ajYRDOvMhp
         MaglZ3Q/Xe+ZQ==
Date:   Fri, 15 Jul 2022 13:27:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220715182715.GA1145359@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701162726.31346-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:27:21PM -0400, Jim Quinlan wrote:
> A submission [1] was made to enable a PCIe root port to turn on regulators
> for downstream devices.  It was accepted.  Months later, a regression was
> discovered on an RPi CM4 [2].  The patchset was reverted [3] as the fix
> came too late in the release cycle.  The regression in question is
> triggered only when the PCIe RC DT node has no root port subnode, which is
> a perfectly reasonsable configuration.
> ...

> Jim Quinlan (4):
>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
>   PCI: brcmstb: Add mechanism to turn on subdev regulators
>   PCI: brcmstb: oAdd control of subdevice voltage regulators
>   PCI: brcmstb: Do not turn off WOL regulators on suspend
> 
>  drivers/pci/controller/pcie-brcmstb.c | 257 +++++++++++++++++++++++---
>  1 file changed, 227 insertions(+), 30 deletions(-)

I'm assuming there's a v2 coming soonish?  We should see -rc7 this
weekend and likely a final v5.19 release on July 24, so v5.20 material
should be tidied up by then.

Bjorn
