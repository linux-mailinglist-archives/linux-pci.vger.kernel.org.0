Return-Path: <linux-pci+bounces-30960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B14AEBFD5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A21E3AA1E7
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653402EBDE5;
	Fri, 27 Jun 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OoFu0pZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C21F0E25;
	Fri, 27 Jun 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052587; cv=none; b=WdSpFWKsbP9HJwNq69eqXMSO2FrHBNn2hy5iy6KmQJG8pY7as1shEOFnrWvncWbV73W7nGO6WwcdPANyEv/TxRDfdXy1Yu/i3C2Bj3sWs6s44ymyRCSZTnHcGMEEutkPPIBV/m6Fz3qQIGFxvgrolLw+LVgKOfLeDru6siXeMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052587; c=relaxed/simple;
	bh=MAKUi1zdevja1BNptFDStWhXqtQK/SthXkv+Q2DJKho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFAWHHKjqCP3TPay9F9nqSgdF9VN2f49rFd0Lu3WTe7A9xrmazStv7oEnxK//p4RoXJvGSV3hu9/cHWQmEyAOG/PjkrI8YKOX3ulq/Fxn6DvvtL4d3E7BDQWcF36DvW7xuABalJWf0NyqGupFGfX/G0nyc2X9CNqj6ycXBVWcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OoFu0pZh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7292866DEE3;
	Fri, 27 Jun 2025 21:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052580;
	bh=MAKUi1zdevja1BNptFDStWhXqtQK/SthXkv+Q2DJKho=;
	h=From:Subject:Date;
	b=OoFu0pZhBxdhAeWEwPXNFnqWVBIPZs6+Z6GMWHaJbYFxRBLRVZH48MGi+CUeo/RoA
	 /ossDat/LIHVwrFYyZi086OzG9XovgmJmTapswap6n1wviaN6F2Tg6tKvtt5c8ovd7
	 Cb4dr/Ao8JGqAUCtyC8uwa/vcU/b+4BaaHZDiBADmE35+al3DCBr1kf7s5QwKoj9TX
	 bzK511gvS4xs/hy8w3pUw9NiLlOh5kF3g8lLT3lN4P0cPMJ0ePHVXb5W+d3n/3Kw9h
	 1ZxvCjievit3JVBpGcmoLdPtlc6kITMkwFrZ1IGhSikOxgPfdRdn1N8TUk6IDQxAHf
	 Dl9hNdLjACyKw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 4/9] PM: runtime: Clear power.needs_force_resume in
 pm_runtime_reinit()
Date: Fri, 27 Jun 2025 21:16:05 +0200
Message-ID: <9495163.CDJkKcVGEf@rjwysocki.net>
In-Reply-To: <5018768.GXAFRqVoOG@rjwysocki.net>
References: <5018768.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFEDPUlyUa5BH8WhRN8j8ZZL9URt913dE8Sha9XSdHkL34/Q80MoKDsaDIgjxDvSgYGRhjduzyaR7Maer1WfDM3bDUHFgE/RHlxHtfCYi5v3N+Y6N0a1HIWChFMoPzJsH75vj8LV6jwHnfOGZ8T7qxuqBBL4FaRw0h5CxwrCHsFrtRx761X8TCrjddUeCGx0d7qqBLzZBYpYCGod76fBFLaLJaKrxriphNVAMbIMg1VDhShgg9OIsw4ZRJEYJpLGnNIyZOkhI0EyX//9cw8IxzcHB9E7V8gkviVBKyHKUcxlAjaAGHPSZcncqfE7rCuN9zMGhMu5nBuzthWqqcjRP76f7e1Mr0fwT/e97gbLTPC4IxtkHMcY/00W8LVGngkeBB5pgzZtZvkTeIxDHOGx23x6DTqaWxnRsLFUy8JO2Q9Lhp4WA30GqeKCBXKD+XUbvnvZHlavhsQ49X6hoT9oNZLVkBhmtXC0BAGeFVvEfZEuluAZ3YN3OE+qEolsI/Ci6iIsgvpGyHcaMYGe+0eTBuIQPG6gkff3nvmmMcG1BxkP9wzYfG9Ndbc38Pxwdn8JRZpGJkOm6jIAN7rXW/OvtSzHXDlvSrBHTb31euqW0Qa2c2jh9NRPwVw+DsyK1wjVJvUi5b03Uf9RtwkkEjJYeW6wO8HodwM8C17iq48b1F/tw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clear power.needs_force_resume in pm_runtime_reinit() in case it has
been set by pm_runtime_force_suspend() invoked from a driver remove
callback.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Reorder (it was [2/9] previously).

v1 -> v2: New patch.

---
 drivers/base/power/runtime.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1854,6 +1854,11 @@
 				pm_runtime_put(dev->parent);
 		}
 	}
+	/*
+	 * Clear power.needs_force_resume in case it has been set by
+	 * pm_runtime_force_suspend() invoked from a driver remove callback.
+	 */
+	dev->power.needs_force_resume = false;
 }
 
 /**




