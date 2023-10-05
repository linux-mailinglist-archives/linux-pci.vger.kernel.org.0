Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC77BA598
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbjJEQSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbjJEQQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:16:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24023C3F;
        Thu,  5 Oct 2023 08:09:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB8C433C8;
        Thu,  5 Oct 2023 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696518566;
        bh=iNyEx2zeDMXkeQyU4awTbQcL0VPkyps5O1RkC0hGxbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZiJ+wlMd1w869Ss57XCSrFiDzl4klzzAILM6NCGcP2K14xdV8sAtdXMhWDBw8F3l2
         Nlf8zz08KWaS8girGZi8Bb1cysX2NT6d+b7hRh1VtxMzWcds4BKjn2JfQhoGgClYic
         euI0FcofZ3IvtAtH5MIaFtwbDd0SGUsqTyJkpTEGLDqnGY+rwcdYXLfk85hOV4sJl4
         pMzJ3+tR0Pa5urbend+pcDbtoZg9sPWWnQd7TmbJA6ot3pCrdrRXYPp1XGu5mv8QoB
         zc0GcsoiYqeCoViEJSFEaRhnj2DeYv/DCwqwNUwwlZmsP2KPr0VYP91TXLCYrds3lR
         TX0b4n3q/sfiQ==
Date:   Thu, 5 Oct 2023 10:09:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v23 14/16] PCI: dwc: rcar-gen4: Add endpoint mode support
Message-ID: <20231005150924.GA746687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926122431.3974714-15-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 09:24:29PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe controller for endpoint mode. This controller is based
> on Synopsys DesignWare PCIe.

> +/* Endpoind mode */

Endpoint

Bjorn
