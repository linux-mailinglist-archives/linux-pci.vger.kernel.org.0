Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3244FF56
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhKOHsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKOHsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:48:41 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBAC061746
        for <linux-pci@vger.kernel.org>; Sun, 14 Nov 2021 23:45:44 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E79CC30000649;
        Mon, 15 Nov 2021 08:45:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DACF4FEC4B; Mon, 15 Nov 2021 08:45:42 +0100 (CET)
Date:   Mon, 15 Nov 2021 08:45:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211115074542.GA24942@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114173550-mutt-send-email-mst@kernel.org>
 <20211114122249-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 05:37:15PM -0500, Michael S. Tsirkin wrote:
> On Sun, Nov 14, 2021 at 07:06:04PM +0100, Lukas Wunner wrote:
> > Why don't you just trigger surprise-removal from outside the guest?
> 
> Because linux does not handle it well for all devices.  Fixing that
> requires fixing all drivers.

Please expose surprise removal in addition to the Attention Button
to avoid perpetuating this situation.  Teach users to use that for
devices whose drivers already support it well and fall back to the
Attention Button only for those that don't.

macOS and Windows support surprise-removal of most hardware well.
We've made a lot of progress in that area (AMD for one has been
working on surprise removal of GPUs).  It's an embarrassment if
contortions such as abusing the Attention Button are needed just
because surprise removal doesn't work for everything.  I'd like
to see engineering resources spent on fixing surprise removal for
drivers that are relevant for you, rather than implementing
workarounds such as this one.

Thanks,

Lukas
