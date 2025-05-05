Return-Path: <linux-pci+bounces-27205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B3AAA306
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3BC3A5C14
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C02820BB;
	Mon,  5 May 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeSEtR51"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E42820AA;
	Mon,  5 May 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483778; cv=none; b=rwxif/SehyrDbuIoeA0Xo1to7flLtBAagAK91cs8173JRm9XjBUJN4EneNzeuouQVPUyHAb7S+VemCxadgSpdDMW2RCPOXwguMFsPKP+Q+1S2+sLbcIxztVFVyEzmvOTtrHbmtj7Npyhnbx4ny8YDfZvrkZ3F2tPzjOvBQ6TO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483778; c=relaxed/simple;
	bh=MxQF19+oKD8EyuR5LWtAXyY63Cq3zJVXy7arri/hE2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEMia0zj4rHOeLiAKXJt9YISUDwVTu6pFsIA5deRrSf9d+bTc1DlanwNbqdPLAUYqeQLVfOosPtVMSPDbdlf8AoINJ1/uo7sd5+6w/qJoC44RreGKp42+2Z4XKjNdB8EXF+xIC8pikdT2ZInaoGRJ6REPfvAQaQAl4XRSy3a4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeSEtR51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CB4C4CEE4;
	Mon,  5 May 2025 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483778;
	bh=MxQF19+oKD8EyuR5LWtAXyY63Cq3zJVXy7arri/hE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeSEtR51upf1kf/UAEI1sSsPDHgXUVd13/kW0+c3vrIbIuqi/UbHo15UUdJDIKYp8
	 HskUrJbbc5P3do5lpNO41hjK7DJP4Jq4greisu7vcyHrVj7fH+H9byHn35MN55haaL
	 w5fGiNx11TeIdwetkimkKEIyYjUjfiCzGLfi3Rl4LzxrdpCtuk738WwJf66DVXGfs2
	 gmoawrVi/b1s/CouTJLkzjeH4u929DJjgZcJLjXDrrufm+Q57Hqk5/Dxc//Mx0RN1B
	 LCdYrpN0vfvis+vYzEdYMGfsyPPMeCrHG6oZ/U0FjV8Si1dEtGQBxyF8TH/zSSU/2Z
	 X7eTf8qvqnc6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 214/642] misc: pci_endpoint_test: Give disabled BARs a distinct error code
Date: Mon,  5 May 2025 18:07:10 -0400
Message-Id: <20250505221419.2672473-214-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 7e80bbef1d697dbce7a39cfad0df770880fe3f29 ]

The current code returns -ENOMEM if test->bar[barno] is NULL.

There can be two reasons why test->bar[barno] is NULL:

  1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
  2) The BAR was skipped, because it is disabled by the endpoint.

Many PCI endpoint controller drivers will disable all BARs in their
init function. A disabled BAR will have a size of 0.

A PCI endpoint function driver will be able to enable any BAR that
is not marked as BAR_RESERVED (which means that the BAR should not
be touched by the EPF driver).

Thus, perform check if the size is 0, before checking if
test->bar[barno] is NULL, such that we can return different errors.

This will allow the selftests to return SKIP instead of FAIL for
disabled BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250123120147.3603409-3-cassel@kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 4c0f37ad0281b..8a7e860c06812 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -295,11 +295,13 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 	int buf_size;
 
+	bar_size = pci_resource_len(pdev, barno);
+	if (!bar_size)
+		return -ENODATA;
+
 	if (!test->bar[barno])
 		return -ENOMEM;
 
-	bar_size = pci_resource_len(pdev, barno);
-
 	if (barno == test->test_reg_bar)
 		bar_size = 0x4;
 
-- 
2.39.5


