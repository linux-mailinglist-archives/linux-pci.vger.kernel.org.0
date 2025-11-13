Return-Path: <linux-pci+bounces-41180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3EC59C83
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E57F3A4553
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EB31B116;
	Thu, 13 Nov 2025 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXw1Mzmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7A31BCBD;
	Thu, 13 Nov 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062582; cv=none; b=IsuIc49NoxvMDcjF6NCnTW2yIUNZZcJ3f3qdRJ9XQghB8tUQ8Z55nmdHU5vCb1/2RrvIJJB0kZvlhwdmm1R5qysHCLKMrt02meYVvgdUnb4cRgSJFTQzE8dlWIwuVoVQrpnq/LbSB4/K9WBfnUx1yPRYNEIm+PoKamDetgQSfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062582; c=relaxed/simple;
	bh=d6/wr9z7PiikiTt2BwH3154EzjBBkK66uPk6kTQ10ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=osuhkHkabLqJBLQ3CgDHLj//sDpIznv6fb8TkOXCwmst6kDOshvBqe0AFOneWWWg2VEp3t1F68hlB4sFKn7F+A0SPOQRwkbFwsmO9y0NjCv3inynVgrr808fk16hURgMkPpZWv8xvhsPeV9cUkbFQ2vvN8Ipn8SkTlk7WZw5GjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXw1Mzmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7D4C113D0;
	Thu, 13 Nov 2025 19:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062582;
	bh=d6/wr9z7PiikiTt2BwH3154EzjBBkK66uPk6kTQ10ys=;
	h=From:To:Cc:Subject:Date:From;
	b=DXw1MzmgfXdUe2VLx/g3bAIunmcbRCWyautyCBuIrVIiY2I/AiUK86DMpffYME8OP
	 MrYQ2Hk7VkFxpnd4uqZFe3AQO4SE4OtjiLMOJATqDbYd8W3Wz2PjK527PrKfS9BIYv
	 gYAz0haPVjw4vG0nVFXMwhNfGfB5jgLcP9bjDjxgfTiMTBRm0aTTnEv0oMPaCm0wrc
	 eq1dliaISIPU3TRuokU6UmGSI5W4xxcjSjZromXvoT6e1LWJdti9Dbv8lZ/LBeSBVI
	 fAWwNNCqSM6PiiMQ9it2vipP4ZF6sbjjD0OP7s8tubZda7E82K/7V6+0JnlMSm/iqH
	 2yDk+LgTHlCrw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 0/3] PM: runtime: Wrapper macros for usage counter guards
Date: Thu, 13 Nov 2025 20:24:57 +0100
Message-ID: <5959587.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This supersedes

https://lore.kernel.org/linux-pm/13883374.uLZWGnKmhe@rafael.j.wysocki/

as discussed here:

https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/

It adds runtime PM wrapper macros around ACQUIRE() and ACQUIRE_ERR() involving
the guards added recently (patch [1/3]) and then updates the code already
using those guards (patches [2/3] and [3/3]) to make it look more
straightforward.

Thanks!




