Return-Path: <linux-pci+bounces-10697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74393AB99
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887FE1F22812
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133B1C6A1;
	Wed, 24 Jul 2024 03:38:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39111757E;
	Wed, 24 Jul 2024 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721792319; cv=none; b=WdyyEvJc998Fi7XHvJIIovoQFLYKehwduR0z1ix1xOej1+roo3+auowweJXkFKZV2LFaeMMzoJ22XAvQSpO3jBxFQ8+O8h+D+2bQNgwyrwo6EQLjDarl4mauAt4yt5Uk4+M4Mt0rjEAphLRaT/pbsLo6s4wwedPuEMutpMlsoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721792319; c=relaxed/simple;
	bh=ILkK4yINJMkVP4oDOmPuRu3IDjGB7GgtXICZ3nOzZ+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/+krVeoEH6C+pNwp3jjijJP6Lc1RDMg/fXdXgg7e5xZ0rNIF53oxd1TMzqkC2BDc7wyoUQYvEqCWN8kK8eTZLsVCebURGEGJGHymoAkmpIUThpfCBjzbTOal7krqjXF7I7/RH4+3FI/ezW3CWPlo0IUln0V7JH/K8tUFhB5DRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08271923|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00984783-0.000131915-0.99002;FP=8659051540359214238|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033038033188;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.YXxsy1Z_1721792310;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YXxsy1Z_1721792310)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 11:38:31 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: haifeng.zhao@linux.intel.com
Cc: helgaas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: Re: [PATCH v4] Subject: PCI: Enable io space 1k granularity for intel cpu root port
Date: Wed, 24 Jul 2024 03:38:29 +0000
Message-Id: <20240724033829.4724-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <e5c1990b-8c40-4376-bd9f-3701bf4eab91@linux.intel.com>
References: <e5c1990b-8c40-4376-bd9f-3701bf4eab91@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 7/23/2024 4:04 PM, Zhou Shengqing wrote:
> >> I think this has potential.  Can you include a more complete citation
> >> for the Intel spec?  Complete name, document number if available,
> >> revision, section?  Hopefully it's publically available?
> > Most of intel CPU EDS specs are under NDA. But you can refer to
> > https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v2-datasheet-vol-2.pdf
> > keyword:"EN1K".
> > ...
> > 
> > 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> > 		if (pci_domain_nr(d->bus) == pci_domain_nr(dev->bus)) {
> 
> Perhaps it is enough to check if the 0x09a2 VT-d and the rootport are on the smae bus
> e.g. On my SPR, domain 0000

Thank you for your comment.

Do you mean it shoud be like this?

	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
		if (d->bus->number == dev->bus->number) {
			pci_read_config_word(d, 0x1c0, &en1k);
			if (en1k & 0x4) {
				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
				dev->io_window_1k = 1;
			}
		}
	}

> 
> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
> 
>   
> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
> 
> and if you check domain number only, they might sit on different bus, perhaps that
> would make thing complex, could you make sure the VT-d is on the upstream bus of the
> bridge ?

I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
and VT-d device and function number is always 0. 

Please let me know if further modifications are needed.

> 
> Thanks,
> Ethan

