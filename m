Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C557390CB
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjFUU3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUU3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 16:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35FA1;
        Wed, 21 Jun 2023 13:29:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E1F616A1;
        Wed, 21 Jun 2023 20:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2579EC433C8;
        Wed, 21 Jun 2023 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687379353;
        bh=L+rO1CMYqXKXf6AoAVFANg2xBTRriB5N07RJDG1s6Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PYdpokDmsLXR3gMVTD3O3cev7KqBdfi56w1P8y6fh83Yw57XZNnH50InYGQbfztrw
         rgkm4PC0Pzi+XMMSyPsVKSb9CpOGfnCOIMrl+5Vra8EgCvi3IBE64t2GKS0ZFSWzBu
         FUw2LgPaCO/epg1++kiwPvkfHN1toFUNkcPZ7b1gzmhcdz0uO18scCRfSSFdfIC3jJ
         LjvV41xx5PoD2yz5TJSe3YBhAXKo0gwh+QYp1RCsZ24u8ibuh8h0KSJ0NAoeXm6D6i
         JderUS+0Qrdyjjm9wAQQeXi6xfA5b4oOm3zIvoBocHMWgsGoUdRZRQLeU4rMEItH8M
         NnG855wdACLTQ==
Date:   Wed, 21 Jun 2023 15:29:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 0/6] Generate device tree node for pci devices
Message-ID: <20230621202911.GA116530@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620220818.GA418170-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 04:08:18PM -0600, Rob Herring wrote:
> On Thu, Jun 15, 2023 at 09:50:36AM -0700, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven method
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. Second, it allows reuse of a OF
> > compatible driver -- often used in SoC platforms -- in a PCI host based
> > system.

> >  drivers/of/dynamic.c                          | 164 ++++++++++++++
> >  drivers/of/overlay.c                          |  42 +++-
> >  drivers/of/unittest-data/Makefile             |   3 +-
> >  .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
> >  drivers/of/unittest.c                         | 210 +++++++++++++++++-
> >  drivers/pci/Kconfig                           |  12 +
> >  drivers/pci/Makefile                          |   1 +
> >  drivers/pci/bus.c                             |   2 +
> >  drivers/pci/of.c                              |  81 ++++++-
> >  drivers/pci/of_property.c                     | 190 ++++++++++++++++
> >  drivers/pci/pci.h                             |  19 ++
> >  drivers/pci/quirks.c                          |  12 +
> >  drivers/pci/remove.c                          |   1 +
> >  include/linux/of.h                            |  25 ++-
> >  14 files changed, 768 insertions(+), 16 deletions(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
> >  create mode 100644 drivers/pci/of_property.c
> 
> Bjorn, I think this is pretty close to being in shape for merging. Do 
> you have any comments on the PCI bits? Would you prefer that I ack the 
> DT bit and you take it or vice-versa?

I acked the PCI bits (modulo some trivial comments), and this seems
more DTish than PCIish, so happy if you would take them.

Bjorn
