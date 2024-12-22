Return-Path: <linux-pci+bounces-18944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1219FA843
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 22:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0033E188639B
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303D1946BC;
	Sun, 22 Dec 2024 21:15:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC589192D7B;
	Sun, 22 Dec 2024 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734902108; cv=none; b=RSqIcgHsGkBFFgZ5HeyVoaBQF9zW8CQRIzNwRXttzB9ONoaMUxCjL/WbECxRptuAwnRR4ww7YkGir7Zggx18/eY4/uSiaSG5PaT2Za1E9e8ZmYd+UUCnoAdwxRbYQ27Mr4V8+nR1CPzIhWNvlPm/T2wBvqYDJLL4MO5QUaPaLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734902108; c=relaxed/simple;
	bh=Spe0xJ6A60wVvLDJX49Zn/oShZOuqycqezYeOxSKF3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvFbm+oeFy8Be211Su+GVp0E+b981D2tTBk5sQZ3eX8sQflsdAtdyS7RCfo7OXhsSqYf7WmNFDoNExAb2bL1u6WrZ4KZ3jCpB/tonwerC20JQHj2LiGjHusPsXB4OUpkc3If4Vkyvl+o4lbpHQSECECQPXs+MlK2rfvhCmljRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216395e151bso23050615ad.0;
        Sun, 22 Dec 2024 13:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734902106; x=1735506906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2EAvvGaGQe4GZOyf1+O7bXahYdeX6C577uneV/yQI8=;
        b=hOqLTJlf+ow57sna9U3DlR7Txi1yEWB3kUwIWc2/wLIElVJ3KgzaR1Iy325SyrN3GD
         22L/TvW9pqPK71Oxjii1Y3qRluO6W3GYknuXHK0U05tmFQ3DfN+6CkDwmkk5gQmiUb0P
         1ChfXdiEqNA9n0Y4gme1QQflcuAzY610Gh+X/nL3qtgsfPrhzbQHpCHgqtFYyCTSAX+x
         XjAmWc6N3wFEoc0b+M40aZPVng9R7lcTRtLA+WjLa0+JkVY45Q9gGWur7AXVyO6rWrKN
         LkkCnjMDyyufnPivyaCmPNLKKFlo44Yq3YqW1tKab35+UGIrhcPunz3Lwb11FTKxhgNt
         Ps0A==
X-Forwarded-Encrypted: i=1; AJvYcCXdQ7eWZk9iPrICK/qbLAFL4LJ7u4jUttWMvv/kbLVC58n+cdYSMcTPX4vcBg5crR7gjotRe583pLwj@vger.kernel.org, AJvYcCXvX9nsf8sf5+hndL3khXPOS2oFeWoKEJu8I8NOr1AOVENF4dE4RjAtVhu1/xjriRlg9q8s7NxEQYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFr4huPJ/jDdwnhjHKzCMWmOI7L6M4If5c1F9s0dTkTrr4kE63
	QQEWLfkrfXKiWbLb8iEdoTxwadBp3QPu8bcpxFkagblHks36uH7y
X-Gm-Gg: ASbGnctrnZf6tmzVUM61RlLYZcKP6D4H5xRTqWzhQtiz8am7WbXJr1KSx4HFOJFpFZa
	fIRfchg+5+RStqVtwq+7Mtfa3rfm5sdqDcOcOhyzaXT2Oz3BpcDY1sfJU90sTK4urO8dI6FlNdp
	TZzc58cGv5AiXc8REO9wP6Jacntlo77q2/VVkUujaUw4rmN2H4c7ZzT36v3RNwneR8Bab6PE4fe
	dibsm570lEyaG920gFL5TOEdEhXP9CCkGoA2wheVkXsWoGubArvCAeqO3DTh2iuYLfZhF05Tpi3
	7RYOEcjtXiAlad8=
X-Google-Smtp-Source: AGHT+IFnh8/2jH1K2C8laRyf+QSqdgxXTyVDB6IlMXv9COCrJqawDYFQvRtiTT9LwezuAyZuQTniUg==
X-Received: by 2002:a17:902:c402:b0:215:a034:3bae with SMTP id d9443c01a7336-219e6d59abemr151928855ad.18.1734902106227;
        Sun, 22 Dec 2024 13:15:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0194bsm61117915ad.248.2024.12.22.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 13:15:05 -0800 (PST)
Date: Mon, 23 Dec 2024 06:15:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 0/6] PCI: mediatek-gen3: mtk_pcie_en7581_power_up()
 code refactoring
Message-ID: <20241222211503.GE3111282@rocinante>
References: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-pcie-en7581-fixes-v5-0-dbffe41566b3@kernel.org>

Hello,

> Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine

Applied to controller/mediatek, thank you!

[01/06] PCI: mediatek-gen3: Add missing reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
        https://git.kernel.org/pci/pci/c/3b2ea2d9a669
[02/06] PCI: mediatek-gen3: Use clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
        https://git.kernel.org/pci/pci/c/a28adc4d00b7
[03/06] PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
        https://git.kernel.org/pci/pci/c/599e5a6bc452
[04/06] PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()
        https://git.kernel.org/pci/pci/c/cdd822338f1b
[05/06] PCI: mediatek-gen3: Add reset delay in mtk_pcie_en7581_power_up()
        https://git.kernel.org/pci/pci/c/6c042f72a930
[06/06] PCI: mediatek-gen3: Use msleep() in mtk_pcie_en7581_power_up()
        https://git.kernel.org/pci/pci/c/90fcb3d015ef

	Krzysztof

