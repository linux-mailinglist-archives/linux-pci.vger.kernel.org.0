Return-Path: <linux-pci+bounces-9534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7791E984
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFF2283D1B
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783CB16F908;
	Mon,  1 Jul 2024 20:22:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6616D9C9;
	Mon,  1 Jul 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865377; cv=none; b=IBlVDEIiWEiVEH24VlWseGzb/eQhcpdKPluGf3TcTH72s+megqzAN+iMDDPSwK0CgyE9n+AFpk8g84w+AT14nHrAe9loqbwVZqnpAyE5cX5dknU/Cda5cmfsqQo7U/tU79/psAJxp5i/s2hp5f95JnfoaSLF7L0v3wPMNSgUJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865377; c=relaxed/simple;
	bh=AoCWJ9Yh4C+GfuQFmNewtN2w1FMUXLYgaMYSlRgegtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2SQn0wDPpGW8PpmZ/uGjNyr14glZRMY9zSi/gn0hiwBjDczwbEzSM6XnDgukc2O4u6dHwBbGp/HERazpLPGBhcpSDRQKBcGlrGXwjwIMr6yWdb1YkZf4vJSTJpcuH7CQ9zVwYa3qYWXAJj/t5jnH811wCUtaohSkDbYtLCnyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7066a3229f4so2094680b3a.2;
        Mon, 01 Jul 2024 13:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865375; x=1720470175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9EMAUsDZQjNn8rQ2Ng0mnKCF6QCdhwlpPX+tSDzSBI=;
        b=hLEBD4MC10uRXx+RPiT9Vf+olWbKC4timMsAglz4PavnefxOO/8Oku5ZrZgi66M6P4
         /U/Vd9xK9vLIQ40QhnRqfwZtg1swKeS3lYuW1aDs6NAJ2Wz2jDvwDJfeaOMW0JAVcoyO
         kKMeNNj4YPolJZbpftuUtDoRvSFHi81/5F4L1Si2XQOi4aP0e8IAMf6Jgg9VYIIJ6XgG
         W1K8UPoFskJr4IEtFr39BYdGy+zU6ETFj0+WAoL6isBv7ZonCtVAlvc2pu2L0re6XvFx
         TFm89KCYjNWl4yO1VBxlPXCY5g4lF+q3cNwJxbBPmdugt6KOJx77lkMGVTCjCWoSKstD
         bDJw==
X-Forwarded-Encrypted: i=1; AJvYcCUpGxCVAcucoqXTsd3jnIyQYeAfXb+5ca+9aRI9lJ9eF9t5EjgULz/Q6MRW3nqUhU7ppjF1n6UIt2nLTgAINj2XGk4DRUsC6ObEGu+HBqn0vkv4Lyny0SfixFYkSN6Z793kBFdLCQU/
X-Gm-Message-State: AOJu0YykrDhD6tgHDyKzNcirPi40smyTWcRM1vYSiLr6ouHP3KZOX2It
	YciI5f4dUhHr50umarjUQvRjhSGRtpZ9PPMFlqEmeBpuGAxxY8Um
X-Google-Smtp-Source: AGHT+IEQAT+sffDRBS+Y8YiJm63+AMFRtY3FFjbBkHj5Xt1KVNn71x5FxUSeIBnndjYpbtGQ1fWbeQ==
X-Received: by 2002:a05:6a20:2d2a:b0:1be:ccb7:7b14 with SMTP id adf61e73a8af0-1bef61ff40emr5251733637.40.1719865375151;
        Mon, 01 Jul 2024 13:22:55 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8a10bsm6906849b3a.210.2024.07.01.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:22:54 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:22:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lpieralisi@kernel.org,
	bhelgaas@google.com, conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek,mt7621-pcie: add PCIe host
 topology ascii graph
Message-ID: <20240701202253.GD272504@rocinante>
References: <20240522044321.3205160-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522044321.3205160-1-sergio.paracuellos@gmail.com>

Hello,

> MediaTek MT7621 PCIe subsys supports a single Root Complex (RC) with 3 Root
> Ports. Add PCIe host topology ascii graph to the binding for completeness.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: mediatek,mt7621-pcie: Add PCIe host topology ASCII graph
      https://git.kernel.org/pci/pci/c/868f61ed02a3

	Krzysztof

