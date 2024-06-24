Return-Path: <linux-pci+bounces-9171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC6F914469
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543E41F235A0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800442E3FE;
	Mon, 24 Jun 2024 08:17:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA59199B8;
	Mon, 24 Jun 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217027; cv=none; b=GDlXUE8TOOz/KtXZaLTHHIFP0FxrDIVxYgAxiMOQeFeoE+xtLcwKWeOkLADHnN+Ho9By3BsjikoHFssc91UWa7q0zV4O7feN/X8OAJcdZiHzgaZ2J4II4aRrCf/5dtvcN3dCP1CgIR+kBXvQShsQB9GpStUl/+7WzjGUPUJVEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217027; c=relaxed/simple;
	bh=hXRRTlient8WSSpmiaWRN0a8Hjl5zz2ypgcPSM+y9Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bk625NpGbiL3+jpUTHsBry/KWiofKZd3QCZ7PhmcqcwhFovVZMZV1v5baKOcbuT11h1dKAPXrPDpamkzTYX1s+OvD+j3ELWosRTh7CKlmgXWiMFNfCc9xmVbtUn/8blcqr8AohFdZ/rHPs7ljVktuBzsMMGPY+sbo1jw69AyUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3104835|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.488855-0.0031871-0.507958;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Y8jr4AK_1719216066;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.Y8jr4AK_1719216066)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 16:01:06 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	zhoushengqing@ttyinfo.com
Subject: Re: Re: [PATCH] PCI: Enable io space 1k granularity for intel cpu root port
Date: Mon, 24 Jun 2024 08:01:05 +0000
Message-Id: <20240624080105.16960-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240623022611.41696-1-zhoushengqing@ttyinfo.com>
References: <20240623022611.41696-1-zhoushengqing@ttyinfo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > That seems like a really broken kind of encapsulation.  I'd be
> > surprised if there were not a bit in each of those Root Ports that
> > indicates this.

> Your understanding is completely correct.intel ICX SPR RMR (even GNR) 
> CPU EDS Vol2(register) spec says "This bit when set, enables 1K granularity
> for I/O space decode in each of the virtual P2P bridges corresponding to 
> root ports,and DMI ports." it targets all P2P bridges within the same root bus,
> not the root port itself.The root ports configuration space doesn't have a 
> "EN1K" bit. 

For this reason, it doesn't seem feasible to implement this patch in 
fixup.c or quirks.c.Would it be reasonable to implement this patch in the 
pcibios_fixup_bus function in /x86/pci/common.c? I also think adding this patch
in pci/probe.c is not a good idea.

