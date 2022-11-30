Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2563CFBB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiK3Haz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 02:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3Haz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 02:30:55 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546B2D771
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 23:30:53 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id AF29B100DE9DD;
        Wed, 30 Nov 2022 08:30:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 897ABA072C; Wed, 30 Nov 2022 08:30:51 +0100 (CET)
Date:   Wed, 30 Nov 2022 08:30:51 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Message-ID: <20221130073051.GA8198@wunner.de>
References: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
 <Y4Y1EYZ+1Otx9LaT@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Y1EYZ+1Otx9LaT@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 09:36:33AM -0700, Keith Busch wrote:
> On Tue, Nov 29, 2022 at 08:35:55AM +0100, Lukas Wunner wrote:
> > Add DPC Software Trigger as a reset method to be used for silicon
> > validation among other things:
> 
> Do you really need a kernel helper to do this? You can test these with
> 
>   # setpci -s <dsp's b:d.f> ECAP_DPC+6.w=40:40
> 
> And since the kernel is a not aware you are synthesizing the DPC event,
> that more naturally tests how the kernel would react to a hardware dpc
> trigger.

I've seen people write a value directly instead of using the "data:mask"
syntax above and that's dangerous because the register is under the
control of the kernel.

By exposing software trigger as a reset method I hope to make its
invocation error-proof and more comfortable.

Thanks,

Lukas
