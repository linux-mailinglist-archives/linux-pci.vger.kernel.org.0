Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CD670B7A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjAQWN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 17:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAQWM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 17:12:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A00360BF;
        Tue, 17 Jan 2023 12:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED3DCB81A0C;
        Tue, 17 Jan 2023 20:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEC9C433EF;
        Tue, 17 Jan 2023 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673987537;
        bh=oWArDaU1DZ8qSMwUfX0DJS1kByfHC40zRhFfLw4sElw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=So0CGmlLd0rpIGyI1GLq77v0BmHP+sTo1hURjyCdtUdg6xg1ABSapvnbdUl94W3rY
         2p1hElP35LI+u7wMLC7UEzcrcbPPWtHBdiXO0kzXLmiOH2Wx8cQRXFDVkc3yxFVGBf
         ioeYYCQPpV6Fxpn8KPdNI3fxGCA+Cm/jiALg8+Znof2ifM1bS0CUQxC2Qe9Qi0qNMQ
         lHc4ylkndFepazbC0Q9fOPYJJCJmGmVtJQhFKdvuAJ79ckSNtYL2KwfqCn6UYUsVxA
         0NgFveb9erbKvtimViaQ7MqGatjUZJHgyBReX+dGffuUzqvOj9uiBvYe63vhUQV9iS
         qge43omTJNOuQ==
Date:   Tue, 17 Jan 2023 14:32:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Deal with alignment restriction on EP side
Message-ID: <20230117203215.GA144880@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113090350.1103494-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 06:03:47PM +0900, Shunsuke Mie wrote:
> Some PCIe EPC controllers have restriction to map PCIe address space to the
> local memory space. The mapping is needed to access memory of other side.
> On epf test, RC module prepares an aligned memory, and EP module maps the
> region. However, a EP module which emulate a device (e.g. VirtIO, NVMe and
> etc) cannot expect that a driver for the device prepares an aligned memory.
> So, a EP side should deal with the alignment restriction.
> 
> This patchset addresses with the alignment restriction on EP size. A
> content as follows:
> 1. Improve a pci epc unmap/map functions to cover the alignment restriction
> with adding epc driver support as EPC ops.
> 2. Implement the support function for DWC EPC driver.
> 3. Adapt the pci-epf-test to the map/unmap function updated at first patch.
> 
> I tested this changes on RENESAS board has DWC PCIeC.
> 
> This is a RFC, and it has patches for testing only. Following changes are
> not included yet:
> 1. Removing alignment codes on RC side completely
> 2. Adapting map/unmap() changes to pci-epf-ntb/vntb
> 
> Best,
> Shunsuke
> 
> Shunsuke Mie (3):
>   PCI: endpoint: support an alignment aware map/unmaping
>   PCI: dwc: support align_mem() callback for pci_epc_epc
>   PCI: endpoint: support pci_epc_mem_map/unmap API changes

s/unmaping/unmapping/

Capitalize subject lines ("Support ...").

Would be nice to say something more specific than "support ... API
changes."

The last patch seems to be for a test case.  Some previous changes to
it use the "PCI: pci-epf-test" prefix so it's distinct from the
pci-epc-core changes.

>  .../pci/controller/dwc/pcie-designware-ep.c   | 13 +++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 89 +++++--------------
>  drivers/pci/endpoint/pci-epc-core.c           | 57 +++++++++---
>  include/linux/pci-epc.h                       | 10 ++-
>  4 files changed, 90 insertions(+), 79 deletions(-)
> 
> -- 
> 2.25.1
> 
