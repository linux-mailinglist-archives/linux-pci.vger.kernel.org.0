Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA245C931
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbhKXPzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhKXPzA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 10:55:00 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C20C061574;
        Wed, 24 Nov 2021 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wQ9c1OyXliyVa3SZJEUE6NB0qCU3PeHRx3gFUjMhhYs=; b=Ae7WQrBWTZDIYvyutWusRzRTBn
        z30jfyALoVO6oBfTUtZs+0NzOcx78MbmkQ1u940EKXqsWk+a8sELPnby7Eqa9xyZHp2NPjrgHK6aj
        eMGznYW5LYHw+SwyyiOOlLWJ9JRj5/3y7/V4iRjWFTqE2y19HlS84lyHdnwiihsvP6HoImQMF2skj
        Cv36I9b2g5TqiD9UjowzD8rIh4vGmPF4YujKqAU5ecr/Zb2TLDBSPZvPv526iVAgeTZF2J/lqfc4O
        FF3dNRFb/D42LA6v18Hq0El8qgm9QPDt65BjdKb72PO5SvSwkwzTe778iO6ypctvAAacF8npmx4Z6
        1afM5I7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55854)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mpuYg-0000ob-Hj; Wed, 24 Nov 2021 15:51:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mpuYg-0001JH-1C; Wed, 24 Nov 2021 15:51:42 +0000
Date:   Wed, 24 Nov 2021 15:51:41 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm: ioremap: Replace pci_ioremap_io() usage by
 pci_remap_iospace()
Message-ID: <YZ5fjXNpYpWaxZtv@shell.armlinux.org.uk>
References: <20211124154116.916-1-pali@kernel.org>
 <20211124154116.916-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124154116.916-5-pali@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 04:41:15PM +0100, Pali Rohár wrote:
> Replace all usage of ARM specific pci_ioremap_io() function by standard PCI
> core API function pci_remap_iospace() in all drivers and arm march code.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
