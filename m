Return-Path: <linux-pci+bounces-1856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C47827BE1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 01:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518201C228B8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FE199;
	Tue,  9 Jan 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BDj3leBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E28191
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d40eec5e12so19387385ad.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1704759320; x=1705364120; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dsmhF/lEKaoDK06x3XxnA1iekFAy9HUSx/nXSrfXHaU=;
        b=BDj3leBzkx6Kqrd9GnHPB7cyQtmx3fzxIxikJwCW1gjLIrqcnA9l8Vvz/JZMLbHoTr
         qxsOzvTDPvJpvUcukhO+dK2zIq0d4KKL+LBRVHFkQ4/Rbz5PzWrZ3cx2LQvaq/z23bcl
         JtOOnKnE7+GqXyyYgV6ckU8XHDL21U3/+TQeDYzJbpdLZNhamEfa8jGVMrvQ0P4qtqsH
         U2E/6afXVHpTYTY8bBJTHs7dZlnC5RHatpPFc1Ug1GZYddtU8BjFfKozSaxVTb3/oZ65
         DRBUUsOz7pybW0Ge1Y3VQpODfCVCl7vpSBovBxuqSJkccTFWp80jVVzdpM2gvSxg1v24
         CIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704759320; x=1705364120;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsmhF/lEKaoDK06x3XxnA1iekFAy9HUSx/nXSrfXHaU=;
        b=Kjqq2C7s6jk2a45ONlbPwkgfRqilAk2mDuwJYupI1dpqTEj1h6VGHuenTXkb6fdbc6
         9t6Rp3pCEBlZg3qdIVSH7y9+M0Ib5uaDxYBrcYRjxma8d1BhzpcsobVsrlST7qhJbWV7
         aG+HVefSNsDvDpGZWPYKiWq86vWX1wlCXN3XlpcsqN69uGl6xro1JRD8QcQUAPtZoPbr
         WyBVkgKitBz7sdQy9eBowu+anTD+E3lu835oDBrU8vXk174l1PolMLO7J7hW2XXkOto0
         EScbLpTOUiE+nAFKpV2NNQhd54tQgJ3WdJJ4+4kfuz+Z0CQLZe+wmht1KkJnf5mTWvaO
         Fumw==
X-Gm-Message-State: AOJu0YyjB2UVAVjuMzSvT0/mhc/TDfgQwTDzPpWeZpJaIkrXbRFNBtJW
	PQvUspcVXcymkB9zYi+d+Y72OtmiRuDPCQ==
X-Google-Smtp-Source: AGHT+IEPIfCUbCtQrC8QSO8ekCOU05fss+/E27htpOT3JeJCRY0UfBSnwDcPe1IKsf9a9wLRNFlx1Q==
X-Received: by 2002:a17:902:a3c9:b0:1d4:3eb1:1e3 with SMTP id q9-20020a170902a3c900b001d43eb101e3mr4175690plb.13.1704759320123;
        Mon, 08 Jan 2024 16:15:20 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id v13-20020a170902e8cd00b001c407fac227sm470277plg.41.2024.01.08.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:15:19 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com,
	helgaas@kernel.org,
	kbusch@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Mon,  8 Jan 2024 17:15:08 -0700
Message-Id: <20240109001508.32359-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aac66e30-4b3f-4b08-83bd-d50472007212@linux.intel.com>
References: <aac66e30-4b3f-4b08-83bd-d50472007212@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

A small part is probably historical; we've been using DPC on PCIe switches
since before there was any EDR support in the kernel. It looks like there
was a PCIe DPC ECN as early as Feb 2012, but this EDR/DPC fw ECN didn't come in
till Jan 2019 & kernel support for ECN was even later. Its not immediately
clear I would want to use EDR in my newer architecures & then there are also
the older architecures still requiring support. When I submitted this patch I
came at it with the approach of trying to keep the old behavior & still support
the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to change
the behavior for both root ports & switch ports, requiring them to set
_OSC Control Field bit 7 (DPC) and _OSC Support Field bit 7 (EDR) or a kernel
command line value. I think no matter what, we want to ensure that PCIe Root
Ports and PCIe switches arrive at the same policy here.

Should we consider CONFIG_PCIEAER or CONFIG_PCIEDPC as any amount of directive
for the OS to use AER/DPC? In addition we have kernel command line arguments
for pcieports=(compat/native/dpc-native) and pci=noaer. There are perhaps some
others I'm not aware of. Then, there are the PCIe capabilities of the devies
& bios settings for AER FW/OS controls, etc. I'm not sure if it strikes me as the
right thing to now require users to specify additional fields to use DPC when
they had been using it happily before.

Perhaps the condition should be:
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -           pci_aer_available() &&
> -           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +           pci_aer_available() && (pcie_ports_dpc_native ||
> +           (host->native_aer && !IS_ENABLED(CONFIG_PCIE_EDR))))

i.e: Use DPC if we set the command line argument or use DPC if we are are using
EDR's _OSC DPC field, or use DPC if we have AER & there isn't EDR support?

