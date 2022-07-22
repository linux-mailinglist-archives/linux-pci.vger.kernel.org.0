Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3357E74F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiGVTYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 15:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVTYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 15:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34161105;
        Fri, 22 Jul 2022 12:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1122A617B1;
        Fri, 22 Jul 2022 19:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42397C341C6;
        Fri, 22 Jul 2022 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658517873;
        bh=v9iFrD/QGUF5GFfCZcVltWib9BENP1EbeimH9tpGgd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lN3rWplUaT+yeB0zqHvh4zAjKVtmtuPF00xF+9Mj5RpwEL4b4sk7gZKy9qBsdQRW6
         a2dvia0tswCPd8RxhzeE78mj0FZlWAQtw8+XOnLI1VcR3rNYBo9SSHxzCkamSlR2Q8
         llSLWlBEgv9QSdx93+RKKQoJlhtRoVWsKp44hQMVO99gYmNQWlxfQ5jX1OhhZeFz6F
         k761INM3sgEXrwSHM1NLKXTyYnc25PPY6GA97bDBfz4PFxkgDIjPw+Yjfnm5vkvGkC
         Suu9tB4VvSUKTCV6aFj9XMexaBzKGAPXdZSgxKFTP/F7ceX2MClL9SVNYY0EroGYpF
         V1MShkjfCee6g==
Date:   Fri, 22 Jul 2022 14:24:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Message-ID: <20220722192431.GA1923712@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 04:26:44PM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
> 
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additional register bit
>   to enable and handle legacy interrupts.
> 
> Changes in v6:
> - Added of_device_get_match_data to identify CPM version.
> - Used enum values to differentiate CPM version.
> 
> Bharat Kumar Gogada (2):
>   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
>   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
> 
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++-
>  drivers/pci/controller/pcie-xilinx-cpm.c      | 64 ++++++++++++++++++-
>  2 files changed, 98 insertions(+), 4 deletions(-)

Applied to pci/ctrl/xilinx-cpm for v5.20, thanks!

I tweaked the driver patch to test:

  if (port->variant->version == CPM5)

instead of just:

  if (port->variant->version)

so it doesn't depend on the enum values.
