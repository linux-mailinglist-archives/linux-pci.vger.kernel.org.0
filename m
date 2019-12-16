Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6191219F9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 20:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLPTcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 14:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfLPTcZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 14:32:25 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6173521582;
        Mon, 16 Dec 2019 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576524744;
        bh=gUCXgs9sg1RuHHcgRE7XvMN+ly9EJcv+KchCItb7IIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bw5bqB4O50LOacNDVJ9rIsgCCz9Lxg8+A/tA7mSljTsHPsEIBe28p7sgTWRDzJQaE
         0g+5bBGtExGiJKM769f+Z8cm1lTGKPxa8ED/37d9+rMJZY2AqnRC+6FKBvyPCxL8wi
         3XsrGFizRzykVAKv3tBLDqYlB6OX3/sq9RvmOm2g=
Date:   Tue, 17 Dec 2019 04:32:17 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     bjorn@helgaas.com,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
Message-ID: <20191216193217.GA18101@redsun51.ssa.fujisawa.hgst.com>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
 <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CABhMZUUGTiH-KfPtLQrc6LkXzc7CpkrAcOSmvv6p0Uj4K+_abQ@mail.gmail.com>
 <be8abbfc-2f98-a6cb-fbf5-7ec8e7051a39@denx.de>
 <20191216155009.GB11424@redsun51.ssa.fujisawa.hgst.com>
 <f3a51108-10e4-f60d-de18-a12de85d07df@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a51108-10e4-f60d-de18-a12de85d07df@denx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 06:34:22PM +0100, Stefan Roese wrote:
> Hi Keith,
> 
> On 16.12.19 16:50, Keith Busch wrote:
> > On Mon, Dec 16, 2019 at 07:50:20AM +0100, Stefan Roese wrote:
> > > On 16.12.19 01:46, Bjorn Helgaas wrote:
> > > > > > The logs are also included. Please let me know, if I should do any other
> > > > > > tests and provide the logs.
> > > > 
> > > > Please include these logs in your mail to the list or post them
> > > > someplace where everybody can see them.
> > > 
> > > Gladly. Please find the archive here:
> > > 
> > > https://filebin.ca/55U8waihXJVI/logs.tar.bz2
> > 
> > I can't access that. Could you paste directly into the email? I'm just
> > looking for 'dmesg' and 'lspci -vvv' right now, so trim to that if your
> > full capture is too long.
> 
> Sure, here a try with inline logs (stripped down a bit). I didn't include
> all test versions for now, since this inrease the mail size even more, Only
> test a) ... d)  are inlined here:

I think your platform bios simply doesn't support it. It does not
provision empty slots on its own, and it doesn't tolerate the OS
reassigning resources to them from what appears to be unnassigned memory
windows. The platform may be using those memory windows for something
outside the kernel's visibility.

What happens if you boot the system with all slots populated? Do all
devices configure in that case, and if so, can you hot-swap them?
