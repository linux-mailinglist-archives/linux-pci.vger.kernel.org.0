Return-Path: <linux-pci+bounces-9467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34891D387
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 21:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F20D2812C9
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 19:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944C2C859;
	Sun, 30 Jun 2024 19:45:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18A38DF2;
	Sun, 30 Jun 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719776716; cv=none; b=i8Imm5BImxQWcuu6XxrhohguLBUFRhJ2JidSzDHbAOaDR+6v7lM22TS8HB99cftQcDc33tMj11KhOITnLh66NoLyz86uGNKE6mjzhTJN4Va0pBKsoU3LIxLz7/riZR4tKeSS2HQq+RQ5k+volwW664npnVzeNKlBUavvLwjQ+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719776716; c=relaxed/simple;
	bh=iChmBiCH957hVqpkPbOVEM27uxwgCagWtvWjjvKqmnU=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=SJI7mTxSvLprhRmqcch1sQs8/I/uB/h5VROI7QZLu5jGfJ6W3USMe4ihEl2t6yq7H2b1RM4yBKfkDvwZbjMjeVpPIrr9cHYIwJEZVfLHb426h1JqBik19swiRngK/efau1oBX1v9tzHy9q/Ab9Tp0zZAxFjvvKESvSRQrXdhSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 019CB10190FA3;
	Sun, 30 Jun 2024 21:35:32 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id BC69061DA802;
	Sun, 30 Jun 2024 21:35:31 +0200 (CEST)
X-Mailbox-Line: From ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a Mon Sep 17 00:00:00 2001
Message-ID: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:35:00 +0200
Subject: [PATCH v2 00/18] PCI device authentication
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

PCI device authentication v2

Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
expose the result in sysfs.

Five big changes since v1 (and many smaller ones, full list at end):

* Certificates presented by a device are now exposed in sysfs
  (new patch 12).

* Per James Bottomley's request at Plumbers, a log of signatures
  received from a device is exposed in sysfs (new patches 13-18),
  allowing for re-verification by remote attestation services.
  Comments welcome whether the proposed ABI makes sense.

* Per Damien Le Moal's request at Plumbers, sysfs attributes are
  now implemented in the SPDM library instead of in the PCI core.
  Thereby, ATA and SCSI will be able to re-use them seamlessly.

* I've dropped a controversial patch to grant guests exclusive control
  of authentication of passed-through devices (old patch 12 in v1).
  People were more interested in granting the TSM exclusive control
  instead of the guest.  Dan Williams is driving an effort to negotiate
  SPDM control between kernel and TSM.

* The SPDM library (in patch 7) has undergone significant changes
  to enable the above-mentioned sysfs exposure of certificates and
  signatures:  It retrieves and caches all certificates from a device
  and collects all exchanged SPDM messages in a transcript buffer.
  To ease future maintenance, the code has been split into multiple
  files in lib/spdm/.


Link to v1 and subsequent Plumbers discussion:
https://lore.kernel.org/all/cover.1695921656.git.lukas@wunner.de/
https://lpc.events/event/17/contributions/1558/

How to test with qemu:
https://github.com/twilfredo/qemu-spdm-emulation-guide


Changes v1 -> v2:

* [PATCH 01/18] X.509: Make certificate parser public
  * Add include guard #ifndef + #define to <keys/x509-parser.h> (Ilpo).

* [PATCH 02/18] X.509: Parse Subject Alternative Name in certificates
  * Return -EBADMSG instead of -EINVAL on duplicate Subject Alternative
    Name, drop error message for consistency with existing code.

* [PATCH 03/18] X.509: Move certificate length retrieval into new helper
  * Use ssize_t instead of int (Ilpo).
  * Amend commit message to explain why the helper is exported (Dan).

* [PATCH 06/18] crypto: ecdsa - Support P1363 signature encoding
  * Use idiomatic &buffer[keylen] notation.
  * Rebase on NIST P521 curve support introduced with v6.10-rc1

* [PATCH 07/18] spdm: Introduce library to authenticate devices
  New features:
  * In preparation for exposure of certificate chains in sysfs, retrieve
    the certificates from *all* populated slots instead of stopping on
    the first valid slot.  Cache certificate chains in struct spdm_state.
  * Collect all exchanged messages of an authentication sequence in a
    transcript buffer for exposure in sysfs.  Compute hash over this
    transcript rather than peacemeal over each exchanged message.
  * Support NIST P521 curve introduced with v6.10-rc1.
  Bugs:
  * Amend spdm_validate_cert_chain() to cope with zero length chain.
  * Print correct error code returned from x509_cert_parse().
  * Emit error if there are no common supported algorithms.
  * Implicitly this causes an error if responder selects algorithms
    not supported by requester during NEGOTIATE_ALGORITHMS exchange,
    previously this was silently ignored (Jonathan).
  * Refine checks of Basic Constraints and Key Usage certificate fields.
  * Add code comment explaining those checks (Jonathan).
  Usability:
  * Log informational message on successful authentication (Tomi Sarvela).
  Style:
  * Split spdm_requester.c into spdm.h, core.c and req-authenticate.c.
  * Use __counted_by() in struct spdm_get_version_rsp (Ilpo).
  * Return ssize_t instead of int from spdm_transport (Ilpo).
  * Downcase hex characters, vertically align SPDM_REQ macro (Ilpo).
  * Upcase spdm_error_code enum, vertically align it (Ilpo).
  * Return -ECONNRESET instead of -ERESTART from spdm_err() (Ilpo).
  * Access versions with le16_to_cpu() instead of get_unaligned_le16()
    in spdm_get_version() because __packed attribute already implies
    byte-wise access (Ilpo).
  * Add code comment in spdm_start_hash() that shash and desc
    allocations are freed by spdm_reset(), thus seemingly leaked (Ilpo).
  * Rename "s" and "h" members of struct spdm_state to "sig_len" and
    "hash_len" for clarity (Ilpo).
  * Use FIELD_GET() in spdm_create_combined_prefix() for clarity (Ilpo).
  * Add SPDM_NONCE_SZ macro (Ilpo).
  * Reorder error path of spdm_authenticate() for symmetry (Jonathan).
  * Fix indentation of Kconfig entry (Jonathan).
  * Annotate capabilities introduced with SPDM 1.1 (Jonathan).
  * Annotate algorithms introduced with SPDM 1.2 (Jonathan).
  * Annotate errors introduced with SPDM 1.1 and 1.2 (Jonathan).
  * Amend algorithm #ifdef's to avoid trailing "|" (Jonathan).
  * Add code comment explaining that some SPDM messages are enlarged
    by fields added in new SPDM versions whereas others use reserved
    space for new fields (Jonathan).
  * Refine code comments on various fields in SPDM messages (Jonathan).
  * Duplicate spdm_get_capabilities_reqrsp into separate structs (Jonathan).
  * Document SupportedAlgorithms field at end of spdm_get_capabilities_rsp,
    introduced with SPDM 1.3 (Jonathan).
  * Use offsetofend() rather than offsetof() to set SPDM message size
    based on SPDM version (Jonathan).
  * Use cleanup.h to unwind heap allocations (Jonathan).
  * In spdm_verify_signature(), change code comment to refer to "SPDM 1.0
    and 1.1" instead of "Until SPDM 1.1" (Jonathan).
  * Use namespace "SPDM" for exported symbols (Jonathan).
  * Drop __spdm_exchange().
  * In spdm_exchange(), do not return an error on truncation of
    spdm_header so that callers can take care of it.
  * Rename "SPDM_CAPS" macro to "SPDM_REQ_CAPS" to prepare for later
    addition of responder support.
  * Rename "SPDM_MIN_CAPS" macro to "SPDM_RSP_MIN_CAPS" and
    rename "responder_caps" member of struct spdm_state to "rsp_caps".
  * Rename "SPDM_REQUESTER" Kconfig symbol to "SPDM".  There is actually
    no clear-cut separation between requester and responder code because
    mutual authentication will require the responder to invoke requester
    functions.
  * Rename "slot_mask" member of struct spdm_state to "provisioned_slots"
    to follow SPDM 1.3 spec language.

* [PATCH 08/18] PCI/CMA: Authenticate devices on enumeration
  * In pci_cma_init(), check whether pci_cma_keyring is an ERR_PTR
    rather than checking whether it's NULL.  keyring_alloc() never
    returns NULL.
  * On failure to allocate keyring, emit "PCI: " and ".cma" as part of
    error message for clarity (Bjorn).
  * Drop superfluous curly braces around two if-blocks (Jonathan, Bjorn).
  * Add code comment explaining why spdm_state is kept despite initial
    authentication failure (Jonathan).
  * Rename PCI_DOE_PROTOCOL_CMA to PCI_DOE_FEATURE_CMA for DOE r1.1
    compliance.

* [PATCH 09/18] PCI/CMA: Validate Subject Alternative Name in certificates
  * Amend commit message with note on Reference Integrity Manifest (Jonathan).
  * Amend commit message and code comment with note on PCIe r6.2 changes.
  * Add SPDX identifer and IETF copyright to cma.asn1 per section 4 of:
    https://trustee.ietf.org/documents/trust-legal-provisions/tlp-5/
  * Pass slot number to ->validate() callback and emit it in error messages.
  * Move all of cma-x509.c into cma.c (Bjorn).

* [PATCH 10/18] PCI/CMA: Reauthenticate devices on reset and resume
  * Drop "cma_capable" bit in struct pci_dev and instead check whether
    "spdm_state" is a NULL pointer.  Only difference:  Devices which
    didn't support the minimum set of capabilities on enumeration
    are now attempted to be reauthenticated.  The rationale being that
    they may have gained new capabilities due to a runtime firmware update.
  * Add kernel-doc for pci_cma_reauthenticate().

* [PATCH 11/18] PCI/CMA: Expose in sysfs whether devices are authenticated
  * Change write semantics of sysfs attribute such that reauthentication
    is triggered by writing "re" (instead of an arbitrary string).
    This allows adding other commands down the road.
  * Move sysfs attribute from PCI core to SPDM library for reuse by other
    bus types such as SCSI/ATA (Damien).
  * If DOE or CMA initialization fails, set pci_dev->spdm_state to ERR_PTR
    instead of using additional boolean flags.
  * Amend commit message to mention downgrade attack prevention (Ilpo,
    Jonathan).
  * Amend ABI documentation to mention reauthentication after downloading
    firmware to an FPGA device.

* [PATCH 12/18 to 18/18] are new in v2


Jonathan Cameron (2):
  spdm: Introduce library to authenticate devices
  PCI/CMA: Authenticate devices on enumeration

Lukas Wunner (16):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  certs: Create blacklist keyring earlier
  crypto: akcipher - Support more than one signature encoding
  crypto: ecdsa - Support P1363 signature encoding
  PCI/CMA: Validate Subject Alternative Name in certificates
  PCI/CMA: Reauthenticate devices on reset and resume
  PCI/CMA: Expose in sysfs whether devices are authenticated
  PCI/CMA: Expose certificates in sysfs
  sysfs: Allow bin_attributes to be added to groups
  sysfs: Allow symlinks to be added between sibling groups
  PCI/CMA: Expose a log of received signatures in sysfs
  spdm: Limit memory consumed by log of received signatures
  spdm: Authenticate devices despite invalid certificate chain
  spdm: Allow control of next requester nonce through sysfs

 Documentation/ABI/testing/sysfs-devices-spdm | 247 ++++++
 Documentation/admin-guide/sysctl/index.rst   |   2 +
 Documentation/admin-guide/sysctl/spdm.rst    |  33 +
 MAINTAINERS                                  |  14 +
 certs/blacklist.c                            |   4 +-
 crypto/akcipher.c                            |   2 +-
 crypto/asymmetric_keys/public_key.c          |  44 +-
 crypto/asymmetric_keys/x509_cert_parser.c    |   9 +
 crypto/asymmetric_keys/x509_loader.c         |  38 +-
 crypto/asymmetric_keys/x509_parser.h         |  40 +-
 crypto/ecdsa.c                               |  18 +-
 crypto/internal.h                            |   1 +
 crypto/rsa-pkcs1pad.c                        |  11 +-
 crypto/sig.c                                 |   6 +-
 crypto/testmgr.c                             |   8 +-
 crypto/testmgr.h                             |  20 +
 drivers/pci/Kconfig                          |  13 +
 drivers/pci/Makefile                         |   4 +
 drivers/pci/cma.asn1                         |  41 +
 drivers/pci/cma.c                            | 247 ++++++
 drivers/pci/doe.c                            |   5 +-
 drivers/pci/pci-driver.c                     |   1 +
 drivers/pci/pci-sysfs.c                      |   5 +
 drivers/pci/pci.c                            |  12 +-
 drivers/pci/pci.h                            |  17 +
 drivers/pci/pcie/err.c                       |   3 +
 drivers/pci/probe.c                          |   3 +
 drivers/pci/remove.c                         |   1 +
 fs/sysfs/file.c                              |  69 +-
 fs/sysfs/group.c                             |  33 +
 include/crypto/akcipher.h                    |  10 +-
 include/crypto/sig.h                         |   6 +-
 include/keys/asymmetric-type.h               |   2 +
 include/keys/x509-parser.h                   |  55 ++
 include/linux/kernfs.h                       |   2 +
 include/linux/oid_registry.h                 |   3 +
 include/linux/pci-doe.h                      |   4 +
 include/linux/pci.h                          |  16 +
 include/linux/spdm.h                         |  46 ++
 include/linux/sysfs.h                        |  29 +
 lib/Kconfig                                  |  15 +
 lib/Makefile                                 |   2 +
 lib/spdm/Makefile                            |  11 +
 lib/spdm/core.c                              | 442 +++++++++++
 lib/spdm/req-authenticate.c                  | 765 +++++++++++++++++++
 lib/spdm/req-sysfs.c                         | 619 +++++++++++++++
 lib/spdm/spdm.h                              | 560 ++++++++++++++
 47 files changed, 3436 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 Documentation/admin-guide/sysctl/spdm.rst
 create mode 100644 drivers/pci/cma.asn1
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/keys/x509-parser.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/spdm/Makefile
 create mode 100644 lib/spdm/core.c
 create mode 100644 lib/spdm/req-authenticate.c
 create mode 100644 lib/spdm/req-sysfs.c
 create mode 100644 lib/spdm/spdm.h

-- 
2.43.0


