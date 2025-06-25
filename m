Return-Path: <linux-pci+bounces-30644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B84AE8E8B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABE7A36E3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DF2DAFDE;
	Wed, 25 Jun 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="x+ufyYeQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AD2135B9;
	Wed, 25 Jun 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879550; cv=none; b=ZyheG9xOnDs9Axto8uhHdXAZ5CFv8nQrVAZVsCiVDumGFtkLic+ltS4E1vwvITJMe4n0MkcuVwPePDjbg/hlKSuGH/JQoEQZDXiBnjlD8lMHoxWG1cFep+FmZRTI7Q+a0JKkpwiylNEywpO/K3Bcpc0s/QDy7iU57vc3fh5hLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879550; c=relaxed/simple;
	bh=Vp9r34YREOKgaFBKzpSO3/LYviFx9DAwEtJl/EGbS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcbCQOqXvrxX4NE8kITidcmMb9NmIkF6ZhIxw62p2QrSNSVnYErXXueyg+sBzgc9DwCZwEPwKvIH95PCnw+UPdHHVwI4+gJYQBWKGBCdGCc+eJJkwrv6v7c1VETT2Iyi8C9CJHEdyK81mLxOjelS55GE/1yD9Yx45thkjPHrfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=x+ufyYeQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7F47166E7A8;
	Wed, 25 Jun 2025 21:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879539;
	bh=Vp9r34YREOKgaFBKzpSO3/LYviFx9DAwEtJl/EGbS1A=;
	h=From:Subject:Date;
	b=x+ufyYeQtT/JNFEptUA77ZHyTn/b1yIXM8zrqqpkVm9bTLUMk4CJnwtnTnZjvKyLz
	 w6gCpnKvFt809F1RukUJLnmo83KdaY1Dv28zB1aaWOG8qh13XNQnpPlXDuPHa1nCIe
	 U2SuArI+qgOLlQXwpk4g2YXp3cTdc+QtRCBUigki0nkY5j0ex5DOkcJd79t+4K3MdK
	 wvLEVYOFMkn9HyvtEWBYlX87ZKIV2o1L3OXhOMg0ICLo1+LRqhseQb8oNj6/3xNQCK
	 TiIVyESUm4hzyQyrVNtt3k38okKjAh670EwEW78BrJ+IA6DKa3FI6dXzLYvHkPzzsr
	 bWZ9Y7LDa+utg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 9/9] PCI: PM: Set power.strict_midlayer in pci_pm_init()
Date: Wed, 25 Jun 2025 21:25:21 +0200
Message-ID: <116746583.nniJfEyVGO@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
References: <22759968.EfDdHjke4D@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFf0XyIiSZsZxYER0kz1TDEaXPAxA6gWWkqxbUG6bEHYAAT6v7TovVLR3EubwKjtEYyKmRiDNwmxXjQgb7Fv7X9ZuMdrdZfAsHv0PNIdc3iCuimsCLgXHS3VdwsBDlX+N2aSEHhKkKe4bFtl6F8Z6j2Dip+JGIUOsjjf6wHXknBNzvedAFcMa3I+tP7mmNK0F2ZVMgNSEzPeNupteWTsKw+sVoNy7iibCNpCgtEmjTquEHJKyONjNL/DspJaB9CYI95YPuyjrNfj7djbo9ryKCwSItxPuwAqjcIzTCmlXbMERM6KTV/Uy/Mx0PyilUut5rFF6N5pUFFlP2Rd0dpJHiDgWq9yoR+FkOO3PKkJkDfCLLGFBJNq0OXAXgv/nixpXMfL8TFZ8y+xdrxiB4yQJJwXeFP5drDuRgdwkgKOE2WhdQfz1sfwD9HnXQA00ZOj71eQs/puNBZYfV1wd89ehNJcaahbNBdh/GDq8rZDqrGykbN2l5Y2EbeEUA/nSUx2xnY3ZveP4pRpJSRvEvZF65P27PTLV5aZygR0CJj7R+DZVhTfLlFo0rNdZmgNv2N+paMfDSc8XTP/A46VCwxpJgtLZNSCIDh0rs8P7UhJd7okghakcokMAMP0VyBqT1iqM9FkPBsKJqzYhiw4/dvpxQh8FSDbV7fAPGXqXm9D4TEdQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PCI bus type does not expect its runtime PM callbacks,
pci_pm_runtime_suspend() and pci_pm_runtime_resume(), to be invoked at
any point during system-wide suspend and resume, so make it express
that expectation by setting power.strict_midlayer for all PCI devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3208,6 +3208,8 @@
 	u16 status;
 	u16 pmc;
 
+	dev_pm_strict_midlayer(&dev->dev, true);
+
 	device_enable_async_suspend(&dev->dev);
 	dev->wakeup_prepared = false;
 




