Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955772DA1C2
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503290AbgLNUiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 15:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503362AbgLNUir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 15:38:47 -0500
Date:   Mon, 14 Dec 2020 14:38:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607978286;
        bh=VxyJ4UtDTcxBmyqCR8InRULR9CxYNwYmHeq59aIftvc=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=cKy1dubN6kvHJ5aGU5z4TmQdbYiGgWsiu6RJQfRNYxdRBoPmUlJTTkzpHBpZDsGlD
         XZ1z8MVdAi2F6WTaPCPhYM8WAB3emjFlZo5qqt5h8c7PkonL2R19yYSy3qJTH30/XK
         Jdl/Pi/yd4kmOUnvyKi/7jop3AorriUizetsJ3XRzIq4D7+9fPtOdxqSE4PS9Y0vAX
         RtMm8Cnft5ngmHXBDHSF1w3hM3gqcysi5NEOaloWNtpJq4SJSZAUaR3qak6FL2/xDs
         R9vs6er+VfwYJG52bjccwMjbEDg/fMkRfTOoqtlq/77W7NdpxoYq7EyxZTyz1M8qon
         rz2wQegQQuE7Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201214203805.GA250639@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 08, 2020 at 07:05:09PM +0100, Marek Vasut wrote:
> On 12/8/20 5:40 PM, Bjorn Helgaas wrote:

> > Does this problem occur in both these cases?
> > 
> >    1) When ASPM enters L1, and
> > 
> >    2) When software writes PCI_PM_CTRL to put the device in D3hot?
> > 
> > IIUC both cases require the link to go to L1.  I guess the same
> > software workaround applies to both cases?
> 
> Yes

If ASPM puts the Link in L1 and the device needs to DMA, how does the
Link get back to L0?  Do we use the same data abort hook?  If getting
back to L0 requires help from software, it seems like that would
invalidate the L1 exit latency advertised by the devices.  Wouldn't
that mean we couldn't safely enable L1 at all unless the endpoint
could tolerate unlimited exit latency?

Bjorn
