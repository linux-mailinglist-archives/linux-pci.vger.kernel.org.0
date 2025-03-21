Return-Path: <linux-pci+bounces-24295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90DA6B2CA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8C486B6E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA41E0DBA;
	Fri, 21 Mar 2025 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J11HKGsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF521DFD95
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522317; cv=none; b=RrFD1GaiZcYlF31RE/b0gjNXQZewnUyzFuVlSoEXH7Z8R65VAKsLRnJtp8qwhI/gZp80DCeRlVt5B9e0U9uS1AHLl573EaoW8wcpnJkVL7ytpJfmA9N6Jbfa5fJ/Nfn5HN28JqWd918F2MtJHFrd8mCtjIOna+X3HtYIx/3Yjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522317; c=relaxed/simple;
	bh=9XedSuAs+PcMxam+6jM/ZI9aC4u/aia2p6UH/CBQFto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UhVqpQgylD6miMq/eHI0KhURWL83Ge5YWnT0ZeAe03VT1IfRc+z8PUbmn98ATqTrPTJV+uM6LEbXeXZV1ZFl6gbEhagPKd6NSFkoLzC7VhhxuUZjyoiM23lf53+qAuclP0uMVohGAmTbnTxDRgXRp1/Rj5cp6VValet60aWKBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J11HKGsE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2233b764fc8so22244005ad.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522313; x=1743127113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkyXCP/lPdH8yGr8EWVQ+s8St28L9FhUSKnHg2FvWac=;
        b=J11HKGsEVF8tzsEz3t3CfrTKXDcG/wWgQ51lyJetH7rqYLLuLMZ6nZjbQ13dYevYqB
         ekmnuQxn9qY7dbYE+EXK0RpdVwsbPWgKdP9Ctw2yzlFdNyrwlMLUd6lPsY3Hk3pnNlGD
         cBdJ3FEzq1/1jD1QfmVoKqsNqn1D72MIGMXp6Q9mTTXy9jhUedGhLLue7kLNEVSh+1Tg
         bQhKGatIPj8si+MybJ6MewHfWDRRKY2LrGA1KavBMJNc60dxxecYqDNmJjJQJBPhgiCd
         GwTe2+9nmjFZEubXEEEWkeLVZkkOU3Gv4n3mHqljQTNRfRV1S+mxruHj19XOOCP/hIYc
         Bslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522313; x=1743127113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkyXCP/lPdH8yGr8EWVQ+s8St28L9FhUSKnHg2FvWac=;
        b=qV4wUJbrVcxBBy0NPbZuuV/Q2Qlj5lRDB9++YJl+kgvVjhTYdYzGlxrGPpPv5zxdAp
         pvZ7NS+vaJyA45VkXhE4cXfFJxLJkgmyfwovtwpWViozxDQkeEgb0ocO8945UQdsWoz2
         kzZALy8HMVoiXUShzYTHnE8DvCbODhKU+XZQ6EQNxdVRBbysZc38A6mxRPxaUP8+wqbf
         Y+xPZKArH3LpF2bZzbTJsXZdYRvRhlxLBudN+gmiZMeOTsr/xlNNW1t43YW9cToQYLxS
         O58aZmJyhmfnjwJInVx54ATJ/fMgD9FjDgNodeZOrEHl4XWcfUCDkk7kUbbyABAWhSRQ
         1IAg==
X-Gm-Message-State: AOJu0Yy9RXSnlrHJMYDACYc50K0UscRWbgWyO6mRSxJmQmQ7DcTZNOjp
	LMpUeysQqy2H8eozhlfIJ6APU1xJ4anlom3zKkRXkixac1bcfTp7gQFCIRERHnBRLva5bOT3Ofd
	gog==
X-Google-Smtp-Source: AGHT+IFCdeu6Fz8xHwUpBmkSIe2ywyMCjM/6AiMtqN8xK5e/csPHNiTk/3gabtv+u2i45cmrXMlHNAfnES8=
X-Received: from plcn1.prod.google.com ([2002:a17:902:d2c1:b0:223:52c5:17f6])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cb:b0:221:78a1:27fb
 with SMTP id d9443c01a7336-22780c50872mr26811545ad.11.1742522313376; Thu, 20
 Mar 2025 18:58:33 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:05 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-8-pandoh@google.com>
Subject: [PATCH v5 7/8] PCI/AER: Add ratelimits to PCI AER Documentation
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ratelimits section for rationale and defaults.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..896d2a232a90 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+--------------
+
+Since error messages can be generated for each transaction, we may see
+large volumes of errors reported. To prevent spammy devices from flooding
+the console/stalling execution, messages are throttled by device and error
+type (correctable vs. uncorrectable).
+
+AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
+DEFAULT_RATELIMIT_INTERVAL (5 seconds).
+
 AER Statistics / Counters
 -------------------------
 
-- 
2.49.0.395.g12beb8f557-goog


