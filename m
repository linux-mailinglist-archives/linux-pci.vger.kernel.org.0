Return-Path: <linux-pci+bounces-25968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1AA8AC4A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 01:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436C03B1074
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36B2D86BC;
	Tue, 15 Apr 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKb0G2aF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA622741DB
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760692; cv=none; b=TFDuFsOpnYfdwBfyFUdoph+MIBB1yWTaHNqtoqW7Xw4eMxwY/TJ8NtW4YZlsAL721sdamIZz5pMew3dL7ap+QRz5FnIiK+0PLuU6dBKSA0/Odd4tTQRwnW2aHTJ3rPS2tSEzvB2ZVsakbzEooVK+uCvOi+XEHVmyz7NpRFcr8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760692; c=relaxed/simple;
	bh=4fFhy1bv3fjXJ2gbAVmeQDcY3EdBueBEOE7YRGXbX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ns42C6H6wbq2WgKmlim4/zUCxq/IpKdoZC8kraE14BLKZ9mOx0xk0Y+QXHa8SH2qJ9Ni8wQ147oh5rlAXuhODR65dRakxKSNXG+xpwOy+Q5bZEeAQ8zdpKNNElIuD3ue9nteqZZpWchckdwQuF84W5g08WqHfmmFi/IX/aSVG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKb0G2aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389EFC4CEE7;
	Tue, 15 Apr 2025 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744760691;
	bh=4fFhy1bv3fjXJ2gbAVmeQDcY3EdBueBEOE7YRGXbX7k=;
	h=Date:From:To:Cc:Subject:From;
	b=BKb0G2aFnEt+XoEOyYfPViJo7uCR9hEbrFCn5iDUzpj/dgR6XQSPOKfmBnbg4wYKq
	 c2m8fY5Wm8Ma0GyCshQDPZTnppJjqhXmDeeqHnkdS5+60DKXahlOjkTS2lAMnIx7Ni
	 Z/WY5xboHlRuZb9p/07U8ThrPYlbsgGZ+APFogfMoyUz1fiToukbxLK5Sf7xNTNldL
	 iF+9KgpYMxiXsbrN41FE4/WOXJp4n6kTjz7eN+7V+or87y7ZyMeX7udKEtrciB6I6D
	 um04q5zt45jNj74mjQQYdPB7Nw9xyvmkDPe+G7lCdpZ9YxpttyW3C636y6JkffndQ9
	 PEH0RrTHTbCtg==
Date: Tue, 15 Apr 2025 18:44:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Athul Krishna <athul.krishna.kr@protonmail.com>
Subject: [bugzilla-daemon@kernel.org: [Bug 220010] New: Regression: 6.14.2
 breaks PCI passthrough, qemu-system-x86_64: no available reset mechanism]
Message-ID: <20250415234449.GA45571@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Forwarding to linux-pci just for completeness.

https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bc0b828ef6e5
is queued on pci/for-linus for v6.15 and stable.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Subject: [Bug 220010] New: Regression: 6.14.2 breaks PCI passthrough,
	qemu-system-x86_64: no available reset mechanism

https://bugzilla.kernel.org/show_bug.cgi?id=220010

Created attachment 307958
  --> https://bugzilla.kernel.org/attachment.cgi?id=307958&action=edit
lspci

Device: Asus Zephyrus GA402RJ
dGPU: RX 6700S
Kernel: 6.14.2

03:00.0: dGPU (IOMMU Group 16)
03:00.1: GPU Audio Controller (IOMMU Group 17)

qemu-system-x86_64: vfio: Cannot reset device 0000:03:00.1, no available reset
mechanism.
qemu-system-x86_64: vfio: Cannot reset device 0000:03:00.0, no available reset
mechanism.

BISECTED: 792bd08a41bdc309e08ff4d429f670cbb30f2b63

03:00.0 does have `bus` in `03:00.0/reset_method`, and `03:00.1` does not have
`03:00.1/reset` file. 

Removing `03:00.1` from PCI passthrough still shows error:
qemu-system-x86_64: vfio: Cannot reset device 0000:03:00.0, no available reset
mechanism.

Attached lspci -vv output

----- End forwarded message -----

