Return-Path: <linux-pci+bounces-39544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A641C15937
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2211886855
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C715342CA7;
	Tue, 28 Oct 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdOMxHPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482A33F8BC
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666159; cv=none; b=tjTZDjSh3a8psR7ptFRFKzXElqL2ZnmRa38zlBjnn7HFcilZdNRPmG9zi3M/EDEnWwjvhOM+7bPyhIH01MauYlKHI0tjRLisO8AtlK3eJkKZi7VTpff15ho1bS0y3P6M1oBhbUO+lYqhKiicfBTrUrMmhYwIY/AUvx82YwnUhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666159; c=relaxed/simple;
	bh=+qmujv1j2dhUiejUJ6vkuBSeYgnuFw12qWJH/G+NXcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvxKmio/k28mxR40Y3BaQECsiXNjGmhXTa6zkTf19ELjxuXRbwALEFF47VSOC1B1a7d9j4OxPydEbxiTTpvio+jyvOFZJg+UjW9S3n4mQ7TIAEXupkugNedttlcL0o0muLAVViwwL8klMjXGXkqoB3/hyHRT730rkVEy+1Z4W1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdOMxHPI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290deb0e643so57047665ad.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666157; x=1762270957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4y0EJSogwXb/l2ctLCybder9EWKsVTxzS16PIlLrZdk=;
        b=PdOMxHPIIz/e6kJQiTlpfEr3V5/os9F6YnV7X4b9T6lD/QoPVWEh6Fc8YGVnBK8Vje
         1HIujHTJ74YAZKU/pkVXIMR5CBfxLAyQ9/l19U8Eq8ezH6kWMLO3YNP6ZO+KVEBqUS8N
         ErueFhsGXFk2/B+wUr3KPkVr63iUZH+bKov84O6id7KiJzKyds4cyazK5ugbiN3gQe/f
         pMyr0JaMXO+7gjZKymWxA2eAHspNKc7ZOs2IMSkm78TgH0AKiE6dCEMO3akIQINU4Viy
         vSoZwnWD/PrsIhhjEY7iJgse3cG3hnqqSASG3bEAOnx/ExMS04zIPLQZTtDDnLBaLKCk
         eE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666157; x=1762270957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y0EJSogwXb/l2ctLCybder9EWKsVTxzS16PIlLrZdk=;
        b=K/kmzxulTG0YBxeMTy6jO8YR5HoddSpFIJFG943QvFjDikf1hPhgKJHRidb104BQmR
         KWjCrFzxreQMzTEy20hdSfb23YGpHhLwq+faVKpK2BjHMaieYnOkGwezTodDpbxDkxV0
         gDUf8a9HWPpuP+MYQv99J49azBJ6O63RNbgHpQ/OQVY8ishPmemj+E5GHEI103Q5GlKL
         EcIDFy619wbIzOE4PdP5EAxXjtvq8zUO+FLzoFYS0avnJYFq7zAyZAouVbQZzZRLuQWq
         ICOIK+rH1JXSPm/W74w8wgrDtHBv7QpE4tmR2cpsI3XR2HmzXoEDs2CQpui8EA9SG9QG
         rXsg==
X-Forwarded-Encrypted: i=1; AJvYcCWCNXfJs6HE0Nc43ukl+SoMhv+/UG1jOh1BhKt4wVtIiXmb0lMWWw9p4EexGS5UsAck0Ug4Q42psGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uUbFG7NISNJB4nMNOpaO4Y3Z61gGiPSS5OYrinX1bhflyERv
	ikMEo6FpGQjwGvyGe3o2cpzpzsEDdg6XPuNPbyop3dKEnrHMWgKgMwRZ
X-Gm-Gg: ASbGncsV8k/8WFhCev5mNzfe0aaR/GKeQUBLn1Pv7zezcLyVq34dceFnwhyszkcp81X
	0Z3fIsGmmG237thUQzQL8TKks73g+KwKlgL1Jpr/RDtQTEoFvqSVHg4ygFLI0aqFNU0541RAT9g
	qdBgvEzobBrM6UIBt9efjwf9YJtfDn6CxjvLGPcMWS02+5ScSGNymC8Er4+2+iZ6v2ZYfLqH0Z/
	BwQ7e/mh4ek7HDT9HyzuZndqqeTeoWo/j6RFpBR2ak7GLCvw3szpa4g5cYzquvV4iPSr5BAH6A2
	s45u5mmmsyXzuKv4uDEOHXJNpi6SFRmHi5ku8VHlyXRNd/gtTl03us8zBJldy1axQIVENIGDsvQ
	0WVApaASDIopsbmqU6lj24vCgSgUH9A8eQm1CArzeHl1FqKOYvv0KI5ISCUOGvO61Y4vp1lBnCq
	Pv01/ml2f8
X-Google-Smtp-Source: AGHT+IEmbuhAY39zkLzLEiO4/3IEI+wJ/XdixLTlEX12sPPCwzL9L/N235oD3a/xqhHcC17poBLbbQ==
X-Received: by 2002:a17:903:384d:b0:276:76e1:2e87 with SMTP id d9443c01a7336-294cb52558cmr46649865ad.44.1761666157092;
        Tue, 28 Oct 2025 08:42:37 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a4d9sm119815145ad.37.2025.10.28.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:42:36 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Date: Tue, 28 Oct 2025 21:12:22 +0530
Message-ID: <20251028154229.6774-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

v3  : https://lore.kernel.org/all/20251027090310.38999-1-linux.amoon@gmail.com/
v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Changes
v4  : Improve the commit message.

v2  Drop the dev_err_probe return patch.
    Fix small issue address issue by Dan and Markus.
v1:
   Add new patch for dev_err_probe return.
   dropped unsesary clk_disable_unprepare as its handle by
   devm_clk_get_optional_enabled.

Thanks
-Anand

Anand Moon (2):
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)


base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
-- 
2.50.1


