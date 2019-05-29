Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E902E2AD
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2019 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2Q7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 12:59:18 -0400
Received: from foss.arm.com ([217.140.101.70]:49490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfE2Q7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 12:59:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDDF0341;
        Wed, 29 May 2019 09:59:17 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9681C3F5AF;
        Wed, 29 May 2019 09:59:16 -0700 (PDT)
Date:   Wed, 29 May 2019 17:59:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2 0/2] tools: PCI: Fix broken pcitest compilation
Message-ID: <20190529165856.GA25642@redmoon>
References: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558646281-12676-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 02:17:59PM -0700, Alan Mikhak wrote:
> This patchset fixes a compiler error and two warnings that resulted in a
> broken compilation of pcitest.
> 
>  tools/pci/pcitest.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to pci/misc for v5.3, thanks.

Lorenzo
