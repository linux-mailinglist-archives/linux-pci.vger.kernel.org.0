Return-Path: <linux-pci+bounces-38578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530CBECD87
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8480D1A605AC
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D952271454;
	Sat, 18 Oct 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="D16bC5fT"
X-Original-To: linux-pci@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86C19006B
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760783942; cv=none; b=huxXHFbkolA8Pby4taCdTwwVg8WmHW40v6C0lWmFVx5gEw71cP7STo0VnIVn82wYxEolAym1H/CbzMe1vP6C/2UX5Rw5dqR2E9GnTrqo27ff8BsMRStkkNDF4OpJ5qoX2b2wZ5hBAYjdERNllfindTaIyHQCOkhjiL2n1ofQ7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760783942; c=relaxed/simple;
	bh=eQhGnnyneKp3f20ag+2affhDZfNWqDuILCM0sASI9L0=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=SK4Fi/N/OvrxIOD7Qf4d0bLbANdCQ5awSrRtlbSsJEK22COfR7bYiVVy0DqLiieVh1HtjJfHcvdS3F7JLi4w+JN4Y4y6HWbnEnGJbDYge8mPV8LGOpk1BOuuwCAzLk/EXlcpngJzGycpo+Bw2JXUMU+q7LfvY/QyKSruakxVWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=D16bC5fT; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr9.hinet.net ([10.199.216.88])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 59IAcwBb162140
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 18:38:58 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1760783938; bh=XBDkIftLWaggqyGUNmS4hRAQ+WY=;
	h=From:To:Subject:Date;
	b=D16bC5fTa8ggYuODGDfkMoKc83xbWQ4eWi1/AwkqtqUBjVEEefoudbw7ol/Hl1t2D
	 9JsI0WTCpTmbPddJU4MS9BLongto6yWUHJD1TpccVrUnsBprnXYw13axXImG0NTLbb
	 SOmU2q5o7TQeRR+7rgfOqa/TOMHjB8H0uOM3sSQ8=
Received: from [127.0.0.1] (220-143-207-99.dynamic-ip.hinet.net [220.143.207.99])
	by cmsr9.hinet.net (8.15.2/8.15.2) with ESMTPS id 59IAXMhE340996
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 18:33:51 +0800
From: "Sales - iGTI 053" <Linux-pci@ms29.hinet.net>
To: linux-pci@vger.kernel.org
Reply-To: "Sales - iGTI." <sales@igti.space>
Subject: =?UTF-8?B?Rmlyc3QgT3JkZXIgQ29uZmlybWF0aW9uICYgTmV4dCBTdGVwcw==?=
Message-ID: <db36b22f-a48d-1046-81a5-7112fe568728@ms29.hinet.net>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Oct 2025 10:33:50 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=cYdxrWDM c=0 sm=1 tr=0 ts=68f36d10
	p=ggywIp0tIZrEgnU2bSAA:9 a=/R5G9olcge+GsD5ET2bp6w==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-pci,

I hope this message finds you well.

We are a diversified general trading company with multiple business streams=
 and affiliated sister companies. While our operations span various sectors=
, we currently have a strong focus on the resale of general machandise and =
services on several products to our partners and associates in the UAE and =
UK.

Having reviewed your website and product offerings, we are pleased to move =
forward with our first order. To proceed, we would like to align on the =
following key details:

-Minimum Order Quantity (MOQ)
-Delivery timelines
-Payment terms
-Potential for a long-term partnership

To facilitate this discussion and finalize next steps, we will be sharing a=
 Zoom meeting invitation shortly.

We look forward to your confirmation and the opportunity to build a =
mutually beneficial relationship.

Best regards,
Leo Viera
Purchasing Director
sales@igti.space
iGeneral Trading Co Ltd
igt.ae - igti.space

