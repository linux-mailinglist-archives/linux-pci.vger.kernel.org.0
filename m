Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C17D7713
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJYVvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYVvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 17:51:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37456A3;
        Wed, 25 Oct 2023 14:51:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F3C433C7;
        Wed, 25 Oct 2023 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698270678;
        bh=PjnBP9jEL2AWQ7PbVvmJXlUUowLNSpEaOjN6Erdxx7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FH+c+m7NzeG/KQdNL0oyOj3P67+XqkQYe2XINJfANb1L6Wes0YQDDBHBr5QRIYFDH
         SUFy3znctK02yBQVQmZjbAyhh/kkcO86o3Ff7qa3CXvSjrt3O050Y9Z87fAGnCn8oQ
         BoJEgM/lYyWvAFMCz7vcuZHZoUQD53EIKW76vf3PUrXaZkAKcYnlUqraudTMPoQUyp
         40fcVkjYc5eUZoHUUVs+djiljw0atPNJa9QMHinzvUD2tvRbLW6Wf8gyoJqbWPD5+y
         5AYZOZQC6IQixB+sjP59SFTJyTJa7VWuZ3XdBVAToHZj20q/LtRfUFcWpHmWYAzpi2
         bHll+1Euz7XNw==
Date:   Wed, 25 Oct 2023 16:51:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sharath.kumar.d.m@intel.com, Joyce Ooi <joyce.ooi@intel.com>
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v4 0/2] PCI: altera: add support to agilex family
Message-ID: <20231025215116.GA1768116@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917170546.2097352-1-sharath.kumar.d.m@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Joyce, Altera PCIe maintainer]

On Sun, Sep 17, 2023 at 10:35:44PM +0530, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
> 
> added new callback for
> 1) read,write to root port configuration registers
> 2) read,write to endpoint configuration registers
> 3) root port interrupt handler
> 
> agilex and newer platforms need to implemant the callback and generic root
> port driver should work ( without much changes ) , legacy platforms (arria
>  and startix) implement configuration read,write directly in wrapper
> api _altera_pcie_cfg_read/_altera_pcie_cfg_write

Do these patches make the driver work on some new platform?  Has it
been tested?  Please include the name of the new platform.

Saying this "... driver should work (without much changes)" does not
sound like anything has actually been tested on hardware.

> changelog v2:
> saperated into two patches
> 1.refactored the driver for easily portability to future Altera FPGA
> platforms
> 2.added support for "Agilex" FPGA
> 
> this driver supports PCI RP IP on Agilex FPGA, as these are FPGA its up
> to the user to add PCI RP or not ( as per his needs). we are not adding
> the device tree as part of this commit. we are expecting the add device
> tree changes only if he is adding PCI RP IP in his design

Please cc: Joyce on any future postings, since she's listed as the
maintainer for pcie-altera.c.

Joyce, please comment on these.  We don't like to merge things
affecting your file unless you approve.

> changelog v3:
> incorporate review comments from Bjorn Helgaas
> 
> changelog v4:
> added below callback for root bus
> alt_read/write_own_cfg
> added below callback for non-root buses
> alt_read/write_other_cfg
> 
> D M Sharath Kumar (2):
>   PCI: altera: refactor driver for supporting new platform
>   PCI: altera: add support for agilex family fpga
> 
>  drivers/pci/controller/pcie-altera.c | 313 ++++++++++++++++++++++++---
>  1 file changed, 280 insertions(+), 33 deletions(-)
> 
> -- 
> 2.34.1
> 
