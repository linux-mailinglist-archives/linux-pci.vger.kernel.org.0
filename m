Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3F3E05C8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhHDQWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:22:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3577 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhHDQWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 12:22:05 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gfxnr30Q0z6DJ3x;
        Thu,  5 Aug 2021 00:21:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 18:21:50 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 17:21:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/4] PCI/CMA and SPDM library
Date:   Thu, 5 Aug 2021 00:18:35 +0800
Message-ID: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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


Jonathan Cameron (4):
  lib/asn1_encoder: Add a function to encode many byte integer values.
  spdm: Introduce a library for DMTF SPDM
  PCI/CMA: Initial support for Component Measurement and Authentication
    ECN
  cxl/pci: Add really basic CMA authentication support.

 drivers/cxl/Kconfig          |    1 +
 drivers/cxl/mem.h            |    2 +
 drivers/cxl/pci.c            |   13 +-
 drivers/pci/Kconfig          |    9 +
 drivers/pci/Makefile         |    1 +
 drivers/pci/doe.c            |    2 -
 include/linux/asn1_encoder.h |    3 +
 include/linux/pci-doe.h      |    2 +
 lib/Kconfig                  |    3 +
 lib/Makefile                 |    2 +
 lib/asn1_encoder.c           |   54 ++
 lib/spdm.c                   | 1196 ++++++++++++++++++++++++++++++++++
 12 files changed, 1285 insertions(+), 3 deletions(-)
 create mode 100644 lib/spdm.c

-- 
2.19.1

