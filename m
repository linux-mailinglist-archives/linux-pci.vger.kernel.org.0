Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299167DF8B5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 18:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKBR2f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjKBR2f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 13:28:35 -0400
X-Greylist: delayed 6882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 10:28:29 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA4182;
        Thu,  2 Nov 2023 10:28:29 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id BD6472800A286;
        Thu,  2 Nov 2023 18:28:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A78522E5C18; Thu,  2 Nov 2023 18:28:27 +0100 (CET)
Date:   Thu, 2 Nov 2023 18:28:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102172827.GA8677@wunner.de>
References: <928df647-5b20-406b-8da5-3199f5cfbb48@amd.com>
 <20231102154748.GA122230@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154748.GA122230@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 10:47:48AM -0500, Bjorn Helgaas wrote:
> On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> > On 11/1/2023 17:52, Bjorn Helgaas wrote:
> > > Is the implication that a tunneling port can *never* be a speed
> > > bottleneck?  That seems to be how this patch would work in practice.
> > 
> > I think that's a stretch we should avoid concluding.
> 
> I'm just reading the description and the patch, which seem to say that
> pcie_bandwidth_available() will never report a tunneling port as the
> limiting port.

If the Thunderbolt host controller is a discrete chip attached with PCIe,
the bandwidth is capped by its Switch Upstream Port.

E.g. the "Light Ridge" Thunderbolt 1 controller's Switch Upstream Port
supports 5 GT/s at x4 width.

In contemporary systems, the Thunderbolt controller is often part of the
CPU SoC, so attached Thunderbolt devices appear below a Root Port.
In that case, there's no such limitation.

Additionally the bandwidth is limited by the Thunderbolt generation:
Thunderbolt 1 had two bidirectional 10 GBit/s channels,
Thunderbolt 2 has 20 GBit/s total, Thunderbolt 3 & 4 has 40 GBit/s total:

https://en.wikipedia.org/wiki/Thunderbolt_(interface)

Hence assuming "unlimited" capacity for Thunderbolt wouldn't be accurate.

Thanks,

Lukas
