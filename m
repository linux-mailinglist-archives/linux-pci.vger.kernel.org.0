Return-Path: <linux-pci+bounces-3015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077A8470F4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D728930B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810237144;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlbPU2Mx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE745253;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879821; cv=none; b=oJYYszLg26xb+YY3+DPIY728h/Ytjh7jda5qxEwyEOzbRYridN8rnV/6ibhf3CtHhQAkBDU3ghPPUNYxEyvUQKkqWOg7xKn809wqREj+QmVRcuckbODHONyPY5ufKqdVnZUEum2nu6GYbG06qMSY6piMSGDS8VU2PuzCF3M2V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879821; c=relaxed/simple;
	bh=WJ6di6rAbW+F7smaUbbT+QY5cidNRjEj7IYYHZC6twc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujpSZAW+Uv1h27dDXq0rOY+WK4Sgmnl5y8CyBw5KyUV8BLP6ZfLEjyhO5mEUcc5GKmN6oeknCy3qqfeFJW2rs7+jPQ4nB9sIj53aEugEiEiUZwu+MTPUdLBusIY+uWqE4iasvWGSF0bdP7rw4zSyA5/LK6LQSVdvyad6a1E6iKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlbPU2Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D39DC433C7;
	Fri,  2 Feb 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706879821;
	bh=WJ6di6rAbW+F7smaUbbT+QY5cidNRjEj7IYYHZC6twc=;
	h=From:To:Cc:Subject:Date:From;
	b=HlbPU2Mx++DXxa+ZPGaqrNIGx1s73M0kon3pJgCj4ab2hzrWVKmOGLHh0h1QtEitz
	 NLHYtbmaIuTEK6mU8eNUycbA+FIAMYMbmaVMMNxyeWHzJIXBGkwKLEQMPrAscEtaz2
	 FHZ6txAF8G5RCagacXyYiymgeN1tSZVk3nNPtEqqMp5qtNxB+CKy0VdDCWko0vTqqi
	 D6XYXPKA+jFR8HVdd8nCgzE+B7xHRt+AaUkwjfQsybG+YGNLuKQhqcRVkPj8IM+e0s
	 nkGScYNGNI5MBTuQil3XLTAeUpsbxQeYvJu6mObEpgWdcAxil2Qb9Qf+itPE87iM/j
	 bqjz34+FCH3aw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rVtPk-000000002yK-2VKh;
	Fri, 02 Feb 2024 14:17:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] PCI/AER: Fix rootport attribute paths in ABI docs
Date: Fri,  2 Feb 2024 14:16:33 +0100
Message-ID: <20240202131635.11405-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some AER attribute paths were changed in the final revision of the
series adding them but the ABI documentation was never updated to match.

Included is also a related white space cleanup after a commit fixing the
'KernelVersion' field name.

Johan


Johan Hovold (2):
  PCI/AER: Fix rootport attribute paths in ABI docs
  PCI/AER: Clean up version indentation in ABI docs

 .../testing/sysfs-bus-pci-devices-aer_stats    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0


