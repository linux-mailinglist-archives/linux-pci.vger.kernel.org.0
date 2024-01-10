Return-Path: <linux-pci+bounces-2010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56EA82A1A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 21:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8294E2826D7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D94D5AF;
	Wed, 10 Jan 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="V6ZEraV6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E34CB44
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3ec3db764so18518785ad.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1704916898; x=1705521698; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/0lv4AI2otwOhf0YWXAf3zw3NIfoMrE5DRtJbvILGQk=;
        b=V6ZEraV6AJT6H4A6Gr3NJAb22GFGQ0jX6GffVZXuBzoLmRhNb2yCYEIehtJ+dUb0nO
         03JO4kINKG+oXadptEQx1HajVoOdLb1xxRMrsF16lMEcrkeqWM/EorFZigD2waIXLGda
         qQz/z/nNLM69Il2C2DiLIv9KJbSJ2GFhUXEdcaaSCM79sDrgmXiM5F31+HMc+eQbXm3v
         8PbvnfIeM603SiuL745gu044QNRQDIH3aL3ziL48l9rHzIxrR1Lqdve+dQsmmqDUaDXf
         iAfMrDYPU6PvvghN63coIaqhbTSKBtDTFzp/Vl0vpjrsWdq16XyqAA+VvEP8tWn0SpHL
         tPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916898; x=1705521698;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0lv4AI2otwOhf0YWXAf3zw3NIfoMrE5DRtJbvILGQk=;
        b=wBKGOmp0RkOaN6eEqDba7oqUQK8GcgvlOY5KCYPEmLzZEt12kjI3WdULwqfXGARrp1
         HYdz2DaaqflKwz1MGzsAhSZEVK22MS+hOIYTi5KOyBHvh2lFrC1K+Lk3or2v1Nw+Jesy
         NNu0jFI/M6d/TsL/VNtZsPiwsnGNRU3vP+f9Apj2DaFYICzPWy78QUump0GsfcirSRra
         /avFqPhdGSsLKEHqXxWdQ1O7gioorh6V8RfvVECVX5MQecxY/vz12EaYQ/lBD5nA2HKY
         nm1iosbZd+xYhtmv8JQrWkSPPhtb7QGlDttoFG67l3/RD8p7ENNYXCf64QwSRVDhH4gR
         TUeQ==
X-Gm-Message-State: AOJu0Ywo4V8h8oi4BNAWZtGNeivFYv+QlXjuTnBjHObezAgCZOzJnTXf
	5y0N7Zn4xTs8ynH1yruk85nSohqbt4lHPQ==
X-Google-Smtp-Source: AGHT+IHHZJX3kD9aPy8hH9OcP3Ut9ClHlOldNAMIMTukZ8wBgz3RDM0eHGoHxoBftnlZq6lN/PlGyw==
X-Received: by 2002:a17:902:f7c1:b0:1d4:458:7aa8 with SMTP id h1-20020a170902f7c100b001d404587aa8mr62293plw.30.1704916897736;
        Wed, 10 Jan 2024 12:01:37 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id f12-20020a170902ab8c00b001d3bf27000csm4048463plr.293.2024.01.10.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:01:37 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com,
	helgaas@kernel.org,
	kbusch@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively
Date: Wed, 10 Jan 2024 13:01:31 -0700
Message-Id: <20240110200131.5825-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com>
References: <3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

On 1/10/2024 8:41 AM, Kuppuswamy Sathyanarayanan wrote:
> Since your kernel has EDR source support, why not enable
> the relevant config? or did I not understand the issue correctly?

As I had said we never intend to use EDR or firmware controlled DPC. Why should
I have to build in more code that I wouldn't use? I'm not sure that we're
both using the same lense to consider how & whether _OSC DPC Control supports
the old world of DPC. i.e OS never required firmware's permission to control
DPC & it was not tied to EDR. I wish I had been working in this area at the
time they were drafting the 2019 FW ECN then I might have known to try & influence
its details.

I think the first & primary problem for the kernel here is not treating root
ports & switch ports the same when deciding to use DPC. I would like to hear
from Bjorn first, but I guess I could be open to just relying on the cli
pcie_ports=dpc-native field if there is reason for the kernel to only support
the latest additions of the PCIe FW DPC ECN by default. In this case the patch
would look as the one in Bjorns response on Dec 28 2023 at 1:23PM, included
again below. We may find others who are using Root Port DPC now needing to
change their config to support EDR or use the cli pcie_ports=dpc-native as
a result however.

If this is the route that makes the most sense, I can update my patch & resubmit
as below if that is ok. Perhaps there might also be some docs/notes to be created
around all of this.

-Matt

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..423dadd6727e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -262,7 +262,7 @@ static int get_port_device_capability(struct pci_dev *dev)
         */
        if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
            pci_aer_available() &&
-           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+           (pcie_ports_dpc_native || host->native_dpc))


