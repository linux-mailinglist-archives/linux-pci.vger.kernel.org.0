Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9E7CE9B3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRVGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjJRVGA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 17:06:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D026B9;
        Wed, 18 Oct 2023 14:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC6FC433C8;
        Wed, 18 Oct 2023 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697662814;
        bh=+oTS7I7JNI/J+BTOhgsPn3eiiZsLYX0DDk0p+Z+nkIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=twja5MihZhvKa4MTYlWZKHIUiXXeRMPTGvbNT6sC1ZKwv6fz+/BbsW/hhikmCDb/d
         8L97wx09Tkmxh3rcM/sBj1CyNswnnqXiMQtHgULtiW406x49GCwDsJ5idV5tEbe8v7
         isWBrPh7P7eWr7RLM4tayr4P/VskZfkDHGd2VxLwzs01hhscCGiwzlSU8HyzAd+/ye
         GCgyiRFSsyx0BnCK9C7rBjhMndMlx3DMMhVzmZ7xlOGLHq5EUTn7SV9niL3Pe7Q+KR
         YjKPGQWA/T3GSH/qWxps9zjGkbcTa3Nlx/Ufv7qB9PcGJz5DW86F9LZT+DYPuE2Ge0
         FEpp6qsFAUMYw==
Date:   Wed, 18 Oct 2023 16:00:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/10] PCI: Use FIELD_GET() and FIELD_PREP()
Message-ID: <20231018210013.GA1377253@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 03:44:26PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() and FIELD_PREP() to avoid the need for shifting.
> 
> These apply on top of the PCI patches from Ilpo's series:
>   https://lore.kernel.org/r/20230919125648.1920-1-ilpo.jarvinen@linux.intel.com
> 
> Bjorn Helgaas (10):
>   PCI: Use FIELD_GET()
>   PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
>   PCI/ASPM: Use FIELD_GET()
>   PCI/ATS: Show PASID Capability register width in bitmasks
>   PCI/ATS: Use FIELD_GET()
>   PCI/DPC: Use FIELD_GET()
>   PCI/PME: Use FIELD_GET()
>   PCI/PTM: Use FIELD_GET()
>   PCI/VC: Use FIELD_GET()
>   PCI/portdrv: Use FIELD_GET()
> 
>  drivers/pci/ats.c             |  7 ++---
>  drivers/pci/pci.c             | 53 +++++++++++++++++------------------
>  drivers/pci/pcie/aspm.c       | 31 +++++++++++---------
>  drivers/pci/pcie/dpc.c        |  9 +++---
>  drivers/pci/pcie/pme.c        |  4 ++-
>  drivers/pci/pcie/portdrv.c    |  7 +++--
>  drivers/pci/pcie/ptm.c        |  5 ++--
>  drivers/pci/probe.c           |  8 +++---
>  drivers/pci/quirks.c          |  2 +-
>  drivers/pci/vc.c              |  9 +++---
>  include/uapi/linux/pci_regs.h | 15 ++++++----
>  11 files changed, 81 insertions(+), 69 deletions(-)

I applied these to pci/field-get for v6.7, thanks for all the reviews!
