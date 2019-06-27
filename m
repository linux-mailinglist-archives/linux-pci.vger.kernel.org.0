Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0282D58BA8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0U0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 16:26:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:57300 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfF0U0Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 16:26:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5RKQ0JI017540;
        Thu, 27 Jun 2019 15:26:01 -0500
Message-ID: <29195ddffa377c5d080552bb5194018681f8f5f7.camel@kernel.crashing.org>
Subject: Re: Multitude of resource assignment functions
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Fri, 28 Jun 2019 06:26:00 +1000
In-Reply-To: <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
         <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
         <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
         <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
         <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-27 at 10:35 -0600, Logan Gunthorpe wrote:
> My worry would be if the firmware depends on any of those PCI resources
> for any of it's calls. For example, laptop firmware often has specific
> code for screen blanking/dimming when the special buttons are pressed.
> If it implements this by communicating with a PCI device then the kernel
> will break things by reassigning all the addresses.
> 
> However, having a kernel parameter to ignore the firmware choices might
> be a good way for us to start testing whether this is a problem or not
> on some systems

As I consolidate that accross archs I can add such a parameter... I
haven't quite folded x86 in yet, but I'm hoping I'll be able to do so
soon. I plan to move some of those x86 specific kernel parameters into
generic code while doing so. I can add this one.

Cheers,
Ben.



