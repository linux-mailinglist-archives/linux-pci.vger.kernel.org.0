Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E775B489310
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 09:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiAJIKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 03:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiAJIKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 03:10:46 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3646C06173F
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 00:10:45 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JXRN16lvLzQjnW;
        Mon, 10 Jan 2022 09:10:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <4264ac63-6072-5a43-2f5e-79d899cf0882@denx.de>
Date:   Mon, 10 Jan 2022 09:10:37 +0100
MIME-Version: 1.0
Subject: Re: "PCI/MSI: Mask MSI-X vectors only on success" (boot problem on
 c4.large)
Content-Language: en-US
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Ydh5OCudJKz5Y7jc@arighi-desktop>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <Ydh5OCudJKz5Y7jc@arighi-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrea,

On 1/7/22 18:32, Andrea Righi wrote:
> I'm experiencing some boot problems on c4.large instances on AWS with
> this commit applied (system stuck at boot - no oops or panic, just
> stuck):
> 
>   83dbf898a2d4 ("PCI/MSI: Mask MSI-X vectors only on success")
> 
> If I revert this commit the boot completes correctly (found doing a
> bisect).
> 
> I'm using a 5.15.12 kernel. Let me know if there's anything I can do to
> better track down the issue. For now I've just reverted the commit.

Sorry, I don't have a good idea what might go wrong here. Perhaps Thomas
has some thoughts on this?

Thanks,
Stefan
