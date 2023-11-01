Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CA7DDD2A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 08:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjKAH1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjKAH1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 03:27:23 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB38E4;
        Wed,  1 Nov 2023 00:27:19 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B8605100D9404;
        Wed,  1 Nov 2023 08:27:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6577B1BAC8D; Wed,  1 Nov 2023 08:27:17 +0100 (CET)
Date:   Wed, 1 Nov 2023 08:27:17 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     linux-coco@lists.linux.dev, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: TDISP enablement
Message-ID: <20231101072717.GB25863@wunner.de>
References: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
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

On Wed, Nov 01, 2023 at 09:56:11AM +1100, Alexey Kardashevskiy wrote:
> - device_connect - starts CMA/SPDM session, returns measurements/certs,
> runs IDE_KM to program the keys;

Does the PSP have a set of trusted root certificates?
If so, where does it get them from?

If not, does the PSP just blindly trust the validity of the cert chain?
Who validates the cert chain, and when?
Which slot do you use?
Do you return only the cert chain of that single slot or of all slots?
Does the PSP read out all measurements available?  This may take a while
if the measurements are large and there are a lot of them.


> - tdi_info - read measurements/certs/interface report;

Does this return cached cert chains and measurements from the device
or does it retrieve them anew?  (Measurements might have changed if
MEAS_FRESH_CAP is supported.)


> If the user wants only CMA/SPDM, the Lukas'es patched will do that without
> the PSP. This may co-exist with the AMD PSP (if the endpoint allows multiple
> sessions).

It can co-exist if the pci_cma_claim_ownership() library call
provided by patch 12/12 is invoked upon device_connect.

It would seem advantageous if you could delay device_connect
until a device is actually passed through.  Then the OS can
initially authenticate and measure devices and the PSP takes
over when needed.


> If the user wants only IDE, the AMD PSP's device_connect needs to be called
> and the host OS does not get to know the IDE keys. Other vendors allow
> programming IDE keys to the RC on the baremetal, and this also may co-exist
> with a TSM running outside of Linux - the host still manages trafic classes
> and streams.

I'm wondering if your implementation is spec compliant:

PCIe r6.1 sec 6.33.3 says that "It is permitted for a Root Complex
to [...] use implementation specific key management."  But "For
Endpoint Functions, [...] Function 0 must implement [...]
the IDE key management (IDE_KM) protocol as a Responder."

So the keys need to be programmed into the endpoint using IDE_KM
but for the Root Port it's permitted to use implementation-specific
means.

The keys for the endpoint and Root Port are the same because this
is symmetric encryption.

If the keys are internal to the PSP, the kernel can't program the
keys into the endpoint using IDE_KM.  So your implementation precludes
IDE setup by the host OS kernel.

device_connect is meant to be used for TDISP, i.e. with devices which
have the TEE-IO Supported bit set in the Device Capabilities Register.

What are you going to do with IDE-capable devices which have that bit
cleared?  Are they unsupported by your implementation?

It seems to me an architecture cannot claim IDE compliance if it's
limited to TEE-IO capable devices, which might only be a subset of
the available products.


> The next steps:
> - expose blobs via configfs (like Dan did configfs-tsm);
> - s/tdisp.ko/coco.ko/;
> - ask the audience - what is missing to make it reusable for other vendors
> and uses?

I intend to expose measurements in sysfs in a measurements/ directory
below each CMA-capable device's directory.  There are products coming
to the market which support only CMA and are not interested in IDE or
TISP.  When bringing up TDISP, measurements received as part of an
interface report must be exposed in the same way so that user space
tooling which evaluates the measurememt works both with TEE-IO capable
and incapable products.  This could be achieved by fetching measurements
from the interface report instead of via SPDM when TDISP is in use.

Thanks,

Lukas
