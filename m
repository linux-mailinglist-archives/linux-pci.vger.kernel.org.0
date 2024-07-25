Return-Path: <linux-pci+bounces-10767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CC93BD43
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042161F21B46
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBB16F908;
	Thu, 25 Jul 2024 07:44:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9916D9A3;
	Thu, 25 Jul 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893457; cv=none; b=WADOPDYi/wadB9XYlCuOOzPz6p8iKW1HIJL+WqbhgeerA5wLbOXT8XoL1cgNg30nIBgAiMA9O7l0cnZmRf+x59SekE5+9MiVwUCXS5cjJLI1Deu4OhEjYBHlb/m51P7i1p3GwA89dTnov6gVwj9Xu6yRFm0LFW76uTg/WxHjSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893457; c=relaxed/simple;
	bh=VsRD9RpGfNzTJeBE424wyq4lMEpvXqO7CWBLN2aG/Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwbT6BOvNTMCU06PAbrm9zEFDFuJdnPCOJAIPW9HnebgyTrRtfhO3oKf+jVKIJGEOwSHu7R7qmOYTqnY98ivbmOWuSdSNH86ycyA2midzN3fGzLXmkikryALLE6Uet5C4/ZxRU60uMgjwyMsB83o9lHDF2WKOfJROzDX2hJ2urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440004|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00729649-0.000270946-0.992433;FP=16230201195628131514|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.YZIOBDn_1721893443;
Received: from ubuntu..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YZIOBDn_1721893443)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 15:44:04 +0800
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
Date: Thu, 25 Jul 2024 07:44:03 +0000
Message-Id: <20240725074403.12928-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2912551a-b4c6-4bd4-8c1c-22de7fd8fa20@linux.intel.com>
References: <2912551a-b4c6-4bd4-8c1c-22de7fd8fa20@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 7/24/2024 2:35 PM, Zhou Shengqing wrote:
> >>> Do you mean it shoud be like this?
> >>>
> >>> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> >>> 		if (d->bus->number == dev->bus->number) {
> >>> 			pci_read_config_word(d, 0x1c0, &en1k);
> >>> 			if (en1k & 0x4) {
> >>> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> >>> 				dev->io_window_1k = 1;
> >>> 			}
> >>> 		}
> >>> 	}
> >>>
> >>>> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> >>>> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
> >>>>
> >>>>     
> >>>> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
> >>>> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
> >>>>
> >>>> and if you check domain number only, they might sit on different bus, perhaps that
> >>>> would make thing complex, could you make sure the VT-d is on the upstream bus of the
> >>>> bridge ?
> >>> I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
> >>> and VT-d device and function number is always 0.
> >> Yes, every VT-d instance in the root complex and the root port integrated are
> >> on the same bus. and VT-d is the first device of that bus.
> >>
> >> The EDS doesn't say if there is exception one of the VT-d instances in an
> >> system its EN1K wasn't set while others were set, vice vesa. so I suggest
> >> just check the VT-d and then set the root port's io_windows_1k of the same bus.
> > But as Bjorn mentioned at July 12, 2024, 6:48 p.m.,
> >
> > "To be safe, "d" (the [8086:09a2] device) should be on the same bus as
> > "dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
> > which would be a different bus, and they presumably are not influenced
> > by the EN1K bit."
> >
> > When VMD enabled, just check bus number identical may lead to enable
> > 1k io windows for VMD domain root port. E.g. 0000:80:00.0 is a
> > VT-d(09a2). If VMD enabled, there might be a root port 10000:80:01.0 present.
> > this code may lead to enable 10000:80:01.0 io_window_1k = 1.
> > This is probably not expected.
> >
> > If I modify it like this,
> >
> > 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> 
> BTW, don't save letters to use single letter variable 'd', please use 'vtd_dev' or
> something else to express the VT-d device.

Got it!

> 
> > 	---if (d->bus->number == dev->bus->number) {
> > 	+++if (d->bus == dev->bus) {
> 
> What if their 'bus' are NULL, though it is almost impossible. :)
> 
> > 			pci_read_config_word(d, 0x1c0, &en1k);
> > 			if (en1k & 0x4) {
> > 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> > 				dev->io_window_1k = 1;
> > 			}
> > 		}
> > 	}
> >      
> > Can the situation mentioned above be avoided?
> 
> Yes, my understanding, as Bjorn pointed out root port extended from VMD
> bridge not on the same bus as VT-d.

For the root port extended from VMD, should the 1k window be set
when BIOS setup EN1K knob enabled? 
In my case, I think  EN1K should not apply to the VMD root port.

But what I'm confused about is, how can I reasonably exclude the VMD root port
in the code?

> 
> 


