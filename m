Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5E3172A3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 22:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhBJVqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 16:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhBJVqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 16:46:43 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860DC06174A
        for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2021 13:46:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id ACA83102EDCE4;
        Wed, 10 Feb 2021 22:46:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 60BBE4E74A; Wed, 10 Feb 2021 22:46:00 +0100 (CET)
Date:   Wed, 10 Feb 2021 22:46:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210210214600.GA15101@wunner.de>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
 <20210201125523.GN2542@lahna.fi.intel.com>
 <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
 <20210204104912.GE2542@lahna.fi.intel.com>
 <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 10, 2021 at 07:40:06PM +0000, Sergei Miroshnichenko wrote:
> The branch is finally ready, so if you still have time for that, please
> take a look:
> 
> https://github.com/YADRO-KNS/linux/tree/yadro/pcie_hotplug/movable_bars_v9.1

Just a quick drive-by comment, in commit

    scsi: mpt3sas: Handle a surprise PCI unplug faster

you probably want to call pci_dev_is_disconnected() instead of
adding a new flag.

Thanks,

Lukas
