Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27746343B4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 19:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiKVSeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 13:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiKVSeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 13:34:23 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF17C6B5;
        Tue, 22 Nov 2022 10:34:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6C08C2800BBC5;
        Tue, 22 Nov 2022 19:34:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5F64AA072B; Tue, 22 Nov 2022 19:34:20 +0100 (CET)
Date:   Tue, 22 Nov 2022 19:34:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/2] PCI: hotplug: Add checks to avoid doing hotplug
 on PCIe Upstream Ports
Message-ID: <20221122183420.GA22578@wunner.de>
References: <5623410.DvuYhMxLoT@kreacher>
 <20221122180603.GA205176@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122180603.GA205176@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 12:06:03PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 21, 2022 at 07:13:15PM +0100, Rafael J. Wysocki wrote:
> > PCIe Upstream Ports are not hotplug-capable by definition, but it turns out
> > that in some cases, if the system is configured in a particularly interesting
> > way, the kernel may be made attempt to operate an Upstream Port as a hotplug
> > one which causes functional issues to appear.
> > 
> > The following 2 patches amend the code to prevent this behavior from occurring.
> 
> Thanks, applied to pci/hotplug for v6.2.  Lukas, I didn't presume to
> convert your LGTM to Reviewed-by, but would be happy add it.

I figured that having both a Suggested-by and a Reviewed-by might
look odd, hence went with the more neutral LGTM.  But I see it was
ambiguous.  Either way is fine for me. :)

Thanks,

Lukas
