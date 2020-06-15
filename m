Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156AB1F9FE3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgFOTGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOTGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 15:06:48 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Jun 2020 12:06:47 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7EAC061A0E
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 12:06:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 791F510379560;
        Mon, 15 Jun 2020 20:56:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD3A151FE25; Mon, 15 Jun 2020 20:56:50 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:56:50 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ian May <ian.may@canonical.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with
 reset_lock and device_lock
Message-ID: <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
References: <20200615143250.438252-1-ian.may@canonical.com>
 <20200615143250.438252-2-ian.may@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615143250.438252-2-ian.may@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 09:32:49AM -0500, Ian May wrote:
> Currently when a hotplug interrupt and AER recovery triggers simultaneously
> the following deadlock can occur.
> 
>         Hotplug				       AER
> ----------------------------       ---------------------------
> device_lock(&dev->dev)		   down_write(&ctrl->reset_lock)
> down_read(&ctrl->reset_lock)       device_lock(&dev->dev)
> 
> This patch adds a reset_lock and reset_unlock hotplug_slot_op.
> This would allow the controller reset_lock/reset_unlock to be moved
> from pciehp_reset_slot to pci_slot_reset function allowing the controller
> reset_lock to be acquired before the device lock allowing for both hotplug
> and AER to grab the reset_lock and device lock in proper order.

I've posted a patch to address such issues on Mar 31, just haven't
gotten around to respin it with a proper commit message:

https://lore.kernel.org/linux-pci/20200331130139.46oxbade6rcbaicb@wunner.de/

I've solved it by moving the reset lock into struct pci_slot.
I think that's simpler than adding two callbacks.

Do you think the AER deadlock could be fixed based on my approach?

Thanks,

Lukas
