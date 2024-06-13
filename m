Return-Path: <linux-pci+bounces-8771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3FA907F1A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FA21C2244C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A95137923;
	Thu, 13 Jun 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AZe7D+wq"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67813B791
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318878; cv=none; b=ZhfUXE9QylJ5lPikpG9UruLUUa12jVeQViBv51eb8E8d1+IMlrq0gVkWIavvZAt8PVz8/BNbBGHneIgyaXYaBXYNBZigBkcszmzWzsZmLHNrmgmHqwMKELQTxr71ZbuO1yO1zSG06dnvBNUVlIYPQOVuOdwWnwGxlkQDpehqbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318878; c=relaxed/simple;
	bh=9DwkIrA2kiM9u+NvqL/Wc9fSO8rIMkO+fxe7CSzAxQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsqaLitPTVC/Hg8Cbya6HIQDpgfNBa99pT+dYdnaBF+SNx/JeSpSANyKR7A2OVePEOpEK/fp6WfI3FJ7n+NXIE5K09Kqwzek7KCHqETpTL+NGxM4Lq3wmUQ42flmmaBTiikHukyeuWLHzm2L0Nbep4ntmIZMWMiC6KOJccTmPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AZe7D+wq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.vs.shawcable.net (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 010C320B7001;
	Thu, 13 Jun 2024 15:47:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 010C320B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718318875;
	bh=iQmYjmbcGNpBmAZnx5/tTrXhJJ/BQtCTBwPAJj9aRz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZe7D+wqlwsiKfBKNV5ZfhJLOPMJTExiDdAgvn1JA6VBkbVTG99OVWCuR1PyKnDKh
	 0HrI0eLTz7j+eDCc8QFcW/HFzElzflCYlX/Y13g674l2pzQ7MIYdzUIbhmVmfC9f4m
	 EgH9ne0jbFMKYUIpyk7b0OAWAE13w1mS2KS6bBg4=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: manivannan.sadhasivam@linaro.org
Cc: Sergey.Semin@baikalelectronics.ru,
	apais@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	code@tyhicks.com,
	fancer.lancer@gmail.com,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	okaya@kernel.org,
	robh@kernel.org,
	shyamsaini@linux.microsoft.com,
	srivatsa@csail.mit.edu,
	tballasi@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Date: Thu, 13 Jun 2024 15:47:47 -0700
Message-Id: <20240613224747.545908-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612060743.GE2645@thinkpad>
References: <20240612060743.GE2645@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Manivannan,

>> Before this change, the dwc PCIe driver configures only 1 ATU region,
>> which is sufficient for the devices with PCIe memory <= 4GB. However,
>> the driver probe fails when device uses more than 4GB of pcie memory.
>> 
> Something is not clear... This commit message implies that the driver used to
> work on your hardware (you haven't mentioned which one it is) and broken by the
> commit from Sergey.

sorry for any confusion, the driver use to work in v5.10 kernel, with v6.0 kernel it
fails to probe with following messages:
layerscape-pcie xx00000.pcie: Failed to set MEM range ...
layerscape-pcie: probe of xx00000.pcie failed with error -22

By tracing code, I found that the probe was failing on [1] this check,
which was added in [2] upstream commit from Serge and finally, the ATU upper bound limit was
set to 4G in [3] commit

pci driver probe succeeds either when
         1) I remove [1] check
         2) or by setting the ATU limit to the size of Mem64 range (my original patch [4])

> As per Sergey's commit, we auto detect the dw_pcie::region_limit. If the IP is <
> 4.60, then the limit is 4G, otherwise depends on CX_ATU_MAX_REGION_SIZE set in
> hw.

I couldn't find any reference of CX_ATU_MAX_REGION_SIZE in my PCIe TRM, perhaps because it
is older than v4.60

> So if your IP is < 4.60, you cannot map > 4GB of outbound memory anyway. But if
> it is > 4.60, you shouldn't see the failure that you reported for > 4G space
> (well you can see the failure if the limit is less than the region size). In the
> previous thread you mentioned that dw_pcie::region_limit is set to 4G. So how
> come your driver was working previously?

The PCIe IP is from Synopsys and is older than 4.60, the board is from Freescale LX2
family. The board uses drivers/pci/controller/dwc/pci-layerscape.c driver
Given PCIe IP is older than 4.60, I am not sure why it was working earlier for a memory range larger than 4G
Highly appreciate your guidance and help on this.

Best regards,
Shyam

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware.c?h=v6.10-rc3#n480
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/controller/dwc?h=v6.10-rc3&id=edf408b946d37cc70fbf0db6ab85bbf67dae1894
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/controller/dwc?h=v6.10-rc3&id=89473aa9ab261948ed13b16effe841a675efed77
[4] https://lore.kernel.org/linux-pci/20240523001046.1413579-1-shyamsaini@linux.microsoft.com/





