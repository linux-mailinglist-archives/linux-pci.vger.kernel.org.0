Return-Path: <linux-pci+bounces-2725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEDF8408C5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59091F2254E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56952151CFB;
	Mon, 29 Jan 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUgKrzI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52965BCB
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539297; cv=none; b=rkkylqmAFPc4JPNsGMERh9o1yWESIqNLOuQbDHNquqrWpZVZcSrky8WvD3OAXceN80nSnhgkv0VNXlcYbdFm0mkWphPkDXfs4h/jFkHB+y6zG8VhxYaIjrhqNEx1YjfALAdngA9xu89FOGflPAEhPQTC38yGos4Vi4cnhBd+//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539297; c=relaxed/simple;
	bh=YmUnaTwJOUF+5HG/UU6LIU+Dr1N5LPeDWxSA+o1/Oxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ncATSg7et80YwhWyzeYDPRjVuZ9HmK/fO692EZSjHQLmS5GMwmA5iLL9B+rUDPYdgJvJCwH4PSTiCXmsSWzkNXfAwWdTAQcdel5gz+d1Hi503p89IVuN8gW44xju2bXoDq+0KdWcrU1TPdTvW7j951sisr6K7iwckU8/KdvGq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUgKrzI1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso1144547a12.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706539293; x=1707144093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfCVaGYCNuqKIo4TvINYQmKbbbpUP4GXnpGkxglu05Q=;
        b=rUgKrzI1lBaWQHdFssShZUIkqnoNP5zMoZpW96WiDf3AcBcgQ80ufFPa0F41y9THP3
         c4Qa6n6oIkyAgtyMp3LvwvWhB0v4+dpniqVj/2QcCrqxEGyXt5Lk9DqCRoBEyuRiaV6a
         cNNd1EIuKE0m3xbkPk7lozQvOXxCLLv45XoiQ6kDznXwvQZ4IBxeyuyp20rrMzxevhGn
         yi0l2lyhlMwELFEEQOYZQhm3w4zoNQqlTNlu2cNQ4r6q3OrRdmo0CHhjohRU/sKv4+6q
         HK4oPDC93xYB8uxXyRXMqzyp0AepOp1dwFG+7B20kqYbJoJBkevj7Sm3lOAPwfRbi24K
         TA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706539293; x=1707144093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfCVaGYCNuqKIo4TvINYQmKbbbpUP4GXnpGkxglu05Q=;
        b=Ef7pvifYZJZwzoS+mWtdAMSu5brzLa0vEG/dWGW2KQpYV3UNhHoGXUkC+zopX90FFp
         XsZrm5CQAosaBNBOpjafBDdBgLfe13+K3GzCw8SWGh+7VVqqCqMfn7YpUWSJse5eL0L0
         LiBaJXw2wcXhdyRzsegSsqaTL6DBBL0WDSe39qJ3bXo7O8b50x/XXP+7pka0BVUC0Z8N
         od7w5JpMo0XPGwvx+fstrK5pt5Ho3Je6S94GEZANuVbSLfKCI4nRI/VrZ2/LVX46fhBK
         cpPJsaKY0uhzuqWJ3ck+B6YLl8AhFPBSn/kFEh4VCzXYuZwLDy5ZQhCuVXiDRLsQaPlt
         AfOw==
X-Gm-Message-State: AOJu0YyalZCYbQbmDcJIg7cw0Eo517NV0BHeLfyh0+UfypDro+BK1qnF
	Ry8qWkyc++dWH95Vfcm5aHUz3ecowEWIen4Jm21vOJYdm1ji5La9blFCQM2N8t0=
X-Google-Smtp-Source: AGHT+IEqOlwRTopVXq5z3xdY2ou7VYl/rLsBVDmB1sqMwPUY2WReRnfiyBB9wqZ5IHfTP5Nt4B63hw==
X-Received: by 2002:a05:6402:35c2:b0:55d:2447:844f with SMTP id z2-20020a05640235c200b0055d2447844fmr5932955edc.26.1706539293650;
        Mon, 29 Jan 2024 06:41:33 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id em2-20020a056402364200b0055ec051ab49sm2548415edb.6.2024.01.29.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:41:33 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RESEND v2 0/2] PCI: qcom: Add PCIe support for X1E80100
Date: Mon, 29 Jan 2024 16:41:18 +0200
Message-Id: <20240129-x1e80100-pci-v2-0-5751ab805483@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA65t2UC/32NsQ6CMBRFf4V09pn3KhRwcpDVQUfj0MJDmpBiW
 iUYwr/bsLE43ntz7plFYG85iGMyC8+jDXZwMchdIupOuyeDbWIWEuWBJBJMxAUSIrxqC3zQTUl
 ZYYxMRUSMDgzGa1d3EXKfvo/ly3Nrp9VxF9fqVl3O4hH7zob34L+reqR1jZYUSZZby0hAwG3T5
 llR5orx1Fun/bAf/HN9GuU/WgKCTpVqCFWRGbWhl2X5AS36+2IEAQAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=YmUnaTwJOUF+5HG/UU6LIU+Dr1N5LPeDWxSA+o1/Oxk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt7kVcX1dmHcCcX4dItcbzvHLDzbeDraL9WIA7
 CozxP8qOjOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbe5FQAKCRAbX0TJAJUV
 VpzIEACF/NC1QizFmhsMb7TV3UCRTYP3/cArb81+0X5ilyC1CS/Vawvyo7uu1waeyXnGa5GRaer
 9UtnnBbAlIMryQUWI7uRmhLHQpAtmM+zxJVC6JSxp35HOKaCCRi5TtNNyvbhx4v742tGGGS1e0k
 EARqsDhTbbGBPyKbAEODdv3czzYDdZfMElUK5qXab6IZnpKiMyep8KcWGcqEIGL87+lPoQmchDK
 WXIjGn+4z9juNsQ0UKGap86m5Gs9yUOv/7hq2STOyqq6c4ntT4CfreWhA3yEwQ+sIAgn7heo8S6
 4BVSN7j8Z9VfmWSACaBwW8StK+JfmZPDE9a/2AxwPm017gf75lujNdN0dphUqH5naDmE6h1kxKq
 rp39dD3h6WMnCdcfo/sVaHvchyeqoIgdQg46GGQU15LOPFpH01ucQANBUPJ1HdFBYaxldCaLwyl
 poU73tqjlIrdPzve3r8GtRXRpaXu2n4idDVtc6NNYD4WtBQazhTTXehiXQz1lGylv8TVYMzImC0
 mZWeNrl/B3qME4cNwQT61gYjezdIVDu2mavjGW65AJHcBoK1g5xYcXOasJZ4KzSjc/Dr+dV5fmh
 LE82O1o3BZheSvTveOyDPzVUTK47AhBpNhPY8DzYm9MYCTKsLScM5ezvDmSG9NRfXBj3gW+DeQO
 qD2vHQKEvAlaXIw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add support for PCIe controllers found on X1E80100 platform.

Re-sent due to CC list not properly fetched.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes in v2:
- Documented the compatible
- Link to v1: https://lore.kernel.org/r/20240129-x1e80100-pci-v1-1-efdf758976e0@linaro.org

---
Abel Vesa (2):
      dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller
      PCI: qcom: Add X1E80100 PCIe support

 .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |  1 +
 2 files changed, 30 insertions(+)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20231201-x1e80100-pci-e3ad9158bb24

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


