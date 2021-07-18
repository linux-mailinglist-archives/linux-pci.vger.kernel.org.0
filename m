Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBB3CCAD3
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhGRV3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 17:29:18 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:58835 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhGRV3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jul 2021 17:29:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6511D280253E9;
        Sun, 18 Jul 2021 23:26:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 59BA21C0F2; Sun, 18 Jul 2021 23:26:09 +0200 (CEST)
Date:   Sun, 18 Jul 2021 23:26:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210718212609.GA12573@wunner.de>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
 <20210626065049.GA19767@wunner.de>
 <661f1019-da20-6656-989f-2e7dea240fc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661f1019-da20-6656-989f-2e7dea240fc4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 05:15:02PM -0500, stuart hayes wrote:
> I believe the Link Down is happening because a hot reset is propagated down
> when the link is lost under the root port 64:02.0.  From the PCIe Base Spec
> 5.0, section 6.6.1 "conventional reset":
[...]

Hm, sounds plausible.  Just so that I understand this correctly,
the hotplug port at 0000:68:00.0 is DPC-capable, but the error
that is contained by DPC at the Root Port occurs further up in
the hierarchy, right? (I.e. somewhere above the hotplug port.)

The patch you're using to work around the issue would break if
the hotplug port is *not* DPC-capable.  Yes, yes, I understand
that it's not meant as a real patch, but it shows how tricky
it is to fix the issue.  I need to do a little more thinking
what a proper solution could look like.

Thanks,

Lukas
