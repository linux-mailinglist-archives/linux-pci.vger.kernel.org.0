Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47DF570AFB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGKTx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGKTx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3F62CB
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 12:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F896159D
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 19:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524FEC341C0;
        Mon, 11 Jul 2022 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657569235;
        bh=/UjzOInfMIVKs+2LvVnPCc91FNgWO9fb4Oz3CNEaYZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hW0dxSpSfLkmfRoZqZkoZbXOW52KGQ2BSh5nCspVUJE0m41kRb+mjcYovHchkmvGu
         o/8JlFMNjaUmGO+Dy7mqI8Ek3vSGwP6OTnq5ZoGVnWZyyjMwyHBR2eUpBm3OZvfxEA
         JNKRjpbV7Em3XOZaLeAfziuMIPf6fSLuk94bzJF39FrE575ZG2NQCQOqlYk4u6n1Kh
         t/dy2i/3dqp84MO2WrRhbAgnlotPi77VCzv6pFrfegifrFAF0mLoj/IIkYELHuXVQ1
         cyff+VLJqIwPuvh2L8yHDZnZBqquK7pWPXgS66Z1R0G0rAwYoewATritM3/sn1a8JB
         R9bO84qNsBu8w==
Date:   Mon, 11 Jul 2022 14:53:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v4 0/3] Fully enable AER
Message-ID: <20220711195353.GA683105@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125071820.2247260-1-sr@denx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 25, 2022 at 08:18:17AM +0100, Stefan Roese wrote:
> While working on AER support on a ZynqMP based system, which has some
> PCIe Device connected via a PCIe switch, problems with AER enabling in
> the Device Control registers of all PCIe devices but the Root Port. In
> fact, only the Root Port has AER enabled right now. This patch set now
> fixes this problem by first fixing the AER enabing in the
> interconnected PCIe switches between the Root Port and the PCIe
> devices and in a 2nd patch, also enabling AER in the PCIe Endpoints.
> 
> Please note that these changes are quite invasive, as with these
> patches applied, AER now will be enabled in the Device Control
> registers of all available PCIe Endpoints, which currently is not the
> case.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>
> 
> Stefan Roese (3):
>   PCI/AER: Call pcie_set_ecrc_checking() for each PCIe device
>   PCI/portdrv: Don't disable AER reporting in
>     get_port_device_capability()
>   PCI/AER: Enable AER on all PCIe devices supporting it
> 
>  drivers/pci/pcie/aer.c          | 10 +++++++---
>  drivers/pci/pcie/portdrv_core.c |  9 +--------
>  2 files changed, 8 insertions(+), 11 deletions(-)

Applied to pci/err for v5.20, thanks and sorry for the delay.
