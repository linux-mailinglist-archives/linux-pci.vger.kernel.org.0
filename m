Return-Path: <linux-pci+bounces-24693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C5A709AD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 19:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E343B6448
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC31F0980;
	Tue, 25 Mar 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="C9xCpXD/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BD1EEA33;
	Tue, 25 Mar 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928569; cv=none; b=C+BhYYDIVoJJWScrHClP+cHRnKkoCOQWhBTidmV8j7DCT3FyRY2S2muDElx3ZmAA+Krt4r1n3PhGq0LDTEnJLOIgur9zgd7Qm+CF8FMOaUJXYGceghJ0DLrKE1UEHvhCmldYZfnuoTVYmcW/NiiaXaQA7rNsUN0RNTqWcLAd/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928569; c=relaxed/simple;
	bh=XgDj0Di+eeIry852R2GnUTi+rR8sbqw6aKuA6K7yA90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIt4o0DRWuOSCH/fzs/aK2YUBLxYDcH9et0sDGr4dtGaLj08UwJqHD1aDhWYz92YCqbTiUSKj49OySih9NRmZRRsLsMQ7ip2YpFJVuKEZW/Ia8O7PCE9QjjUVNEOOTib4FGgVNyVKJogWnVv6irvU5uhqkAlSduDl7ihzju432o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=C9xCpXD/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1742928568; x=1774464568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JD6sTKoX3EKujTqY4AfZRs3b8uuJh68B1d1wrI3KDxg=;
  b=C9xCpXD/Eqel0k67PrvXDJSXOdMOCYInYTC1CEK2eD9OncTFwEefHdGq
   uEQx5VHjYuOwg+aPF8rqIqPxHyHTTyh9nu8XGRmBaRS20h+oSQ+qUGdx1
   jmI3Zuw0vn2oVS/C9e9uAF2pzKNJPV2KFMl2oR+yYWniofZoYoiRFm7GL
   w=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="810472843"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 18:49:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:23246]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.232:2525] with esmtp (Farcaster)
 id 52821a66-889d-4c0a-8d94-c24f240e5145; Tue, 25 Mar 2025 18:49:27 +0000 (UTC)
X-Farcaster-Flow-ID: 52821a66-889d-4c0a-8d94-c24f240e5145
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 18:49:26 +0000
Received: from 80a9974c3af6.amazon.com (10.37.245.7) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 18:49:23 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <sraithal@amd.com>
CC: <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-next@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<sfr@canb.auug.org.au>,
	<syzbot+d33642573545e529ab61@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <takamitz@amazon.com>
Subject:
Date: Wed, 26 Mar 2025 03:49:14 +0900
Message-ID: <20250325184914.85065-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f5c68bc9-3c47-49a1-b336-4fe19a9f407f@amd.com>
References: <f5c68bc9-3c47-49a1-b336-4fe19a9f407f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

Subject: Re: [syzbot] [pci?] linux-next test error: general protection fault in msix_capability_init


> I tried booting host with my host config, there I am seeing different 
> issue but host crashes

This issue is also reported in [0] that it is related to the commit
"d9f2164238d8" (PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain
flag).

The new patch is prepared in [1].

[0] https://lore.kernel.org/all/qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7/
[1] https://lore.kernel.org/all/87v7rxzct0.ffs@tglx/

