Return-Path: <linux-pci+bounces-24952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FFA74D2F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0591894EF9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B71C9B62;
	Fri, 28 Mar 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j47aPpmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790171C4A2D
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173631; cv=none; b=lFqju9UURXaWIMARoVKZuN62yccLYHEYD04Ln1pCCuKIfET+7cZ9SmTuj3t1dCWukFeIwpZMjKc5uu7ar7k6ABrgadr2cnK4zrhtVSiDRGqOJrrpbvvDioq2Weu6rh01kdUQ3W3gTqEkRCilrjRAEFneapwkhDcRkcWAgH7hWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173631; c=relaxed/simple;
	bh=h+SzrP+RZ8z9TwNW8IncYGnwYKmJ+Japqx/sQUvxAAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hx86J953XwBzuU7GbaIFOJ4xkv+NKEFILnOzhJBzdzCSdlN4PclN/B6/Ihz+Fck/0UmlN4UwS79Zy9LhZUHkQQoHN5rHH99jl1k3yJoom8sIjtvKyS9gs9nfNW3dDAqOC8KCOO2ZvxrvIZqN1mnCZ3kYYBQOQnrtoc1PlDWMu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j47aPpmg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso15736135e9.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743173628; x=1743778428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkLAt8PK2xSjKKwaEKAeZ6n8Ih4eyZAWH2VlHcJWcqY=;
        b=j47aPpmgTDSlW/QP9AD/JOqfES38bh6IHHFuddOQ4VffqIQSeOZ7RbzVDzwVl/wTHy
         /IlQL54XDwIFZ+I2Rc0VWZqeCKT55MsNAfNCpquoYGAQtT7ieEe2ykzdXKA4PjKd36mm
         RhmSIWWWGKNLMz5mDiJaShAem7rPXKli3MvouCeYmDE7jHcceBsFqfPyxRUST11s7/ZQ
         S8LUdbsoySw3EhTf8z6whrgZPheWdO/WoGzSEVUCeXf0V4Il6Sw/tiCdOcn6doPhOmVe
         o1QZ6D133CceGggSXDJ9910ZRffUZKuO8PJH46KLbCGddx2kyzN8slYN6KnW2tnlmJLS
         x2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173628; x=1743778428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkLAt8PK2xSjKKwaEKAeZ6n8Ih4eyZAWH2VlHcJWcqY=;
        b=XLWoYCU+V3GR1IwJE47RDS9eilsvjUaREzbYReHoKUVrjnHzf08op8zhZNJn936wLh
         pu3YnzD6PHvLhdIbvjisLrl+Dos543GuZT4Yn8iNqZQrBnyM4KbAFRF9RUa1GkgdnB1+
         VWYbTJch7nSp3TKlGswCFzAe0OH/aZNK17E0eNaKe+mMrXHL3CZZfLUjwPnIE10p5qly
         /H+2iu6zpJLShbm6JWTLllPabbBivSkGLToj2n05/sidrKDPSuzOOt+cp8Y4Wfc0nm6q
         DxvGQvVZa2vkTA8rPjR7xkOP3YdB0+lHG9AMdn34FH8QpHjPX95c/nfKD8i/onHUQcSK
         zEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9fU+Kq8B7bC7oy7d0kyb6zYPuqHD/r6g/Xs3cCuDEv3LNZhuGqyYA3NLmctYPDkzqJtJxlLm2SKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLy1mlQ8wsKXxmZUtP+Ug0QohPjL8VKIfOfmhHHuPw5qgB79l
	/RTHXFpzSjGsTqfzWgA2rRr/fu4b8PC+yPRDrNvZ3liyAUVIKxG4yT5GQ0DVRU4=
X-Gm-Gg: ASbGnctD3+YrQfmsqfJQjC2cDS8HsOv13LvsvhxlF0VecqL40hJaoDhJ2GRvgBlARvv
	VgBCNcxMdAkUaENeASy+JaHEUo5pvnu87bAcE35n8+jBS17Flf33OA0Mswvm9vQr6KXLiJxjEY/
	70UOvtSCf2Od0vQENERy/Pirr7kGd+kb0xyHK6D/1MbFGYbd31qhsBIjlJwDrIurcHkhhRNQNlQ
	+UzimUIr0Zf8jp2aHBB04B0WJbFYk7V7/8CpieaI5dm39uWYb+V4SRwmozTYnAE+GwVV5XgID27
	DNxkVX1A1UCnj/JYPwzSedGdMH3FbYldqo1v+L+iZjD7EhkKEN0u34ThYIo=
X-Google-Smtp-Source: AGHT+IGNCjgZ3Bl84aRncvmcRZ1fKqVabYX/8QK9ricPnQMRBg81uZzPmVzF9hh/OcpNiA/ptaZDaQ==
X-Received: by 2002:a05:600c:1e87:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-43d850fd4c6mr101061575e9.14.1743173627741;
        Fri, 28 Mar 2025 07:53:47 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8314e110sm75219615e9.39.2025.03.28.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:53:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] PCI: endpoint: space allocation fixups
Date: Fri, 28 Mar 2025 15:53:41 +0100
Message-Id: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPW35mcC/x3MQQqAIBBA0avIrBswQ7CuEi00pxooE42IorsnL
 d/i/wcyJaYMnXgg0cmZ91BQVwLGxYaZkH0xKKm0bJTBODJSxMw3oV15DhuFA1tvtFPGGakllDY
 mmvj6v/3wvh/So2qPZwAAAA==
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=h+SzrP+RZ8z9TwNW8IncYGnwYKmJ+Japqx/sQUvxAAk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rf3xAEcVhRALQDeCJiKrmyvwItNhXGCxC0ay
 wRo6Wa/OkiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+a39wAKCRDm/A8cN/La
 hdF0EACTpRUMvCU/wOvjdf1cqHznSt44zlfO+tSUZuOgT+NJzi949cAUHB1spKGFqF481MJtTDI
 NvdIZkR4YrTWFXbCxiUa+55YL5Y9gWG91c+lYVwp4q7BTqvbYDE48Iwvag/Zkbj5Nc2l9N0n1Ja
 Eg2xvUArK9CGvEhUoo9lzUeuprfo5OSpogtLvoyG1F5WQMLDAH1nUf+T+LzOFzLTbbVTMJwxbZG
 dnxgteTNrwqANTbxorv+b51/5pRbak3YvUtgRhrNWMKg6KkRAoZhfslTe+M+nyEfDxEdsCjXb4D
 TiTMOxpiTWFm8C1Cj88NwRpGyQvuoSGKGLFUa/gjfKGV0gAGtSsgfmLBl9kJfXy9Nr2T5nten++
 u9GEwtgnDspcBFCXEJTQUgQtL6jNUVi2UHjHepwVVMwP21kQS6hn516xUG06zSCDYc1dJ+yHb/F
 i4U7KqMK2s4PGb1EEsUV5CnCuDzy3J8+SJbOmqkwBLMjf2gKrMBbSVCJBykRqlDVgZVfpAdSt++
 OPBDXz3JJRwh1QkEnNMUtNw36DFF/wdimHclAqRD1BUytA0wbwVTRLVeeApOHMEPUQssFzafiRv
 tBQV5ijsPDBeNNC/XP6me9S/9MGr5xyCcgYzOVhQhvNuTixGb9+e7AhrAfjv/fZmWbz6zzu5kqA
 iAHkXA2b74vDOrg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      PCI: endpoint: strictly apply bar fixed size to allocate space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
 drivers/pci/endpoint/pci-epf-core.c           |  7 +++----
 2 files changed, 5 insertions(+), 26 deletions(-)
---
base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome


