Return-Path: <linux-pci+bounces-7101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04978BC4F2
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 02:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CDA2820E9
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 00:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E28C11;
	Mon,  6 May 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UOAB8NYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA48BFA;
	Mon,  6 May 2024 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956418; cv=none; b=SDgf00gLKIaeoFvvNVDfyYH8evdX2OivbMajpFnrDnFwspCvjU7HHz8YdlUqrJYiX7cR1hMgUM/TBZPxZciDU3p4vZzudEhUb/t+VzQu+q/k4WCijegjDMAwAV8d5SgYvq2CUkYcoqB8RSCqBqwsjGwo2fWjPtR27n2Xa+meyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956418; c=relaxed/simple;
	bh=MCWSf42J7Ydt7/06DV5oxor9m2vYQxvl2U5A48OU0b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raBj3Mjj7a0V0N9nXxtb3HqD4hJlY9eQ6rmTn0kad2egM8SFcGJQfdFsS/Uu6/Kn2AN5oOMQaVc+kCRsWxCcUzIZVJ2m2aPucVDZlWiL8MMZxZu8fuc/cIjSGKeKXgGdqs5wXWlCBxW+VXna/+fNGrNttzGh+YPWT1nsyNTw/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UOAB8NYu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=hbpmqPehKNeC5DN8fCY+LuqViDM4iLNJexDFtFPKmY8=; b=UOAB8NYu0lXONDkd
	oV9zpYk0rOSPw8lr3oFl9y7nli4Wg6ClBbyoVQ84Jv4SoHkF5ZHSmMdMKTcgwaSK7cFTDkUHCIvDe
	f8z/RSHeODkQsqndhdi26KjoLi3kNmuYwv7krKFsAxhsqrxa6xSmrNW/j0hnmlgbBb4DIsjDmx5V3
	F+KyGrWT9VpYXv6gmXuwNcVEjKsbX2bNy8YBuuIIyY+6OXdeoAUOsVYMjuplWhr079xGaxbDCPsZi
	m5dPRli51gLJHo8qX/Lhm2sehlRHLXJ2bTNxeAqwXbeawc+0Dum7zv4yVq2URbMJJ1o5K3+KN42PY
	y79elB7uFP1b3vnerg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3mVG-004piy-36;
	Mon, 06 May 2024 00:46:50 +0000
From: linux@treblig.org
To: bhelgaas@google.com,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] x86: ce4100: Remove unused struct 'sim_reg_op'
Date: Mon,  6 May 2024 01:46:47 +0100
Message-ID: <20240506004647.770666-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This doesn't look like it was ever used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/pci/ce4100.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 87313701f069e..f5dbd25651e0f 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -35,12 +35,6 @@ struct sim_dev_reg {
 	struct sim_reg sim_reg;
 };
 
-struct sim_reg_op {
-	void (*init)(struct sim_dev_reg *reg);
-	void (*read)(struct sim_dev_reg *reg, u32 value);
-	void (*write)(struct sim_dev_reg *reg, u32 value);
-};
-
 #define MB (1024 * 1024)
 #define KB (1024)
 #define SIZE_TO_MASK(size) (~(size - 1))
-- 
2.45.0


