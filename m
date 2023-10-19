Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D557CEE55
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJSDKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjJSDKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 23:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC1109;
        Wed, 18 Oct 2023 20:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE343C433C8;
        Thu, 19 Oct 2023 03:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697685045;
        bh=U0+ivHJ2WS4HBD8gV/eAfFBE2jB5E3jN09d0Z0lakMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kLlhSJG+jBc5Jbr/diXdt08iKb3O8zW/SnBVtwV6TgQ59f97A7AxJw5WYFtPCK5Vt
         4nFYmL0RbVzAFMlOulnbYHFq53iQuw2GSJEp3kBwJuITh5KBhi3+Rt17AEvBRUyCTJ
         0EPTqhNjY8ljKiFp2rGjl6oieHi+eNc2pOYbLD/q2jj+5SsfsyNdtoXQTGpff+f2tx
         IMhb46+wU/1H8FOyQ7FNnViE3mVWce0f696vQxp2JVfj/8V5afDrt4IS7AMESgbF2W
         qZfq5b+LKlRb0cbuVRQCsx06BQxiK+e18d2LWcawtjvBBVYonTJYf08eh1c5M2sL0V
         DfLcz9rUQ2CNA==
Date:   Wed, 18 Oct 2023 22:10:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v25 00/15] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 support
Message-ID: <20231019031042.GA1385745@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018085631.1121289-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 05:56:16PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint modes.
> To support them, modify PCIe DesignWare common codes.
> 
> Changes from v24:
> https://lore.kernel.org/linux-pci/20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com/
>  - Based on the latest pci.git / next branch.
>  - Reordering the patches. (This is suggested by Bjorn.)
>  - Drop "PCI: dwc: Disable two BARs to avoid unnecessary memory assignment"
>    because break other platforms.

Does R-Car Gen4 still work without this patch?

The previous commit log said host mode didn't work:

  PCI: dwc: Disable two BARs to avoid unnecessary memory assignment

  According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
  Rev.5.20a, we should disable two BARs to avoid unnecessary memory
  assignment during device enumeration. Otherwise, Renesas R-Car Gen4
  PCIe controllers cannot work correctly in host mode.

(from
https://lore.kernel.org/r/20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com)

I don't think we want to merge the driver unless it actually works.

Bjorn
