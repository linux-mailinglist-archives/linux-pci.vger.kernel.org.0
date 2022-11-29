Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2774863C4A9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiK2QGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 11:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiK2QGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 11:06:31 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514513F46
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 08:06:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id AC86D2800C982;
        Tue, 29 Nov 2022 17:06:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A1068173A43; Tue, 29 Nov 2022 17:06:26 +0100 (CET)
Date:   Tue, 29 Nov 2022 17:06:26 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221129160626.GA19822@wunner.de>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
 <20221128203932.GA644781@bhelgaas>
 <20221128150617.14c98c2e.alex.williamson@redhat.com>
 <20221129064812.GA1555@wunner.de>
 <20221129065242.07b5bcbf.alex.williamson@redhat.com>
 <Y4YgKaml6nh5cB9r@black.fi.intel.com>
 <20221129084646.0b22c80b.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129084646.0b22c80b.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 08:46:46AM -0700, Alex Williamson wrote:
> Maybe the elephant in the room is why it's apparently such common
> practice to need to perform a hard reset these devices outside of
> virtualization scenarios...

These GPUs are used as accelerators in cloud environments.

They're reset to a pristine state when handed out to another tenant
to avoid info leaks from the previous tenant.

That should be a legitimate usage of PCIe reset, no?

Thanks,

Lukas
