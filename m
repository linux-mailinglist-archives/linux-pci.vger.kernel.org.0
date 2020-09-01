Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF625A1DE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAXXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 19:23:17 -0400
Received: from kernel.crashing.org ([76.164.61.194]:52830 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAXXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Sep 2020 19:23:16 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 081NMtMT027356
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 1 Sep 2020 18:22:58 -0500
Message-ID: <658051b1ba6533fef92648eba08dfdf240af7a18.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Sep 2020 09:22:53 +1000
In-Reply-To: <20200901183702.GA196025@bjorn-Precision-5520>
References: <20200901183702.GA196025@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-09-01 at 13:37 -0500, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > Using write-combine is crucial for performance of PCI devices where
> > significant amounts of transactions go over PCI BARs.
> > 
> > arm64 supports write-combine PCI mappings, so the appropriate
> > define
> > has been added which will expose write-combine mappings under sysfs
> > for prefetchable PCI resources.
> > 
> > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> 
> Fine with me, I assume Will or Catalin will apply this.

Haha ! Client had sent it to them originally and I told him to resend
it to linux-pci, yourself and Lorenzo :-)

So the confusion is on me.

Will, Catalin, it's all yours. You should have the original patch in
your mbox already, otherwise:

https://patchwork.kernel.org/patch/11729875/

Cheers,
Ben.


