Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE77CE2A5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjJRQXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRQXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:23:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1798;
        Wed, 18 Oct 2023 09:23:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBC4C433C7;
        Wed, 18 Oct 2023 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697646212;
        bh=EU9od74l7DczH5yRKH/azRD3pECNA7YaypodW+1xz+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=duKsn24TPHawugE8wRyIQxNsZfEzs+EPZd51XKtAYOKrx0kZToSxvafLOXEYWsW6x
         +c9FmuxdeePzGYaxUQTEOzYW9KpVZ0dJiJ7lnoqydkhixwZLcAvhXC6ztXfR2RLnT7
         gnB7C2r+iPFt0d4VuvSTLMQ/Gy0R532dOjJP02lHYHfhaORL7qVX8NzKlSNNmI6K/H
         D7SeRKbWHfcUcwRaV1m7SMEt4IFx2FN0toIMghEZuHo4iltM5jLGimkTwDwhWdupNe
         7f+ZULnhF97X1/uFvhE5Pk1myrBw3vQoS2jbfgvUypYF/FAnyqiK2X4psIDo1gTa/g
         wpsCeBXqDn6vw==
Date:   Wed, 18 Oct 2023 11:23:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI: Use FIELD_GET/PREP() & other reg field cleanups
Message-ID: <20231018162328.GA1363813@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 02:32:47PM +0300, Ilpo Järvinen wrote:
> Hi,
> 
> Here's what I think should cover most of the remaining FIELD_GET/PREP()
> conversions under drivers/pci/.
> 
> The patch from Bjorn is from
>   https://lore.kernel.org/linux-pci/20231010204436.1000644-7-helgaas@kernel.org/
> But has been adjusted to better blend in with the other DPC changes.
> I've preserved Bjorn as the main From/SoB, and added myself before his
> name instead (since I modified it but my main contribution was to
> remove stuff he had made to it).
> 
> Bjorn Helgaas (1):
>   PCI/DPC: Use FIELD_GET()
> 
> Ilpo Järvinen (6):
>   PCI: cadence: Use FIELD_GET()
>   PCI: dwc: Use FIELD_GET/PREP()
>   PCI: hotplug: Use FIELD_GET/PREP()
>   PCI/DPC: Use defined fields with DPC_CTL register
>   PCI/DPC: Use defines with DPC reason fields
>   PCI/MSI: Use FIELD_GET/PREP()
> 
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  9 ++--
>  .../pci/controller/dwc/pcie-designware-ep.c   |  7 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  5 +--
>  drivers/pci/hotplug/pciehp_core.c             |  3 +-
>  drivers/pci/hotplug/pciehp_hpc.c              |  5 ++-
>  drivers/pci/hotplug/pnv_php.c                 |  3 +-
>  drivers/pci/msi/msi.c                         | 10 +++--
>  drivers/pci/pcie/dpc.c                        | 42 ++++++++++++-------
>  drivers/pci/quirks.c                          |  2 +-
>  include/uapi/linux/pci_regs.h                 |  9 ++++
>  10 files changed, 61 insertions(+), 34 deletions(-)

Applied to pci/field-get for v6.7, thanks, Ilpo!
