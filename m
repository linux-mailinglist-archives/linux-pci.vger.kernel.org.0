Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA812327F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 17:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfLQQay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 11:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfLQQay (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 11:30:54 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BF321D7D;
        Tue, 17 Dec 2019 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576600253;
        bh=ELfXB4kOCjfXxNtciCDztOtMLcyNgsTVpl1df/9690w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWmrwLdAgvD5xSPvzsrJg77S+A7dTxN87nd2VffHWcF4pV8TjcqRSwkdM4A/MrEAh
         Ap71rdESnwomCphxbW3K+rxwZ1hU1IDi3k2QJu7HSdUjh7HdE6mT1ScpsSAn9W3Al6
         rq/TZpCJjGQprEZo4n3fVTf/kCPK8H6pPXjY4orw=
Date:   Wed, 18 Dec 2019 01:30:46 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
Message-ID: <20191217163046.GA2029@redsun51.ssa.fujisawa.hgst.com>
References: <20191216233759.GA249123@google.com>
 <8a0d7768-55f1-c1c8-1507-04e977184a67@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0d7768-55f1-c1c8-1507-04e977184a67@denx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 02:54:06PM +0100, Stefan Roese wrote:
> On 17.12.19 00:37, Bjorn Helgaas wrote:
> >    - Boot with all four PLX slots occupied by NVMe devices.  The BIOS
> >      may assign space to accommodate them all.  If it does, you should
> >      be able to hot-remove and add devices after boot.
> 
> Unfortunately, that's not an option. We need to be able to boot with
> e.g. one NVMe device and hot-plug one or more devices later.

That was also my suggestion, but not necessarily as a "solution". It's
just to see if it works, which might indicate what the kernel could do
differently.
