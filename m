Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F451C49CD
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgEDWwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 18:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgEDWwh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 18:52:37 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AC3206C0;
        Mon,  4 May 2020 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588632756;
        bh=oDW2m6L9Wrq4l6Sa6FvG+TJuH2YvKGkX1auEkVIa68g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qmCv3L7FRPXdzRbioI3T3Quf3DdF6rhAzTR9i6zP7T4//X93+af4luIhonhjHQsxn
         O95sd19nj4u3WoDX9BhU/vRHt6Zi37Lp/sCZ6sACPd6FOUe2HAPUO8R8uVm7pVR6n6
         raEzi3KqsL9DDVFz4SAVWJmSttzT9aOGcEGIbSDc=
Date:   Mon, 4 May 2020 17:52:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stefan Wahren <wahrenst@gmx.net>, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, f.fainelli@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, RayJui <rjui@broadcom.com>,
        ScottBranden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v7 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
Message-ID: <20200504225234.GA300024@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d105712418b93ebce7c0498d05eea77171892366.camel@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 10:59:29AM +0200, Nicolas Saenz Julienne wrote:
> On Sat, 2020-05-02 at 11:05 +0200, Stefan Wahren wrote:
> > > +	pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET, &version);
> > pci_read_config_dword() can fail, we might want to store the return value?
> 
> I planned on doing that, but realised that the vast majority of
> pci_read_config_*() users pass on checking for errors.
> 
> Bjorn, any rule of thumb on when to check for errors here?

Not really.  It *can* fail, for sure.  If it does fail, you normally
get ~0 data, which means you would skip the firmware load, do another
config read (which probably also returns ~0) and print firmware
version ffffffff, and the device probably won't work.

But checking doesn't get you much other than a better error message.

Personally I probably wouldn't bother because it clutters the code so
much for so little benefit.

Bjorn
