Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB47E5BD31F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiISREx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiISREe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C340E18;
        Mon, 19 Sep 2022 10:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F625B81E85;
        Mon, 19 Sep 2022 17:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33278C433D6;
        Mon, 19 Sep 2022 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663606975;
        bh=X4h9HckllndXS+TNcSz6L4GDhtvtdBz4D8Y07rreB3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kEHd9cE/KYe6tru3Ista5AFLiDJ5X39rzR3J7TjYfPmCCROsgrWkPSwzquxzD5P/p
         XUsy59b/I6/KWxa000yEY9oC7baf3HYflwKSR2+fX91VoI0lyRDidwMghItFyRRiW0
         U2vtNNQcRUNNjVL6nGD8a2v/T5xS0tTVmwzj2G/YcZva5sXPbFeBSpv/lp6O3fgWEf
         aDHa8pRSy7yMfM+10RVhB9/UBnPmVqdFlzEiMWfPnRkeIRmzglFlrwJ2cAGViFU6Uq
         Llc0f2Yy1wj6BSV5pdPnYTOYePBHF17bjLjWq2H/dOuWMFkP9aNDnwr0YlnBkU2+TA
         9jw5Brdz3dUww==
Date:   Mon, 19 Sep 2022 12:02:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com, imx@lists.linux.dev,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v11 5/6] PCI: endpoint: cleanup pci-epf-vntb.c
Message-ID: <20220919170253.GA1011825@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919154038.187168-6-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject (I mentioned this last time, too):

  PCI: endpoint: pci-epf-vntb: Clean up

On Mon, Sep 19, 2022 at 10:40:37AM -0500, Frank Li wrote:
> Remove unused field: epf_db_phy.
> Remove __iomem before epf_db.
> Change epf_db to u32* from void *
> Remove dupicate check if (readl(ntb->epf_db + i * 4)).

s/dupicate/duplicate/

> Using sizeof(u32) instead of number 4 at all place.
> 
> Clean up sparse build warning
>   Using  epf_db[i] instead of readl() because epf_db is located in local memory
>   and allocated by dma_alloc_coherent()

Is "Using epf_db[i] ..." an sparse warning?  The indentation suggests
that it is, but it doesn't seem related.

> Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle path
> to match pci_epf_alloc_space().
> 
> Cleanup warning found by scripts/kernel-doc
> Fix indentation of the struct epf_ntb_ctrl
> Consildate term

s/Consildate/Consolidate/

>   host, host1 to HOST
>   vhost, vHost, Vhost, VHOST2 to VHOST
