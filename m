Return-Path: <linux-pci+bounces-30087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491DADF21D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC144A03F9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7562EE28B;
	Wed, 18 Jun 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LijKba0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C912EB5AF
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262551; cv=none; b=GnaaXb+iU3ZvmfskVAIde3CRgouKaXirm//54HhXjYxFSS5734Ya/osZUTwXKQvE3HlXFrlHLeRs/dzYF5OtNVJaRlzANFNBlevykTDANqGKeBCdHtBKBhWlI4FPjaVtfwgYUFUkn/Hrtygo2hbUhNjvoJLdszZCUP9NCeRySxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262551; c=relaxed/simple;
	bh=szpCxpm/j2ZbcXcfCS9kCbBVMGO+lYR+TOvNQfWht2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtp/MClrQsMcsk//Z+0GiJf1f9nf9xkHao93UUEiKDMU6Fpp+wHxIUH+U1CMD6eHnSRbJ/+JuChdQWtS8Yuir9sdm6xqIw+2D8oZm4ZTRH8wHWlkUbPhrRYGvMWZzQrH6LwqZOurmyTEbHwRQNhuwMqMOWNyF78qihZgi5SsYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LijKba0L; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4079f80ff0fso577800b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750262549; x=1750867349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHWHgwA/STLjiBuexUHGmnhpSwfTae10x6GG0C7Yl58=;
        b=LijKba0LwOio5PKcfPJHGJj8p/7ATCv3EVfcxwvX1Swv95zZWG3k/ayHqEZOm8YnNc
         XQkrxq/6pjXIEnq6PTtgBHTVS8y1sYGJNqhJQBwsyNjwAPblhm2iRrVxU62FxCRMY6rZ
         D2g8Y1RLT3KtJrp66E9ORS+efui1VtIhjo8upE6jqyRBivRli42hRJ6eDhzNfcLeAN7U
         K9PtSXtWT5mGya8OFt0dIZ/XdSemPHNhBz7WDHsx8JHm5VJl22mwph7ESUccg2I0Uk5V
         7Hn243BsD/HZI//gcF9Eo/MqAhtYQXUU51EYCNZTLSx+WW0yX5KbSEabwud28+cRqiEB
         sqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750262549; x=1750867349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHWHgwA/STLjiBuexUHGmnhpSwfTae10x6GG0C7Yl58=;
        b=FW1zfR1uVJ7py72m8bq4CbjbmEGOnl5qdjSm75UAYL2FXaqcSAsSCrC0XJISf4wpRz
         atJ5xUdZG6zmMJwJYxTk2Mt5zESSxIiJE8dee/88qheA3+T7aP1wXd2mq+pOGzO6Xus7
         UE6aFfmTEKTXXe39/Ln3DMPKB8Ph0+P4wr7FkKIl5Ba8KJUsJDiiS6F2vlCstJLPS11E
         yh9A/eiq4I4fTmfjiY6T4o6VlAmFFz/kxqr3VQOdi/B8xt0pPKgOZX/uOdqFrEpDqgBv
         N7WP5eiPUfEm8bp/JuyNcfJmy58gJSCNUK03WKLxE3iG8YRPKv0IwcaWAqBWPpGg80ld
         RlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJA8Y1VzsxmthDLKotPnRTesjVVtmcvfud5iUWIdP2VGSGhuficnMQlnqHeKwWLh5g8Wx8fpo8p0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/lp+xzsp8fXJQLygb5jyezyQiOhgVisGiaT5L3UJg3Lv1zs0
	WmiT7yku67JwhDIx7FlicEqMj+TNmXGVP+QHU9+SNIe75s91LQsGH3vjqMTCvrfu/60=
X-Gm-Gg: ASbGncsXBMOXhVN/45gGtmg/d4BTHekOlm45DgI4JL5j1VEW41EPVF8WEg9QpsplWEQ
	otpouHVeXjY71un4V2olP3lBavydsCHgN2nr8TzDxMoo3nJVFZi91Ouezi65KixjfkkTxteXT8B
	V10GNreTyQYKIP9F4xMI6uPZ0vqWt5Hc+0hgSlJo7SUL2VEYBT1R+PD9tjxLUFOsQ/VoAuxs8zh
	pE0EAbt2VeZAIpOUb+L4BMhgktNwMR93uLZVpAxx7SnGTLtYnTxrs9a72tfSezLlGZlNA5ai19u
	2+gcvGpI1X1klm7cGa8Ous9KCnoGKopvp+t+x9Cl4yt6z8WEsrROWsBudMvIfVRCSjFEew==
X-Google-Smtp-Source: AGHT+IFdKAGH3Dc73tUBzIIxeMD+asyvvqOBafuZVazwZnURkN8zz0IH1vKpB9D7wWwudeN/TRUMfQ==
X-Received: by 2002:a05:6808:4f26:b0:40a:5380:b8d1 with SMTP id 5614622812f47-40ab510f58emr105690b6e.3.1750262549102;
        Wed, 18 Jun 2025 09:02:29 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a283dc98asm2012193a34.11.2025.06.18.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:02:28 -0700 (PDT)
Date: Wed, 18 Jun 2025 19:02:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: rafael@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	kwilczynski@kernel.org, sashal@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ACPI: Fix double free bug in pci_acpi_scan_root()
 function
Message-ID: <f04d01a7-28f5-41ea-85f6-ba0e67c80428@suswa.mountain>
References: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>

Wait, what?  We can't just delete pci_acpi_generic_release_info().
What's going to free all those things on the success path?  I
don't understand.

I had suggested you do something like this:

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..ff5799b696d6 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1012,20 +1012,20 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		 root->segment, busnum);
 
 	if (ops->init_info && ops->init_info(info))
-		goto out_release_info;
+		return NULL;
 	if (ops->prepare_resources)
 		ret = ops->prepare_resources(info);
 	else
 		ret = acpi_pci_probe_root_resources(info);
 	if (ret < 0)
-		goto out_release_info;
+		goto cleanup_init_info;
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
 	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
 				  sysdata, &info->resources);
 	if (!bus)
-		goto out_release_info;
+		goto cleanup_acpi_pci_probe_root_resources;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
@@ -1053,8 +1053,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
 	return bus;
 
+cleanup_acpi_pci_probe_root_resources:
+	free_something_with_probe();
 out_release_info:
-	__acpi_pci_root_release_info(info);
+	free_something_info();
 	return NULL;
 }
 

But you'd need to replace the dummy code with actual code and
change the callers etc.  And I haven't looked at the actual
code to verify it's a good idea.

regards,
dan carpenter


