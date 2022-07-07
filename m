Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842156ABC7
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiGGTXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiGGTXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 15:23:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCE24F15;
        Thu,  7 Jul 2022 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KWl14oEa0MF7Xw06jzUPkQgdDKHH6yGLsoXZ9btlyRQ=; b=BGKHd2w2//3uKjZlEQrqf9re7g
        zT6PYmgBxQ1bTmUbWiAy32OyUlKTs+W/HXZ+SLIGwKkY4ytqN3GLgRRECbHvK9GVPxq/XksCkD7EM
        xQobBBPn8HU6WQXbBQ0xPxfQNcTwGRD+/bGEWlQEIphXw4IaXNr8ZgFVGu/WkhO1jrnxplR0pRpSu
        ARpXbs55sTUCmWJU+kqV2TdZCqf1tblJf5ws8TL6XhHVvYjciM3W/sqTSn1qTtRakht+QOlNttb33
        kyXZlfUTWabmZI0T3BAfRmFEwLfrs8jycsd9a4Zl6rIvihrB42DtIBy8UnT+Nft7RhqeLs7klwn8s
        JP7hu9pQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33242)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o9X5Y-0004ID-QT; Thu, 07 Jul 2022 20:23:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o9X5W-0005WU-Ke; Thu, 07 Jul 2022 20:22:58 +0100
Date:   Thu, 7 Jul 2022 20:22:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Marvell: Update PCIe fixup
Message-ID: <YscykvpwPPHiaLf1@shell.armlinux.org.uk>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102171259.9590-1-pali@kernel.org>
 <20211109225332.kqyfm4h4kwcnhhhl@pali>
 <20220514182125.xfvnw7yj2rmxpi7l@pali>
 <20220707183112.f7dgz3lzordxnqhj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707183112.f7dgz3lzordxnqhj@pali>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 08:31:12PM +0200, Pali Rohár wrote:
> PING? I have not received any reply!

The Dove device I have doesn't make use of PCIe, so I don't think I can
test there, and I don't have the other platforms either.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
