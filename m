Return-Path: <linux-pci+bounces-7544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B528C70F8
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 06:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7601F23CB8
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 04:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A6F9CF;
	Thu, 16 May 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="LB4+TNRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840904411
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834336; cv=none; b=cYDyxKSeTNuR3RWGGJ3610FGD+E3q/mcNPcY448KwfOpQb8h3gp81//w7yqclOEosHJ48+KfxqMyVCQI+9E75G/NLgNx21flWDvC//oayyFUy6F6wBsknhbZz4x+8f7hiv5P+dUvXHXDGN1dKeCLXBznM1NW3+SpglzB3P4PJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834336; c=relaxed/simple;
	bh=qHoOUwREVTq9/fjODXT75Tx6BX8vUTTA9jwGJM7RRYA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=obN5qcz+kGc2YewsVeNDfsHi1KvRw/Se3kIpYIRrEKYZaFdfgfvQ1feN9aeqqe1AGEq4gVzeb5YX8KSd3PjP85P24c1BB02i14CXcfEZkN6+iASndCBw7LqwqvUEcO8jaVhxDICA1UI1T/GzKN6Cp4O4JLZ9EAFXfkXrDmy1G7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=LB4+TNRt; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f74cca5a2bso2563750241.3
        for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 21:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1715834333; x=1716439133; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/nCfgLAV7XtKqCLdjeyN0oC9NfV4F1u8+7J5GLS4xk=;
        b=LB4+TNRtU+0RIpH3ykLwWB4fCMpidoZGwYXaEdlC4Du/Jipq5NqyADGwNJ8qRXYUFE
         qPkx75hRe3T0X4P9Y9DCHNhX4FQvzLlJC2/5JIV0+YuHwkqgoAi4nhTZVU4G6hsmXKTd
         a3DEkn13EmqlHWhIk7+Deffa7y+VVZd3HPAJ0HjIAGpg86z/2IDiwHKJAjtmT72rf0Tw
         skk6jkbKADFpZg1m4Kp0Hrb2t4vpVb7LhnCyce0+AZ4tVqQKFZT0JgaA4dKd7HLdZRor
         AYv4zN84lrWAGwDfGuCBFzL/RNKd2owas8h1h9h9BQE1zF3eTCA4552akUbQxi6aIGlX
         djHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834333; x=1716439133;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/nCfgLAV7XtKqCLdjeyN0oC9NfV4F1u8+7J5GLS4xk=;
        b=rgomt5LWkNRA5w3dqYlbNnExcXXNiE6ap8KSbMJfAkZY5xaZBqcA1/qN0Kzd2I4ZTa
         +VDw+p30f8vX//l5d80k1OIczZP+I1FFNsHKmkSKvCtqBC2o7qFx/wwTpTuaOJd9E1Rg
         92j42D0RKZPmSWKXJQXsZ741veE6h77H4R5oDSRmb0lwW7E8ipRWI1g2+kAcLD+JJvYC
         hY8ud0hnVjJbTvugq6TPH2TQ/mWn2btXqBaG9zxXhwxL9WBjt9xaIrHO9S4B39ovXCvJ
         lYWF2dSwu7tds/ZMc3Or6xm+q8sar6TGw6cw5jzLiueCO8AbNdH51G+WSmzYwB5LsFf8
         Pg2A==
X-Gm-Message-State: AOJu0YzTMPQhkpykxVr2SoAK7XMNQ+ARFLekxX7OJ0mZ6QQ9NdDuhX3R
	oGVLZsyghIqFfTVAi9unJJUeCBPJXXYDpIWATOSaJCYWPuzRHHPm5GkevtKUnogPd6S08lAnfhf
	Vx8svuXwoWZB0W/EI1LML19DJLcGPTbNvlX8cKAc1nge+K5YML6g=
X-Google-Smtp-Source: AGHT+IEsoVJK0J430lXFuzp1LZ9ypq47J+pgsT1lINC+p6B4b1zx1YvC/VwZwOSerGcfKTs8hUNWcdHIWNKAkkl1rio=
X-Received: by 2002:a05:6102:c88:b0:480:77c8:8d96 with SMTP id
 ada2fe7eead31-48077ddcf74mr19011646137.5.1715834331626; Wed, 15 May 2024
 21:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shunsuke Mie <mie@igel.co.jp>
Date: Thu, 16 May 2024 13:38:40 +0900
Message-ID: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
Subject: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi virtio folks,

I'm writing to discuss finding a workaround with Virtio drivers and legacy
devices with limited memory access.

# Background
The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
indicate devices requiring restricted memory access or IOMMU translation. This
feature bit resides at position 33 in the 64-bit Features register on modern
interfaces. When the linux virtio driver finds the flag, the driver uses DMA
API that handles to use of appropriate memory.

# Problem
However, legacy devices only have a 32-bit register for the features bits.
Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
result, legacy devices with restricted memory access cannot function
properly[1]. This is a legacy spec issue, but I'd like to find a workaround.

# Proposed Solutions
I know these are not ideal, but I propose the following solution.
Driver-side:
    - Implement special handling similar to xen_domain.
In xen_domain, linux virtio driver enables to use the DMA API.
    - Introduce a CONFIG option to adjust the DMA API behavior.
Device-side:
Due to indistinguishability from the guest's perspective, a device-side
solution might be difficult.

I'm open to any comments or suggestions you may have on this issue or
alternative approaches.

[1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
The Linux PCIe endpoint framework is used to implement the virtio-net device on
a legacy interface. This is necessary because of the framework and hardware
limitation.

Thanks,
Shunsuke

