Return-Path: <linux-pci+bounces-19626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B52A09267
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5563AA602
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F720E33F;
	Fri, 10 Jan 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JPyBWRZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643462063C9;
	Fri, 10 Jan 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516805; cv=none; b=a0wEphDdzr5Ms0rDVxUh08/CroNXG8+sa6i4CB5yEd8HzzEIfla7nx0F9PMTXPnxon/cEvSRvWamP+cmNgdZ6AgqC0jgbRCSKziEIYNgdw5WQOYjudhrgY9P4gacQ4wipg+gqXzbhEaBDeewPeWlvWOkRqqbUy4jVRxiwL+tKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516805; c=relaxed/simple;
	bh=oZawplHCNRT8BruZ7AHnDuMCVbBUTqmmU1w72cdFPW8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=cmXU6J/wEzCiSmbz1NzYYOWMa6hp3XgBBjcC+nhAB6SyyFT8dtL78fLae5WZe4yl1I52oml1K9x+eTv2Zeb94F/fDOjpbXDsAV9+3TEuFIrchhqufPwABzGhjg0Osruu4e469VYDgWCxbISF3xnL/8reN6TeALrgZvx2zqaMOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JPyBWRZG; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736516792; bh=sv735Zju32zbddEntk9l6cBvbBc4hC1Divb3zrT5+Pk=;
	h=From:To:Cc:Subject:Date;
	b=JPyBWRZGvX8dq1p0TkA5La1VbTuNfrd/wZTK18OFCZg0alCh8jb4n5FWXR7kByYEh
	 wuWbixcNayrfT95ouiM6XJ+gfhiDuGWV+MiXE4CM7mgFo084qI960JdmrZpDHzubHW
	 DrnrWqTNWV+C0Z21jUfgir37yeF7SDY1ATcSMbxs=
Received: from jiwei-VirtualBox.lenovo.com ([120.244.62.107])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id A0E03ABA; Fri, 10 Jan 2025 21:40:14 +0800
X-QQ-mid: xmsmtpt1736516414t5m8cmw5w
Message-ID: <tencent_753C9F9DFEC140A750F2778E6879E1049406@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn/roit6RvG8nk1osforKZTegtUm3EH8/PLOXQhK9iCzAql5LsEV
	 peeOO+Gz37CklgAjiiuG/xc+WnWOQXfdwFiRFJfv0PaV8A6ATafjF2pjOBk9fRleCYnue06z1BNJ
	 qezvP27nVicxwFsKRakPUNlHxwKwAkK35rXrZmxu8ZAZS/hWwvOB6BeGXMlYEBeD7Du1NdtM7btZ
	 lLyXbJePXNe4jWLNJCHdbiUACXBK4LeCx8tJT71KUOT1+ffZma2b7uMk5R24jXRut5m3z1952qQZ
	 tWPBpF9Xi6j00v7QETSZJSxO01qiwItnURFaYfWzTuoXLGbM3T3+Dil6gKac76Rzos8qLtgzR6ZA
	 sirCHE3a0ljgV5quH057w9npW4GwFtHrDzxIbXA4mIhQEMseKfTgRXxZyFnSoYMbAaDLlAavdxsk
	 HGcZHTsiJhWqImswAp4V811xkGkGLaDPWnyjnss1Ixc7JO2n3OUbHFM7vXKDe7ObRBO1UG204Kvp
	 c8K+zHBfxmdzRVNbjJK4HEyjkMfpCEpkvW6UlN5WdoeywUshRHG8/lCK9bNTdFjesM6xzsIZxdoC
	 ECDPipv6DY6JNLGHfF7BBMVfGrXk6KzxbUORP/TAU3c4ViUpsu1wLaagoahE47DMg899a8IWcaye
	 U2ssqRKazAze7mIiZPVZaZuIFmMRJOcTleD/XKc87Hl7Lv0PFDiWBw+FXgrVlyUcD15zmLjsT1oc
	 yZrfRwQK1Fs/Jckr38uFy0HOlNlUEFwDRHTXyJIGjjxNATdHRTqfhAAORv89S/gJcXXnqDjiWUy6
	 vdfk2nFkhv7cuUbiq6FCWgfj0h1pAL9J56GMRgaz6reIXgW/Cd0jJKzGNcLnbFug6FmAZWdIGRj2
	 eUHc5qanWPZk6Sid2ohCsWp9lFGseGT+Plz1AYnUW0lguG6K3kkA8OHOteqSjFU7d6CI7mKTDguC
	 nE4J0tekemH6i6SOBFlrX902ar0Qq+W/xCF579Ad/YBjfp215brTbv4IY/mMCSKvMDEpMiWZFEOg
	 xLyXI2XA/rsc2agCiYWxRIaS4XbuahSJSmEKI8TYAc/LjFeQlX0RKPIvMJecMnwdOF9aUU/g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Jiwei Sun <jiwei.sun.bj@qq.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com
Subject: [PATCH 1/2] PCI: Fix the wrong reading of register fields
Date: Fri, 10 Jan 2025 21:40:06 +0800
X-OQ-MSGID: <20250110134006.33527-1-jiwei.sun.bj@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiwei Sun <sunjw10@lenovo.com>

Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
PCIe Link Speed"), there are two potential issues in the function
pcie_failed_link_retrain().

(1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
uses the link speed field of the registers. However, there are many other
different function fields in the Link Control 2 Register or the Link
Capabilities Register. If the register value is directly used by the two
macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).

(2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
changed after reading from PCI_EXP_LNKCTL2. It might cause that the
removing 2.5GT/s downstream link speed restriction codes are not executed.

In order to avoid the above-mentioned potential issues, only keep link
speed field of the two registers before using by pcie_set_target_speed()
and reread the Link Control 2 Register before using.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..605628c810a5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -118,11 +118,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
+			oldlnkctl2 &= PCI_EXP_LNKCTL2_TLS;
 			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
 					      true);
 			return ret;
 		}
 
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	}
 
@@ -133,6 +135,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+		lnkcap &= PCI_EXP_LNKCAP_SLS;
 		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
-- 
2.34.1


