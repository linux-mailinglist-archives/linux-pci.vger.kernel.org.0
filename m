Return-Path: <linux-pci+bounces-11856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81969957F1D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C62819C7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15934084E;
	Tue, 20 Aug 2024 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8abEFRW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4A18E344;
	Tue, 20 Aug 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137867; cv=none; b=inAb+HdsG1m+E2djo2RqPaKkgVCY5hzdlQ5a4W5QcVPWkDVVZ9Wuu7KhH9t4scn7+nt+/vM3ZE1oGeG23zBoxLZpfyjFhDKDbNwbndQYZzQguRAoYpLtvvc8i8b4rziFCjjKSVINH/8fYmTq1mtDL9FTe05ELDFyBwrP9wW0oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137867; c=relaxed/simple;
	bh=ZhrWVXHynw6IxsFgb5JAOsRnWxE2Eo1B6P0XSiPH2Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOifWc2a4n5wAvIAFIF7Z5tgrJxDe+/O3NG6gk232B5y9Cc8uXRB6Axp80usKXZq73mRkOEa6aVWUH2tXQQxL17ggeO8gUeZznkLaPTfALsyGg2yC9x6n23cESglkmboL0LUVE1hHoLK7Iom7MjaVQIu2vAS+JQqTdqq9cYuyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8abEFRW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so1626841a12.0;
        Tue, 20 Aug 2024 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724137864; x=1724742664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzBGxwknVzLiUwPp49bCeb2JdXQ66b25/vzSQzWpf3Y=;
        b=i8abEFRWuAPI9Haap6sBFuWM6Bgc92yZ5PK3s69KBu1Rt09bh2h2rTO3aXu/23HtkN
         Zl1RzQXH+i09E7DMYIoBKKibM2C9F9lmZmbug9OEu5z9klXyZSMg/q2Biukj0jr31TXv
         +qgubxTZw/mDjDchpU3HALUafObVIIneWX2pfj3cFrzJydrhbnw1M5Zlabi25QQQwKsQ
         J2jVs8h5pN2UscRAS5B+DsA9jcAZ2awjzhyYe7/nHodvHrFJXu9WNsCfsjg+3A1El72s
         MnEpzHQeAQTlhGajNESDAyvFSH5tLBsLhzBqYEAZJkCRjba3hAX1hcekIQ2vrTYHHxLi
         /SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724137864; x=1724742664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzBGxwknVzLiUwPp49bCeb2JdXQ66b25/vzSQzWpf3Y=;
        b=tUKJD9SwciJnbJoqNCI6U8jk5Xf5YwVuqLS+Zd85YaNeEl9qMRQMN6Lnq8UU5/bFFh
         R+fvDPijHkpPGmbhAqkIiZFvBCmOHX8cNZq0AOJIWozIDZJrhqxCQtIrqYsQ9BbjcqPo
         dA2OvDzcrC0GWKsYDgFHArfedLuu/b/hF+2gpQf+GRPtxfhqspgvll1sALWs5o58pyVX
         gxfPP4ngpacULLaGua7NNKfyDJYSSoKa4PLuzpaDXaKkvR9hAyD/U4pEtLPsVTKrJeAE
         4wB6G/K1w0xObB0QtV8v8Js617d5Z3zQGcHOZocpzl33U9arxEkn7H0TbmzEBnHPJMJQ
         hvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUH2qIEC/SGUKFuMs7gRpZM2vNPaOyfR0puqGUicQ/XHYWU/CQDmgRQ2V4LgtUDgZEuOzOb/hBEiUhpEi+VVOzm0GKfMdaWJEvsB8NiRXoTC13oF0H9upED8ivJ1mEE2LyTAxi4HYAf
X-Gm-Message-State: AOJu0Yzx9bH+A+oN/R+XjMUWSYvRpP+GdTmbPf4TXGrhdK97nZWEji/8
	fGMHS4zF3xRfMD7PTSK5pAQ7RHFbs2EXMXeniA2zfcvi1wwk5dC+
X-Google-Smtp-Source: AGHT+IGXZKewjSMY+GBxDGzvr/6BuJe2OiiCtHRThGifnnhxtLGvREHSyd9vU4gJgcSD38oLxXlf+Q==
X-Received: by 2002:a17:907:3f1b:b0:a77:e0ed:8bb with SMTP id a640c23a62f3a-a8392a11722mr1001269366b.42.1724137863916;
        Tue, 20 Aug 2024 00:11:03 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6639sm721911666b.7.2024.08.20.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:11:03 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] PCI: endpoint: pci-epf-test: Call
Date: Tue, 20 Aug 2024 09:10:57 +0200
Message-Id: <20240820071100.211622-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
I added a cover letter to keep track of the changes between versions.
I feel the v3 is clear and clean.

Best regards,
Rick

Changes from v2:

- Removed duplicated code and simplified the patch.

https://lore.kernel.org/linux-pci/20240819120112.23563-1-rick.wertenbroek@gmail.com/

Changes from v1:

- Clarified the commit message.
- Clarified the error message in endpoint.

https://lore.kernel.org/linux-pci/20240806162756.607002-1-rick.wertenbroek@gmail.com/

Rick Wertenbroek (1):
  PCI: endpoint: pci-epf-test: Call pci_epf_test_raise_irq() on failed
    DMA check

 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1


