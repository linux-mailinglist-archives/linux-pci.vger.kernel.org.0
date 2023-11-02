Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB667DF680
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbjKBPdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbjKBPdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 11:33:50 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F744138
        for <linux-pci@vger.kernel.org>; Thu,  2 Nov 2023 08:33:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6196028046BF6;
        Thu,  2 Nov 2023 16:33:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 553B157544; Thu,  2 Nov 2023 16:33:45 +0100 (CET)
Date:   Thu, 2 Nov 2023 16:33:45 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102153345.GA30347@wunner.de>
References: <20231101225259.GA101390@bhelgaas>
 <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
 <20231102152154.GA22270@wunner.de>
 <bb4d8fad-dced-4fed-9582-2db50643e868@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4d8fad-dced-4fed-9582-2db50643e868@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 10:26:31AM -0500, Mario Limonciello wrote:
> On 11/2/2023 10:21, Lukas Wunner wrote:
> > On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> > > Considering this I think it's a good idea to move that creation of the
> > > device link into drivers/pci/pci-acpi.c and store a bit in struct
> > > pci_device to indicate it's a tunneled port.
> > > 
> > > Then 'thunderbolt' can look for this directly instead of walking all
> > > the FW nodes.
> > > 
> > > pcie_bandwidth_available() can just look at the tunneled port bit
> > > instead of the existence of the device link.
> > 
> > pci_is_thunderbolt_attached() should already be doing exactly what
> > you want to achieve with the new bit.  It tells you whether a PCI
> > device is behind a Thunderbolt tunnel.  So I don't think a new bit
> > is actually needed.
> 
> It's only for a device connected to an Intel TBT3 controller though; it
> won't apply to USB4.

Time to resurrect this patch here...? :)

https://lore.kernel.org/all/20220204182820.130339-3-mario.limonciello@amd.com/
