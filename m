Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55F52042E
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiEISLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiEISLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 14:11:17 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63FBF40;
        Mon,  9 May 2022 11:07:21 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 72A45300002AC;
        Mon,  9 May 2022 20:07:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 623D8B1FD3; Mon,  9 May 2022 20:07:17 +0200 (CEST)
Date:   Mon, 9 May 2022 20:07:17 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        keyrings@vger.kernel.org, Bjorn Helgaas <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        dan.j.williams@intel.com
Subject: Re: [RFC PATCH v2 12/14] spdm: Introduce a library for DMTF SPDM
Message-ID: <20220509180717.GA7015@wunner.de>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
 <20220303135905.10420-13-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303135905.10420-13-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 03, 2022 at 01:59:03PM +0000, Jonathan Cameron wrote:
> --- /dev/null
> +++ b/include/linux/spdm.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMTF Security Protocol and Data Model
> + *

Please amend this comment at the top of both spdm.h and spdm.c
with a link to https://www.dmtf.org/dsp/DSP0274
so the casual reader knows the document number and
knows where to find the spec.


> +struct spdm_header {
> +	u8 version;
> +	u8 code;  /* requestresponsecode */
> +	u8 param1;
> +	u8 param2;
> +};

I think you need to add __packed to all of the message structs
to ensure the compiler doesn't add padding anywhere.


> +struct spdm_exchange {
> +	struct spdm_header *request_pl;
> +	size_t request_pl_sz;
> +	struct spdm_header *response_pl;
> +	size_t response_pl_sz;

I assume "pl" means payload.  This isn't accurate as the spec defines
payload as the message body only (i.e. sans header).
I'd just omit the "_pl" suffix.


> +int spdm_measurements_get(struct spdm_state *spdm_state);

That function is declared in spdm.h but there's no implementation
provided in this patch.  Probably a leftover from an older iteration?


> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -289,6 +289,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>  obj-$(CONFIG_ASN1) += asn1_decoder.o
>  obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
>  
> +obj-$(CONFIG_SPDM) += spdm.o

It certainly seems wise to put this in lib/ so that it can be used by
other buses as well once they add encryption/authentication.
It's clearly not a PCIe-only feature.

I'm thinking of USB specifically since the USB Authentication Spec
seems to have served as a blueprint for SPDM.

I'd suggest to only include a forward declaration of struct spdm_state
in spdm.h to avoid exposing internals.  I'd further suggest to expose
one function to allocate & initialize an spdm_state.  By initialize I mean
that a transport function pointer is passed in which is stored in
struct spdm_state.  The transport function performs one request/response
transaction.  I think you should not mark the dev pointer in struct
spdm_state as "For error reporting only", rather that's the device with
which an SPDM exchange is performed.  The transport function should use
that dev pointer instead of duplicating the pointer in transport_priv.

Authenticating a device would thus encompass two function calls,
one to allocate & initialize spdm_state, another one to perform
SPDM session setup (which does authentication).

Encryption would encompass a third function call to set up IDE.


> +	spdm_state->measurement_hash_alg = __ffs(le16_to_cpu(rsp->measurement_hash_algo));
> +	spdm_state->base_asym_alg = __ffs(le16_to_cpu(rsp->base_asym_sel));
> +	spdm_state->base_hash_alg = __ffs(le16_to_cpu(rsp->base_hash_sel));

The weaker algorithms are represented by lower bits, so this selects
the weakest supported algorithm.  Wouldn't we want the opposite?
I guess that's a policy decision that user space should decide...

Thanks,

Lukas
