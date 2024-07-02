Return-Path: <linux-pci+bounces-9550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4C91EE89
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 07:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B031F22D36
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 05:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ED878C67;
	Tue,  2 Jul 2024 05:50:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A85C8EF;
	Tue,  2 Jul 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899402; cv=none; b=gGf07oaW6W4yQD1xHbQC8YPSLVTz1fFYEpxd6Z8KziVJI7T+dMi7nHMYPCLNWDoG/dVm4TPz+mNYVxep0HblvHHdlWNJvtUtc47PzqQvP8aKTlvD9kH0GQbdJy++NlIYMv8etL54W0ZMTOKBVU74Qlj2eVBDHUoROuupG78kszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899402; c=relaxed/simple;
	bh=r3kPzEw7v6TNbHMYTGt40eoeeIKe//M6zF721bQKgPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAmTC4Y1wcseglQF3Rbe7MYtaQ17KP8pwa1o0wws9Htd4Z0IMy83YPER63HP/RRsmyNxO9KZCbmu+YDZpQmygUGkHpCTWWQuD9FoawLdMLhLpTaG6R6g0qIzWY2B/9G0t5kExPQ/yY8YLfFHxLpN2LxrxZdmYXFMqd/oWmLMIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1484611|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.180177-0.0129281-0.806895;FP=18286485004836861259|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037136014;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.YEtLVOK_1719899389;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YEtLVOK_1719899389)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 13:49:50 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: Re: Re: Re: [PATCH] PCI: Enable io space 1k granularity for 
Date: Tue,  2 Jul 2024 05:49:49 +0000
Message-Id: <20240702054949.14274-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701210656.GA16926@bhelgaas>
References: <20240701210656.GA16926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > I still think this is not going to work because I don't want this kind
> > of device-specific clutter in this generic path. The pcibios_*
> > interfaces are history that we'd like to get rid of also, but it would
> > be better than putting it here.
> 
> Do you think it should be putted to the pci_bios* interface?
> 
> And if there is no suitable place to apply this patch, 
> then let's just ignore this issue.

> What are the device/function addresses of the IIO and the Root Ports?

IIO device = 0,function = 0.
Root Ports device = 1/2/3/4/5/6/7/8,function = 0, And they are on the same bus.

> 
> They must all be on the root bus, and if the IIO is enumerated first
> (i.e., if it has a smaller device/function number), you may be able to 
> make a quirk that applies to the Root Port vendor/device ID but reads
> the config bit from the IIO.
> 
> quirk_passive_release(), quirk_vialatency(), quirk_amd_780_apc_msi(),
> etc. do similar things.

I have commited a new patch referred to quirk_passive_release(). 
https://lore.kernel.org/all/20240702035649.26039-1-zhoushengqing@ttyinfo.com/

And I validate it on my system which previously some devices couldn't have IO space.
After applying this patch, all devices were able to have IO space.

Thank you again for your assistance.

> 
> Bjorn


