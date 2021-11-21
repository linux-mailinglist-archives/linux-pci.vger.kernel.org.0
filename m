Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61DA458664
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 21:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhKUUvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 15:51:12 -0500
Received: from mail.godzilla.net.ua ([178.209.51.88]:51370 "EHLO
        mail.godzilla.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhKUUvL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 15:51:11 -0500
Received: from refinery (unknown [31.43.105.136])
        by mail.godzilla.net.ua (Postfix) with ESMTPSA id 58518127;
        Sun, 21 Nov 2021 22:48:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dedrozeba.org.ua;
        s=dedrozeba1; t=1637527684;
        bh=CgaGwblDkEzI1kbHAQwtAHpClopf+h9NF4o8XWTEQnI=;
        h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:from;
        b=04rmagia85NtUC+uHdHDYFKgO6f9gAReuG/yHLGHQy600tu2asoxqRihQcV53UGIU
         5OnhYM7welhiLnnjeE3xAShBThjSKYAoRwR7c21h+6pDeormVYswmoShQEjhCmM1aJ
         5A5zEQw2RWve24FOoDtBFCAi+ZfuPiOTv3L5tlpoHXuqolCTYc/DRF2D0DSr+EmWtT
         rLpPRbFVV/5GCjb5/DiAWtDxkHGN4Cw1X3yXoUIu4kggo5djj/QtaVK0/XdavHUniP
         4cRnETg6jmyqax98hJUEbl6gS+BUxzoa+Ji6crycQaxPzx6ixzpO+fKrlAZLT0v13q
         q/MoCVsrLe47Q==
Date:   Sun, 21 Nov 2021 22:48:02 +0200
From:   Maxym Synytsky <synytsky@dedrozeba.org.ua>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Yuji Nakao <contact@yujinakao.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Message-ID: <20211121224802.24b0565b@refinery>
In-Reply-To: <87a6hxs2l4.wl-maz@kernel.org>
References: <87h7ccw9qc.fsf@yujinakao.com>
        <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
        <YZQ+GhRR+CPbQ5dX@rocinante>
        <8735nv880m.wl-maz@kernel.org>
        <YZTNCO4OBUrVkCuA@rocinante>
        <20211121174118.231086eb@refinery>
        <87a6hxs2l4.wl-maz@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 21 Nov 2021 19:58:31 +0000
Marc Zyngier <maz@kernel.org> wrote:

> > Hi.
> > I am also experiencing this issue on Gigabyte GA-M720-US3 mobo which uses
> > NVIDIA nForce 720D chipset. As I understand from the quirks patch it does
> > not fix my controller?  
> 
> Are you sure? The dmesg you attached to this email shows otherwise:
> 
Yes, this dmesg is for 5.14 kernel which works fine.
For some reason Arch complains in initramfs that root is locked and I am not
dropped to recovery shell so getting dmesg for 5.15 would be tricky for me.

Max.
