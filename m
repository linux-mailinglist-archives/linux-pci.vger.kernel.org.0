Return-Path: <linux-pci+bounces-7723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876568CB2ED
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 19:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAB228271A
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732922EF5;
	Tue, 21 May 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6on3Zj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A0D299;
	Tue, 21 May 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312895; cv=none; b=Jr/q2sRz/DYdChVgcnjro6Y1rPk4MYW/4jKjtRpBOjUyGN2uUYBmzn4G8RKL3zjCrOOsZWZV/WfAnU3e6RTIdKtSgUyrQjNE1X/LseJoSTW675ID9kCS4LmvF2cQTFGRWe3JyzipQb08xYxzdpV1dh7ZcgC3wVSFkdKN7tkkuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312895; c=relaxed/simple;
	bh=c2kHZM/T9HIIiKdVJZ1uKyZ5IQfEUIzPgC9/2aeKNBY=;
	h=From:Content-Type:Mime-Version:Subject:Date:Message-Id:Cc:To; b=gYLqQstNoQzFrGK8bflYICGSt6cuYorutMHioIVzNOcSfRujJksoBKg9yY/ESqTEqYeatSphtJXKUWY8E1H1xRO8Fi3PTBghzfe9O1G0GgqscYIGGZhsNfaXOq4Dr4LLIAM84p//YVxE5d+bJMUxaJXCAtcG+j86xI81/wbiuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6on3Zj1; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9cc681ee4so2000402b6e.0;
        Tue, 21 May 2024 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716312893; x=1716917693; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atIYRDSM21wXH5p/I8X6KQp3p9fC4TApzoZBDsjakTA=;
        b=U6on3Zj1tJ1wt5NK70RZBjFWCEOSDOuVWQVExSwZ6xehop26FsF31QeVyKlzJyj94I
         z3quR9v26YH7HQPajaOMKcP+3lzbG9ifO3nrsrUpor5EEFARUIbLq5yQwQL+mg7KIxtX
         LOs+GyBCLGPMDABAwTkun9MfnFe0LACG1bLBzAxYw0up6EIfEETxx+hxRHs0QXi82MvW
         kIhOqiT7+qq9u2f3//VbFJaH+zj8tuHXhKGUJpHn9rFEy3FNW0itTrmiNF81qCBrpTpy
         zSN3HcB+2LVlD0XAt5xEAPG1d0tzCtTMkaWNERXO4PhPpLfs9+XXIQwJKjeSXhpTb4wj
         Vw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312893; x=1716917693;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atIYRDSM21wXH5p/I8X6KQp3p9fC4TApzoZBDsjakTA=;
        b=Y7JmXJ2apTk6QLDpA0WQuT7bmlJrW7/mbnGdwv/hSZpzNxLR9T3OFfuBmhybpprrXb
         WCt5245g0znaNHgKBE7lG78X5fZcdH2uxybQYAHvk9t+AW2PGeybEnFEJA00pYlXlf3n
         j/gQ+hz5+sAXDYIqax3ZeyV03nT0gzQ1TOHUsvGHgmzSrSLqrdWaBOrqluNDXyqGqjjG
         lSC6rHNoHcKt2WgX/WYPi1TAg+i/x0ZiXmsDygnMQ/nKm3vK/aW7hFoszcESJooyfQTY
         +APHUXib8JZ34XKLBlJIc7VHQe+lXYUG41K82GXb+2VH2UsZg7vuL4RqM5p062t+abCH
         slgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD+z9Pxs/lZLRRT3cwzJvOrR2PR+rzyrXgPYt59pFAmmRQPfrMtVdiIpaIMkCtAgvvVuTebClJ8AziZHDZ05CNI4ZNDD27F966W0F2uKtL4ZJq7Mc7+w2CBCIJDG5K52cw1US+
X-Gm-Message-State: AOJu0YxU6ISWRgCOlG7baF3SC7NHY3yeiiDYiIP3S1L0pisfI7//nmRE
	1GFEqVwSCQB13uV8GbrMdL9bjb/xxjHje0GeyBiTcIyCe2+CLiXn
X-Google-Smtp-Source: AGHT+IFQmVQY/9McfRKqvZc+lBX3PE4Ev6TXuv5DQIQq8Q/CfzZxzDGp45KhjGP3DEAbo407EIui6g==
X-Received: by 2002:a05:6808:3c6:b0:3c9:60a3:dfb1 with SMTP id 5614622812f47-3c9970492dfmr33309724b6e.21.1716312892665;
        Tue, 21 May 2024 10:34:52 -0700 (PDT)
Received: from smtpclient.apple ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3cab1e41394sm810802b6e.55.2024.05.21.10.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 10:34:52 -0700 (PDT)
From: Vishal Aslot <os.vaslot@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Reply-To: 20240325235914.1897647-3-dave.jiang@intel.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Date: Tue, 21 May 2024 12:34:40 -0500
Message-Id: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
Cc: Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com,
 bhelgaas@google.com,
 dan.j.williams@intel.com,
 dave@stgolabs.net,
 ira.weiny@intel.com,
 linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org,
 lukas@wunner.de,
 vishal.l.verma@intel.com,
 Vikram Sethi <vikramsethi@gmail.com>
To: dave.jiang@intel.com
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi,
       For T2 and T3 persistent memory devices, wouldn=E2=80=99t we also =
need a way to trigger device cache flush and then disable out of =
cxl_reest_bus_function()?
       CXL Spec 3.1 (Aug =E2=80=9923), Section 9.3 which refers to =
system reset flow has RESETPREP VDMs to trigger device cache flush, put =
memory in safe state, etc. These devices would benefit from this in case =
of SBR as well, but it is root port specific so may be an ACPI method =
could be involved out of cxl_reset_bus_function()?

-Vishal=

