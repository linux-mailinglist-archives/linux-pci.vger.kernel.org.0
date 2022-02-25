Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0A4C4B97
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiBYRDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 12:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbiBYRDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 12:03:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF63B546;
        Fri, 25 Feb 2022 09:02:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3A961D4E;
        Fri, 25 Feb 2022 17:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E44C340E7;
        Fri, 25 Feb 2022 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645808546;
        bh=dN2Bz1iygo2sIzesrF8govzJ+5QKuGfIYEDRIld0RBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kNz+vf0XXx6YWRBHyghc9YOie2pR8cVyN/8NcKdyUPkLFTfzE0Eccuet4IqVWopnD
         WUpD1ykttsJFpRQSRH8wV7ysRpinVdd01d34pMOfhTOiV1uazBqaWJsWOlYTjSOev8
         4JUqe/yCwUbMwWAkNIHlBnCDVtFGJqTajEtIyUbG4z1LOB2n9/cX13hR9l6vSDOSWC
         xsW8Un1/afxBL0SmeUdyGsmETQb/6xoFN0J1BWnvyp6UsEX+HQU9XXSSsT8Y5CSA/L
         RLHvnIFhHNRXovtG7GSY8suQKmzy2y83z1sFk6nt6ncaWxDbJ379TsDQZ7Nx0fWSJL
         qKme2ubhjDpFA==
Date:   Fri, 25 Feb 2022 11:02:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20220225170225.GA363593@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225125407.wglplhyisgges3zk@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 01:54:07PM +0100, Pali Rohár wrote:
> On Thursday 24 February 2022 15:28:11 Bjorn Helgaas wrote:
> > On Tue, Feb 22, 2022 at 05:31:57PM +0100, Pali Rohár wrote:
> > > This PCIe message is sent automatically by mvebu HW when link changes
> > > status from down to up.
 
> > PCIe r6.0, sec 2.2.8.5 and 7.5.3.9, also say Set_Slot_Power_Limit must
> > be sent on a config write to Slot Capabilities.  I don't really
> > understand that, since AFAICS, everything in that register is
> > read-only.  But there must be some use case for forcing a message.
> 
> I understood it in this way: Capabilities register is read-only hw-init
> and so firmware / driver can write initialization values into this
> register. And when firmware / driver is doing this write then Root port
> should send that Set_Slot_Power_Limit message.

Sec 7.5.3.9 describes the behavior of Slot Capabilities in config
space, where it must be read-only.  Firmware (or the mvebu driver)
must use a different mechanism to initialize the values.

FWIW, I found this implementation note in PCIe r6.0, sec 6.9 that
explains why config writes to this read-only register would be useful:

  IMPLEMENTATION NOTE: AUTO SLOT POWER LIMIT DISABLE

  In some environments host software may wish to directly manage the
  transmission of a Set_Slot_Power_Limit message by performing a
  Configuration Write to the Slot Capabilities register rather than
  have the transmission automatically occur when the Link transitions
  from a non-DL_Up to a DL_Up status. This allows host software to
  limit power supply surge current by staggering the transition of
  Endpoints to a higher power state following a Link Down or when
  multiple Endpoints are simultaneously hot-added due to cable or
  adapter insertion.

Bjorn
