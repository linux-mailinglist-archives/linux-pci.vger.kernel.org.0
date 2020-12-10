Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F22D6976
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 22:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbgLJVI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 16:08:26 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46127 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404615AbgLJVIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 16:08:17 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 16:08:16 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB5B93000629E;
        Thu, 10 Dec 2020 21:56:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EBBF310692; Thu, 10 Dec 2020 21:57:19 +0100 (CET)
Date:   Thu, 10 Dec 2020 21:57:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/1] PCI: pciehp: Add support for handling MRL events
Message-ID: <20201210205719.GA25769@wunner.de>
References: <20201122014203.4706-1-ashok.raj@intel.com>
 <20201122090852.GA29616@wunner.de>
 <20201203225124.GA72369@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203225124.GA72369@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 02:51:24PM -0800, Raj, Ashok wrote:
> - Press ATTN, 
> - Slot is empty
> - After 5 seconds synthetic PDC arrives.
>   but since no presence and no link active, we leave slot in 
>   BLINKINGON_STATE, and led keeps blinking
> 
> if someone were to add a card after the 5 seconds, no hot-add is processed
> since we don't get notifications for PDC events when ATTN exists.
> 
> Can we automatically cancel the blinking and return slot back to OFF_STATE?

Yes.


> If the operation initiated by the attention button fails for any reason, it
> is recommended that system software present an error message explaining
> failure via a software user interface, or add the error message to system
> log.

Ah so we're supposed to log a message if the slot is empty.
That needs to be added then to the code snippet I sent you
yesterday in response to your off-list e-mail.


> Alternately we can also choose to subscribe to PDC, but ignore if slot is
> in OFF_STATE. So we let ATTN drive the add. But if PDC happens and we are
> in BLINKINGON_STATE, then we can process the hot-add? Spec says a software
> recommendation, but i think the cancel after 5 seconds seems better?

That approach seems more complicated.  It's better to stop blinking
and return to OFF_STATE if after the 5 second interval the slot is
found to be empty.

Thanks,

Lukas
