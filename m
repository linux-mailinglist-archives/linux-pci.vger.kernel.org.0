Return-Path: <linux-pci+bounces-10708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309993ACB2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E22B283FD0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59184655F;
	Wed, 24 Jul 2024 06:36:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-6.us.a.mail.aliyun.com (out198-6.us.a.mail.aliyun.com [47.90.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC043150;
	Wed, 24 Jul 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802979; cv=none; b=ITg4bq9F7KeEy1eoBSkoBe4tObSP6eAZE/qDsILeZmJDOIqRk7+jQAFGrKSeHCldlDg8lgN1L7MQPeaDQeyZ9twbkZMoaLhATspsYBR6F34tJyfbOowWzLqta78mqJkwZO7Y2QCV4Dqgx6/Ld/soS8umHGJ6TIwbKa3HcAJRNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802979; c=relaxed/simple;
	bh=Ebd14HrAYjGw8+Qc37MwbFm3fXYOaB8vE0cSnkFhrC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2jnD3ollDP/SDSngrP4VIYjLusHWi0kANUaay1APPyvxXn3sMu4wM/6w7IN5yyubN2O7QJqraUF5j+V4g0dB0HZtw8bmaFandL4doeqA3k7kuk3RImhq2npp4AcqKkCcBlqC1okSyasHJBFO/xBBwqLreJg5/2bLql3w7qfoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07492151|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00739205-0.00019925-0.992409;FP=16154132379161130174|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033038033188;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.YY4fdiP_1721802955;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YY4fdiP_1721802955)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 14:35:56 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: haifeng.zhao@linux.intel.com
Cc: helgaas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: Re: [PATCH v4] PCI: Enable io space 1k granularity for intel cpu root port
Date: Wed, 24 Jul 2024 06:35:55 +0000
Message-Id: <20240724063555.3819-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <48373ac6-574b-4f72-b4f1-ddb7de8a5107@linux.intel.com>
References: <48373ac6-574b-4f72-b4f1-ddb7de8a5107@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Do you mean it shoud be like this?
> >
> > 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> > 		if (d->bus->number == dev->bus->number) {
> > 			pci_read_config_word(d, 0x1c0, &en1k);
> > 			if (en1k & 0x4) {
> > 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> > 				dev->io_window_1k = 1;
> > 			}
> > 		}
> > 	}
> >
> >> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> >> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
> >>
> >>    
> >> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> >> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
> >>
> >> and if you check domain number only, they might sit on different bus, perhaps that
> >> would make thing complex, could you make sure the VT-d is on the upstream bus of the
> >> bridge ?
> > I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
> > and VT-d device and function number is always 0.
> 
> Yes, every VT-d instance in the root complex and the root port integrated are
> on the same bus. and VT-d is the first device of that bus.
> 
> The EDS doesn't say if there is exception one of the VT-d instances in an
> system its EN1K wasn't set while others were set, vice vesa. so I suggest
> just check the VT-d and then set the root port's io_windows_1k of the same bus.

But as Bjorn mentioned at July 12, 2024, 6:48 p.m.,

"To be safe, "d" (the [8086:09a2] device) should be on the same bus as
"dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
which would be a different bus, and they presumably are not influenced
by the EN1K bit."

When VMD enabled, just check bus number identical may lead to enable
1k io windows for VMD domain root port. E.g. 0000:80:00.0 is a 
VT-d(09a2). If VMD enabled, there might be a root port 10000:80:01.0 present.
this code may lead to enable 10000:80:01.0 io_window_1k = 1. 
This is probably not expected.

If I modify it like this,

	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
	---if (d->bus->number == dev->bus->number) {
	+++if (d->bus == dev->bus) {
			pci_read_config_word(d, 0x1c0, &en1k);
			if (en1k & 0x4) {
				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
				dev->io_window_1k = 1;
			}
		}
	}
    
Can the situation mentioned above be avoided?

Hope for your suggestion.

> 
> Hope that works for your case.
> 

