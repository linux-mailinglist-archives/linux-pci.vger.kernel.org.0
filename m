Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EE4CBF49
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiCCN7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 08:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiCCN7o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 08:59:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324264BC9;
        Thu,  3 Mar 2022 05:58:58 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xdd09Ffz67svF;
        Thu,  3 Mar 2022 21:58:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:58:55 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 13:58:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 00/14] PCI/CMA and SPDM Library
Date:   Thu, 3 Mar 2022 13:58:51 +0000
Message-ID: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes since RFC V1:
- Rebase on top of v5.17-rc1.
- Note includes rebase of Ira's v6 DOE set - I haven't made any changes
  to respond to the review feedback on those patches, purely done a minimal
  rebase. Only included here to make this easy to try out.

Main purpose of this to provide a working starting point for others
interested in alternative transports as I messed up the original v1
posting and unsuprisingly it needed a rebase.

NB: If using github.com/dmtf/spdm_emu : The current version of libspdm
  that will checkout as a submodule has expired certificates which have
  been fixed in libspdm. To test this I regenerated a set using the
  instructions in the libspdm unit tests directory but hopefully
  that issue will be resolved soon anyway when they move their libspdm
  submodule forwards.

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
the device backed by openSPDM emulation of the SPDM protocol.

https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/

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

Thanks,

Jonathan

Ira Weiny (7):
  PCI: Replace magic constant for PCI Sig Vendor ID
  PCI/DOE: Introduce pci_doe_create_doe_devices
  cxl/pci: Create DOE auxiliary devices
  cxl/pci: Find the DOE mailbox which supports CDAT
  cxl/cdat: Introduce cdat_hdr_valid()
  cxl/mem: Retry reading CDAT on failure
  cxl/cdat: Parse out DSMAS data from CDAT table

Jonathan Cameron (7):
  PCI: Add vendor ID for the PCI SIG
  PCI/DOE: Add Data Object Exchange Aux Driver
  cxl/mem: Read CDAT table
  lib/asn1_encoder: Add a function to encode many byte integer values.
  spdm: Introduce a library for DMTF SPDM
  PCI/CMA: Initial support for Component Measurement and Authentication
    ECN
  cxl/pci: Add really basic CMA authentication support.

 drivers/cxl/Kconfig           |    2 +
 drivers/cxl/cdat.h            |  120 ++++
 drivers/cxl/core/memdev.c     |  141 ++++
 drivers/cxl/cxl.h             |    3 +
 drivers/cxl/cxlmem.h          |   29 +
 drivers/cxl/pci.c             |  213 +++++-
 drivers/pci/Kconfig           |   19 +
 drivers/pci/Makefile          |    5 +
 drivers/pci/cma.c             |  105 +++
 drivers/pci/doe.c             |  798 ++++++++++++++++++++++
 drivers/pci/probe.c           |    2 +-
 include/linux/asn1_encoder.h  |    3 +
 include/linux/pci-cma.h       |   19 +
 include/linux/pci-doe.h       |   63 ++
 include/linux/pci_ids.h       |    1 +
 include/linux/spdm.h          |  104 +++
 include/uapi/linux/pci_regs.h |   29 +-
 lib/Kconfig                   |    3 +
 lib/Makefile                  |    2 +
 lib/asn1_encoder.c            |   54 ++
 lib/spdm.c                    | 1196 +++++++++++++++++++++++++++++++++
 21 files changed, 2908 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/cma.c
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-cma.h
 create mode 100644 include/linux/pci-doe.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/spdm.c

-- 
2.32.0

