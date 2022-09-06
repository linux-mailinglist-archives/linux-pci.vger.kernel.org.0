Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A435AE652
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiIFLP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIFLP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 07:15:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B42127F;
        Tue,  6 Sep 2022 04:15:55 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMN8Z4w9Mz688p7;
        Tue,  6 Sep 2022 19:15:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:15:52 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:15:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v3 0/4] PCI/CMA and SPDM Library - Device attestation etc.
Date:   Tue, 6 Sep 2022 12:15:52 +0100
Message-ID: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sharing now to provide some an example of what a fully in-kernel
implementation looks like before the BoF session on this topic at Linux
Plumbers. The big discussion there will probably be how much of this to
do in userspace vs in the kernel.

https://lpc.events/event/16/contributions/1304/

Changes since v2:
 - Rebase on v6.0-rc2. DOE infrastructure now upstream so much smaller
   series.
 - SPDM 1.2 support. Fairly minor changes for attestation. Negotiation of
   highest mutually supported version included with drivers using this
   code specifying a minimum version they will accept.
 - Various fixes in particular to correctly identify ECDSA x9.62 format
   signature being passed to signature verify.
 - Changes suggested by Lukas in his review of RFC v2.
   Make spdm_state opaque outside of libspdm.c
   Drop misleading _pl_
   Drop non existent forwards definition of spdm_measurements_get()
   Add spec link.

v2 was a rebase + fixed some files I missed in v1.

v1 Cover letter:

This is an RFC to start discussions about how we support the Component
Measurement and Authentication (CMA) ECN (pcisig.com)

CMA provides an adaptation of the data objects and underlying protocol
defined in the DMTF SPDM specification to be used to authenticate and
conduct run-time measurements of the state of PCI devices (kind of like
IMA for devices / firmware). This is done using a Data Object Exchange (DOE)
protocol described in the ECN.

The CMA ECN is available from the PCI SIG and SPDM can be found at
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.1.1.pdf

CMA/SPDM is focused on establishing trust of the device by:
1) Negotiate algorithms supported.
2) Retrieve and check the certificate chain from the device against
   a suitable signing certificate on the host.
3) Issue a challenge to the device to verify it can sign with the private
   key associated with the leaf certificate.
4) (Request a measurement of device state)
5) (Establish a secure channel for further measurements or other uses)
6) (Mutual authentication)

This RFC only does steps 1-3

Testing of this patch set has been conducted against QEMU emulation of
the device backed by openSPDM emulation of the SPDM protocol
(rebased version to be sent shortly).

Open questions are called out in the individual patches but the big ones are
probably:

1) Certificate management.
   Current code uses a _cma keyring created by the kernel, into which a
   suitable root certificate can be inserted from userspace.

   A=$(keyctl search %:_cma  keyring _cma)
   evmctl import ecdsaca.cert.der $A

   Is this an acceptable way to load the root certificates for this purpose?

   The root of the device provided certificate chain is then checked against
   certificates on this keychain, but is itself (with the other certificates
   in the chain) loaded into an SPDM instance specific keychain.  Currently
   there is no safe cleanup of this which will need to be fixed.

   Using the keychain mechanism provides a very convenient way to manage these
   certificates and to allow userspace to read them for debug purpose etc, but
   is this the right use model?

   Finally the leaf certificate of this chain is used to check signatures of
   the rest of the communications with the device.

2) ASNL1 encoder for ECDSA signature
   It seems from the openSPDM implementation that for these signatures,
   the format is a simple pair of raw values.  The kernel implementation of
   ECDSA signature verification assumes ASN1 encoding as seems to be used
   in x509 certificates.  Currently I work around that by encoding the
   signatures so that the ECDSA code can un-encode them again and use them.
   This seems slightly silly, but it is minimum impact on current code.
   Other suggestions welcome.

3) Interface to present to drivers. Currently I'm providing just one exposed
   function that wraps up all the exhanges until a challenge authentication
   response from the device. This is done using one possible sequence.
   I don't think it makes sense to expose the low level components due to the
   underlying spdm_state updates and there only being a fixed set of valid
   orderings.

Future patches will raise questions around management of the measurements, but
I'll leave those until I have some sort of implementation to shoot at.
The 'on probe' use in the CXL driver is only one likely time when authentication
would be needed.

Note I'm new to a bunch of the areas of the kernel this touches, so have
probably done things that are totally wrong.

CC list is best effort to identify those who 'might' care.  Please share
with anyone I've missed.

Jonathan Cameron (4):
  lib/asn1_encoder: Add a function to encode many byte integer values.
  spdm: Introduce a library for DMTF SPDM
  PCI/CMA: Initial support for Component Measurement and Authentication
    ECN
  cxl/pci: Add really basic CMA authentication support.

 drivers/cxl/Kconfig          |    1 +
 drivers/cxl/core/pci.c       |   47 ++
 drivers/cxl/cxlpci.h         |    1 +
 drivers/cxl/port.c           |    1 +
 drivers/pci/Kconfig          |   13 +
 drivers/pci/Makefile         |    1 +
 drivers/pci/cma.c            |  117 +++
 include/linux/asn1_encoder.h |    3 +
 include/linux/pci-cma.h      |   21 +
 include/linux/spdm.h         |   81 +++
 lib/Kconfig                  |    3 +
 lib/Makefile                 |    2 +
 lib/asn1_encoder.c           |   54 ++
 lib/spdm.c                   | 1333 ++++++++++++++++++++++++++++++++++
 14 files changed, 1678 insertions(+)
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/linux/pci-cma.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/spdm.c

-- 
2.32.0

