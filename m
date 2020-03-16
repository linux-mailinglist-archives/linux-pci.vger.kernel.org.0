Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468901871F6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgCPSLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 14:11:01 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:59127 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbgCPSLB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 14:11:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 57A5B2800C7D5;
        Mon, 16 Mar 2020 19:10:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 248614058E6; Mon, 16 Mar 2020 19:10:58 +0100 (CET)
Date:   Mon, 16 Mar 2020 19:10:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Hoyer, David" <David.Hoyer@netapp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200316181058.pidouiqrempa6qnq@wunner.de>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316161543.GB1069861@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316161543.GB1069861@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 16, 2020 at 09:15:43AM -0700, Keith Busch wrote:
> I'm not sure why the hard-irq context is even setting the thread running
> flag while it can still exit without handling anything. Shouldn't it leave
> the flag cleared until knows it's actually going to do something?

No, ist_running must be set to true before the invocation of
atomic_xchg(&ctrl->pending_events, 0).

There's a time window between the atomic_xchg() and actually
turning off the slot when pending_events is 0.  Previously we
only checked in the sysfs functions that pending_events is 0.
That was insufficient as we risked returning prematurely from
the sysfs functions.  The point of ist_running is to prevent
that.

Thanks,

Lukas
