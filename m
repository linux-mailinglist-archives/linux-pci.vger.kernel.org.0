Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832E73A398F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFKCPD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 22:15:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47327 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230168AbhFKCPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 22:15:02 -0400
Received: (qmail 24249 invoked by uid 1000); 10 Jun 2021 22:13:04 -0400
Date:   Thu, 10 Jun 2021 22:13:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ibrahim Erturk <ierturk@ieee.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Strange problem with USB device
Message-ID: <20210611021304.GA23289@rowland.harvard.edu>
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
 <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
 <20210608185314.GB1812516@rowland.harvard.edu>
 <960057be-ef17-49e7-adba-ba2929d3a01f@lwfinger.net>
 <20210609021237.GA1826754@rowland.harvard.edu>
 <CAFHYy-iMty-jjZzgzRA6tOezN-RJ+o4hRL1kZk+tuN1i-K9Ukg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFHYy-iMty-jjZzgzRA6tOezN-RJ+o4hRL1kZk+tuN1i-K9Ukg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 11, 2021 at 03:08:16AM +0300, Ibrahim Erturk wrote:
> Hi,
> 
> I've already attached logs and a snapshot from the device manager on
> the windows side into the bug report. Hope this helps.

Yes, it does help.  Although the information in those reports is somewhat 
disorganized, it clearly shows there is only one USB host controller in the 
system, and that is the one Linux detects.  So my impression that we weren't 
finding the host controller was wrong.

Back to my earlier guess: The Realtek board has to be told to do something in 
order to make the Bluetooth device start working, such as turning on a power 
source.  (And perhaps that is what the RealTek people were talking about when 
they suggested the problem could be in the rtw8822 power-up sequence.)  Whatever 
it is, the rtw8822 driver isn't doing it.

This means it's still a PCI problem.

Alan Stern

PS: Larry, the discrepancy between Windows reporting an Intel USB hub and Linux 
reporting two Linux Foundation hubs isn't real -- or at least, it's what should 
be expected.  I can explain in more detail if you're curious, but you don't need 
to worry about it.
