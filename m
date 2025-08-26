Return-Path: <linux-pci+bounces-34747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA1B35E50
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC7366ACD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C38202F7B;
	Tue, 26 Aug 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQqgtlZX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14B393DD1;
	Tue, 26 Aug 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208574; cv=none; b=OCOiU5gPn8SXKdu179oOlqqhdFFSL9yfSA+8EmtMpk+8Qlfem231KCrLpOTvX0l+lq/+X9pOGE/o9icYSnOIJQU+1ZwBSooD/2zStE7UzEt2bleVOQIiL1vz32IBNhyyG+s7vrkT7RVmvgEJBf8z4nYvZbaPPivNCaqXIpQ79PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208574; c=relaxed/simple;
	bh=Xx84B80yl9s5MKdpn1AdlJtJZU7aFzllXR3eTO3zx00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkVFD6dft/50ROga9T+8BMdYrfYfiMdugUeOrRfVDT8y1fX3W1pTcvRjdJDQIe5snH5ldTwQzHrWQrpK6fEfi6tea/EQTKx0gHBtjnFMnrrrhgNr8vNsB4cxgKt8pVi+1zgXJaS6r1KdFsEjflJ1yH1fIx10HWOSAeNY2pXJys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQqgtlZX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266cdf64so4046569a91.0;
        Tue, 26 Aug 2025 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756208572; x=1756813372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BX+2HoJ02Ew7shzFz7rI9qYusnmHKSjjBetjjXJ4TQ=;
        b=ZQqgtlZXdQN7mft4MOKk/QqxYZv9NW3sxXHcT9LTULXiBleTntsJ4RAXggVE0MLviY
         uDG9ZmCn9XtldWB1fUchq8sJalfN0hYEGheta90wF1fOPNZiBLYlTBex6HbHJPWhIiFg
         Y32Mxmoj+DTieqw5mcsOusX22nUOrwAFgs0F4hdRreEWnB27bgZR2T3tCd2+yUAOP4ec
         eGQdHz99Cl4H0vLnZaye29Ykt0vNmWX6ePKteRnXn3qVJbjo8S3gjGanSBhF7ANL63mw
         62AT6h9rXILzcl/rjbCb3rpSn9K26S9FT1mGAV6PJtcTLEZXJ2699bXpe+3fWK5SJN5h
         N4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756208572; x=1756813372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BX+2HoJ02Ew7shzFz7rI9qYusnmHKSjjBetjjXJ4TQ=;
        b=QjZij3l97wp8W88PX0jxJ7eJnrata5FjR5L0N1VfHcmpF19vEZa+Yj3zJ8DGKVEDO2
         nEJfvVhbw23BK0zQPIO5rOplvxWMHunNza3dUy12kwEKJn3nNzz9JdMhktm+6lDZwVGD
         bjS+XG+pbKuKQQL6Fc9GqCNfnzm+T2hnX8B1hEibceVGyjrCPJlyYyp8dNti0UABPG6s
         +aWWXr5rZxCa2bNrW3Up555MsUt3CYy5TfxpAfk5orNLNa6oTq3cPLfi49t3o8IqG9T0
         f23Z4XvcO4c1Hd/9Ii/bHK+hfT5NaLu0DovVJ8Evd4hb8lXcNeLEugPZMCeIrVCUkKmC
         6ytw==
X-Forwarded-Encrypted: i=1; AJvYcCUzvRcPTgXgiycR9EtuaFgvZed5FpAVhCdqaPFgtw4OvFek79RHB/AqJWtVtX78CLutLR3USB4dXCy+ELY=@vger.kernel.org, AJvYcCVpQ00R0O1PMXXVyc657nyjYitwl3dGRxFZI4/O7D+i4gGXXqE4qk9ER9NU28AWf66PGKsBEzWu8sr9@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAxW5fecc53sNmpaHG8Crul1Du7WDvKOAtHyDuCxA7EZdOZ0C
	5aioEytMUBHDOKJPoT7P6JzJZSJQu4onIGiWR+jlmlGebT7njuZZs8QO
X-Gm-Gg: ASbGncs7rrnraGkT7sKQSiYRBoHK37jH8RQsN4X3JJQBgkWFzhfYAkgldgEjwP2IqOM
	K/jLHzFqMQjtQDR7ZUvlAtWK7JOqdMwiC51r1bWnhoNst75TdpXqoVF7NOXzb+sk4TsNMncc+xn
	06ear7Csh6NBdOkZoVL9yevEfS9nly5CVZN3jlBit0XU/PfeFWxcBUnHZK1pe1K51D1cgYHkavs
	ru0sHTcHk3d1KDDRfCyl6JQ6rmXiaVRCDubUNdCHlqfdPDRCxPh1cVYtoYJ6JRn1fpclA1aHdrK
	V22ITjQ592rduFGm3yqKs+raHyHxV4Z8trbc914woBhQwu4D5mpfPoSORzpIo0L7oGnQOJ63sXg
	vgxFX8iSVcEZ9LOQpd3bn
X-Google-Smtp-Source: AGHT+IEoKSb9vq/au9mQMY9sjtndAQJuIeZfvPvHmHR0n06Qu+1C+X1Uvs4o72iXCNZATQYyNF9NUA==
X-Received: by 2002:a17:90b:5292:b0:325:7fc5:fd82 with SMTP id 98e67ed59e1d1-3257fc5fecdmr11625183a91.24.1756208572216;
        Tue, 26 Aug 2025 04:42:52 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm5612958a12.35.2025.08.26.04.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:42:51 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR HISILICON STB),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 0/2] HiSilicon STB PCIe host use bulk API for clock
Date: Tue, 26 Aug 2025 17:12:39 +0530
Message-ID: <20250826114245.112472-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code using the clk_bulk*() and reset_control_bulk() APIs

Thanks
-Anand

Anand Moon (2):
  PCI: dwc: histb: Simplify clock handling by using clk_bulk*()
    functions
  PCI: dwc: histb: Simplify reset control handling by using
    reset_control_bulk*() function

 drivers/pci/controller/dwc/pcie-histb.c | 119 +++++++-----------------
 1 file changed, 35 insertions(+), 84 deletions(-)


base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
-- 
2.50.1


