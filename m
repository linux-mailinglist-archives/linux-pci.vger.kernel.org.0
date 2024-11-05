Return-Path: <linux-pci+bounces-16023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F859BC27A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BCB1F22D5A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018218C0C;
	Tue,  5 Nov 2024 01:21:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594FF1CD0C;
	Tue,  5 Nov 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769717; cv=none; b=c9zd/z1YZ2FkN6DG6YGpkvF3Kf+EnxZaZFty84rloF8WG4aWn01BcX1QQWjTY9AALbScux6Ka3CzlguxJumDBZQJvBx67l4bhb7upBfQauTs576ArPRXfKil71p0WHSyFN6zIL7DareNYALPPS/QwQFTEl1iWbspABfRMKceQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769717; c=relaxed/simple;
	bh=m4P+22+nO9PBEAe40Gxpg7dJly3rkV+NgsNx3fvNAl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWI4vNdqVXEtmHyidFcs1NrKKPaY3ctd4UEX2DfOewHgs1y36hBm/HrgfnI893aQaKgbYXZ+tH8P56cjhqchZp/A1iFg/vf2jvqoO0RcHCBzS+SqonudsZHE40NH9o8zfn+yMc0FxEsVQH8sYeD5dS5HrpTLBiAg5PAPTWMCUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.a0pHNot_1730769701 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 09:21:42 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: rafael@kernel.org
Cc: bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: Re: Re: [PATCH] PRESERVE_BOOT_CONFIG function rev id doesn't match with spec.
Date: Tue,  5 Nov 2024 01:21:40 +0000
Message-Id: <20241105012140.202281-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJZ5v0gQ6Y5d5uieaM0FwnKO9yrRKpwZp=YsX5Qn7_4W5_+-eA@mail.gmail.com>
References: <CAJZ5v0gQ6Y5d5uieaM0FwnKO9yrRKpwZp=YsX5Qn7_4W5_+-eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >
> > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> > the code is 1.
> >
> > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
>
> I think there should be a Fixes tag?

I found this bug while reviewing the UEFI firmware code. I haven't 
submitted this bug to Bugzilla, and I couldn't find it in Bugzilla either.
So there is no fixes tag.

Do you mean I should submit the bug to Bugzilla first?

I am a newcomer, thank you for your patience.

