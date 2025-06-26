Return-Path: <linux-pci+bounces-30807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B314AEA520
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3505A0198
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB32F0040;
	Thu, 26 Jun 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Q4exH2Pl"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478BA2EF9A9;
	Thu, 26 Jun 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961752; cv=none; b=t4qEZd8aW1c3rcgnndd/fAdU73YBUEiDpnmspZLkLMQ73kP0Ur1NffwTJGQNNc1/f/esvNWgn4VyAmGu0rX0aj8/1g5s3wflgcPqR7COTZ+EQCAavW9w2tgERArrn6OC/xRnRS4JjbQMntk0sML9gqS0cbBNAnzrzylC3UWi3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961752; c=relaxed/simple;
	bh=XknqYFnTWTX/9400Hf7OQPO6tOi3GD1U3KGl3xqNI3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gedIjptGPfYE/sDOn8AkbPO6zr7kUYVCytDR1MoGw0ZvQaLqMjTssIHF6FaCIMai6OSiqgB6Pq3bTJ0lMNz2IPnv4+U+rhQxNDKcg9vIYokluJb4Oo4hgwis0n+xyOPgpODXb2wcpcbdg1t81zkTk2SjGFh8ivxzXdNbeu50zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Q4exH2Pl; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E36E766E999;
	Thu, 26 Jun 2025 20:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961749;
	bh=XknqYFnTWTX/9400Hf7OQPO6tOi3GD1U3KGl3xqNI3k=;
	h=From:Subject:Date;
	b=Q4exH2PlNPPfq3p+zR4equXK8SufE9xbTEgHMBW7CK4eygAV8n3fZ1M0N1d76icCe
	 xesinawDyBvCgmvVMt0sBiPLPDefB0KQf//y2oVpfxAxbymzPDKIpjDOvDqRy+6fuE
	 z2aKy0JVntQgH6SyGkx9Xib8dB0wq65lSNc7W5HNBNIA4qhiwHUwbvqEWWKjasLugI
	 ES5bok2LN1IcT4duDVwPrIYXXsg/Qim0Ujmy93GICIqo1jJSxH4FYHzYfFQcRb1Gqf
	 aFkAG3niP3VH10FgVRCRsP3rQ2qGH5qE/IZ/TjAlCbtzqZELq9Exy6ARzY6usrjL90
	 g/wqIjUxN3s4w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 2/9] PM: runtime: Clear power.needs_force_resume in
 pm_runtime_reinit()
Date: Thu, 26 Jun 2025 19:58:35 +0200
Message-ID: <3019776.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <5015172.GXAFRqVoOG@rjwysocki.net>
References: <5015172.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFa3M0f04p6hhLyiTVM7rZOcnSqOhT2amPzAoUQYOO+wQ5EdLo0jLcyIjI8b6ghCFqrfH/H49FBgk9zSNAmZVjVmEo/07TYi8hVwSs/HFwMJkisiIHnXAlt0cX8tuInKjbgKryqLCjuMExvs3KJn+fRxmENHGFMbcS2Tcy6P4n1FKBZM45bsYPgRuUUscncS4PHFOQM/6rWZzfskfwzXmJKW4NcLVfzCfST7CEFDH9kAJ1o5fdqYhz/o7TmfNYeiGZTNZ+2v02CFbhpDaX3YgEQq5iXsX6JqBuXRA8cqidHILuNucN2hqUJ/vYcWY0MAUe5nTWWds+DjqWriS8S5QNajLjj2gRYs/mzAOfACsdBfMfiKa23FqmSxUtMUs5OLrbE9eB6mohP3UVVnpxg+1WmRKcvuF5poxE4KzERD360gd7CNPsvDjoYUlmKmf8ymFeno9v4V1I6lYTxkFf7qM5hnPegzmS0BXvfQms3wJpXrT1dX9/UuJbDjZHJkq5Wjl8qi/qnYhSuiXHhn5Wfmq/94OfyIFF1JfFa1rHKuMVsCLfgsD/oPgzbSke+5lqDZ7snWx3TYi+1EGSGv3U/+18sgTuD7uga7w4u51aZnbnJZzC3TGz0sm5jLJTaisVFjVH+2z7PG8t1oeFhxGYlNLLULQNPH5P/Ld2eeHkcl2Q+dQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clear power.needs_force_resume in pm_runtime_reinit() in case it has
been set by pm_runtime_force_suspend() invoked from a driver remove
callback.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

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




