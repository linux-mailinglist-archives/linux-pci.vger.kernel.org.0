Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3217461B48
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhK2Puj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 10:50:39 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:47491 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhK2Psh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 10:48:37 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 10:48:37 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EC4232805F0AC;
        Mon, 29 Nov 2021 16:45:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DF6FA30CB13; Mon, 29 Nov 2021 16:45:18 +0100 (CET)
Date:   Mon, 29 Nov 2021 16:45:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock)
 to fix lockdep errors
Message-ID: <20211129154518.GB4896@wunner.de>
References: <20211129121934.4963-1-hdegoede@redhat.com>
 <20211129121934.4963-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129121934.4963-2-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 01:19:34PM +0100, Hans de Goede wrote:
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -106,6 +106,7 @@ struct controller {
>  
>  	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
>  	struct rw_semaphore reset_lock;
> +	unsigned int depth;
>  	unsigned int ist_running;
>  	int request_result;
>  	wait_queue_head_t requester;

Could you amend the kernel-doc of the struct with a short explanation
of the attribute you're adding above?  Thanks!
