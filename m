Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1217E5AC5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjKHQD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 11:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKHQD2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 11:03:28 -0500
X-Greylist: delayed 1130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 08:03:26 PST
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3281BFD
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 08:03:26 -0800 (PST)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4SQTsw6Xb3zDSq
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 10:44:36 -0500 (EST)
Received: from xps-9320.lan (kenny-tx.gotdns.com [162.196.229.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4SQTsr2Pg4zsvB;
        Wed,  8 Nov 2023 10:44:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1699458275; bh=49JlpVbEi9PYM8BXorNeSMKDtk16l7yJ96LgyF0RG0Y=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=GEiZ9lkM1/QxeEraUfwnPSep+IVjywJOsYlefDQ5+hc5DjKRr3L8oOlY5qFMg6z9n
         9o41OX1NfNwz9VvWdjAlIHuiIP6yiMRT36qPXk86zzHZRsW1NaRYo+GCnEgBFLvG/g
         9kmiq05eILq9l9ixM2X4EFdr4vEVKtiB1eOiuWQQ=
Date:   Wed, 8 Nov 2023 07:44:31 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     vidyas@nvidia.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, andrea.righi@canonical.com,
        vicamo.yang@canonical.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
In-Reply-To: <20231106181107.GA255535@bhelgaas>
Message-ID: <f3dd694b-8d9-ef-9d21-ad4394f6e33@panix.com>
References: <20231106181107.GA255535@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 6 Nov 2023, Bjorn Helgaas wrote:

> > I'd bisected it to the following commits (in this order):
> > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming
> > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
> > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead

> Thanks for these.  You don't happen to have URLs for those Ubuntu
> commits, do you?

https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981

> Thank you very much for raising this again.

They've been really great for battery life on my laptop, so I'd like to help
these in some form get upstreamed (provided there's no bad side-effects, of
course).

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
