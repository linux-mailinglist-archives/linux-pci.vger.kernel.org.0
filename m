Return-Path: <linux-pci+bounces-1261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EE081B465
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45458282550
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B66A029;
	Thu, 21 Dec 2023 10:51:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB46AB88;
	Thu, 21 Dec 2023 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E7D5D28011472;
	Thu, 21 Dec 2023 11:51:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D9B971E5F; Thu, 21 Dec 2023 11:51:24 +0100 (CET)
Date: Thu, 21 Dec 2023 11:51:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Message-ID: <20231221105124.GC12714@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
 <20231213104930.GB31964@wunner.de>
 <31bd82b6-6f7e-4dc4-8cbb-46fa806d699f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31bd82b6-6f7e-4dc4-8cbb-46fa806d699f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 14, 2023 at 08:58:49AM +0800, Ethan Zhao wrote:
> On 12/13/2023 6:49 PM, Lukas Wunner wrote:
> > On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
> > > move pci_dev_is_disconnected() from driver/pci/pci.h to public
> > > include/linux/pci.h for other driver's reference.
> > > no function change.
> > 
> > That's merely a prose description of the code.  A reader can already
> > see from the code what it's doing.  You need to explain the *reason*
> > for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
> > so that it can be called from $DRIVER to speed up hot removal
> > handling which may otherwise take seconds because of $REASONS."
> 
> Yup, why I made it public. then how about
> 
> "Make pci_dev_is_disconnected() public so that it can be called from
> Intel vt-d driver to check the device's hotplug removal state when
> issue devTLB flush request."

Much better.

You may optionally want to point out the location of the file in the
source tree because not everyone may be familiar where to find the
"Intel vt-d driver".  Also, not every reader may know where issuing
of devTLB flush requests occurs, so it might make sense to name the
function where that happens.  Finally, it is common to adhere to terms
used in the PCIe Base Spec in commit messages, so "ATC Invalidate Request"
might be preferable to "devTLB flush request".

Thanks,

Lukas

