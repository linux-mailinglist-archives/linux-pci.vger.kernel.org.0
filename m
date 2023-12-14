Return-Path: <linux-pci+bounces-947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F8812850
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675E61F21A03
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98DCA5C;
	Thu, 14 Dec 2023 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Obavcbfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD25B9
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 22:37:24 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58d956c8c38so4917868eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 22:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1702535844; x=1703140644; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ByMsI+TQi9NOnAmZv30hIBVObC1nPLx9Qj7duP4chNM=;
        b=ObavcbfyQbfE8jemvKgIfGrRI+91HnMmCxyE1adfJFdxRXzNxu7P2/BwV2rMc0Xhu5
         Gi/+zVbZgeL8D3lqpgl7runcUtjd8mg62JGh6cn+mmzBoFzbpBw5iHrMg81CsBF6OwHA
         15CsOq+YuX+x+N4EEfAywXzYBXYnISyO26WvD9MxGTlXloq5hlGQUrqO0yWn51adx+JC
         QutL2YTSdQh/p361TaSZViQec4W/z4s3T2fgQbqfpfn/FDd3aly02jmR6y47U7PMoI2y
         FTXaTjbDHAgsPbzW5eRtgpihngxYEII5T5OPLBHwBfa2+y2ormTQqhkoD8Vy940EPz4j
         3N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535844; x=1703140644;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByMsI+TQi9NOnAmZv30hIBVObC1nPLx9Qj7duP4chNM=;
        b=oHnStei0UXTg8kyv9ycFXnB4c0Jh0M6a1u7hiacCzXOfD2D5QEBj6V7CDTYJ4Aa3UC
         FGovjiJt5fEy7T+KMjwV84Cr/vzd0NoI5C3dM3Mpyyk4dspsp2aD77DP/+M0VEF6ApoT
         dopA9sj4nSj64d+mJWWideyZFejClZlIpxCvV0eEe4Oy4lOQ9serG/E0SheoVuGB3Vly
         8xNPKe5kl5qbTaD6UGizJJzjKV3pgahYTgwc4PQwH1Npy1lHqt4VHTz6NcIsngiYcuuL
         94tfVPeLMOo0fAvczboRj4IHae6s0hg2zXAqM+0gpmuy+tCNnGNjxNLB9xOiG3OLSBRf
         bR4w==
X-Gm-Message-State: AOJu0YzU3R0tfeNRPnBpbw7XywofD3A9lcEf2WrqjIGlHwFSk48BsLHi
	3AX1O08Blr2x5Iox+G7zEC9Ht/aKzfqSGm4M1t8=
X-Google-Smtp-Source: AGHT+IGDYgeMUV/OiBQYd+6hLIHIWc2eMQukN7gerceviPNB12bAQ2UKGqVe84ZOgh2+rdPXNyqT1A==
X-Received: by 2002:a4a:d28f:0:b0:590:e85:199c with SMTP id h15-20020a4ad28f000000b005900e85199cmr6792637oos.6.1702535844207;
        Wed, 13 Dec 2023 22:37:24 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3390878oof.22.2023.12.13.22.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:37:23 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports & RCECs
Date: Wed, 13 Dec 2023 23:37:17 -0700
Message-Id: <20231214063717.992-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
References: <20221210002922.1749403-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hello Any Interested

Recently found that this patch had the affect of requiring us to set
pcie_ports_dpc_native in order to use the kernel DPC driver with PCIe switch
downstream ports. The kernel check for the DPC capability in portdrv.c has;
if pci_aer_available() and (dpc-native or using AER port service driver on
the device). I wonder if we couldn't do away with the requirement of the
AER service being used on the port if pci_aer_available() & host->native_aer
don't lie. I'm still trying to decide exactly what the condition ought to
look like, but it might draw from the AER service check above it. For example:

        if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-           pci_aer_available() &&
-           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+           dev->aer_cap && pci_aer_available() &&
+           (pcie_ports_dpc_native || host->native_aer))
                services |= PCIE_PORT_SERVICE_DPC;

Thanks,
-Matt



