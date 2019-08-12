Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDE8A7C0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfHLUC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfHLUC5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:02:57 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3006420673;
        Mon, 12 Aug 2019 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640176;
        bh=ZtSUhTWtLgk+O84qk1NCx9xH17NjuNhCO7rz3VLE66I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXcAJTNHB3ZYjKTbUHi1zA+KSqOSopqe94euGeu69cHlwy5tKa0OaNOwl7Z738DR2
         dUcebA3lrLTBw4JVydLeduxmnpHNXrIlNOWIpbuUGKXaSjXmrVYWIem0/qH+OXg04T
         cALr6ataZ1ufvG6EsT2/HWJ8v6HdjGApMo6xyS1Y=
Date:   Mon, 12 Aug 2019 15:02:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190812200254.GF11785@google.com>
References: <20190811195944.23765-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195944.23765-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 10:59:40PM +0300, Denis Efremov wrote:
> PCIe defines two optional hotplug indicators: a Power indicator and an
> Attention indicator. Both are controlled by the same register, and each
> can be on, off or blinking. The current interfaces
> (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
> non-uniform and require two register writes in many cases where we could
> do one.
> 
> This patchset introduces the new function pciehp_set_indicators(). It
> allows one to set two indicators with a single register write. All
> calls to previous interfaces (pciehp_green_led_* and
> pciehp_set_attention_status()) are replaced with a new one. Thus,
> the amount of duplicated code for setting indicators is reduced.
> 
> Denis Efremov (4):
>   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
>   PCI: pciehp: Switch LED indicators with a single write
>   PCI: pciehp: Replace pciehp_set_attention_status()
>   PCI: pciehp: Replace pciehp_green_led_{on,off,blink}()
> 
>  drivers/pci/hotplug/pciehp.h      | 30 +++++++++++--
>  drivers/pci/hotplug/pciehp_ctrl.c | 14 +++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 74 +++++++++++--------------------
>  include/uapi/linux/pci_regs.h     |  2 +
>  4 files changed, 58 insertions(+), 62 deletions(-)

I really like these; thanks a lot for doing them.  A few comments
later...
