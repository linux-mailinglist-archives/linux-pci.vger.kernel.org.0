Return-Path: <linux-pci+bounces-27795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC9AB86C8
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AAB4E52AF
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583B29B798;
	Thu, 15 May 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1huVWN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AF29B795;
	Thu, 15 May 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313197; cv=none; b=nuOw1a4WmVudqi4x491NU8ggn9d00lbbfThkChsDN33Tmu5D4kNcpJ7dKAFYkxTGZfAmwkpI/rxqrAy5NTfA/U7Bz+8DZefb7e1/a3Ji3t32ftTp/SZURuSPimO539xW8bSWl6oMN98LF0Hqnb06vq/HsI1pnr58xQenfyWtvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313197; c=relaxed/simple;
	bh=++n7ZlSGf2Ln4jHZubVYkAdCztDuA+SrzPB+ibCF00Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra9B0Ud0w4OFYfzEKsexO+aFNmtDCgKV0E/47Nl/mOAWvqpjK0ZXzcyG1cKTFURSjRrDrWbxqCSa0Dd5guUdpJStBd4p+rMMt5BedW0wbR8f9/EMEOXMMpCpN2PZUO4Jd65CSmlvMKtWDNUA7u/Gi4ITW9XMWOHtaRV7bjGpXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1huVWN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E43CC4CEF1;
	Thu, 15 May 2025 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313197;
	bh=++n7ZlSGf2Ln4jHZubVYkAdCztDuA+SrzPB+ibCF00Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1huVWN4L/rX+E9YZFljZQMVup6V7nV7jUO+pErfAgSvUONAT09V23Pp2MfAwG9Qi
	 rZnhw/f9H8X0EA4uO8PevVxLbVQCH9ZVqj4exItAKSBquQjTfhDXaawLahNyo9BuOu
	 GYfs3jjSM9IKtDsg+dkl/FlShdjoQrZ468N6k5TdQuLZ6haNV08A/X364jbouLl13c
	 O8IfGygEaEzqoBzfL1T+owlDIMV2auBuQGXEgRI/+MQ6CcFzOjl57mDVQxn3t7M0tK
	 mfIOxLemKmJ3MwDWCnTBrCrahJkV1KED5+kr+xN46sWU2TEbuiU/C9DzLNVidC3mYL
	 o7GzcomyWYYYA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/7] PCI: Remove unnecessary prototype from pci.h
Date: Thu, 15 May 2025 14:46:04 +0200
Message-ID: <20250515124604.184313-8-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515124604.184313-2-phasta@kernel.org>
References: <20250515124604.184313-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_intx() once was an internal PCI function, but since then has been
published and is used by drivers, and, therefore, available in
include/linux/pci.h. The function is not used within PCI anymore.

Remove pcim_intx()'s prototype from drivers/pci/pci.h

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cfc9e71a4d84..2dd7fa93d95b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1059,8 +1059,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-int pcim_intx(struct pci_dev *dev, int enable);
-
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
-- 
2.49.0


