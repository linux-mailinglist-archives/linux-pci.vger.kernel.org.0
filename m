Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603C36F0A9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhD2TnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbhD2TnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 15:43:04 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83739C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 12:42:17 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id F1EAF30026EB2;
        Thu, 29 Apr 2021 21:42:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E61A23B12C3; Thu, 29 Apr 2021 21:42:14 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:42:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210429194214.GA22639@wunner.de>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
 <20210428144041.GA27967@wunner.de>
 <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7932c4e-81b1-279d-48df-5d621efff757@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 07:29:59PM +0800, Yicong Yang wrote:
> On 2021/4/28 22:40, Lukas Wunner wrote:
> > If DPC doesn't recover within 3 seconds, pciehp will consider the
> > error unrecoverable and bring down the slot, no matter what.
> > 
> > I can't tell you why DPC is unable to recover.  Does it help if you
> > raise the timeout to, say, 5000 msec?
> 
> I raise the timeout to 4s and it works well. I dump the remained jiffies in
> the log and find sometimes the recovery will take a bit more than 3s:

Thanks for testing.  I'll respin the patch and raise the timeout
to 4000 msec.

The 3000 msec were chosen arbitrarily.  I couldn't imagine that
it would ever take longer than that.  The spec does not seem to
mandate a time limit for DPC recovery.  But we do need a timeout
because the DPC Trigger Status bit may never clear and then pciehp
would wait indefinitely.  This can happen if dpc_wait_rp_inactive()
fails or perhaps because the hardware is buggy.

I'll amend the patch to clarify that the timeout is just a reasonable
heuristic and not a value provided by the spec.

Which hardware did you test this on?  Is this a HiSilicon platform
or Intel?

Thanks!

Lukas
