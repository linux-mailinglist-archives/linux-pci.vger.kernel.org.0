Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C60691B1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbfGOObN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 10:31:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42996 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391774AbfGOObD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 10:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1q5vtulX6Voxl789kmHFwf18zdh2bTyKV31IcrNYlLA=; b=0SHdyISmTAhQj+0wpGceHAUIQ
        6HS9PebCXS+39jDY9iNPYXVKRqYi1gBrBXaS7sNqNA/g/Zr5SVThPXxmWEo6eStZeKLfOppKF0amL
        zMHtIQlTdiGR8lNBXHz874HdfLkO58xGI8VRC9RGel2NBaCxgveaeHUMx1Jz429UWQNGCuXRFJ2BH
        dTPZevJQqSpg4BKE85xt3DIp39i0KWWQsBGLJ5OzZUfBkunigZpT53hJz1RZEWz7wokpD93uiLiJD
        Ueuww5IATrGGsFwGEQN9Vey86Zx7q1o5M3WG1tRyyELi2Zax2763jR59xK4HEPH8l4qJ1h+o/sEYO
        5AIlIc4oA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59510)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hn20E-0005Ur-0P; Mon, 15 Jul 2019 15:30:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hn206-0008QY-WD; Mon, 15 Jul 2019 15:30:47 +0100
Date:   Mon, 15 Jul 2019 15:30:46 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: pci-bridge-emul: fix big-endian support
Message-ID: <20190715143046.r3ja32rfntagqrqr@shell.armlinux.org.uk>
References: <1563200177-8380-1-git-send-email-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563200177-8380-1-git-send-email-jaz@semihalf.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 04:16:17PM +0200, Grzegorz Jaszczyk wrote:
> Perform conversion to little-endian before every write to configuration
> space and converse back to cpu endianness during read. Additionally
> initialise every not-byte wide fields of config space with proper
> cpu_to_le* macro.
> 
> This is required since the structure describing config space of emulated
> bridge assumes little-endian convention.

This is insufficient - pci-bridge-emul.h needs to be fixed up to use
__le32 and __le16.

It is a good idea to check such changes with sparse - a tool originally
written by Linus, which is able to detect incorrect endian accesses
(iow, access to LE members without using a LE accessor.)  Such checks
rely on using the right types.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
