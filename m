Return-Path: <linux-pci+bounces-18446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D649F20A7
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039316429D
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F101335B5;
	Sat, 14 Dec 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="D4uzkZPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657AEC0;
	Sat, 14 Dec 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734206522; cv=none; b=JfxNTuGbf4fRj4NwZcvWGnsk51yPxC3AoC7+44CU/nYi+E8D2ns+eR7zTPnzQZWzlwWpvJj9iG31L721rFWIzPdmfZ9bEYsAMogNdDPGF5zpiL7Om86MMIsEQetcOeA9WK4LgGDiyjdbWjXZtLDkBK++GAMQZfuyL5P9b2pybg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734206522; c=relaxed/simple;
	bh=WkisfuZbrcE7YJEzTY+MTEcQ99F0Jx6Wwv6I6tE/tQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AdCAp2bW9GyIPT/fdvEn2N1BQ6ycIzoDJ3FSkUqWpXevyyN7pFG6E9on8UvpdygFYrJiU3xe24vrg6AF1EodAFM1Y/rOsW12xNoOaqxox+BLdgN2zQsQMMHpZhZqTbqQajFKAI0c9jmCczjIbFnn8KxADsGAeENUjDwuRMj3ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=D4uzkZPh; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CbNvvOuIDSSAEC+SeiGuDXyQPJHTngc0I8oZ/GkCqsw=; b=D4uzkZPhzpQ+KsbSnj003Zzv+g
	xRY5gD0MZElcwDCc2Q4sP7REH6kYvccz0ZnyFVq1U0RaUeS3wCoIMOu8paX0tyEsyfvEBdmDsYCZR
	YlceGdIHzhM7Rjdfj7QMXnd6c/WfzXi6ma3aaSoAws+PbDZD7haeBcNWHVtdfEBT+KYU=;
Received: from [88.117.62.55] (helo=hornet.engleder.at)
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tMXd0-000000003Nx-2xaL;
	Sat, 14 Dec 2024 20:16:38 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bhelgaas@google.com,
	pmenzel@molgen.mpg.de,
	Gerhard Engleder <eg@keba.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
Date: Sat, 14 Dec 2024 20:16:23 +0100
Message-Id: <20241214191623.7256-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

From: Gerhard Engleder <eg@keba.com>

Link down and up triggers update of MTA table. This update executes many
PCIe writes and a final flush. Thus, PCIe will be blocked until all
writes are flushed. As a result, DMA transfers of other targets suffer
from delay in the range of 50us. This results in timing violations on
real-time systems during link down and up of e1000e in combination with
an Intel i3-2310E Sandy Bridge CPU.

The i3-2310E is quite old. Launched 2011 by Intel but still in use as
robot controller. The exact root cause of the problem is unclear and
this situation won't change as Intel support for this CPU has ended
years ago. Our experience is that the number of posted PCIe writes needs
to be limited at least for real-time systems. With posted PCIe writes a
much higher throughput can be generated than with PCIe reads which
cannot be posted. Thus, the load on the interconnect is much higher.
Additionally, a PCIe read waits until all posted PCIe writes are done.
Therefore, the PCIe read can block the CPU for much more than 10us if a
lot of PCIe writes were posted before. Both issues are the reason why we
are limiting the number of posted PCIe writes in row in general for our
real-time systems, not only for this driver.

A flush after a low enough number of posted PCIe writes eliminates the
delay but also increases the time needed for MTA table update. The
following measurements were done on i3-2310E with e1000e for 128 MTA
table entries:

Single flush after all writes: 106us
Flush after every write:       429us
Flush after every 2nd write:   266us
Flush after every 4th write:   180us
Flush after every 8th write:   141us
Flush after every 16th write:  121us

A flush after every 8th write delays the link up by 35us and the
negative impact to DMA transfers of other targets is still tolerable.

Execute a flush after every 8th write. This prevents overloading the
interconnect with posted writes.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
v3:
- mention problematic platform explicitly (Bjorn Helgaas)
- improve comment (Paul Menzel)

v2:
- remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
---
 drivers/net/ethernet/intel/e1000e/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index d7df2a0ed629..0174c16bbb43 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	}
 
 	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+
+		/* do not queue up too many posted writes to prevent increased
+		 * latency for other devices on the interconnect
+		 */
+		if ((i % 8) == 0 && i != 0)
+			e1e_flush();
+	}
 	e1e_flush();
 }
 
-- 
2.39.2


