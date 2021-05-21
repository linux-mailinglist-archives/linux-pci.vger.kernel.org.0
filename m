Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0638CBF0
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhEURUw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 13:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhEURUw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 13:20:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD74861163;
        Fri, 21 May 2021 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621617568;
        bh=Kw0Z/gYngDs6rBwhLk3D/2maC8cRlmPg7zUuoMKOHTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBIkNEqFHLiT+tWQYIZKazBN7xh482iEtWu9x2mWPdsapbSTIU6hw6FgpU85nLv+V
         TfNlY3TzQZFCH3/hXyfOj93Svv4mB7oSYD8Zox3Muk7Yk0r6R6i4VnxVzjVjVZOTgr
         lLFMb0S0xpxa810Nr0NmGxi6IL/VJ5FffYduuKg4=
Date:   Fri, 21 May 2021 19:19:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 12/14] PCI: Fix trailing newline handling of
 resource_alignment_param
Message-ID: <YKfrnG/4O0mLu4Vj@kroah.com>
References: <20210518034109.158450-1-kw@linux.com>
 <20210518034109.158450-12-kw@linux.com>
 <20210521151443.GB39346@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521151443.GB39346@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 21, 2021 at 05:14:43PM +0200, Krzysztof Wilczyński wrote:
> [+cc Greg and Sasha for visibility]
> 
> Hi Bjorn and Logan,
> 
> [...]
> > Fixes: e499081da1a2 ("PCI: Force trailing new line to resource_alignment_param in sysfs")
> [...]
> 
> This probably would be a candidate for a back-port to stable and
> long-term releases.  But, since the move to sysfs_emit()/sysfs_emit_at()
> would be then irrelevant, I can split this patch so that it fixes the
> issue first, and then other patch will move it to sysfs_emit(), so that
> it would be easier to apply when back-porting.

sysfs_emit() and sysfs_emit_at() are in all supported stable and
long-term kernel trees at this time, so there's no need to shy away from
using them.

thanks,

greg k-h
