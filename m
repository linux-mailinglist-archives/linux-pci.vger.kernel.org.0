Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574424C8887
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 10:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiCAJvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 04:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCAJvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 04:51:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419D434BD;
        Tue,  1 Mar 2022 01:50:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB66B817D0;
        Tue,  1 Mar 2022 09:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F51C340EE;
        Tue,  1 Mar 2022 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646128232;
        bh=lOOsSw7Tk3bXo6gVmqcvsCoSXzM9PQBSIvg1gEmMSoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPEdBVePmBJHXmE+N8egu9mj/nL23kiZe+v7tqCnT+vpjUQuOgSHSpPF/1dMX0+tc
         wT78dPr/klG9dHslrMfoZuMis72pLmhRlJWPQUafPHXwx3bWlZik4L20i5uerbJwFF
         N4ndm2yNIyjwlcgmNTI3QChvL1naCwiyef7bvnHyMuRsGVUZ+rS0WEWRV6N5R7jndO
         qRkBKvluUFRJ9e7KSI8vNymdWp1fgmrfp2ceNtJ0ZFUVqpoT/5j24jO/XV9CrmqXDM
         +C0B2C8TcbEldyOWYSlAXRhMK9y+Ob7VzG5v04FlQgu6Rr6x4B7NppCDVR6MsscTaV
         WnBc0wHZmeXlw==
Received: by pali.im (Postfix)
        id B2C6AC77; Tue,  1 Mar 2022 10:50:29 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:50:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20220301095029.sihzfk2vextf7gpz@pali>
References: <20220225125407.wglplhyisgges3zk@pali>
 <20220225170225.GA363593@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225170225.GA363593@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 February 2022 11:02:25 Bjorn Helgaas wrote:
> On Fri, Feb 25, 2022 at 01:54:07PM +0100, Pali Rohár wrote:
> > On Thursday 24 February 2022 15:28:11 Bjorn Helgaas wrote:
> > > On Tue, Feb 22, 2022 at 05:31:57PM +0100, Pali Rohár wrote:
> > > > This PCIe message is sent automatically by mvebu HW when link changes
> > > > status from down to up.
>  
> > > PCIe r6.0, sec 2.2.8.5 and 7.5.3.9, also say Set_Slot_Power_Limit must
> > > be sent on a config write to Slot Capabilities.  I don't really
> > > understand that, since AFAICS, everything in that register is
> > > read-only.  But there must be some use case for forcing a message.
> > 
> > I understood it in this way: Capabilities register is read-only hw-init
> > and so firmware / driver can write initialization values into this
> > register. And when firmware / driver is doing this write then Root port
> > should send that Set_Slot_Power_Limit message.
> 
> Sec 7.5.3.9 describes the behavior of Slot Capabilities in config
> space, where it must be read-only.  Firmware (or the mvebu driver)
> must use a different mechanism to initialize the values.
> 
> FWIW, I found this implementation note in PCIe r6.0, sec 6.9 that
> explains why config writes to this read-only register would be useful:
> 
>   IMPLEMENTATION NOTE: AUTO SLOT POWER LIMIT DISABLE
> 
>   In some environments host software may wish to directly manage the
>   transmission of a Set_Slot_Power_Limit message by performing a
>   Configuration Write to the Slot Capabilities register rather than
>   have the transmission automatically occur when the Link transitions
>   from a non-DL_Up to a DL_Up status. This allows host software to
>   limit power supply surge current by staggering the transition of
>   Endpoints to a higher power state following a Link Down or when
>   multiple Endpoints are simultaneously hot-added due to cable or
>   adapter insertion.
> 
> Bjorn

Hm... I did not understand from this description what should happen when
write operation is performed to the slot capabilities register. It is
allowed to change content of this register?

Or better question, what should write hook in pci-mvebu.c driver for
slot capabilities do?
