Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DEE303AA
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3U60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 16:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfE3U60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 16:58:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06D526197;
        Thu, 30 May 2019 20:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559249906;
        bh=RzysyGPyd/1YfGrfUAerdAkUBe+i+zzpSKAftG8O6q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kj+YxR0PJOduRngkGNK3NVnrXL+3fjj0Twq+mHpZ8YnphK3kahYWsfVtl2Ac2Ozi3
         9ywGdtXK4eqjk3jhGVVwxONwO+OMq1nms6trKDSwUXataFp0iQ6kkV1ErsXM9OkjnI
         QrRU0Kh+8BQvHzqdY8mbuZEbwnl7ILpxn20AWMNY=
Date:   Thu, 30 May 2019 15:58:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Message-ID: <20190530205823.GA45696@google.com>
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
 <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
 <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
 <D8764654-E2A0-43B8-97D9-6644F2BC8D0E@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8764654-E2A0-43B8-97D9-6644F2BC8D0E@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 07:33:01PM +0000, Himanshu Madhani wrote:

> We are able to successfully read VPD config data using lspci and cat
> command

Yes, you mentioned that in the very first email.  I was hoping you
would include the actual data, e.g., "cat vpd | xxd".  That would help
us figure out why you don't see the panic any more.  I suspect either:

  - new QLogic firmware fixed the structure of the VPD data so Linux
    no longer attempts to read past the end of the implemented region,
    or,

  - we still read past the end of the implemented VPD region, but the
    device doesn't report an error or the platform deals with the
    error without causing a panic.

> We also verified this same configuration on a SuperMicro X10SRA-F
> server (which i had sent in earlier email)’ and were able to verify
> that the VPD read was good and there were no errors on PCIe trace.

Since you saw no PCIe errors here, this suggests that new firmware has
changed the format of the VPD data.

> Given this information, Please consider reverting the patch until we
> further debug the issue and resolve as it is affecting general
> availability of our adapter.

1) The way Linux works is that you would post a patch that does the
revert you'd like to see done.

2) It's unlikely that a simple revert of 0d5370d1d852 ("PCI: Prevent
VPD access for QLogic ISP2722") is the right answer because that would
make Ethan's machine panic again.  It's possible that a QLogic
firmware update would avoid the panic, but we can't simply revert the
patch and force users to do that update.

If a QLogic firmware update indeed fixed the VPD format, I suggest
that you ask the folks responsible for the firmware to identify the
specific version where that was fixed and how the OS can figure that
out.

Then you could make a new quirk specific to this device that allows
VPD reads if the adapter has new enough firmware.  If it finds older
firmware, it could even print a message suggesting that users could
update the firmware if they need to read VPD data.

Bjorn
