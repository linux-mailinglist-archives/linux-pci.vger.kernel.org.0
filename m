Return-Path: <linux-pci+bounces-44775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F04D20345
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F963031A38
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA43A35A5;
	Wed, 14 Jan 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Bv9T+83U"
X-Original-To: linux-pci@vger.kernel.org
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783263A35A0;
	Wed, 14 Jan 2026 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408069; cv=none; b=YfsWVOnH4YHQIvoTZ/3pkNGi4HGrefHhY14OS99MnxwCX7kxfJ2vbGtu5V/z71fhmA9z2ryMlCh52XO5ClRSeGiNi6H+PdDaUep3rqtE+NRFgdWT2nhQ82rBoVpFHELx1f+mjrBik5Yf1H4r/9ECgCEfc7pJS/HMVL3oaL6E2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408069; c=relaxed/simple;
	bh=yGxxcUAe03wzjv8Lc6QUTXh3NaMfsLWn2i9o7hTdmQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+szsT1tqfogt1c6wrazG2o1GVL2o3V6dJi+hLrKKCJ/wnkHMQqxt1xadAVwQwvHIZnIpVa/i31y3mgJGY6wVkq4+lBaUdd4r6Ud30Hb8E33Nd5HfeEKtt4BBHmRDqk3jlSrZ3t8Ybh45xDY7vTDUE4HS6uIIxdvE/HZjkvdolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Bv9T+83U; arc=none smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=29; q=dns/txt; s=iport01;
  t=1768408067; x=1769617667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGxxcUAe03wzjv8Lc6QUTXh3NaMfsLWn2i9o7hTdmQY=;
  b=Bv9T+83UrR5bGIbBe/N9Nzzi/bHqN/5dCsbUYkZ/fAZUYXPMbGcNihI1
   F4PMvK+vraKn0XpUpBC6V9eGr3BijAACFk7DIkDUueowJ/hExYOS80e82
   IKz2MNajwXRynplUwqFOmkEm6dUx7P9BrreAF+vLOJdt56UuLRqJIgggE
   2WGXTREH8X+XzMlVgZhXdROLcXcoU8SsrzRCSc0jJf1K8emqmApGLuaKt
   UtLuw/y54YX0PiBAiHEE2b+QF/RE3bsF54l1jCObguh+ltkRbRrvNECiG
   EikJlpdeCGpZzwjPoc8MXnaLXSEYsdhE1w46Ud846F/MlhRVHmic8l7Fy
   A==;
X-CSE-ConnectionGUID: GEKbaa49Qm68bsGhduhW0Q==
X-CSE-MsgGUID: zvir+eFJQGayFPNlKG9pGQ==
X-IPAS-Result: =?us-ascii?q?A0BHBQAQw2dp/89K/pBahSGBX0K3HBQPAQEBD1EEAQGFB?=
 =?us-ascii?q?wKMbQImOBMBAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zch?=
 =?us-ascii?q?lsCAQMyAUYQUVYHCoMKgnQDrFqCLIEBhHzZQYFvFYE4jVKFaScVBn2BEIR9h?=
 =?us-ascii?q?RCFdwSCIoEOlBpIgR4DWSwBVRMNCgsHBYFmAyoLEhIYFW4yHYEjPheBChsHB?=
 =?us-ascii?q?YFZBoh9D4k/ej0DCxgNSBEsNxQbBD5uB7troRGEJqFYGjODcQGmeAEuh1wvk?=
 =?us-ascii?q?E0ipDeEaIF/JYFZTSMVgyNRGQ/SJDtxAgcLAQEDCZNnAQE?=
IronPort-Data: A9a23:v4gtDqJh51cgdW5iFE+R0pQlxSXFcZb7ZxGr2PjKsXjdYENSgT1Um
 DEfWzjVM67fMDP1f9p3bIy+oxxV7ZKAnNVgGwsd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnU0
 T/Oi5eHYgH9gmcoajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1BIWI8NIREq99yXzFE7
 tMYJC0NUUi60rfeLLKTEoGAh+wqIdOuOMYUvWttiGmHS/0nWpvEBa7N4Le03h9p2pwIR6uCI
 ZVFL2A3M3wsYDUXUrsTIJsynfalgHb2WzZZs1mS46Ew5gA/ySQtiOG2bIWMILRmQ+1HgEeC5
 W/o3V3WCwA0DPqb6hXU6l2V07qncSTTHdh6+KeD3vRqjVmcz2UIIBIRUlS/rL+yjUvWc9dWL
 U08+Sc0q6U2skuxQbHVWxy+vW7BvRMGXddUO/M15RvLyafO5QudQG8eQVZpbN0gqd9zXTcr/
 kGGksmvBjF1trCRD3WH+d+pQSiaMCUPaGtHbigeQE5dvZ/ooZo4iVTESdML/LOJs+AZ0ArYm
 1iixBXSTZ1M5SLX/81XJWz6vg8=
IronPort-HdrOrdr: A9a23:ejE8PaG362qmd/WtpLqE7ceALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHOBOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSygck78
 ddm2wUMqyXMbC85vyKhzWFLw==
X-Talos-CUID: 9a23:CNg0QWH4tffUmqpvqmJI2W0eE8l5I0TYkifaOGC4BXtpd+WsHAo=
X-Talos-MUID: 9a23:yZHC0AmvNM4fugFHz6ordnpwKsZyoKmAKnkimIQog++AFgMhIxik2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,225,1763424000"; 
   d="scan'208";a="40134712"
Received: from aer-l-core-06.cisco.com ([144.254.74.207])
  by aer-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Jan 2026 16:26:21 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	by aer-l-core-06.cisco.com (Postfix) with ESMTP id B43D318000492;
	Wed, 14 Jan 2026 16:26:19 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Fix device reference leak in aer_inject()
Date: Wed, 14 Jan 2026 21:56:18 +0530
Message-Id: <20260114162618.28462-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260111163650.33168-1-adiyenga@cisco.com>
References: <20260111163650.33168-1-adiyenga@cisco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-06.cisco.com

Thanks Bjorn, Mani,
Aditya

