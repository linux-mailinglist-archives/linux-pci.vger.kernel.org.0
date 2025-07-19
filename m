Return-Path: <linux-pci+bounces-32585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB6B0ADF1
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 06:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD016AC17CC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9372636;
	Sat, 19 Jul 2025 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhVqdFNy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29C846C;
	Sat, 19 Jul 2025 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899687; cv=none; b=QNoIuKgEd92NY5pX+GgvYPFv5Cq+LCipJAVjr22aLfLdN9M9skawC3CYfeGFDCISPqXg6WfSAnkJabLdq+YGqMgeUX4eW6B/abheF4WpURoko5AASOtG/98HqdFKDKrMXKjmohR2+xbo4TjuEH7Qsldb1zvDo3vqKtJZY4CcYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899687; c=relaxed/simple;
	bh=D+GrDUjLoCYjuZS2ALwEndGPR53wThKPa1kW31PUK5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TzXNQ2wcO7c89frPwI6SyZf++x4zkgsgesVBBBvLjz93SOC1yh+Pn7OZ3TKp7Lar9jg3/I7H2susZMiSHJKue0ywIauSGqGCeg0EuOu5cbApHCo9v2XjhiW4ms8DR3nsbq+6AoM2vZlEqbRxak3tLCZ7DDZ7ZmJTt2+tXSpgplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhVqdFNy; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so36811886d6.3;
        Fri, 18 Jul 2025 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752899685; x=1753504485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivC4LFjcMA2NRwtoT8yMygCEmK6Wm4+nSoOjwBWKu5Y=;
        b=IhVqdFNyN0f/Enqp6/9LR6EC7VdAfkjb7EG0WNNpUpTpUczR2ITPrljW2EqQRIG/Tx
         i4Rk0fHvbPYr/vKhbIeKcZf/dc0f/Evk7h1y/PxD1Q65arfvUOjnZZ3ZBswNW0C281e/
         9m0JdzLtS+IMX+IOv/Yt5SzsIS2n/sLq2KH3zl0gZZbl0y8gicPbY0Ryn4qejC71R8wu
         U/ODcig+Q9SX3gw+KEvGhxhS2Lvnci0f9KsRksbfUQSplneCcYvgafexAd2Vo+7MpQ/y
         7p3ce/8ydlF4yxoe0qNdg/QRxdaL99sGYsjcIlfppEvmmIOwCoZCb/GeLz0TppgODukC
         zChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752899685; x=1753504485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivC4LFjcMA2NRwtoT8yMygCEmK6Wm4+nSoOjwBWKu5Y=;
        b=Bfe95KUp0wt8mPntjIirFT8NpJPSrpR+hYTBMOTVyW/qK6zYbM+B6hgW/rtT50tNmk
         QfpsLtQDP60nHFe6pK6kXee+ctBd20+o0+PcAOcmbkVhxZbPIkVkAZ0Fu9329/7Uwhag
         hdNoOxaJIeXwzhcGSo3kKjHeN13Q9iIeNxadU+ZzQ9d8V6dDnjzW7TGOdpNVAyXnWnKc
         uUihVKUGjSmI09t17hm1nOGB9ZcWLdy4Vx2rTh9DJm3jk+FAh1xwbbmM8pAUjOLkm1Pc
         e3y+TnDcDo5eKMQQJ8PdgRRw0eMFw0N3nDiWq+kVKo9fCcslFgZ4w9u9/6AUBmlsDJyk
         y7VA==
X-Forwarded-Encrypted: i=1; AJvYcCWBjtaur+CObmaiXB0QXZOdMoER+5NowQToIlbKLEJ+Q2HhVRYuNWyb6smdT0GZ40lBP3NPzGfd7Ju9@vger.kernel.org, AJvYcCWffSov0/+rpvh0PJiyHJ4qQoqTcjjHXoEo9NyZkCSR8udEsJTR0Y6BGJsf6JLHZofWeE+DMX5XgufSs9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iHqJZWZBRnM6lRxleLfo4+VZL7PgptJ2TCGJsU17psG5jhS9
	+95Bs1IMKE+7UxExaPuIAnC3RGIfvdTGZy5/YmrsXAHurwcntG8s9ijB
X-Gm-Gg: ASbGncs42G64N0o8s0eHhVWBDe3VC4rbFZ9mAZCXCpsRHy2EPYpAAm6mjWtqqq7l5CS
	DSqhB8S1qP8c8i8ySF2p8KPVOik+RE9OabiuQPKtZruywiThWi24EhOGUF6NmRHYPeRq77DGPy5
	bffrXGr3OL9eEbRKrGrXrGi7bYvR+Nmzq4SGLMB963F+bRBvQiseATnf+m5QC+wEodXmM1TKiMY
	/3c42VZe6oiHiWM+6pj3JT5tjkbapR/6xRXNHXzJsyTqNcstlNQYtAikHFVC2nebMdaYm9oJe8L
	05ngnDYOlVQD1jeKbE04onGmifIju+YqKgJqSvtHAzrlmqB+oO1aNPrNKz8SBuxp38qSRBrMnJE
	3yj6KRhtN6AdGEw==
X-Google-Smtp-Source: AGHT+IFWu8yLfIBJKy6pujMDr34336Oh0WE1hUlwO3izF+IRV6PaVvvw+XcS1tSMo+tG1oya2fRzJw==
X-Received: by 2002:a05:6214:5c08:b0:704:7d7d:8af7 with SMTP id 6a1803df08f44-704f6afbfbemr164519986d6.15.1752899684901;
        Fri, 18 Jul 2025 21:34:44 -0700 (PDT)
Received: from pc ([196.235.158.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6afd9sm15249976d6.56.2025.07.18.21.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 21:34:44 -0700 (PDT)
Date: Sat, 19 Jul 2025 05:34:40 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-ID: <aHsgYALHfQbrgq0t@pc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace devm_add_action() with devm_add_action_or_reset() to make code
cleaner.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/pci/controller/pci-mvebu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a4a2bac4f4b2..755651f33811 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1353,11 +1353,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		goto skip;
 	}
 
-	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);
-	if (ret < 0) {
-		clk_put(port->clk);
+	ret = devm_add_action_or_reset(dev, mvebu_pcie_port_clk_put, port);
+	if (ret < 0)
 		goto err;
-	}
 
 	return 1;
 
-- 
2.43.0


