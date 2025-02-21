Return-Path: <linux-pci+bounces-22013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4BA3FD52
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97027A62B4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54EB2500B1;
	Fri, 21 Feb 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sD8XtQWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212A24E4CA
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158601; cv=none; b=GAa8/REaoP8bNpp0/i1yH9Blm4AZhiUwXHOXbeSbNec6uy86Hrc0NHRVnKfWYZgFIU1hojfEay0HUfv8hK+DC6V9RHEBqRTI3kvyT+70MwQzIvrX2/kZNqcjYM9xIYN//dcN/k85f8EksWI7ksDZmnmAW8hcYaqXm/avAM4sHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158601; c=relaxed/simple;
	bh=v4umuejnk/D3zo0ZfQeNhQtPg7rv/6gl7bzNW+Mvmew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOyRJ5f0g9NBc+pCMXvKxwI1XLTWH8NGKTXYEIguT/u0jEDF8pJFMRugF5LSpt+gR+UuBSrQMUw9s3yLc76cTyOM67xRrry9KD7jl/9AqQ3lRu4EuSRPI7vI99Cpzu30G3eaZ8EW6h4pWTpcizCNahcjqVskBoPph7VLNoBdXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sD8XtQWR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so54126585ad.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740158599; x=1740763399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAC237/i2ojW1+/RqYj3Hliw8hADl+1Y8oHlt264UNY=;
        b=sD8XtQWRDfOG7PdnJ8+GIluw7fyUI/fO7V6CXLU24CAYbsOCRVfHQ4m8iIrwm7zQs5
         jbz+6bzfFi2WwT5vuO3ATpJiiEd0/lsUCR2hfpsPK5y+EBO7qe4HAxuNwALl8Lui4j9N
         pselkXbJC8utrEZWA4aKAGbvTwmyZcDDfo7OIkBlmROyEWTrISKWsFCsPa7e6+tc7DEl
         KXc8HzrhsPx7Y/DNQ/TBrPC55KDNoLYrUdyn5FfDi2v3jzZTuBQU/zwaC/rFUfoSxkvm
         rGIsdprXC4KHZXGL4ci/gy+s2MKGRn9iwmyuBXYKK24ZikY8IBfbsWah/pwquETiM/IC
         vV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158599; x=1740763399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAC237/i2ojW1+/RqYj3Hliw8hADl+1Y8oHlt264UNY=;
        b=s+hySlY5vvSN7AjY/0scf2QAOKc6M2AAQzraZmXL4SnmWRz6TuV8xKlxTdKQ6R9uzv
         H7YEHJPMKlS2T7JyjKCgS6k9SW4AfvIzRXlHBbXjAsdGRHI3FX9EvKDA/M8EMF12fmGz
         /9kWXOuQzrAN1ys7axV5fu/MSKgCvBWfGbBBGiWCxL9AxYxCElpAbIdycJnuYOudAcyz
         IbF4eKFVPHjXGnnSlM3MpfB+U/yzMoR4DgM+CF+5qgB+UcHli7+UbhJFktWpWtt0ArsB
         DXNYZmezMn7pyNoJq4+qEf2O0BqkoINJR9KsV9l0olVMpM5uGCpAtnewX0AsALdJzFxe
         i6sw==
X-Gm-Message-State: AOJu0Yz62ovJP90ZqcUeaANkQkEm7LNvSvQIIvuqJZkGCPGsw2BU1Wkq
	5g9Ml4YORBPR/usQKELN+45z1RCgROXIsXrKcE9Z0pZrzlqEmwGfsN5tJFHi6w==
X-Gm-Gg: ASbGnct8ABxh3k0S8KFkISKE8vT1atZBCShIZ3KQk7/Bu2vSI2LoPjkibhYD0mfBxUE
	186RbT0J2DuGiYidKZ0+GxPvWX/UXnzIFEh8WjD54gUZcWGNQ9NI4IxoWooKZ/OFHSCXA8HJZ3a
	uk110E60kQ6nIJB3k1/5pumtsJTx8AKJzDbIuFxjfE5nHFa8RVgRQGSyX4FTEHU5XjURa862tTd
	Br4BOm4jAwu6+oW0FFgd/JhKskIshzEHs06oXahDojyPjP8X6iL3g3HLjQoLc/wsPdecfF9ROP8
	kENKy8k8eM9ZSPglwkBBBFCCcF/n9GQh9LdUw7ojDO4MZ9xTZ452
X-Google-Smtp-Source: AGHT+IHRjJdp1yc9JTT15Y3zMSAcEmsTgJkEW6HFHwdSfI5yIExfixz8/4XmLd1XnVTnm6VlmGZZ7Q==
X-Received: by 2002:a17:902:e88f:b0:21c:17b2:d345 with SMTP id d9443c01a7336-2219ff30cb1mr55376785ad.3.1740158598987;
        Fri, 21 Feb 2025 09:23:18 -0800 (PST)
Received: from localhost.localdomain ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm141243405ad.148.2025.02.21.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:23:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dingwei@marvell.com,
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: Add support for handling link down event from host bridge drivers
Date: Fri, 21 Feb 2025 22:53:07 +0530
Message-Id: <20250221172309.120009-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for handling the PCIe link down event from the host
bridge drivers. This series moves the link down event handling to the PCI core
(atleast the generic bits) to prevent the host bridge drivers from retraining
the link on the back of the PCI core as done in [1].

Also, the newly introduced callback 'pci_ops::retrain_link()' could be extended
to recover the bus in the case of errors in the future.

I've implemented the 'pci_ops::retrain_link()' callback in pcie-qcom driver as a
reference.

Testing
=======

This series is tested on Qcom RB5 and SA8775p Ride boards.

[1] https://lore.kernel.org/linux-pci/20241112064813.751736-1-jpatel2@marvell.com

Manivannan Sadhasivam (2):
  PCI: Add pci_host_bridge_handle_link_down() API to handle the PCI link
    down event
  PCI: qcom: Add support for retraining the link due to link down event

 drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++-
 drivers/pci/probe.c                    | 34 ++++++++++
 include/linux/pci.h                    |  2 +
 3 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.25.1


