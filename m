Return-Path: <linux-pci+bounces-25099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7CA783B0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 22:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A378F188C665
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662B20C48F;
	Tue,  1 Apr 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OapLdiEU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48519209F31;
	Tue,  1 Apr 2025 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540946; cv=none; b=CYpqYOHg4vq5fWgSl9sYfec2VRt1Vj59ticl40wG9wuXoPxj+ZkOR5HsUj+8qJVFsM5QEaTPoGzDiF/RcDmQXCEWoO4S6FG5VRj/3GniPo2MTM3OpjHFrJSgaPpeuKO3JEAzLsIeEWTrSd4R+X6r9ukup60VFlv4ekZYil+X08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540946; c=relaxed/simple;
	bh=TZ9Y5CWw5617/CTvl/A5AgM4bAqpWJNtdNir9YnP+V0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bZImv5yq0y7UYQrrggpSARrD14RucK4kIS71ohMYuo4N+rRl5QyoL6ZQEMQDpzkiow9RjWTDhTf7wnwvTyfEDIwj5T+enzrVdtRkjnLpv2KM4EI0qTdethmrro2NObsJPP9fVZXGTWdU69VEB9N7mEDHn/Av7e6TVKFqtffc+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OapLdiEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962D8C4CEE4;
	Tue,  1 Apr 2025 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743540945;
	bh=TZ9Y5CWw5617/CTvl/A5AgM4bAqpWJNtdNir9YnP+V0=;
	h=Date:From:To:Cc:Subject:From;
	b=OapLdiEUCgN9698OkImKcFv8jiusMxs+x7oUZHNLOcy6JNt9qfYIQk1i0Z+x7Qvv6
	 1Iqtf0EJLMcyOimsxupu3CUEnWQXywmtLGmMEfaab7KdZpkGMf/8GJF2Zw7ZigPDU8
	 Vp/jLSWg/Liil/mka9uQttpJd6rk6ZrNxC0wYCALLnFzm9Fh8QM/pWDSMzD4YF7dCL
	 yTcmr6dYqx78BhjReR1XxhAcNJ0uqqHCPTQFrBRLxG0MTbdUS9cxV8d56Fs1yo86SN
	 zne05zwDxSYNaQaKObKzOckcdRyPDA8EZMG6GHcSZT9BhikMl9DwzWhx7Vr6dkpi4q
	 2y/nG3CwWAzKw==
Date: Tue, 1 Apr 2025 15:55:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: PCI VPD checksum ambiguity
Message-ID: <20250401205544.GA1620308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The PCIe spec is ambiguous about how the VPD checksum should be
computed, and resolving this ambiguity might break drivers.

PCIe r6.0 sec 6.27 says only the VPD-R list should be included in the
checksum:

  One VPD-R (10h) tag is used as a header for the read-only keywords.
  The VPD-R list (including tag and length) must checksum to zero.

But sec 6.27.2.2 says "all bytes in VPD ... up to the checksum byte":

  RV   The first byte of this item is a checksum byte. The checksum is
       correct if the sum of all bytes in VPD (from VPD address 0 up
       to and including this byte) is zero.

These are obviously different unless VPD-R happens to be the first
item in VPD.  But sec 6.27 and 6.27.2.1 suggest that the Identifier
String item should be the first item, preceding the VPD-R list:

  The first VPD tag is the Identifier String (02h) and provides the
  product name of the device. [6.27]

  Large resource type Identifier String (02h)

    This tag is the first item in the VPD storage component. It
    contains the name of the add-in card in alphanumeric characters.
    [6.27.2.1, Table 6-23]

I think pci_vpd_check_csum() follows sec 6.27.2.2: it sums all the
bytes in the buffer up to and including the checksum byte of the RV
keyword.  The range starts at 0, not at the beginning of the VPD-R
read-only list, so it likely includes the Identifier String.

As far as I can tell, only the broadcom/tg3 and chelsio/cxgb4/t4
drivers use pci_vpd_check_csum().  Of course, other drivers might
compute the checksum themselves.

Any thoughts on how this spec ambiguity should be resolved?

Any idea how devices in the field populate their VPD?

Can you share any VPD dumps from devices that include an RV keyword
item?

Bjorn

