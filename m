Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A060C63CFC0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 08:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiK3Hhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 02:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiK3Hhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 02:37:35 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8D1D0D7
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 23:37:31 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B1C7E10029F8A;
        Wed, 30 Nov 2022 08:37:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 892D51908; Wed, 30 Nov 2022 08:37:28 +0100 (CET)
Date:   Wed, 30 Nov 2022 08:37:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Message-ID: <20221130073728.GB8198@wunner.de>
References: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
 <b201a410-8593-6718-f76a-ea27ee5ab930@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b201a410-8593-6718-f76a-ea27ee5ab930@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 08:27:43AM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 11/28/22 11:35 PM, Lukas Wunner wrote:
> > Add DPC Software Trigger as a reset method to be used for silicon
> > validation among other things:
> > 
> >   # echo dpc_sw_trigger > reset_method
> >   # echo 1 > reset
> > 
> > After validating DPC, the default reset_method(s) may be reinstated:
> > 
> >   # echo default > reset_method
> > 
> > Writing the DPC Control Register requires that control was granted by
> > firmware, so expose the reset_method only if DPC is native.  (And AER,
> > which must always be granted or denied in unison per PCI Firmware Spec
> > r3.3 table 4-5.)
> > 
> > The reset attribute in sysfs is meant to reset a single PCI Function,
> > but DPC resets the entire hierarchy below the parent.  So only expose
> > the reset method on PCI Functions without siblings or children.
> > Checking for that may happen both *before* the PCI Function has been
> > added to the bus list (via pci_device_add() -> pci_init_capabilities())
> > and *after* (via reset_method_store()), hence differentiate between
> > those two cases on reset probing.
> 
> Does this mean you want to only allow this reset method for DPC capable
> ports without any devices attached to it? If yes, why not use other
> reset methods available?

This reset method is allowed if the DPC-capable port has a single child
device and that child has no siblings or descendants.  

And the reset is performed by echoing 1 to the single child's reset
attribute in sysfs.

Those are the same semantics as the Secondary Bus Reset method.

Thanks,

Lukas
