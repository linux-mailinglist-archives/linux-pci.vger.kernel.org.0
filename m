Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1E48C431
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 13:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiALMtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 07:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiALMs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 07:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3AC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 04:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 565AB611C3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 12:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72848C36AE5;
        Wed, 12 Jan 2022 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641991738;
        bh=/9T0s6xbzi2HQddz3QMQs46AFIeuDOt3z8ZPe2K0stM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e5IwVLW7WtyyYwp7ja8nhynr4c2wEScMBnK/JWzCKOrAtNWOtlWyAh/GouviwyPJ6
         qQybVxth1M2ak+JrAdETi3gXbDykIJniIIa7fZ1kaTvmSAxflnt+nRp4gWcEquBU6C
         vm7cv2dLvqAugY1yAWjlwQD1sHFux+K6E9N5Wm2QIqHKClILWbxo2koTlPAr32Jr66
         O6RDLjV8PaDhUGCK4BsjA1BllLzzhqQ3oM3L8avrYyDLHZMBTyLyw8SLmJHBSUENH0
         n0dczlOis6sJ/z+HXteHIjxz/V+4wvTkTu8LJT2JSYafK8g8ItojdCnEDuqH6mWkZH
         aiyBWS+6yEJpw==
Date:   Wed, 12 Jan 2022 06:48:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH resend v2] PCI: pciehp: Use
 down_read/write_nested(reset_lock) to fix lockdep errors
Message-ID: <20220112124856.GA246967@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b38764-835c-83dd-8fb9-b7d6a22e70b6@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 01:39:07PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/12/22 09:28, Lukas Wunner wrote:
> > On Tue, Jan 11, 2022 at 11:14:47AM -0600, Bjorn Helgaas wrote:
> >> On Fri, Dec 17, 2021 at 03:17:09PM +0100, Hans de Goede wrote:
> >>> Use down_read_nested() and down_write_nested() when taking the
> >>> ctrl->reset_lock rw-sem, passing the number of PCIe hotplug controllers in
> >>> the path to the PCI root bus as lock subclass parameter. This fixes the
> >>> following false-positive lockdep report when unplugging a Lenovo X1C8 from
> >>> a Lenovo 2nd gen TB3 dock:
> > [...]
> >> Applied to pci/hotplug for v5.17, thanks, Hans!
> > 
> > I've realized only now that Hans reported this issue already in August 2020
> > and opened a bugzilla for it:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=208855
> 
> Ah I completely forgot about having filed that bug, good catch.
> 
> > The status can now be set to RESOLVED FIXED.  I don't have permission
> > to do that but perhaps either of you, Bjorn or Hans, has?
> 
> I have added a comment and closed the bug now. Note that you can email
> the kernel.org admins with your bugzilla login + a friendly requests
> to give you some more bugzilla rights. I did that a while ago when
> I hit similar issues doing triage of bugzilla.kernel.org bugs.
> 
> > Also, the commit could optionally be amended with a Link: tag to that
> > bugzilla entry.
> 
> There isn't really any new info in the bugzilla though, so I guess
> the commit is fine as is. With that said if Bjorn wants to add it
> that is fine too of course.

Thanks, I added it.  It does have a link to Ted's original email,
which includes a complete dmesg log.

Of course, that makes the commit referenced by
https://bugzilla.kernel.org/show_bug.cgi?id=208855#c2 obsolete, but
that happens anyway because I often rebase to add things like this.

Bjorn
