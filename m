Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA8162904
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBRPB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 10:01:26 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52481 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgBRPB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2020 10:01:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3B2DA30004511;
        Tue, 18 Feb 2020 16:01:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1084E14BA9C; Tue, 18 Feb 2020 16:01:24 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:01:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Stack trace when removing Thunderbolt devices while kernel
 shutting down
Message-ID: <20200218150124.stvsj2rozxrgxw2h@wunner.de>
References: <PSXP216MB0438220243C0097569D4B2DB80110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438220243C0097569D4B2DB80110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 18, 2020 at 02:18:40PM +0000, Nicholas Johnson wrote:
> If I surprise remove Thunderbolt 3 devices just as the kernel is 
> shutting down, I get stack dumps, when those devices would not normally 
> cause stack dumps if the kernel were not shutting down.
> 
> Because the kernel is shutting down, it makes it difficult to capture 
> the logs without a serial console.

Hold a camera in front of the screen and try to capture the messages
as an MP4 movie which can be uploaded to YouTube or something.

If the output moves too fast to capture it, artificially slow it down
by adding a udelay() to call_console_drivers() in kernel/printk/printk.c.

Thanks,

Lukas
