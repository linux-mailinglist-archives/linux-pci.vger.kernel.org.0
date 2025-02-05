Return-Path: <linux-pci+bounces-20776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE381A299DF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D779E1698C3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83311FFC78;
	Wed,  5 Feb 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CWZ0OJDO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4141FFC5D
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782765; cv=none; b=HC0UwGviaCw4n43+G/Y0AJbDoB+S2VK5yD91mPQon7SV0vO+zLvCPwn1UQYKVF3wZF4+LCtnBEnrLuaGqmUYWlDsVWy2TuiyRJmhx54xy9GUi6HD6OhxSwuXKfqbTQbSFIeUwbGimBA28l9BvxQGikI7J+BWw4Eu6/QXudGMpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782765; c=relaxed/simple;
	bh=QXoJSTy8Qec/wV8sRxRD2VX9SrJlzd1/bepXCqAcBgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn5tVEwNrxqzT35eacytIkFuNoHNcRKiWzmAip0F7FykSHwD7J68yymAKCeo7AVBHRy2/j6CLwB5V+XWHwBO1a1asolDJgRHt7Fst5moMV5fr1cgGAtkog0dVr81XAeU4qNvTmJJlMv7seY4Gv6J6bv22kAKMmBO5WN2vZLgy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CWZ0OJDO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2161eb95317so3841745ad.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782763; x=1739387563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0ZTsssVvHzsc0e1DxaZAFNaCnLOP9m4uEkLrLv90vI=;
        b=CWZ0OJDOmwGP708rLU98leg72Av/z5pMPNC1hmOYXttjcyY4glyYSPI0l5gogUSePi
         nkAXgToTQLOCnbjZrs6B8aUVm38gDbmi1qfYR1UdVDNJmIWmlBeHJUBS+fav/Inz543S
         ealfqxIFkE+375jly1Rs9TCuM7Icg47RPyuoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782763; x=1739387563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0ZTsssVvHzsc0e1DxaZAFNaCnLOP9m4uEkLrLv90vI=;
        b=LfqCzmrY4Z4tBhTZS+DAR7ciumdmDhxmj6TBJdrK5sF7N0X2Zi14C90SU3nYmDAwE6
         F9IgfkKrWjWz7a8FIa80b/o+KAb/B5Gu1C+rII9Lg2jTMTTalnjXXmVLgbF8rGHgUXCv
         WmyMvL7og4CESwxIJ02rmIMhfFa0LHNCilrlGyk1jRGN/j5H09IigHelhChSjSW8ktei
         /Jo9BftaC1IWAmYfvLZlUNoCms+NYn2L65Kp2XrFdZQ+EOvb+o12VMepoluOtABC6TzZ
         qcLjti5+I3OStguTMf99rUnhsbeI8q1U/XpQXbZjQRA+adnApWhVgmInn/aHuWEzXhaM
         sJOQ==
X-Gm-Message-State: AOJu0Yz3KfDZmKBMZ6FdRnK6MkdE4zbQDX9G6U5JrEy2NpcJhMDoPzw4
	9RE7D4UjejtixKvkYqP9UqtaiSYphXDU40hAQOmyjCOwNHGPspvZlBzyiljIu5gtoDtMmcnOflX
	+qQ+7Zur9Y/kfFYTwPCTdYI61HIEs2wtar3CXg9FhdT8I/hu8Xxom7WZjhlPK4IZi62p9WLucoW
	paSysnSagh/h3tztZUXeoUa5CHabwx8FhgL3vWG+UQ1rZAhihx
X-Gm-Gg: ASbGnctfGuPxXGNdLbcnvFjTqICSsGpEH5bxgPOwzAlfSuXCqe/F5xxiZ79lCfagVOq
	JImnU2UsNPSX0F4z8WJOJWa5Rg3xITGEr/OIICxq2867pnZwm1MK5MkZNaevQRBL4XRbLNYfeoM
	XfWTYO4u/wqkZdtAsJFCPPtvsxBiLRf2naPLN3YBh8bEWvJnQN3AcX8UPL1VgLFkAMtXfSiR8oM
	7sagUjhbsT7b/feNYLu8hytalbWXjPARHW/fYiTq7lSkQisXjyRhh3ltbifltBoDDO1K+00GF8u
	6tTCEfddpdql1Z6A49xwCTW9O7wmtfzPAOZN+j8tFNVQXoO+3u6qa9a0btWM3vpdYwjzXDk=
X-Google-Smtp-Source: AGHT+IEXcZFzv42qZ8TJ/klgDwqqS/+A00tWNgeMvaWCk7kbJI8shXduYKzokviPveKCUA311SJ4wA==
X-Received: by 2002:a05:6a00:851:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-73035224858mr7975973b3a.24.1738782762954;
        Wed, 05 Feb 2025 11:12:42 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:42 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 6/6] PCI: brcmstb: Cast an int variable to an irq_hw_number_t
Date: Wed,  5 Feb 2025 14:12:06 -0500
Message-ID: <20250205191213.29202-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205191213.29202-1-james.quinlan@broadcom.com>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just make it clear to the reader that there is a conversion happening,
in this case from an int type to an irq_hw_number_t, an unsigned long int.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index da7b10036948..1e24e7fc895c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -560,7 +560,7 @@ static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return hwirq;
 
 	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, hwirq + i,
+		irq_domain_set_info(domain, virq + i, (irq_hw_number_t)hwirq + i,
 				    &brcm_msi_bottom_irq_chip, domain->host_data,
 				    handle_edge_irq, NULL, NULL);
 	return 0;
-- 
2.43.0


