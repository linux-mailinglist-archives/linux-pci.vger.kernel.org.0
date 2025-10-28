Return-Path: <linux-pci+bounces-39575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20080C16CCB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81543A5554
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7834B674;
	Tue, 28 Oct 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RHtI7kSO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97006346E50
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683707; cv=none; b=gjlNLzl4UTNpX5QarHZaHkzTa8lIzqwGTw8x6Uju8hrRBCKLSz+He4l1hRYk45+LdKmBQsBhDRZscgJE0dl5ppHy6u7GMqwRZR0E/sahReotIGJfrdZmNzlfnqZTebkb6OT65nasEpjUu+t122wfL5Rl1I4XK4kba6z8jZjSV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683707; c=relaxed/simple;
	bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiTTjbkDF9w0IWnIrLYg4owb4SMI1cNn1vfH05OAAh6YOu7obGU4TafevvCxbpHZrlaiTkpZaXACwx7+SGfbXf7XdbL/DRWZl+0hzAjAEEr12zannAdIcM47rWYA0xeVikjifErClViHZWkkJNsa76CohxNPaPSf3+Uc6tQqgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RHtI7kSO; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-77f5d497692so7843048b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683703; x=1762288503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
        b=dTGIl8W4wdlmfQ9TkYnDeUM2JszBEvH6vNf9J8uWcoE6JtkZyGqDc1lOVucauPetfq
         sAQtbbEZm9Ru+8lXezhf9d6Z/Kps0m81ZNjvaiD/7J1sUTdrWNDUwJdrnD0A6jdxe4DR
         N9jJQ3FHNiLOQGw8Rs73ySUj0EnlRCV0XsUVqQC1ELczXvxBam/ru/fQ7wIcBSew8Qm8
         5TcFzlDa6dk7V3Jc5opu7vNM9kryANEp8mzF0Sz12vV7SlCciRgXBeHwpnrdroI1iWGk
         6/FaDJEcwpYy3hL6cizZj4XQpvo1BLp1NtaeQ4atrKA7w7su+CbmmN9z9jCrJIbnu7lq
         JKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKXnLaX1/L0//ndb0v/H4ra24D7mnWW1NR1u+F7ONO9F5cIIdaS6jMbnd+CA9rdyJcpgu3SANVQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQ/aiJHTsjVwFVkrD6Z28isw/sHsZ+Y5cOpIPc+BjAw31+w8j
	+bN8vHUnDxAalu6VQBcITk80PDcTi9jYSZcQ2qxJjUxqiAo0fYr79hwzHrpXQNcT0NY1sIJccmM
	3k9FdyQ1Su+estYuDyM1lHoXWQxaC61WLKZqPc85bkcOQVRkNoATKae1Lmh1wPhT5As4O+hlb3O
	MlgHf33MqMXF0dfgNVQeRDYhd4uCB0fw7TFdlWU7usqHpU/HULs7K8e4xe3Vylg7ubD14SX8UDO
	uq3fSBlxVA0HynX
X-Gm-Gg: ASbGncvH8YDCLl2EOYPL4VSu0okyDMmxvWKkhqGnSSY+OoMaJPVWZcDo4qRANKYMwDB
	DpkJ5puMREGXG5Tm/xhsPQNctUITuX6rV36oGNXNRFR4j+mtvdZ0ccw7oQ+4IWkle39PPzLIhOS
	NcUBBjZbiLughB0i9hI/+vLGAuIpm8BjUwhDK8VOzKRfACf9qNtRpGYK1Af10h/ZnkI/n8mQICy
	HeMBYsFxocI7AjKbb9gIejxNawGKm2ZqFEb5EbH3APdOO8qEcTd7By83dabtovZMwLqAp+7/Lhf
	cmJ49PGPqmfCGqcuOZX8lYd0J1/4Nj2DTJSpEms93TrkBdUUVgL6Z3PYjwGcxqfQNAOkPTvp2vW
	WB14qhYNBzf6aM6fYetD7HmyNnvwyG0D624hS0fhQCD/+LJpdXhBACc3+Q5r28Nq1crXLmjYhJ3
	1USuKspGUdhLeDfHCFftw+0bq1d1rbupxv+8Pnlw==
X-Google-Smtp-Source: AGHT+IG39Q5doA8rRbQ1Ho+JusGmdip4/70gCRMXZo/zYF0+DbofTnt/SsI2AalEAjIx1MhYuPKXapcNVHP2
X-Received: by 2002:a05:6a00:2d0b:b0:7a2:8106:7a0f with SMTP id d2e1a72fcca58-7a4e00013c5mr554368b3a.0.1761683702830;
        Tue, 28 Oct 2025 13:35:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7a41409e120sm758676b3a.6.2025.10.28.13.35.02
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:35:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a3d0fb09so97028821cf.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761683701; x=1762288501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
        b=RHtI7kSOLj+djjtMHIFd/GAgbZmOd5bElX+mEe2dO+PHjX7hl5mtRCuCMieQP0q7Om
         iXSEPsmX1eEsFXgwo1Hkk/CyzIsKw4omNOrGMJ4m9zSHphwOSKC8BMsaz0Z1qJHvzXxs
         YvhYlOQl9aEINzYBi0tVxhtCYcXEFr2xPLl5Q=
X-Forwarded-Encrypted: i=1; AJvYcCX+sni4yok2NHbsZD4t3OLT3tmwzjubdS1dVNTMxmQfH7+vI3NYWH6On1TgqMxat1EPb0DgkoNgxWY=@vger.kernel.org
X-Received: by 2002:ac8:58c8:0:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed15b7605dmr7331911cf.34.1761683701340;
        Tue, 28 Oct 2025 13:35:01 -0700 (PDT)
X-Received: by 2002:ac8:58c8:0:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed15b7605dmr7331641cf.34.1761683700947;
        Tue, 28 Oct 2025 13:35:00 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49c5e8esm86789936d6.55.2025.10.28.13.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:35:00 -0700 (PDT)
Message-ID: <78fda7e9-5134-4f75-9ac4-a4918878ad48@broadcom.com>
Date: Tue, 28 Oct 2025 16:34:59 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler
 to driver
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
 <20251003195607.2009785-3-james.quinlan@broadcom.com>
 <7efe5f81-aaa7-45b3-97d0-469ffeb35e5f@oracle.com>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <7efe5f81-aaa7-45b3-97d0-469ffeb35e5f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/4/25 01:06, ALOK TIWARI wrote:
>
>
> On 10/4/2025 1:26 AM, Jim Quinlan wrote:
>> +#define PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK        0x20
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK    0x10
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK    0x4
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK    0x2
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK    0x1
>
> typo __MASK -> _MASK

ack.


Jim Quinlan

>
>> +#define PCIE_OUTB_ERR_MEM_ADDR_LO            0x6018
>> +#define PCIE_OUTB_ERR_MEM_ADDR_HI            0x601c
>> +#define PCIE_OUTB_ERR_MEM_CAUSE                0x6020
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK        0x40
>
>
> Thanks,
> Alok



