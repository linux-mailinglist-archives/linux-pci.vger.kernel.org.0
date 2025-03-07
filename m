Return-Path: <linux-pci+bounces-23094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB897A562DF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BB0171498
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AF1AF4C1;
	Fri,  7 Mar 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWpQmkc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1971A9B49
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337206; cv=none; b=F92m6SO+YcXNU+0S34ivwr5cfn0PGwE10LaNQgFARwsdhbIrU+z0Sc+NVKYKTBgE4Gh/hPZrqnGATHcpEMIGCxzR2VnNxbyVlz5eeAAV4PW1kdU3ZY/wUWMAL9assmwqvEsZxP0rV+8oRodlMBFI/BPRteAFpEJO5nKdArFXxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337206; c=relaxed/simple;
	bh=fKk5IlJrtgZGxwBN1L8aq8vNMpWqWsbH9W2eqn1VRNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCcS6Bz64nShkoQlCopfNi2j5oloqm7QA1n/gx4bfM1cOWMkmRGj1MR2bipLpJSME7wzi5pKOg+YRTDlpXpviILDTZBoF2aCe9H42kDmw5AvWWhJgrBt5xoxqJYOD3Bgh1AdvGdAc55XCL8Sg8OVx5c2fu1txuhnqwKrqQ7xeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWpQmkc6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bcad638efso9211675e9.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741337203; x=1741942003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CeCzp50wQFSHXwUSgk1GK0yw7rurMqQ1v0KAQL33c9Q=;
        b=fWpQmkc6VCH17moFp2gA8PhLXV55aP/S+YrvQ7D52wJNnizEk+fToz5a/rCsFaQF0u
         1PrRY0i+M63N6FzMgnWeTAmg7fym2asbumBBsDr4umxxbscW7OD80GWudJhrPQjs6PCG
         sZLwMvU2bvdviIPYaiKODML6p8l5Ce268T0sqE/nnOVkN422RLKphVEG+TNVSOnct9ha
         K3gx8KfTcsWr8DlZuWxsB8MLvVVkHumdef9PbW1yv0WO2x9stbemAJWLDq91xadw/wI2
         X2GhLUZBZ+m3D934r5wn4GMuUrFpdmAL+rDVvGKkhcMy0mYI1awzfORQIp7sqHMjufC3
         Gubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337203; x=1741942003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeCzp50wQFSHXwUSgk1GK0yw7rurMqQ1v0KAQL33c9Q=;
        b=ITG16KWkQ8jFJZx/uKysAekEvXBkestg6nyGcvgOjMUs1hZD/cLXesQvq8GUBfNbgC
         465Pf+++ZfPnUpqTV5jH/rIHTVXCuU5He9UbVlGeGQMY8NaPySSKM+8vezW23CRF51Qu
         ZtwsVxpUEX5Im0bYR3C8RfdgClcq2/yqDcjmkpZS0AvGnoinWOLBgyfQr6T55DHJBdSV
         Uh34tg4D4O3KMQUELltYTTwclLRwdmyOyliGJbaIfWebvE/xlangjK2XPAHCe00s20QX
         t6eEO/UNhBrJY9EuS4pWyjP/W5h0SERcHh09LTKhZIbCxN8Pf9KyMorBKJLToko4gNGD
         Ql7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo774qCTKmE7o1wFZOBUawnSl+EfOGsyRNvS7x/JLlQF60PAukEJo0t0oL5gzz2EGJprMHHsuRN2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/t0izUAgeQcIq2egaluF13Ihu/P1GoDBjPlrWVMeloVhVe9eN
	CRBKDVS+puqAmc1OcrOsN0Xekr4uHyCA0Ch3HmQ4T752rqopHMYm6e+Bw4lVUTA=
X-Gm-Gg: ASbGncs8YbAzkay2jDSxydOmRpu6Hpc9OvLI/emzi6qfej4xbuPVIjUr4sh4Ezb0FVp
	CyriPlxtJyYJe3zxW40cz5H42/xucjtphnAKbG9qZMLhtZQkhBBTzD3/SNm76i5Km3Yys8G15wF
	o1ervMxwfKbMomjzitE5za83+vuRbyTFEB7Gkimi6LOkxdTYui3HRS7ju81sIQFYpRYHGUuyg71
	ZJcRS/lVlGPem3+rmyfwk/HNmwZC/IXNq1EPdqjvIaZiRuciAV72DbjDCWIhCzHgMItwe+TXOLL
	ZQKfeUFICSvkClZl0d25H9Hdyjiv2ehGfC1vcXJMBHH7tWv3XQ==
X-Google-Smtp-Source: AGHT+IHm1ROMeb88xzMcstE8qmldjWdwE8YGxzBhlEQ+q3xNIiZZGzfSSGSPfht50sw4bsGjMidAfA==
X-Received: by 2002:a05:600c:35d1:b0:43b:da2b:762d with SMTP id 5b1f17b1804b1-43c601d90c8mr17653315e9.7.1741337202942;
        Fri, 07 Mar 2025 00:46:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd6530f26sm71167885e9.4.2025.03.07.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:46:42 -0800 (PST)
Date: Fri, 7 Mar 2025 11:46:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: remove stray put_device() in
 pci_register_host_bridge()
Message-ID: <55b24870-89fb-4c91-b85d-744e35db53c2@stanley.mountain>
References: <cover.1741336994.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741336994.git.dan.carpenter@linaro.org>

This put_device() was accidentally left over from when we changed the
code from using device_register() to calling device_add().  Delete it.

Fixes: 9885440b16b8 ("PCI: Fix pci_host_bridge struct device release/free handling")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ce83a1d6e31..819d23ce3565 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -999,10 +999,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Temporarily move resources off the list */
 	list_splice_init(&bridge->windows, &resources);
 	err = device_add(&bridge->dev);
-	if (err) {
-		put_device(&bridge->dev);
+	if (err)
 		goto free;
-	}
+
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
-- 
2.47.2


