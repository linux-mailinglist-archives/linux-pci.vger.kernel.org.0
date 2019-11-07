Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B121F2F76
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfKGNdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 08:33:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50720 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbfKGNdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 08:33:52 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id aec6358fbcca9be9; Thu, 7 Nov 2019 14:33:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Date:   Thu, 07 Nov 2019 14:33:44 +0100
Message-ID: <1774412.xs4Eg1OkIx@kreacher>
In-Reply-To: <20191106190250.GA238633@google.com>
References: <20191106190250.GA238633@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, November 6, 2019 8:02:50 PM CET Bjorn Helgaas wrote:
> On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series rearranges some PCI power management code to make it somewhat
> > easier to follow and explicitly consolidate the power-up (transitions to
> > D0) code path.
> > 
> > It is not intended to change the functionality of the code.
> 
> Applied with Mika's reviewed-by to pci/pm for v5.5, thanks!

Thank you!

> Thanks for the git tips, too!

You're vwelcome. :-)



