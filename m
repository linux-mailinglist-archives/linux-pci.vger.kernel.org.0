Return-Path: <linux-pci+bounces-21786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B1A3AFCD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D543AAD07
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60B191F89;
	Wed, 19 Feb 2025 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rXZiyop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0528628D
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933414; cv=none; b=Fx3mKTqW/59bZrvBVILq90uo0uB+wvPEBGm2xEnYyCl9Binx/fdxcZoGv4CuCmq/GoiwunBabqY8Yfzb6smV0umlSvwgqY0AaJ/CTfIfIkxM7NqXQColLrRKDDfaW9+XkVfu1M38y6Q/xhJYxvYwGtXzvvzdN/UKOn0t95CkqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933414; c=relaxed/simple;
	bh=2Ke4rcATX8OBAcT3egNCwx3YV2ZgVe6nPTB4c41GhvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijuyykce0CgWAlFGPFcnhrTWEzkUo9QNkCm0BVzufrfyb6cbWJJaLEIHW99biRfy2/JSODGTPNwCQSf4wl9xgcCNO6JWSDBQ+0FugZzoIndGk2C6X6Fd8MxnBY1R2koyZqvn1LU73Tqw+LZ0d7A/8q3UgyHwxgPrLjYOwnhEdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rXZiyop; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso1180753266b.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 18:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739933411; x=1740538211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ke4rcATX8OBAcT3egNCwx3YV2ZgVe6nPTB4c41GhvU=;
        b=4rXZiyop85sbIpkcPNpQTe2tgfH0OejcC7OiOrqAh3SiT3+cwjFdi0i0258NzVCzY5
         oXQ/wiYNF0mT3EeFMUcomXLNWsku5wya9FXl3CiyH3+Dq4eBphFFm12t+Ex1UvEcRUsI
         DP2xqXtX6sp06fuUlViUAA+r/1ACaNd00EexF5/v2vc2U2f7B5GS0PbIfz7YB7FX05oi
         BeP4P13lGUE9DBLcCMXU2d8jH22V9khNZNjdtZ2RnCLFiWDKcOqMPps7Oiq3Ionucnh+
         1u7OhopUel4O0qAMRK28BNJs43rrA9bS1VjHf4oFQFnosv9V7ot/yvN4N+H8Bb3mnL68
         psEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739933411; x=1740538211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ke4rcATX8OBAcT3egNCwx3YV2ZgVe6nPTB4c41GhvU=;
        b=Obz6MsFU5VrF7qbbmro43/XjKmhI+Ete7CSpiXyA3qZ6LxSGQl3mLDn10JkY2Foa57
         ixmASzDQW0N4KijWAJRwPsd/lgf5eRQ7AxaMFjbG63I8GIBPfTl34wVXIAMj4x2raTYg
         AjWcZPFNnYj475rxxgheTvot45PuQyiG/avMtL6MtztINavFe+zRT+VKXKRQnf5xxRnQ
         wt5lhfVWvsBXRSjKJdDlFXoeB1GAfbFLVvsunqteuzq4Bg+Z4KgvHpfpwWOtj1m5wN92
         tzP8VljMrnasIzIvYrgx8MCHUPP/kpSO5tbKt7tXk0qP3qBZRXuGnzoXZAG9atWFK1TL
         JYVA==
X-Forwarded-Encrypted: i=1; AJvYcCVoHOAVwlyuqzsh0nqnVUgEoHhSZWAO/vOe9L4joQZKmNapajRZJaGPV6o5DUzGkG8c3dNcUZ+wyuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIhHvPiLxbG+DDPxbvWDUswygR6TjWp39SrgiNsYT1atx1XGo
	j9Nak80iy3smnrHhr00dyeBQ/rjchqbvst+yU60QAGfdpLb5jaMFcM8zVdkKrKscvcfvE5vBDek
	k5Tc1tdysQhEIFYSbme2ApfQM/+cwdCdAm+XM
X-Gm-Gg: ASbGncud9hX5q0Ntkqq4qdRy/hQXX+jUjXzinJ84Pq/I021ouQXHqps+67zKAcrVGf8
	aIzY3Z5JTYeSd8I0x1pf6Hk3Ha6YfNumOFpnPrWtYVf75U06GgYyA1SDpTwdv+6lHryddQCJcCX
	+en5bTlAWlabUDX5NWo8acljhA2MQ=
X-Google-Smtp-Source: AGHT+IGLZ8tp1lN6LgLadAJ1tdJHYmBaLhLrV3m/NVDF5Z38fZ0N0sUhzRx/cVt/fAIawtJmBLgabzmp8KMz4OVVxlQ=
X-Received: by 2002:a17:906:4794:b0:ab7:7cf7:9f7a with SMTP id
 a640c23a62f3a-abb70db8437mr1716778966b.53.1739933410897; Tue, 18 Feb 2025
 18:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-6-pandoh@google.com>
 <ba1b05d1-d77e-4f35-af1c-836fc881135d@oracle.com>
In-Reply-To: <ba1b05d1-d77e-4f35-af1c-836fc881135d@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 18:49:59 -0800
X-Gm-Features: AWEUYZnILqn6ojyYTbzJJRuPTS1dSRCeCHbsDuoFGRg-OsnWMgme70r5m-OlCek
Message-ID: <CAMC_AXW+yQxGOQ6XnONkC-pg6XYb=p8+NTaLfujniVX2r=HDKQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] PCI/AER: Introduce ratelimit for error logs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:29=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> I'd rephrase the last sentence to say "Add per-device ratelimits for AER
> correctable and uncorrectable errors that use the kernel defaults (10
> bursts per 5s)", but it's just a nit.

Ack. Will change in v3.

Thanks,
Jon

