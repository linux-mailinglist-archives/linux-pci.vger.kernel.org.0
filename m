Return-Path: <linux-pci+bounces-28880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2CACCBA9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815F33A7355
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5C1D54EE;
	Tue,  3 Jun 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2b7cSReR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC32155C82
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970247; cv=none; b=E+NAvCeJ3875SdUQkXiZrsqvRNsMw/EsMEKIR7G2zB6ak6nP1o8RZmb1aABwBVWnM6bdF+E9iCVm0906MOpGcZOIGCaQS9dqPoZ0DwCniWakq6745N5PJJt2jvq4FtmeIQoDAAuTVI9KU1SCgj+/v0rfdHvXW0j5ZNmT1UPVDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970247; c=relaxed/simple;
	bh=4r+5Eof096MZjRh8tpVi37f6nJMhY0833cfm9C9HdL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZlWgj+bJKNEdx+WMX+kFJGqLka8O+etEdVt8aBQGvWqQdgGUHdmr3xQBu7NyyJOuvR/hGZDVTks0FcQaNA3fiVjU/+UGsyg0htyU+hvgfaQW1fx2Lkh32Z2j0DdVc28VMHRg0grbtqLa6k3wj9QyodBqRTeqW+1H/khhoq6zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2b7cSReR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so63232f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748970244; x=1749575044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9KctMIkbgxYBp8QVwwNbz+2eDOalPhBXgUZIQWSTmo=;
        b=2b7cSReRtXT0uSW84ykQaUZH0gPMRasYIx6cwaadLeBmyvLv96BHM9K8FYF/OD+S9U
         DMzzJcQ8yeBC+7xuWyvaoRQSCdBNOt0CI9wdPiisC+k1MiNnSD1BL44DM3nvsSkLBogA
         8CZk2QB7IgorONpNGZSCwarJlaSpV2e/b0WzTvSktUYTzyuU0OZXFlydTgHKtqqMrOTi
         WlpgAcACamRdhk2P2iKgaXVL+asi14KQMrPXiWj+D9uNC4moIj1G/Mjzx2HPhRgpxcMl
         kP+5N3ObyOLvvfR+2mo5QSJn3SV0wGV5WtFbvTnvj5ve+Dn1xvYD6kZVhUp/g/dG885v
         7TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970244; x=1749575044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9KctMIkbgxYBp8QVwwNbz+2eDOalPhBXgUZIQWSTmo=;
        b=eVsqrCVMM2wmKuAzm9kzachV5QwqZ9TWK5SrAUxYujiEqfeJZDIO/Il8hbI3aDlvz1
         tRI5BCLAJMs8QH/7aT3STcRglTFy2wr8afsr2Ut81mCmQY6PDLpQLj0uPVxOUi1RztaJ
         r/gyd4SLqCWPObK3YLoqeEN/Az/7ZX2mREzlwVZjtZ/e9iU9xFZ8NaL/ezodrvO/ta/d
         lp889QiQ1eX1a+gvJ1W3NyCLjdR9DBSrbA1h8F6qB//Z/ZdL564kwD4ogiqnvjYNfV1X
         ICUFMXaJvXHyqvh+/lfCmlVNqrRFVUqBwn/MsX4Pgt26H+o1gl6b/U35LZeVoYNh77HN
         dcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGWHNFqVFxBv+eYs5c+p8zspneT3neXLAqvqOK1q3RtL65IZEA9dT0nPeapORpZzv1naZWShLkkAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvyENBTxbN61p1uNKTKBmpu2nAVzXKCn8JmPFBMqo3+0SzhXD
	pE2HJW0+sG62/D6nO9K9QTylA5EWEp2s2ePF0yzLcewju53s101uPNbRf2hU/UrH3A0=
X-Gm-Gg: ASbGncvjty9y+u0spcjwk7EfH24/b+kAqWT6xXC358q/twrhABECaLhze1gc07ERQYC
	vzbVbF7PJ5OgyNaR8waTHY1/Y8V4XF6OT8kkl8nZFaJgCPCXejUWu7WWeVztD0zK7Wkpt5+zFLv
	CqAKb7aoroo/mzDsVJttFxF8VMSjKWfr6Nx8CJxV7qgVFNkfsQQVPcHsx9ipKhvwW1TOCJrtkM8
	mAo/DYBsUWAMEzOjg9U0RpP6+f8ZLKxwjYoUDAxRtxzqhVeXYP2VlNvgLV3XNg3MpTsYy81bTg9
	9VWrjrzv2bAa3+L/GrTg9/g1u3XxVpR8oHYHU48mnEnbQrAJM3jEB3os/eHe2DIKDw==
X-Google-Smtp-Source: AGHT+IFQ4mga6ZpQOnpfxIJQb2eWoiJqInQW3qkdZiZ9oqXdEFGYy8VI+GYDFKLpm2n+vIAxaELDzA==
X-Received: by 2002:a05:6000:144d:b0:3a3:7ba5:9a68 with SMTP id ffacd0b85a97d-3a5144f8154mr3094893f8f.18.1748970243645;
        Tue, 03 Jun 2025 10:04:03 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ce70:8503:aea6:a8ed])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm19165796f8f.69.2025.06.03.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 10:04:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 03 Jun 2025 19:03:38 +0200
Subject: [PATCH v2 1/3] PCI: endpoint: pci-epf-vntb: Return an error code
 on bar init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-pci-vntb-bar-mapping-v2-1-fc685a22ad28@baylibre.com>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=4r+5Eof096MZjRh8tpVi37f6nJMhY0833cfm9C9HdL0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoPyr/rF0NiI9WeluJ+asQYI6+4kWmycSeT3GUm
 2/aDNg8qiOJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaD8q/wAKCRDm/A8cN/La
 hSLjD/0Q4FwOh6ppUJJ2M+N/1SOee8kK5qxOadTEqWDaaMGNH51khNK0PPAiZMyEIsQQf855Js6
 EuEJcd77GsM3Ntm+F6UMQk9NQ+ZtPhwaGt7tRQ9jma5HTNRv/WHRy6m8qMCbH3nm5eKMRb3a0vL
 hP16eJ+EK2drKPfoOMWTQVyXTFHSasvW3MKH13GyM8yihB9CNcksyNl6+5yIbLPItRA/E+Gf9hP
 0zP/Wkrga6nAorbLUksBosPRVzCM/BSY/CV2dF1gosh2sBxgjwJFrPWisfTmssTMzi803WllYPs
 QnYTl2uullBc1Wucl+zMWEbEDDDYDTobNuHfv37GE94RlHVwumK2kMOSTC6AWJzDZYjUzIwedNY
 ZLnu/atJWd0ffYXGJ2brfXoA2vrvv8b/83LwneArAiKAmrL85Fl+GLsOjxXYXa4IhQN/Hfhp/kv
 VrFLsB7gG2U3eR2DT3JKdNXYiItVLS2OuaYoMGuLw+zKR/t0FeyVTHd0tz67ff0Yt+YQHmuAn1l
 gZoAq4N8RGeueybFK86+IV/eQAWyKEf6syYLlxYrC7lBHofKVa2cLQoktWlVt/gfFpsK88Nn4aY
 NfHplfXZuoXkq48afjQsQzdkE+460W8PcYU/B/afMGCI4qnd4GSGyKMu0wyXC1o+v39S26yeuTh
 wjDsFm/5vzqCmPA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

According the function documentation of epf_ntb_init_epc_bar(),
the function should return an error code on error. However, it
returns -1 when no BAR is available.

Return -EINVAL instead.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e4da3fdb000723e3adad01f0ddf230ecc0e572a7..35fa0a21fc91100a5539bff775e7ebc25e1fb9c1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -680,7 +680,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -EINVAL;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}

-- 
2.47.2


