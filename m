Return-Path: <linux-pci+bounces-10498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6AF934CB5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE39281E47
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62713B588;
	Thu, 18 Jul 2024 11:42:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E11386B4;
	Thu, 18 Jul 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302938; cv=none; b=dJjgsLgwfRGmbI4DheW2xxdEbxqV4g1KIqe40Wmkw957MHUTSH5XytSfgVoFPsvMcpm29RzOs///c+cllLYotaXdSnbTvL9wVB504pAN5Q5Lm6+ZkPoZAbxhHcqNze0ssbc6/EYIIQQnA2rvIutcdEVGSsOS7CavaaRvYyAjYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302938; c=relaxed/simple;
	bh=ny3QGmnxYTlRuJpmo/AX5RfOeShhaF4y/SNWhq/ZGmI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0SS+5ThTI/EfoommSYoo0wqL2wQq7eYernBTnjd12Czxbxse/VzkLJ2L8DAYO07RZ0qtUogPSpFhbXhEVnT7RBGMxNp9pDDhcBjn96n1677utlp1MuJOqJEDuT2QzHq8mCW6T4/joE8wWeyWjPPcT+BwpCUrChd2y/t71zrObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPrTH5Hvpz6K60L;
	Thu, 18 Jul 2024 19:40:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E23B140A36;
	Thu, 18 Jul 2024 19:42:10 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 12:42:09 +0100
Date: Thu, 18 Jul 2024 12:42:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, David
 Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linuxarm@huawei.com>, David Box <david.e.box@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers
	<ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 07/18] spdm: Introduce library to authenticate
 devices
Message-ID: <20240718124208.00002b72@Huawei.com>
In-Reply-To: <668cc61b230c4_102cc294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719771133.git.lukas@wunner.de>
	<bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
	<668cc61b230c4_102cc294c4@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jul 2024 22:09:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Lukas Wunner wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The Security Protocol and Data Model (SPDM) allows for device
> > authentication, measurement, key exchange and encrypted sessions.
> > 
> > SPDM was conceived by the Distributed Management Task Force (DMTF).
> > Its specification defines a request/response protocol spoken between
> > host and attached devices over a variety of transports:
> > 
> >   https://www.dmtf.org/dsp/DSP0274
> > 
> > This implementation supports SPDM 1.0 through 1.3 (the latest version).
> > It is designed to be transport-agnostic as the kernel already supports
> > four different SPDM-capable transports:
> > 
> > * PCIe Data Object Exchange, which is a mailbox in PCI config space
> >   (PCIe r6.2 sec 6.30, drivers/pci/doe.c)
> > * Management Component Transport Protocol
> >   (MCTP, Documentation/networking/mctp.rst)
> > * TCP/IP (in draft stage)
> >   https://www.dmtf.org/sites/default/files/standards/documents/DSP0287_1.0.0WIP99.pdf
> > * SCSI and ATA (in draft stage)
> >   "SECURITY PROTOCOL IN/OUT" and "TRUSTED SEND/RECEIVE" commands
> > 
> > Use cases for SPDM include, but are not limited to:
> > 
> > * PCIe Component Measurement and Authentication (PCIe r6.2 sec 6.31)
> > * Compute Express Link (CXL r3.0 sec 14.11.6)
> > * Open Compute Project (Attestation of System Components v1.0)
> >   https://www.opencompute.org/documents/attestation-v1-0-20201104-pdf
> > * Open Compute Project (Datacenter NVMe SSD Specification v2.0)
> >   https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-0r21-pdf
> > 
> > The initial focus of this implementation is enabling PCIe CMA device
> > authentication.  As such, only a subset of the SPDM specification is
> > contained herein, namely the request/response sequence GET_VERSION,
> > GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE
> > and CHALLENGE.
> > 
> > This sequence first negotiates the SPDM protocol version, capabilities
> > and algorithms with the device.  It then retrieves the up to eight
> > certificate chains which may be provisioned on the device.  Finally it
> > performs challenge-response authentication with the device using one of
> > those eight certificate chains and the algorithms negotiated before.
> > The challenge-response authentication comprises computing a hash over
> > all exchanged messages to detect modification by a man-in-the-middle
> > or media error.  The hash is then signed with the device's private key
> > and the resulting signature is verified by the kernel using the device's
> > public key from the certificate chain.  Nonces are included in the
> > message sequence to protect against replay attacks.
> > 
> > A simple API is provided for subsystems wishing to authenticate devices:
> > spdm_create(), spdm_authenticate() (can be called repeatedly for
> > reauthentication) and spdm_destroy().  Certificates presented by devices
> > are validated against an in-kernel keyring of trusted root certificates.
> > A pointer to the keyring is passed to spdm_create().
> > 
> > The set of supported cryptographic algorithms is limited to those
> > declared mandatory in PCIe r6.2 sec 6.31.3.  Adding more algorithms
> > is straightforward as long as the crypto subsystem supports them.
> > 
> > Future commits will extend this implementation with support for
> > measurement, key exchange and encrypted sessions.
> > 
> > So far, only the SPDM requester role is implemented.  Care was taken to
> > allow for effortless addition of the responder role at a later stage.
> > This could be needed for a PCIe host bridge operating in endpoint mode.
> > The responder role will be able to reuse struct definitions and helpers
> > such as spdm_create_combined_prefix().  
> 
> Nice changelog.
> 
> > 
> > Credits:  Jonathan wrote a proof-of-concept of this SPDM implementation.
> > Lukas reworked it for upstream.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  MAINTAINERS                 |  11 +
> >  include/linux/spdm.h        |  33 ++
> >  lib/Kconfig                 |  15 +
> >  lib/Makefile                |   2 +
> >  lib/spdm/Makefile           |  10 +
> >  lib/spdm/core.c             | 425 ++++++++++++++++++++++
> >  lib/spdm/req-authenticate.c | 704 ++++++++++++++++++++++++++++++++++++
> >  lib/spdm/spdm.h             | 520 ++++++++++++++++++++++++++
> >  8 files changed, 1720 insertions(+)
> >  create mode 100644 include/linux/spdm.h
> >  create mode 100644 lib/spdm/Makefile
> >  create mode 100644 lib/spdm/core.c
> >  create mode 100644 lib/spdm/req-authenticate.c
> >  create mode 100644 lib/spdm/spdm.h  
> 
> I only have some quibbles below, but the broad strokes look good to me.
> 
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d6c90161c7bf..dbe16eea8818 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20145,6 +20145,17 @@ M:	Security Officers <security@kernel.org>
> >  S:	Supported
> >  F:	Documentation/process/security-bugs.rst
> >  
> > +SECURITY PROTOCOL AND DATA MODEL (SPDM)
> > +M:	Jonathan Cameron <jic23@kernel.org>
> > +M:	Lukas Wunner <lukas@wunner.de>
> > +L:	linux-coco@lists.linux.dev
> > +L:	linux-cxl@vger.kernel.org
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> > +F:	include/linux/spdm.h
> > +F:	lib/spdm/
> > +
> >  SECURITY SUBSYSTEM
> >  M:	Paul Moore <paul@paul-moore.com>
> >  M:	James Morris <jmorris@namei.org>
> > diff --git a/include/linux/spdm.h b/include/linux/spdm.h
> > new file mode 100644
> > index 000000000000..0da7340020c4
> > --- /dev/null
> > +++ b/include/linux/spdm.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DMTF Security Protocol and Data Model (SPDM)
> > + * https://www.dmtf.org/dsp/DSP0274
> > + *
> > + * Copyright (C) 2021-22 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + *
> > + * Copyright (C) 2022-24 Intel Corporation
> > + */
> > +
> > +#ifndef _SPDM_H_
> > +#define _SPDM_H_
> > +
> > +#include <linux/types.h>
> > +
> > +struct key;
> > +struct device;
> > +struct spdm_state;
> > +
> > +typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
> > +				 const void *request, size_t request_sz,
> > +				 void *response, size_t response_sz);
> > +
> > +struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
> > +			       void *transport_priv, u32 transport_sz,
> > +			       struct key *keyring);
> > +
> > +int spdm_authenticate(struct spdm_state *spdm_state);
> > +
> > +void spdm_destroy(struct spdm_state *spdm_state);
> > +
> > +#endif
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index d33a268bc256..9011fa32af45 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -782,3 +782,18 @@ config POLYNOMIAL
> >  
> >  config FIRMWARE_TABLE
> >  	bool
> > +
> > +config SPDM
> > +	tristate
> > +	select CRYPTO
> > +	select KEYS
> > +	select ASYMMETRIC_KEY_TYPE
> > +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +	select X509_CERTIFICATE_PARSER
> > +	help
> > +	  The Security Protocol and Data Model (SPDM) allows for device
> > +	  authentication, measurement, key exchange and encrypted sessions.
> > +
> > +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> > +	  in .config.  Drivers selecting SPDM therefore need to also select
> > +	  any algorithms they deem mandatory.
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 3b1769045651..b2ef14d1fa71 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -301,6 +301,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
> >  obj-$(CONFIG_ASN1) += asn1_decoder.o
> >  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
> >  
> > +obj-$(CONFIG_SPDM) += spdm/
> > +
> >  obj-$(CONFIG_FONT_SUPPORT) += fonts/
> >  
> >  hostprogs	:= gen_crc32table
> > diff --git a/lib/spdm/Makefile b/lib/spdm/Makefile
> > new file mode 100644
> > index 000000000000..f579cc898dbc
> > --- /dev/null
> > +++ b/lib/spdm/Makefile
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# DMTF Security Protocol and Data Model (SPDM)
> > +# https://www.dmtf.org/dsp/DSP0274
> > +#
> > +# Copyright (C) 2024 Intel Corporation
> > +
> > +obj-$(CONFIG_SPDM) += spdm.o
> > +
> > +spdm-y := core.o req-authenticate.o
> > diff --git a/lib/spdm/core.c b/lib/spdm/core.c
> > new file mode 100644
> > index 000000000000..f06402f6d127
> > --- /dev/null
> > +++ b/lib/spdm/core.c
> > @@ -0,0 +1,425 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DMTF Security Protocol and Data Model (SPDM)
> > + * https://www.dmtf.org/dsp/DSP0274
> > + *
> > + * Core routines for message exchange, message transcript,
> > + * signature verification and session state lifecycle
> > + *
> > + * Copyright (C) 2021-22 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + *
> > + * Copyright (C) 2022-24 Intel Corporation
> > + */
> > +
> > +#include "spdm.h"
> > +
> > +#include <linux/dev_printk.h>
> > +#include <linux/module.h>
> > +
> > +#include <crypto/hash.h>
> > +#include <crypto/public_key.h>
> > +
> > +static int spdm_err(struct device *dev, struct spdm_error_rsp *rsp)  
> 
> This approach to error singnaling looks unprecedented, and not in a good
> way. I like the idea of a SPDM-error-code to errno converter, and
> separate SPDM-error-code to error string, but not an SPDM-error-code to
> errno conversion that has a log emitting side effect.

That's fair.  Using a common static const array of structs with string
and error code would also make this pair more readable by concentrating
the error code in one place.

> 
> Would this not emit ambiguous messages like:
> 
>     cxl_pci 0000:35:00.0: Unexpected request
> 
> How does I know that error message is from CXL SPDM functionality and
> not some other part of the driver?
> 
> What if the SPDM authentication is optional, how does the consumer of
> this library avoid log spam? What about rate limiting?
> 
> Did you consider leaving all error logging to the caller?

Problem there is that we've typically lost information because
of conversion to a smaller set of errno.

> 
> I have less problem if these all become dev_dbg() or tracepoints, but
> dev_err() seems awkward.

dev_dbg() seems like an easy solution to me.  Maybe add tracepoints
later...

> 
> > +{
> > +	switch (rsp->error_code) {
> > +	case SPDM_INVALID_REQUEST:
> > +		dev_err(dev, "Invalid request\n");
> > +		return -EINVAL;
> > +	case SPDM_INVALID_SESSION:
> > +		if (rsp->version == 0x11) {
> > +			dev_err(dev, "Invalid session %#x\n", rsp->error_data);
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case SPDM_BUSY:
> > +		dev_err(dev, "Busy\n");
> > +		return -EBUSY;
> > +	case SPDM_UNEXPECTED_REQUEST:
> > +		dev_err(dev, "Unexpected request\n");
> > +		return -EINVAL;
> > +	case SPDM_UNSPECIFIED:
> > +		dev_err(dev, "Unspecified error\n");
> > +		return -EINVAL;
> > +	case SPDM_DECRYPT_ERROR:
> > +		dev_err(dev, "Decrypt error\n");
> > +		return -EIO;
> > +	case SPDM_UNSUPPORTED_REQUEST:
> > +		dev_err(dev, "Unsupported request %#x\n", rsp->error_data);
> > +		return -EINVAL;
> > +	case SPDM_REQUEST_IN_FLIGHT:
> > +		dev_err(dev, "Request in flight\n");
> > +		return -EINVAL;
> > +	case SPDM_INVALID_RESPONSE_CODE:
> > +		dev_err(dev, "Invalid response code\n");
> > +		return -EINVAL;
> > +	case SPDM_SESSION_LIMIT_EXCEEDED:
> > +		dev_err(dev, "Session limit exceeded\n");
> > +		return -EBUSY;
> > +	case SPDM_SESSION_REQUIRED:
> > +		dev_err(dev, "Session required\n");
> > +		return -EINVAL;
> > +	case SPDM_RESET_REQUIRED:
> > +		dev_err(dev, "Reset required\n");
> > +		return -ECONNRESET;
> > +	case SPDM_RESPONSE_TOO_LARGE:
> > +		dev_err(dev, "Response too large\n");
> > +		return -EINVAL;
> > +	case SPDM_REQUEST_TOO_LARGE:
> > +		dev_err(dev, "Request too large\n");
> > +		return -EINVAL;
> > +	case SPDM_LARGE_RESPONSE:
> > +		dev_err(dev, "Large response\n");
> > +		return -EMSGSIZE;
> > +	case SPDM_MESSAGE_LOST:
> > +		dev_err(dev, "Message lost\n");
> > +		return -EIO;
> > +	case SPDM_INVALID_POLICY:
> > +		dev_err(dev, "Invalid policy\n");
> > +		return -EINVAL;
> > +	case SPDM_VERSION_MISMATCH:
> > +		dev_err(dev, "Version mismatch\n");
> > +		return -EINVAL;
> > +	case SPDM_RESPONSE_NOT_READY:
> > +		dev_err(dev, "Response not ready\n");
> > +		return -EINPROGRESS;
> > +	case SPDM_REQUEST_RESYNCH:
> > +		dev_err(dev, "Request resynchronization\n");
> > +		return -ECONNRESET;
> > +	case SPDM_OPERATION_FAILED:
> > +		dev_err(dev, "Operation failed\n");
> > +		return -EINVAL;
> > +	case SPDM_NO_PENDING_REQUESTS:
> > +		return -ENOENT;
> > +	case SPDM_VENDOR_DEFINED_ERROR:
> > +		dev_err(dev, "Vendor defined error\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_err(dev, "Undefined error %#x\n", rsp->error_code);
> > +	return -EINVAL;
> > +}
> > +
> > +/**
> > + * spdm_exchange() - Perform SPDM message exchange with device
> > + *
> > + * @spdm_state: SPDM session state
> > + * @req: Request message
> > + * @req_sz: Size of @req
> > + * @rsp: Response message
> > + * @rsp_sz: Size of @rsp
> > + *
> > + * Send the request @req to the device via the @transport in @spdm_state and
> > + * receive the response into @rsp, respecting the maximum buffer size @rsp_sz.
> > + * The request version is automatically populated.
> > + *
> > + * Return response size on success or a negative errno.  Response size may be
> > + * less than @rsp_sz and the caller is responsible for checking that.  It may
> > + * also be more than expected (though never more than @rsp_sz), e.g. if the
> > + * transport receives only dword-sized chunks.
> > + */
> > +ssize_t spdm_exchange(struct spdm_state *spdm_state,
> > +		      void *req, size_t req_sz, void *rsp, size_t rsp_sz)
> > +{
> > +	struct spdm_header *request = req;
> > +	struct spdm_header *response = rsp;
> > +	ssize_t rc, length;  
> 
> What's the locking assumption with this public function? I see that the
> internal to this file usages wrap it in the state lock. Should that
> assumption be codified with a:
> 
> lockdep_assert_held(&spdm_state->lock)
Seems reasonable to scatter those around.

> 
> ?
> 
> Or can this function be marked static?
Not without collapsing the various files into one.
> 
> > +
> > +	if (req_sz < sizeof(struct spdm_header) ||
> > +	    rsp_sz < sizeof(struct spdm_header))
> > +		return -EINVAL;
> > +
> > +	request->version = spdm_state->version;
> > +
> > +	rc = spdm_state->transport(spdm_state->transport_priv, spdm_state->dev,
> > +				   req, req_sz, rsp, rsp_sz);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	length = rc;
> > +	if (length < sizeof(struct spdm_header))
> > +		return length; /* Truncated response is handled by callers */
> > +
> > +	if (response->code == SPDM_ERROR)
> > +		return spdm_err(spdm_state->dev, (struct spdm_error_rsp *)rsp);
> > +
> > +	if (response->code != (request->code & ~SPDM_REQ)) {
> > +		dev_err(spdm_state->dev,
> > +			"Response code %#x does not match request code %#x\n",
> > +			response->code, request->code);
> > +		return -EPROTO;
> > +	}
> > +
> > +	return length;
> > +}

...

> > +
> > +/**
> > + * spdm_free_transcript() - Free transcript buffer
> > + *
> > + * @spdm_state: SPDM session state
> > + *
> > + * Free the transcript buffer after performing authentication.  Reset the
> > + * pointer to the current end of transcript as well as the allocation size.
> > + */
> > +void spdm_free_transcript(struct spdm_state *spdm_state)
> > +{
> > +	kvfree(spdm_state->transcript);
> > +	spdm_state->transcript_end = NULL;
> > +	spdm_state->transcript_max = 0;  
> 
> Similar locking context with public functions concern, but also the
> cleverness of why it is ok to not set ->transcript to NULL that really
> only hold true if spdm_append_transcript() and and
> spdm_free_transcript() are guaranteed to be serialized.

If there is any concurrency risk things have gone very very wrong.
However maybe it's worth adding locking/markings just to make that clear.
Any contention will make the transcript garbage but nothing
stops us making that explicit rather that relying on callers doing
the right thing.

> 
> > +}

> > +/**
> > + * spdm_verify_signature() - Verify signature against leaf key
> > + *
> > + * @spdm_state: SPDM session state
> > + * @spdm_context: SPDM context (used to create combined_spdm_prefix)
> > + *
> > + * Implementation of the abstract SPDMSignatureVerify() function described in
> > + * SPDM 1.2.0 section 16:  Compute the hash over @spdm_state->transcript and
> > + * verify that the signature at the end of the transcript was generated by
> > + * @spdm_state->leaf_key.  Hashing the entire transcript allows detection
> > + * of message modification by a man-in-the-middle or media error.
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int spdm_verify_signature(struct spdm_state *spdm_state,
> > +			  const char *spdm_context)
> > +{
> > +	struct public_key_signature sig = {
> > +		.s = spdm_state->transcript_end - spdm_state->sig_len,
> > +		.s_size = spdm_state->sig_len,
> > +		.encoding = spdm_state->base_asym_enc,
> > +		.hash_algo = spdm_state->base_hash_alg_name,
> > +	};
> > +	u8 *mhash __free(kfree) = NULL;
> > +	u8 *m __free(kfree);
> > +	int rc;
> > +
> > +	m = kmalloc(SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len, GFP_KERNEL);  
> 
> I am not a fan of forward declared scoped-based resource management
> variables [1], although PeterZ never responded to those suggestions.
> 
> [1]: http://lore.kernel.org/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com
> 
Agreed this is better as
	u8 *m __free(kfree) =
		kmalloc(SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len, GFP_KERNEL);

> > +	if (!m)
> > +		return -ENOMEM;
> > +
> > +	/* Hash the transcript (sans trailing signature) */
> > +	rc = crypto_shash_digest(spdm_state->desc, spdm_state->transcript,
> > +				 (void *)sig.s - spdm_state->transcript,
> > +				 m + SPDM_COMBINED_PREFIX_SZ);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (spdm_state->version <= 0x11) {
> > +		/*
> > +		 * SPDM 1.0 and 1.1 compute the signature only over the hash
> > +		 * (SPDM 1.0.0 section 4.9.2.7).
> > +		 */
> > +		sig.digest = m + SPDM_COMBINED_PREFIX_SZ;
> > +		sig.digest_size = spdm_state->hash_len;
> > +	} else {
> > +		/*
> > +		 * From SPDM 1.2, the hash is prefixed with spdm_context before
> > +		 * computing the signature over the resulting message M
> > +		 * (SPDM 1.2.0 sec 15).
> > +		 */
> > +		spdm_create_combined_prefix(spdm_state->version, spdm_context,
> > +					    m);
> > +
> > +		/*
> > +		 * RSA and ECDSA algorithms require that M is hashed once more.
> > +		 * EdDSA and SM2 algorithms omit that step.
> > +		 * The switch statement prepares for their introduction.
> > +		 */
> > +		switch (spdm_state->base_asym_alg) {
> > +		default:
and
			u8 *mhash __free(kfree) =
				kmalloc(spdm_state->hash_len, GFP_KERNEL);

With added bonus that the scope is reduced for this one.
You probably want to add explicit scope though with {} around the case block
so it's more obvious what the scope is.


> > +			mhash = kmalloc(spdm_state->hash_len, GFP_KERNEL);
> > +			if (!mhash)
> > +				return -ENOMEM;
> > +
> > +			rc = crypto_shash_digest(spdm_state->desc, m,
> > +				SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len,
> > +				mhash);
> > +			if (rc)
> > +				return rc;
> > +
> > +			sig.digest = mhash;
> > +			sig.digest_size = spdm_state->hash_len;
> > +			break;
> > +		}
> > +	}

