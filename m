Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2817DDD4C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 08:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjKAHiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 03:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjKAHiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 03:38:17 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05CC2;
        Wed,  1 Nov 2023 00:38:15 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 12FA7100D9404;
        Wed,  1 Nov 2023 08:38:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DEC64120EBC; Wed,  1 Nov 2023 08:38:13 +0100 (CET)
Date:   Wed, 1 Nov 2023 08:38:13 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: TDISP enablement
Message-ID: <20231101073813.GC25863@wunner.de>
References: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
 <CAAH4kHYgMKv2xYT8=4Vx7i8hhpCOMZNdzf8G4fbNdx=9gQ8Y1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHYgMKv2xYT8=4Vx7i8hhpCOMZNdzf8G4fbNdx=9gQ8Y1w@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 04:40:56PM -0700, Dionna Amalie Glaze wrote:
> Only read? Can user space not provide a nonce for replay protection
> here, or is that just inherent to the SPDM channel setup, and the

That's internal to SPDM, regardless whether SPDM is handled by the
TSM or OS kernel.


> These vendored certificates will only grow in size, and they're

The size of a cert chain is limited to 64 kByte by the SPDM spec.

A device may have 8 slots, each containing a cert chain.


> device-specific, so it makes sense for machines to have a local cache
> of all the provisioned certificates that get forwarded to the guest
> through the VMM. I'd like to see this kind of blob reporting as a more
> general mechanism, however, so we can get TDX-specific blobs in too
> without much fuss.

Cert chains and measurements from the interface report need to be
exposed as individual sysfs attributes for compatibility with
TEE-IO incapable devices.

Blobs make zero sense here.  Doubly so if they're vendor-specific.

Thanks,

Lukas
