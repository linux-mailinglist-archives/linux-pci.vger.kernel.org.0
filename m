Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E113B2B0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANTHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 14:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgANTHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 14:07:04 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C47624672;
        Tue, 14 Jan 2020 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579028823;
        bh=4Ev8ap2VqtQ0F1aiYKeN/13TLf0ae9A2fOJ8gxXMaJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BpCHhg88cdGU69qecfkv9GBRwKg/A2BWsBH+iaKgvOUKcIYqyQ0QW+BvbdULb+caa
         eVgnc3pLzstNLxtpc4GVMfT1T2hAaN5ZrZVBHCP1Gz8ecU4BxTUkFl3QXOTje1/D4O
         iEzbh0l/2midTQ6c0r3vRiQUuv+mqbhwtLLUqCek=
Date:   Tue, 14 Jan 2020 13:07:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Kelvin.Cao@microchip.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, epilmore@gigaio.com, dmeyer@gigaio.com
Subject: Re: [PATCH 03/12] PCI/switchtec: Add support for new events
Message-ID: <20200114190701.GA262120@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ec69e8-624a-8e35-9a9e-3f8193fe9f68@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 11:21:45AM -0700, Logan Gunthorpe wrote:
> Bjorn,
> 
> On 2020-01-13 7:07 p.m., Kelvin.Cao@microchip.com wrote:
> > 'InterComm' is the spelling in the latest datasheet, it's short for "Inter Fabric Manager Communication". Thanks.
> 
> I noticed you fixed up the spelling in your branch but the IOCTL define
> is still spelled INTERCOM, which is arguably the most important seeing
> it's a userspace interface.

Thanks, I missed that one.  Fixed now.
