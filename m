Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8AC73B082
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjFWGGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFWGGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 02:06:31 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B282E48;
        Thu, 22 Jun 2023 23:06:30 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 412DE2800C986;
        Fri, 23 Jun 2023 08:06:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 304D9155F74; Fri, 23 Jun 2023 08:06:28 +0200 (CEST)
Date:   Fri, 23 Jun 2023 08:06:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230623060628.GA28334@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
 <8bb20976-97ec-0c5c-adc8-183896de6768@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb20976-97ec-0c5c-adc8-183896de6768@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 05:59:55AM +0200, Felix Kuehling wrote:
> On 2023-06-22 23:42, Lukas Wunner wrote:
> > On Thu, Jun 22, 2023 at 02:02:12PM -0700, Smita Koralahalli wrote:
> > > Would it be fair to just reuse pci_enable_atomic_ops_to_root() for
> > > Atomic_Ops configuration?
> > 
> > Hm, that's a good question.  I'm not an expert on that corner of
> > the PCI core.
> > 
> > But indeed what you could try is amend that function to not only
> > *set* PCI_EXP_DEVCTL2_ATOMIC_REQ if it's supported, but to also
> > *clear* it if it's not supported.
> > 
> > And you'd have to call pci_enable_atomic_ops_to_root() on enumeration,
> > e.g. from pci_init_capabilities().
> > 
> > That should obviate the need to call pci_enable_atomic_ops_to_root()
> > from drivers, so you could probably remove the call from all the
> > drivers which currently call it (amdgpu, infiniband, mellanox),
> > in one separate patch per driver.
> > 
> > An then you could drop the EXPORT clause for pci_enable_atomic_ops_to_root()
> > and make it private to the PCI core.
> 
> Then our driver would need an alternative way to determine whether atomic
> capabilities are enabled for a device. We currently use the return value
> from pci_enable_atomic_ops_to_root to determine this.

Just read PCI_EXP_DEVCTL2 and check whether PCI_EXP_DEVCTL2_ATOMIC_REQ
is set.  (I.e. has been set by the PCI core on device enumeration.)

Problem solved, I guess?

Thanks,

Lukas
