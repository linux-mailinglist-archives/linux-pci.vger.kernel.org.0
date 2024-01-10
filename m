Return-Path: <linux-pci+bounces-2009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B203282A1A4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E6B21A3C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4DA4E1D3;
	Wed, 10 Jan 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gGF4XW4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9D4D5AF
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d542701796so23600735ad.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1704916776; x=1705521576; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/0lv4AI2otwOhf0YWXAf3zw3NIfoMrE5DRtJbvILGQk=;
        b=gGF4XW4cfDpbQBjz9VqTDSQ3YfGuaUJk0l7rOHEJBC/jb7lwv9tJp+IUqnV46LKYPj
         YxgpNsKRN/cIx1x89JxpD7S/Dq2xHsvKwjhPoQ8Wz52QMShi9/5zc8QyUyib6D+nAmD4
         Ei7srreO/P9IErIjwnIV/5m0tRm79aDJAK/sfFBD3Wn5lyg1PlOqyOTtUCe3EWV9yhUz
         SNdrvs9qDotWQKCfewDN3tt3ungd/t9h/0HEZYnd+17I4es7nWePurvz3w3Rt2xGZ8AI
         iaeE858iWmLduqxdpw20XkbrM7PAbh4kgsfYrRkwvcmZkjcM1ulmHG3uBxKiRvUUFIiz
         7/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916776; x=1705521576;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0lv4AI2otwOhf0YWXAf3zw3NIfoMrE5DRtJbvILGQk=;
        b=e9VWhCAk7hnzSq2aeEH34x5spM4P/ms4pdLqg44l6y9v/VBD0e69eRu+M8mD/7Ds4P
         /eFkhPUuTa80Tr5JXFO6nET4niR53Ulj7Pdb0gMYzA1t/3Ymd2PoUpYAZ4hc3FafkyvZ
         VGKdLfxeDCQtNHZ230Nh85hLHS3Z+9CssTTOvYDjYE2YMqyfyv5IAw6PApZPaTzeiVvr
         io0C170BDkREYbiEcvVjncKdeyjOPApIphBAx3NgZ33bLlmhtXR/0iG0B2g7bTW+SuUx
         yggcFqozlnpRjMkN00oCa58lUUj4o2nzZDLsJ3DzgvUaZVQs2w6BQe9QqaYEcoZNn8lt
         b6UQ==
X-Gm-Message-State: AOJu0YyASYVsrnD2HfcQhecvWm0M5wACVi7M3p10fFlcOjJAnH6yY2uB
	7JJ3MEU+8iSEQ6ssmjRNss99hHrOH2Asiw==
X-Google-Smtp-Source: AGHT+IEFwnyqHwEKQy4YPReV8jjF3UWURbJ0awmG6Eybzcdb0QLRmTT87wkMLNkwqawFINt+dEmYlw==
X-Received: by 2002:a17:902:d58d:b0:1d0:c5f8:22d3 with SMTP id k13-20020a170902d58d00b001d0c5f822d3mr78297plh.10.1704916776228;
        Wed, 10 Jan 2024 11:59:36 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id p1-20020a1709026b8100b001d50ca466e5sm4019499plk.133.2024.01.10.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:59:35 -0800 (PST)
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
Date: Wed, 10 Jan 2024 12:59:29 -0700
Message-Id: <20240110195929.5775-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <65c81900-cec6-4d3a-b2fe-bb8169ee701c@linux.intel.com>
References: <65c81900-cec6-4d3a-b2fe-bb8169ee701c@linux.intel.com>
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


