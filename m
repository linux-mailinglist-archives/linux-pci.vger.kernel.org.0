Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE7647E2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGJOOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 10:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfGJOOk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 10:14:40 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1D12086D;
        Wed, 10 Jul 2019 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562768079;
        bh=doOg+rHk2EN9esXNLf9coAoeUka6jalwXBt2NUvawdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f47oWhKvnxmeDUYzYhus0hu7jRaCo5u4QFhREAWnendTAZThMO2ePqxaAn9iglU/7
         3xR//69DOv7HVWwoo6g2fR9Dc8QpzjLtPdja8sHteYZT3Hwm8+v3rKxitPLDWwj5AA
         fU30c2T8nrtYLZHXdsbauSDj5fgypEiH2xH8ql94=
Date:   Wed, 10 Jul 2019 09:14:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: reprobing BAR sizes and capabilities after a FLR?
Message-ID: <20190710141438.GO128603@google.com>
References: <20190709154019.GA30673@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709154019.GA30673@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Tue, Jul 09, 2019 at 08:40:19AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> I've just been talking to some firmware developers that were a little
> surprised that Linux does not reprobe BAR sizes after a FLR.  I looked
> at our code and we do not reprobe anything at all after a FLR.  Is it
> a good assumption that a devices comes back in exactly the same state
> after an FLR?

I am a little nervous about the fact that we don't reprobe devices
after reset because the reset may cause the device to load new
firmware, which may cause arbitrary changes (device type, number and
size of BARs, etc).  FLR is a little more restrictive than
Conventional Reset, e.g., FLR must not affect the link state, so maybe
it's safer to assume BAR sizes are unchanged.  But I'm not at all
confident about that.

I mooted the idea of reprobing after reset, but that would break higher
level software that isn't prepared to see hotplug-like events caused by
reset, so haven't gone that direction (yet).

Bjorn
