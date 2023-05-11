Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EA6FEC06
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEKG5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEKG47 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 02:56:59 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544756A76;
        Wed, 10 May 2023 23:56:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B571D100EF4DF;
        Thu, 11 May 2023 08:56:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8B8E4228AE5; Thu, 11 May 2023 08:56:36 +0200 (CEST)
Date:   Thu, 11 May 2023 08:56:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230511065636.GA2478@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
 <8e1e8daa-f6d5-3cb9-e2d1-cb4ef8f7f3ad@linux.intel.com>
 <5efcb6a9-5878-1e26-dd43-2e4bd01bc8a1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efcb6a9-5878-1e26-dd43-2e4bd01bc8a1@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 02:42:13PM -0700, Smita Koralahalli wrote:
> As far as I can see, async removal solely with DPC is not handled properly
> in Linux.

The dpc driver can react to a DPC event, attempt reset recovery.

But it doesn't do de-enumeration or re-enumeration of subordinate devices.
It also doesn't do slot handling (enable/disable Power Controller etc).
That's only implemented in the hotplug driver.

PCIe r6.0.1 contains appendix I.2 which basically suggests to "use DPC"
for async hot-plug but that doesn't really seem to make sense.


> On AMD systems, PDSC is triggered along with DPC on a async remove. And this
> PDSC event (hotplug handler) will unconfigure and uninitialize the driver
> and device.
> This is one thing which I wanted clarity on as per my question in v1.
> Whether all systems
> trigger PDSC on a async remove along with DPC?

In principle, yes.  Actually the hotplug driver will see both a DLLSC
*and* a PDC event and will react to whichever comes first.  Experience
has shown that the two events may occur in arbitrary order and with
significant delays in-between.

There are systems which erroneously hardwire Presence Detect to zero.
The hotplug driver works even with those.  It solely relies on the
DLLSC event then, see commit 80696f991424 ("PCI: pciehp: Tolerate
Presence Detect hardwired to zero").


> I feel there are two approaches going forward. Since, hotplug handler is
> also
> triggered with PDSC, rely on it to bring down the device and prevent calling
> the
> error_recovery process in dpc handler as its not a true error event. I have
> taken this
> approach.
> 
> Or, don't call the hotplug handler at all and rely on DPC solely to bring
> down the device
> but here, there should be additional callbacks to unconfigure and
> uninitialize the pcie
> driver and currently I only see report_slot_reset() being called from
> error_recovery()
> and I don't think it unconfigures the driver/device.

The latter approach doesn't really make sense to me because we'd have to
duplicate all the slot handling and device de-/re-enumeration in the dpc
driver.

Let's try masking Surprise Down Errors first and see how that goes.

Thanks,

Lukas
