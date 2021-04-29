Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9236E4F7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 08:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhD2Gmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 02:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhD2Gmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 02:42:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF1C06138B;
        Wed, 28 Apr 2021 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eectPFpfXLXiECozRv565wMzMoLfV81R/OySRcsjIx4=; b=uwuYZy6an6Yzrtggc09lLu7dx/
        P7MoqcJRxJWnckM11s38h5AIFZ/xy9t2z7FSvqMe8jYQZ0qQa7fCl/W1IQiSXbKQoV/z+2Qz8EnuN
        ABHiL6eAqLUMBCFaF4VBrCLgjnCd4CquwthzqQbGRxGM3xkulwS75BVpVBUFO+a3vJwZMqckDC4nv
        ZvxQqk3jUkbBmgm0VGFpd2pBuhYR03g+I4g5v2FV2r67B3gKj2bxTM+JFneIQfPZk9bGS6jSI8nQ9
        HHFu5VGYvymMmnvvXidLWXh5Y2TqKxgFqFu5dpJWTCCllyR7JO3/LV22uGXSvMpFwOy0A6g2w0RmU
        AGENQd5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lc0MP-009ILi-Rb; Thu, 29 Apr 2021 06:41:19 +0000
Date:   Thu, 29 Apr 2021 07:41:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7] PCI: rockchip: Add Rockchip RK356X host controller
 driver
Message-ID: <20210429064117.GA2214470@infradead.org>
References: <20210414070325.924789-1-xxm@rock-chips.com>
 <CAMdYzYqf3FhYrFR1DGrP=_CbNpq5uB+J-m42Mv=c6Pu71Jcxww@mail.gmail.com>
 <5af0f6f8-bc29-f50e-ca14-94049b7d17ed@rock-chips.com>
 <CAMdYzYr=i7X22-38VyY-GQLWs+aV+ZcWwO_uDymFxmaNO8SpmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYr=i7X22-38VyY-GQLWs+aV+ZcWwO_uDymFxmaNO8SpmA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 28, 2021 at 09:42:37PM -0400, Peter Geis wrote:
> I have functional MSI support, some devices do not support MSIs
> however and need legacy INTx.
> I'd like to point out that the downstream patch does not actually work
> on downstream.
> The GFP_DMA32 flag is discarded by the slab allocator, this breaks MSI
> allocation when the PCIe driver probes.
> I hacked together my own version which works but would definitely not
> be accepted for submission.

Seriously folks.  Never, ever use GFP_DMA or GFP_DMA32 in actual driver
code.  They fundamentally don't do what you want.  Devices as a rule of
thumb do care about DMA addressability, not CPU addressability, so they
must use the DMA API to allocate the memory, and the dma mask to control
addressability.
