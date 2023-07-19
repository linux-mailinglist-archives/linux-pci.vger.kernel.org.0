Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E277598E7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGSO52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGSO51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 10:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED1C7;
        Wed, 19 Jul 2023 07:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC0761722;
        Wed, 19 Jul 2023 14:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E58C433C7;
        Wed, 19 Jul 2023 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689778645;
        bh=ioxh6o118q6+dHWAukEdaC/0qLhTOk/cq+k9l/QZjHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uJFJ+VCsuyrn1Svp5t1Yx2Zm9gBP1Mm9qqO4AEmXa7WFYgjyBaS4owi8p88sBr0Qo
         6hnApno9OOFsXr7LJ+0VlGFYrVHcZFFikRVi3mB/gIqeXMeXdxYsnfZoQSm6NK1nsi
         QoVbZ6Osihgz5Tq3aw56aDkfXswV5kH2dl7PsJQgekkqs+J6Re790NPUAGLUHGX5eL
         7q4GWrpv6+9lNOI6rJOnJgxVBOmDRU4dkaF3MlRhMvthq9exuZLcTWiqaP3uZJu/DN
         9W3lr5d9TYHoEy9uIEoXTFNNDdBdwQTeKAtL/DJJRGM74WQv/wsKKRdTbIR+BnuXCf
         kYlGS4SRINgYg==
Date:   Wed, 19 Jul 2023 09:57:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230719145722.GA501156@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a9ab32-c030-1906-7e7d-c529e6c9c70d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 04:31:13PM +0530, Vidya Sagar wrote:
> On 7/18/2023 4:39 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 18, 2023 at 08:03:47AM +0530, Vidya Sagar wrote:
> > > On 7/14/2023 3:09 AM, Bjorn Helgaas wrote:
> > > > On Mon, Jun 19, 2023 at 03:56:04PM +0530, Vidya Sagar wrote:
> > > > > This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> > > > > support for 256 Byte payload").
> > > > > 
> > > > > Consider a PCIe hierarchy with a PCIe switch and a device connected
> > > > > downstream of the switch that has support for MPS which is the minimum in
> > > > > the hierarchy, and root port programmed with an MPS in its DevCtl register
> > > > > that is greater than the minimum. In this scenario, the default bus
> > > > > configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
> > > > > MPS settings in the hierarchy correctly resulting in the device with
> > > > > support for minimum MPS in the hierarchy receiving the TLPs of size more
> > > > > than that. Although this can be addressed by appending "pci=pcie_bus_safe"
> > > > > to the kernel command line, it doesn't seem to be a good idea to always
> > > > > have this commandline argument even for the basic functionality to work.
> > > > 
> > > > I think this has some irrelevant detail (IIUC the problem should
> > > > happen even without a switch) and could be more specific (I think the
> > > > problem case is RP MPS=256, EP only supports MPS=128).
> > > 
> > > The issue is present only if there is a switch.
> > 
> > So if there's no switch, and an EP that only supports MPS=128, the PCI
> > core changes the RP MPS setting to 128?  Just based on reading the
>
> Yes. The code after the if condition here takes care of that.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?h=v6.5-rc2#n2049

Oh, right, thanks.  I vaguely remember the logic that if the immediate
parent is a Root Port, there are no other branches in the hierarchy to
worry about, so we can just configure the Root Port MPS to match the
device.

> > code, I thought we would leave RP MPS=256 and EP MPS=128, which would
> > be a problem.  But maybe the PCI core changes the RP down to MPS=128?
> > 
> > Bjorn
