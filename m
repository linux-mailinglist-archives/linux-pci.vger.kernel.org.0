Return-Path: <linux-pci+bounces-8677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC7905A4B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A979E284225
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2731822DA;
	Wed, 12 Jun 2024 18:00:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6B1822D5;
	Wed, 12 Jun 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215249; cv=none; b=KPzltNC6ykSgYW90u0Kou79EvmP0rLcSSfl/mx1qqVY8llDNALznKipbwIIoR8e+Oe7v79+oV5SwlRumZUCmYXNUqlHyZoZaDVwz1FMfZPl+En01TLgzGmmnZQWooWmW9mUOm0QADQOHpyxjdx1AxIeWlFkDvmR0JCiIsul+p+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215249; c=relaxed/simple;
	bh=hHaYPQX8j+dGFk9XQCp/V49UGNtgT74NHbQ1ciMXc84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moV0z4mw501wdfm1+A8/h6+sPqK5stUGLE+syW3WpysKDLZmbXAaRzMmmRkcHw3eTQs+/HB9tLLBqSB5zsAAdzZjZxkT2mbpaVKdCNus6Qo5+YlCkp3A1AzywqnFyeLb8fJXHhQ8K0KaRXj1zt9VQ+SSCOuyQvIeD8qOHeGS4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9CDC116B1;
	Wed, 12 Jun 2024 18:00:49 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 0/2] cxl: Region bandwidth calculation for targets with shared upstream link
Date: Wed, 12 Jun 2024 10:59:47 -0700
Message-ID: <20240612180046.1810907-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- Address multiple RPs under a HB. (Jonathan)
- See patches for specific change log

This series provides recalculation of the CXL region bandwidth when the targets have
shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
as the code trasverses up the tree. An example topology:

 An example topology from Jonathan:

                 CFMWS 0
                   |
          _________|_________
         |                   |
     ACPI0017-0            ACPI0017-1
   GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
     |          |        |           |
    RP0        RP1      RP2         RP3
     |          |        |           |
   SW 0       SW 1     SW 2        SW 3
   |   |      |   |    |   |       |   |
  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

 Computation for the example topology:

 Min (GP0 to CPU BW / total RPs * active RPs,
      Min(SW 0 Upstream Link to RP0 BW,
          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
      Min(SW 1 Upstream Link to RP1 BW,
          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
 Min (GP1 to CPU BW / total RPs * active RPs,
      Min(SW 2 Upstream Link to RP2 BW,
          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
      Min(SW 3 Upstream Link to RP3 BW,
          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))


