Return-Path: <linux-pci+bounces-8062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C51E8D406B
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C35284B00
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F91C9EAD;
	Wed, 29 May 2024 21:44:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC531C9EA7;
	Wed, 29 May 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019041; cv=none; b=dFjFoFcw6ctmDb7v2NIwJJ3gOPcirw0BlYr+MvQP62SWm5cWAoLAwCJDuoZwXDiM92QxJtw5NCvE9ZISObb313DbKOxismSG+/2VPl7phbSHPejr7l+q1NAOHukrRl+7L321oJiDleQvLxpTL166nvkOCcm52mc2+aozeBxi3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019041; c=relaxed/simple;
	bh=Seo2xr4OdPoW0MZrXwJuv4xC2zDOzgalqb/WA5jCekQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGYdrKMP6KTCiEFn07WVY2N/LQCAqg/7yujrQk+KrnQAUp/kjyNmL54Ga3rqkuzaVfgiz+hKo4aqjuqOicn0UDyunyouKb86ALaBHgkGPByUcXzxxFxQV7GF6oYc0PsC0Xg5Ny2Vk0QMSpEcn4Ylxk/SCmpx65cx0vG9KihXO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320F3C113CC;
	Wed, 29 May 2024 21:44:01 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v3 0/2] cxl: Region bandwidth calculation for targets with shared upstream link
Date: Wed, 29 May 2024 14:38:56 -0700
Message-ID: <20240529214357.1193417-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides recalculation of the CXL region bandwidth when the targets have
shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
as the code trasverses up the tree. An example topology:

 An example topology from Jonathan:

                 CFMWS 0
                   |
          _________|_________
         |                   |
   GP0/HB0/ACPI0017-0  GP1/HB1/ACPI0017-1
     |          |        |           |
    RP0        RP1      RP2         RP3
     |          |        |           |
   SW 0       SW 1     SW 2        SW 3
   |   |      |   |    |   |       |   |
  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

 Computation for the example topology:

 Min (GP0 to CPU BW,
      Min(SW 0 Upstream Link to RP0 BW,
          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
      Min(SW 1 Upstream Link to RP1 BW,
          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
 Min (GP1 to CPU BW,
      Min(SW 2 Upstream Link to RP2 BW,
          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
      Min(SW 3 Upstream Link to RP3 BW,
          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))


