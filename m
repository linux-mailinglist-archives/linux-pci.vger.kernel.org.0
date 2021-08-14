Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00703EC0F2
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhHNGmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhHNGmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 02:42:11 -0400
X-Greylist: delayed 1093 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Aug 2021 23:41:43 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80EC06175F
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 23:41:43 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 38F883000E426;
        Sat, 14 Aug 2021 08:41:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2CDBE4F16; Sat, 14 Aug 2021 08:41:42 +0200 (CEST)
Date:   Sat, 14 Aug 2021 08:41:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Rajat Jain <rajatja@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Levin <levinale@google.com>,
        Madhusudanarao Amara 
        <madhusudanarao.amara@intel.corp-partner.google.com>,
        Prashant Malani <pmalani@google.com>,
        "abhijeet.rao@intel.com" <abhijeet.rao@intel.com>
Subject: Re: PCIe device (thunderbolt tunneled) runtime suspended while
 driver wants to attach.
Message-ID: <20210814064142.GB25723@wunner.de>
References: <CACK8Z6HLr4tk4UkrzBN7wydDmqk=cqN2a7bQfVdjp9cE_ov_Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6HLr4tk4UkrzBN7wydDmqk=cqN2a7bQfVdjp9cE_ov_Jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 10:26:06PM -0700, Rajat Jain wrote:
> 2) Is my understanding correct that any device should NOT be runtime
> suspended while a driver is trying to attach to the device? Where is
> this ensured (for e.g. for NVMEs)? Is this ensured by the driver core,
> or a device driver that is trying to probe a PCI device needs to
> ensure this?

For some reason the driver core only runtime resumes a device on unbind
(in __device_release_driver()), but not on bind (in driver_probe_device()).

However, the PCI core makes up for that by runtime resuming the device
in local_pci_probe().


> 3) So all downstream devices of a PCI bridge need to be suspended
> before it can be suspended (and vice versa for resume)? In other
> words, is ita bug if I notice that a PCI bridge is runtime suspended
> while any of its downstream devices are not?

Yes to both questions.


> 4) Any suggestions for me to try?

Could you try to bisect the issue?

Thanks,

Lukas
