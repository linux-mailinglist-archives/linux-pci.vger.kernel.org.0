Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547335E8893
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 07:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIXFkC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiIXFj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 01:39:59 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D782CC9A;
        Fri, 23 Sep 2022 22:39:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A3A4310045BFB;
        Sat, 24 Sep 2022 07:39:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6BE1C51EC1; Sat, 24 Sep 2022 07:39:53 +0200 (CEST)
Date:   Sat, 24 Sep 2022 07:39:53 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [RFC PATCH v3 3/4] PCI/CMA: Initial support for Component
 Measurement and Authentication ECN
Message-ID: <20220924053953.GA13820@wunner.de>
References: <20220906111556.1544-4-Jonathan.Cameron@huawei.com>
 <20220923213634.GA1420285@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923213634.GA1420285@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 04:36:34PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 06, 2022 at 12:15:55PM +0100, Jonathan Cameron wrote:
> > --- /dev/null
> > +++ b/drivers/pci/cma.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Component Measurement and Authentication was added as an ECN to the
> > + * PCIe r5.0 spec.
> 
> It looks like PCIe r6.0, sec 6.31?  (Oh, I see that's what you mention
> above in the Kconfig text :))  I have absolutely no idea what CMA is
> about or how it works.  Other than pci_doe_submit_task(), nothing here
> is recognizable to me as PCI-related and I can't tell what else, if
> anything, is connected to something in the PCIe spec.

CMA is an adaption of the SPDM spec to PCIe.

Basically this is about authenticating PCI devices:
The device presents a certificate chain to the host;
The host needs to trust the root of that certificate chain;
The host sends a nonce to the device;
The device signs the nonce with its private key, sends it back;
The host verifies the signature matches the certificate (= public key).

The protocol to perform this authentication is called SPDM:
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2.1.pdf

Various other specs besides PCIe have adopted SPDM (e.g. CXL).

One transport over which the SPDM message exchanges are sent is PCI DOE,
which appears in v6.0.

So-called measurements can be retrieved after authentication was
completed successfully:  E.g. a signed hash of the firmware.
Thereby, the host can verify the device is in a trusted state.

"Attestation" appears to be a fancy terminus technicus which encompasses
authentication and validation of measurements.

Authentication forms the basis for IDE (PCI TLP encryption,
PCIe r6.0 sec 6.33).  Encryption is useless without authentication
because it's otherwise susceptible to man-in-the-middle attacks.

Authentication also forms the basis for TDISP (Trusted I/O virtualization,
recently accepted as an ECN).

There was an SPDM BoF at Plumbers last week:
https://lpc.events/event/16/contributions/1304/attachments/1029/1974/LPC2022-SPDM-BoF-v4.pdf
https://lpc.events/event/16/abstracts/1301/

The outcome is that we'll be working towards a minimal CMA implementation
which is capable of authenticating PCI devices and presenting the result in
sysfs.  There might be a global policy knob in sysfs to control handling
of devices for which authentication failed (e.g. forbid binding to
drivers).  Features such as a per-device policy can later be added on top
if need be.  We'll need to rework DOE handling such that the PCI core
scans all DOE mailboxes on device enumeration to look for one capable
of SPDM and perform authentication.  We'll seek to upstream this though
the PCI tree.  That's my summary in brief, Jonathan or Dan may have
amendments or corrections to make. :)

Thanks,

Lukas
