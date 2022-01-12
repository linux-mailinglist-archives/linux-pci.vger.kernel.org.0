Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDF48BFD6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 09:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351552AbiALI2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 03:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiALI2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 03:28:05 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BDC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 00:28:04 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9F5A030000E55;
        Wed, 12 Jan 2022 09:28:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 93E961701B8; Wed, 12 Jan 2022 09:28:01 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:28:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pci@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH resend v2] PCI: pciehp: Use
 down_read/write_nested(reset_lock) to fix lockdep errors
Message-ID: <20220112082801.GA19022@wunner.de>
References: <20211217141709.379663-1-hdegoede@redhat.com>
 <20220111171447.GA152379@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111171447.GA152379@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 11:14:47AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 17, 2021 at 03:17:09PM +0100, Hans de Goede wrote:
> > Use down_read_nested() and down_write_nested() when taking the
> > ctrl->reset_lock rw-sem, passing the number of PCIe hotplug controllers in
> > the path to the PCI root bus as lock subclass parameter. This fixes the
> > following false-positive lockdep report when unplugging a Lenovo X1C8 from
> > a Lenovo 2nd gen TB3 dock:
[...]
> Applied to pci/hotplug for v5.17, thanks, Hans!

I've realized only now that Hans reported this issue already in August 2020
and opened a bugzilla for it:

https://bugzilla.kernel.org/show_bug.cgi?id=208855

The status can now be set to RESOLVED FIXED.  I don't have permission
to do that but perhaps either of you, Bjorn or Hans, has?

Also, the commit could optionally be amended with a Link: tag to that
bugzilla entry.

Thanks,

Lukas
