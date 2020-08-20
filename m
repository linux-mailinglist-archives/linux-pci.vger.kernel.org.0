Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8274F24B0E3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHTIQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 04:16:45 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:36653 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgHTINW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 04:13:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4566C30000CCE;
        Thu, 20 Aug 2020 10:13:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E4AED16038D; Thu, 20 Aug 2020 10:13:14 +0200 (CEST)
Date:   Thu, 20 Aug 2020 10:13:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train links
 in 100 ms
Message-ID: <20200820081314.l25cjoehbnvbjbrk@wunner.de>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 04:06:25PM +0300, Mika Westerberg wrote:
> Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
> at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
> JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
[...]
> +	 * Also do the same for devices that have power management disabled
> +	 * by their driver and are completely power managed through the
> +	 * root port power resource instead. This is a special case for
> +	 * nouveau.
>  	 */
> -	if (!pci_is_pcie(dev)) {
> +	if (!pci_is_pcie(dev) || !child->pm_cap) {

It sounds like the above-mentioned Thunderbolt controllers are broken,
not the Nvidia cards, so to me (as an outside observer) it would seem
more logical that a quirk for the former is needed.  The code comment
suggests that nouveau somehow has a problem, but that doesn't seem to
be the case (IIUC).  Also, it's a little ugly to have references to
specific drivers in PCI core code.

Maybe this can be fixed with quirks for the Thunderbolt controllers
which set a flag, and that flag causes the 1000 msec wait to be skipped?

Thanks,

Lukas
