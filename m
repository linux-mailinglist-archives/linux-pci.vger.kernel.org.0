Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65B51CA54F
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHHiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 03:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHHiD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 03:38:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303AD206D5;
        Fri,  8 May 2020 07:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588923482;
        bh=HgSffkZ3pjQDj7iS38C707e8soAKo3/5HEBzFLGlmGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiYMAXyOOzjj5TJpsGy3geryC12x8gjVFEBMUeV570xP5rrJAfXg8C7lWeo/UXS3n
         hpGS+w0y5NN/8N2zg/q2WXmSRS1ac9NobH5JQ/DXBiAxlv5QSAN7j6RjgY13sImqS3
         3p3sBNVDwbtvl4fylYuSRr7o9wvh1CdCOp199cDA=
Date:   Fri, 8 May 2020 09:38:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Jiri Slaby <jslaby@suse.com>,
        Je Yen Tam <je.yen.tam@ni.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jay Dolan <jay.dolan@accesio.com>,
        Denis Efremov <efremov@linux.com>,
        "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: 8250_pci: Move Pericom IDs to pci_ids.h
Message-ID: <20200508073800.GC3374631@kroah.com>
References: <20200508065343.32751-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508065343.32751-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 08, 2020 at 02:53:40PM +0800, Kai-Heng Feng wrote:
> Move the IDs to pci_ids.h so it can be used by next patch.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 6 ------
>  include/linux/pci_ids.h            | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
