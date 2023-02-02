Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD9688125
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjBBPHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 10:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjBBPHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 10:07:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A181BBA1;
        Thu,  2 Feb 2023 07:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB5061B98;
        Thu,  2 Feb 2023 15:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89629C4339B;
        Thu,  2 Feb 2023 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675350433;
        bh=/Az06wtw401fFjXXuAAlXfabiERrRwrN3jkAjpAhBEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRdITdtkOlRaonzpSjGjGAJhXf+SHJAOOjSHoHQyncahcaFNvzfco5VaMgkJJJrmD
         IwZdUEPAzPOh+AkBwEEHgU41nObP8OnLq7zpHCTzaRjxWAIYJwFRmQWcmkns6dnANR
         W8QJ2Q9Qqec/H4P2sj3cLw3oXtFq8vKU68Zte25wlh9Ve2LjaXHr4AG6apODOq5jMv
         lsGW51FCNqUel7KLPVlkBrXbkzghGKMoOWzfewxXkGoT8ufKUfjtWWbOhESIv8cCNh
         pK0PbeW87QW8xCVLJtlGJbkC7+IimIwihcALAGlz10tOX6s2qhIbjUAFsMISQudLEX
         xs+PYoP7LM0Lg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     rafael@kernel.org, robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@intel.com, hch@infradead.org,
        nirmal.patel@linux.intel.com, kw@linux.com, me@adhityamohan.in,
        "David E. Box" <david.e.box@linux.intel.com>,
        jonathan.derrick@linux.dev,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 0/4] Enable PCIe ASPM and LTR on select hardware
Date:   Thu,  2 Feb 2023 16:07:07 +0100
Message-Id: <167535021818.878843.16607825325351434821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120031522.2304439-1-david.e.box@linux.intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Jan 2023 19:15:18 -0800, David E. Box wrote:
> This series adds a work around for enabling PCIe ASPM and for setting PCIe
> LTR values on VMD reserved root ports on select platforms. While
> configuration of these capabilities is usually done by BIOS, on these
> platforms these capabilities will not be configured because the ports are
> not visible to BIOS. This was part of an initial design that expected the
> driver to completely handle the ports, including power management. However
> on Linux those ports are still managed by the PCIe core, which has the
> expectation that they adhere to device standards including BIOS
> configuration, leading to this problem.
> 
> [...]

Applied to pci/controller/vmd, thanks!

[1/4] PCI/ASPM: Add pci_enable_link_state()
      https://git.kernel.org/pci/pci/c/de82f60f9c86
[2/4] PCI: vmd: Use PCI_VDEVICE in device list
      https://git.kernel.org/pci/pci/c/cca0dfecdba3
[3/4] PCI: vmd: Create feature grouping for client products
      https://git.kernel.org/pci/pci/c/14d2079af648
[4/4] PCI: vmd: Add quirk to configure PCIe ASPM and LTR
      https://git.kernel.org/pci/pci/c/f492edb40b54

Thanks,
Lorenzo
