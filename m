Return-Path: <linux-pci+bounces-13511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E663798577C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62CB285BAF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4978B50;
	Wed, 25 Sep 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQmjGs6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D23335A5
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262083; cv=none; b=Rz/k6mjWkz1uzBBcn0Ba6Xy77eWkZ/MvZ+4YysSHyLt67KlvgwwVJBUpUQHBh8jIPxSwm+1UOA+ED3k/IXou2ZEWyA2DdUzPxajr8lazdstEe+WLSwFuEduZYWQ0tR43QiPe7ymNSOa59aDgfSOJQ2Xc+cIJbtD1C16Ah3ooZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262083; c=relaxed/simple;
	bh=E14547+Z5pM+4hyJJ9CX2ijEIt8G13j2nVrnOZDkQ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ee+1j3YFdxCvWM8B+Oivj8XV9mARcgizLJ8cfrDKXclwzrk6VdFB1POaath6A5PooUV0prT3obbMRwxXlSXxW2SPHPEXRRkoWQJsSVDG0K6KJ+FnRBlZu4hv0cltI3xv+Alox+ouLLYUKt9f4rO1G1wfYB7xAXqvvi4wzpfjP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQmjGs6D; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so29592005ab.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262081; x=1727866881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+wU+nQmthczOLIKmqdKHiC6ejraUTpzi9Y1GrEh5og=;
        b=IQmjGs6DEFD7dwSjPKZKG0+YT6g9uB2CNDfxbS4J8sVj7iWjzPvdtJEv9zC09DqaV+
         DJuhOF/rLg6vBAgzWRrYuJGmYF9xZwfApS4r03WIe3kIFwn2KDQ0aPScVJpHjHRUZ1fp
         EoeuRbmVIeZCMKb6c8t4QEaRMMLC937KxAzWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262081; x=1727866881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+wU+nQmthczOLIKmqdKHiC6ejraUTpzi9Y1GrEh5og=;
        b=YVEf0GAQxEUyu1rGfpgBbMQs2ihL5R8C0LpCHRhcsqa0Aq+Vh+GQNH94X5KEouT7nW
         q7xuDtW7JUQBO55xxfqiBwMTFNFHHHkwgascVyxMbh4mmHCF6MMm5cOZE/QX5y+6Imva
         xxqfq9KJksFEJjrMthvwf03m/JQ0EL7evO9lgRa8GSRdn9aNHOnCd40TjVi2WsCOhNOx
         s3bJzr53eDfpSUXT2iLTUaMGN+7urkolS1FzbYLX56sXiht2z+3g+FjTcddvo609MLE7
         LlShuinNz2bSUDtQBxwvYqMsWFzI6dFfDdhrEOzbWomjcSOq44rHfdPrf+DY7sFcIaYL
         A9HA==
X-Forwarded-Encrypted: i=1; AJvYcCWRplrfQf46IvT7PwSNFLOJyZe7j5akQ93dTQHGbFhoHRx5g6jmjQMu65OgFgH+twhG5LA+LcX04Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgQmn5ujxzyaf4jQUayJeyWLjgqt5k9kbtKqyN5G/ccUzX6yd
	umxjyCqqjx0Kyz47hEiY3866v35wPwKfB+9y/i6OuMzdIk51FVRmFypAJF+Hkw==
X-Google-Smtp-Source: AGHT+IGjqwv6hyYB9WgLlo4cxUlTkRTFUHeo+Nb8obSIHI0syyubDfaR8EBimZS1brkQVkQGQfPnaQ==
X-Received: by 2002:a05:6e02:1566:b0:3a1:a179:bb54 with SMTP id e9e14a558f8ab-3a26d5e8bf2mr30993475ab.0.1727262081294;
        Wed, 25 Sep 2024 04:01:21 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2b86:78b6:8ebc:e17a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73085sm2570298a12.59.2024.09.25.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:01:20 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] MT8188 DT and binding fixes
Date: Wed, 25 Sep 2024 18:57:44 +0800
Message-ID: <20240925110044.3678055-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is split from a previous series[1] to focus on few fixes and
improvements around MediaTek MT8188 device tree and bindings, and also
addressed comments and carried tags from the mentioned series.

[1]:
https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.org/

Regards,
Fei


Fei Shao (6):
  dt-bindings: power: mediatek: Add another nested power-domain layer
  dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
  arm64: dts: mediatek: mt8188: Define CPU big core cluster
  arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
  arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
  arm64: dts: mediatek: mt8188: Update vppsys node names to syscon

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  5 ++-
 .../power/mediatek,power-controller.yaml      |  4 ++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 37 +++++++++++--------
 3 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.46.0.792.g87dc391469-goog


