Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95E45C92F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhKXPys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 10:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbhKXPyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 10:54:47 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49EC061574;
        Wed, 24 Nov 2021 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=83Z9ctsXhi4n6jL1I+xnZYOsulRili5YtWNkeTxLDvY=; b=O7JOpWGcH4DnhCV+XrFVDi83VC
        vjiYAQOklY/dedfzCATe0m84ZCCGpC19/nyEcuuM5m94AIzji0oGc9sfnQQR8aolKgTxP4o2GQ+Xc
        YlZeXOYhBsdXAZMwSi+YqF+bCuqPTBtTzP35dk3g6C58RZTaYf2g+yaXSQOHzwuL/XSGrSB8QmTXd
        +SxFWxTlgGfheF5iU10JREpJdELdxQSs9O+mJxIg7DkuZhIw1PYGodPZUKjp7VHnkmvgnkmkI5tPh
        cX/AGJsyoeHQtMxrgWTaBVfptCGiBzQcu5eYlw0mZE5Fu7RfqUixgtVKnAmiuNgx7n30DLyGv2D7+
        4k6GdpEw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55852)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mpuYP-0000oH-NY; Wed, 24 Nov 2021 15:51:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mpuYN-0001JA-4r; Wed, 24 Nov 2021 15:51:23 +0000
Date:   Wed, 24 Nov 2021 15:51:23 +0000
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
Subject: Re: [PATCH 1/5] arm: ioremap: Implement standard PCI function
 pci_remap_iospace()
Message-ID: <YZ5fez3JSUgl+NNq@shell.armlinux.org.uk>
References: <20211124154116.916-1-pali@kernel.org>
 <20211124154116.916-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124154116.916-2-pali@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 04:41:12PM +0100, Pali Rohár wrote:
> pci_remap_iospace() is standard PCI core function. Architecture code can
> reimplement default core implementation if needs custom arch specific
> functionality.
> 
> ARM needs custom implementation due to pci_ioremap_set_mem_type() hook
> which allows ARM platforms to change mem type for iospace.
> 
> Implement this pci_remap_iospace() function for ARM architecture to
> correctly handle pci_ioremap_set_mem_type() hook, which allows usage of
> this standard PCI core function also for platforms which needs different
> mem type (e.g. Marvell Armada 375, 38x and 39x).
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
