Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A01E3CEC
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbgE0JAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 05:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388251AbgE0JAJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 05:00:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE06A20723;
        Wed, 27 May 2020 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590570009;
        bh=GzN9KZi8SIAiZv6JsaMy5rtT9c4WVtJCbDQmDejM+Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dw8PQDiM90GK1xPK0MDmtsB/uuNO5KqcuE2U8o5Bi9m3bkWcLa2RYu4UYcftfI8gL
         7map9j1fDgO+xHYZCtIgx1wv9/xmbcAUQMZ2V17LMke54thxct3Cz7n7lWZ60o+1Qn
         SucOB5Se6nCwWAoR5L8bMbTnC5mBS13qfDJaL2Og=
Date:   Wed, 27 May 2020 11:00:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200527090007.GA179718@kroah.com>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 07:49:07PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI but are actually on the AMBA bus,

Why would these devices not just show up on the AMBA bus and use all of
that logic instead of being a PCI device and having to go through odd
fixes like this?

thanks,

greg k-h
