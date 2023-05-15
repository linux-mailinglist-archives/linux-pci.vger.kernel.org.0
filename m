Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BDA703DC8
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbjEOTik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOTik (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 15:38:40 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB710C1;
        Mon, 15 May 2023 12:38:37 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C53AC2800B776;
        Mon, 15 May 2023 21:38:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BC13C1B8046; Mon, 15 May 2023 21:38:35 +0200 (CEST)
Date:   Mon, 15 May 2023 21:38:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Message-ID: <20230515193835.GA17526@wunner.de>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
 <20230510201937.GA11550@wunner.de>
 <20230511152326.GA16215@wunner.de>
 <579cb233-4827-2d03-56ad-1b807a189ba8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579cb233-4827-2d03-56ad-1b807a189ba8@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 12:20:42PM -0700, Smita Koralahalli wrote:
> On 5/11/2023 8:23 AM, Lukas Wunner wrote:
> > Subject: [PATCH] PCI: pciehp: Disable Surprise Down Error reporting
> > 
> > On hotplug ports capable of surprise removal, Surprise Down Errors are
> > expected and no reason for AER or DPC to spring into action.  Although
> > a Surprise Down event might be caused by an error, software cannot
> > discern that from regular surprise removal.
> > 
> > Any well-behaved BIOS should mask such errors, but Smita reports a case
> > where hot-removing an Intel NVMe SSD [8086:0a54] from an AMD Root Port
> > [1022:14ab] results in irritating AER log messages and a delay of more
> > than 1 second caused by DPC handling:
[...]
> Thanks for the patch. I tested it and I notice that the AER status registers
> will still be set. I just don't see a DPC event with these settings.
> 
> I have logged in the status registers after the device is removed in
> pciehp_handle_presence_or_link_change().
[...]
> Section 6.2.3.2.2 in PCIe Spec v6.0 has also mentioned that:
> "If an individual error is masked when it is detected, its error status bit
> is still affected, but no error reporting Message is sent to the Root
> Complex, and the error is not recorded in the Header Log, TLP Prefix Log, or
> First Error Pointer"..

Thanks for the thorough testing.  So the error is logged and next time
a reporting message for a different error is sent to the Root Complex,
that earlier Surprise Down Error will be seen and you'd get belated
log messages for it, is that what you're saying?

I guess I could amend the patch to let pciehp unconditionally clear
the Surprise Down Error Status bit upon a DLLSC event.

Does the patch otherwise do what you want, i.e. no irritating messages
and no extra delay incurred by AER/DPC handling?

Thanks!

Lukas
