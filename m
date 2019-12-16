Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B41204AD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLPMDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 07:03:19 -0500
Received: from foss.arm.com ([217.140.110.172]:52194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLPMDR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 07:03:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F186D1FB;
        Mon, 16 Dec 2019 04:03:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67F493F719;
        Mon, 16 Dec 2019 04:03:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:03:14 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Yurii Monakov <monakov.y@gmail.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191216120314.GU24359@e119886-lin.cambridge.arm.com>
References: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
 <20191004160519.GV42880@e119886-lin.cambridge.arm.com>
 <20191004163723.GA31823@monakov-y.office.kontur-niirs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004163723.GA31823@monakov-y.office.kontur-niirs.ru>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 07:37:23PM +0300, Yurii Monakov wrote:
> > This looks fine, however are the earlier lines still correct?
> Yes, according to TI Keystone PCIe datasheet pg. 3-10 OB_SIZE
> register should hold log2 of actual window size in MB (bits 2-0):
> 
> 0h = 1MB
> 1h = 2MB
> 2h = 4MB
> 3h = 8MB
> 
> But OB_OFFSET_INDEXn/OB_OFFSETn_HI register pair hold absolute
> 64-bit bus address, so 'start' variable sholud be incremented
> by 8M to map all PCIe data space (according to the comment above
> the loop).
> 
> TI confirms this bug for for kernel v4.14, but since then
> some driver code relocation happend and I've decided to
> report this here.

Thanks for this, I'll add:

Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")

Acked-by: Andrew Murray <andrew.murray@arm.com>

> 
> Regards,
> Yurii
> 
