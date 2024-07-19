Return-Path: <linux-pci+bounces-10560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC86937E3D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 01:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C81C20E9B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE251494A3;
	Fri, 19 Jul 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atkeKVRF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE13C149019
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433211; cv=none; b=INkQWEISX91coXxvWqDz36ltMUb3RXdumIPCaI2w39A/6Eq4fAYYYzEH4qREU7apUenINl32GXfhqKlBvVXI9/ySLTZR9AwjmjR8DfRDfdZ71rlyCB+whstdixgfRaLcNjJEHKmXDWykAk8HjlG96sZz+f/tTqY2DrYiHm7rYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433211; c=relaxed/simple;
	bh=N0Bf1snEyOmN9PwI7D1qGPLrWeE4OLp76LEIGveAXm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LxcEGdE0XCykkmU/8bCvNOjSyNm3ejrAnPKW2oyDfexJdeM04uLlE4PRp8RuvySlkTVa3rFgJZ5u1odKb3S14ogUMco0sDU+laOkWXKjJ47mk9Gj5QrfMMgNbXvFoSkgXQq+bNt4fbXr0RPcmvp6GjRHL66k//D8wc5oELMAYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=atkeKVRF; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703775e4d5dso1145344a34.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721433209; x=1722038009; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMyG/FHVUOF+k6JySFz3GLM1XY2nmeubfD72U+zllkA=;
        b=atkeKVRFNA+aR7+F2Tw/EkyJkCCxEog/Q1Psm6iSyAmbNmmEVxkxy8uwbG2eGAVeLX
         8nvJRsC3I+d5gFa2Q8tAZZdRJs9uHl1ty377nNBWUxwes/NOlzE7Jp2fqDmVKBOw0fhl
         ya2XXYj7j31uow4viFa2JxBdb6UPq1h75uuMlUu1Z0TCezVVEe8ZTIOn2H/CTj8NM678
         1NQP3+BDmCHJ4NEcupxZwyf0V74YmC+ozfvVD+tc5cl4v/Hpiz9xEgiNBWL+PWmVbr4Q
         2GtsrZrDHZglbuIn4Lg92Twtlz7WvJfRZHUql9m0ykLpf5qy9hSL5+GpHSR7EYwQwrsW
         YYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433209; x=1722038009;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMyG/FHVUOF+k6JySFz3GLM1XY2nmeubfD72U+zllkA=;
        b=OTBrIYFoqJ0mxTHbeRKuuKehpTnsXGa+tnxaBnzt8sxh805oMTSEzOIrJzWa1ojc5s
         Am0pUsp0nRBmskLn8f2/CtpF+2JzT+PeYSSrM3kEpPAHmO6pGeoA6oT9TJkesnCN0xpn
         FG6nXS9RREUeGAPQxmB7crWcKeUCf2B6dt1kwcPOl9b0lu24tT2O4LruXA4Aj17rABx/
         xuEoS6VISs3b8bD9Z3fkijZDfE4yJLQJMAhgNJ0T7gUTCPtSZgfrd7jSyoPFF7JzT+MO
         AfAD6teKpY6y8fwbyH9rIheyXru46FF4cO8blykzj6l2LrxCeaPTbKEo+96lAdGVOi4H
         f6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXNRpml6fKWE92C+6gdtIimgF+VgKksJK+1Pwnnl09h1BHSGZLFHUxKP1clJYHGzDUWL6UremMpEZiZ6f1T3Uvmcpe34+Bf3Cn+
X-Gm-Message-State: AOJu0YyKECaDRwwa6XyfHtdMX22RXQumlwCTStTWsUn2PS5x2TiJAHKb
	z8gA7jZsRE2KJ4GM6oVAIBtTV/pWoXB4woiuHwLwEQlOnerXxJO8z7XOHjBshg4=
X-Google-Smtp-Source: AGHT+IHZwhEqRVINdFyb0JRqoDuwEVo6XNOi3YkdDsvf5Rjc9CJ2SYqTjSAxr4NzWjTL0X9tiwaDdQ==
X-Received: by 2002:a05:6830:b87:b0:703:5e1f:8f8c with SMTP id 46e09a7af769-7090092dedfmr71204a34.18.1721433208989;
        Fri, 19 Jul 2024 16:53:28 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:739a:b665:7f57:d340])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60d3560sm519172a34.31.2024.07.19.16.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:53:28 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:53:26 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: keystone: Fix && vs || typo
Message-ID: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally uses && where || was intended.  It potentially
results in a NULL dereference.

Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 52c6420ae200..95a471d6a586 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -577,7 +577,7 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(am6_pci_devids, bridge)) {
 		bridge_dev = pci_get_host_bridge_device(dev);
-		if (!bridge_dev && !bridge_dev->parent)
+		if (!bridge_dev || !bridge_dev->parent)
 			return;
 
 		ks_pcie = dev_get_drvdata(bridge_dev->parent);
-- 
2.43.0


