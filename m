Return-Path: <linux-pci+bounces-5247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7D88DCE3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069C82977A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC812BF0C;
	Wed, 27 Mar 2024 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+Gh+NKc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216C839F0;
	Wed, 27 Mar 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540328; cv=none; b=PWLIJjjkzY2vpwuTCbGvyWtu21mkUJhzQeXqdd0WBBpnYd+hgop1hLR3fTP/w8JUkKHJJXKBxqqHnXUVX4c4kVIzleUviKMP4SJGYXguTDQHlLKGO2VBgXtypO66E9AaN6t1DBUzm1chxVHNZ9yNkr8fxByzvBecThIHpxdKxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540328; c=relaxed/simple;
	bh=4hdiSWyOaq4PTNqiiHYw1eV5isab4taY8SB4Jx/XtiA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PfKqcTBPFI33PdPfyxbmE1PngFJsFVTlTxiEZ+qwy/cwezJyMEfAM1n5bbGA0fZmFRSu/wnepYFN6SI61u1UWsaG+n8onlBj8sxSf3t4bnqOQCy7ainEr0DDdchn/2id3QTgGF6aIaRKef2/9cVk1iEjaffhvVzm07v4v08ARDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+Gh+NKc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45f257b81fso765669366b.0;
        Wed, 27 Mar 2024 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711540325; x=1712145125; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+d1nuqxFtNkWbCvpZ9Vg4lSX7Mk6a5AbjdAX72V6OQ=;
        b=E+Gh+NKc+Z3p3vSSmb83kJox+QSfJR+7MHw/iSLmX7sAwuUnCLVwoqRo/vB7FMHgtF
         t+3g/9YQCO9utNdOOu79RvfbH4wSLowYC0XkGpNgulWsOUiIG3dMkDKndaSJweL1tJDa
         g0nXM3i6TTn1LU5r2vTLogsq7c69APsyBeGKNHu3Um2oxz3SHydWOBAVB4pPRdGz+iv5
         ezGrZXcEQQfEdsvJs+0XioEN3jzAfuJffcS4c2x8ayDaZC8hcSdXTMVXW8Ow894yuhpv
         QB6+hw7eMYqaKYvmgeCEaqcsDo1s9xQ7CkPeLKqnMPZbNs4DNAkS+tL4uDIniZF5NUgZ
         Ntdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540325; x=1712145125;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+d1nuqxFtNkWbCvpZ9Vg4lSX7Mk6a5AbjdAX72V6OQ=;
        b=RdpWbY7VjIJ0T1U8TZRcohH/eH/QQO6bB1XzfhnvquvbUSeGQNENzgVbI3jkjQ/dzI
         Zny1xEF/WB5Kw/LoZ+sZLu0d+w4RMoFs2dG+dNdT/O4UUdyTMKMp5MweUG9zBdxoZUop
         ZqpljU7x9DX9mCyuZF9/CaM47IkuZ0U2ugpope+dnCheoLJsNjsS9eiIjXVmgZGw4/6l
         fqUMwmKUu+HosGowegDBxLgR0yVtvORSxpGPS0Ejd6GA0KAgKgz9CpXgH/Q3Djr2JtTo
         hQZJN9rYplUpnNRrsJh1zfhGm5luVZwv8pnxk3EfYkW3gPI7WEKWt1vqvCsV7zIuAr1E
         L21Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqhiFnqMypGgoP3eUhCmu8OP6S1fSRWTqZrIwJJSENwiCzDRIY2yIfPsNg0T5ZwI0OZKsRRSm9HwNg5n7OTFUbgzmBcK0p
X-Gm-Message-State: AOJu0YwWhtWub7gsc2z+456Bb2UgFPeVVnDJv7Pqt8neNbAAjk1xVRlW
	9rKPfg8CW1sC8+sE9/fWyYVcTBRnhXIcV0DxCKtAkNZuc/A/hinibpKU6T1b
X-Google-Smtp-Source: AGHT+IEZB9iv0yio76vX87RQYNFK/Yt+r52vpa230EJAe6g42GyVUYPJ3p9MMiNPp59XMnju/SjZJA==
X-Received: by 2002:a17:906:a855:b0:a4d:f682:50c5 with SMTP id dx21-20020a170906a85500b00a4df68250c5mr725198ejb.53.1711540324629;
        Wed, 27 Mar 2024 04:52:04 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a? (dynamic-2a01-0c22-7b87-a500-dd0e-a4dd-4c2a-b10a.c22.pool.telefonica.de. [2a01:c22:7b87:a500:dd0e:a4dd:4c2a:b10a])
        by smtp.googlemail.com with ESMTPSA id c21-20020a170906155500b00a46baba1a0asm5358054ejd.100.2024.03.27.04.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:52:04 -0700 (PDT)
Message-ID: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Date: Wed, 27 Mar 2024 12:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <bhelgaas@google.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Several drivers use the following sequence for a single BAR:
rc = pcim_iomap_regions(pdev, BIT(bar), name);
if (rc)
	error;
addr = pcim_iomap_table(pdev)[bar];

Let's create a simpler (from implementation and usage perspective)
pcim_iomap_region() for this use case.

Note: The check for !pci_resource_len() is included in
pcim_iomap(), so we don't have to duplicate it.

Make r8169 the first user of the new function.

I'd prefer to handle this via the PCI tree.

Heiner Kallweit (2):
  PCI: Add pcim_iomap_region
  r8169: use new function pcim_iomap_region()

 drivers/net/ethernet/realtek/r8169_main.c |  8 +++----
 drivers/pci/devres.c                      | 28 +++++++++++++++++++++++
 include/linux/pci.h                       |  2 ++
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.44.0


