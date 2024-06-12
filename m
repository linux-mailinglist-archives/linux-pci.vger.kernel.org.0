Return-Path: <linux-pci+bounces-8622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC99049B8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 05:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6EF1F23F7C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 03:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4F171C4;
	Wed, 12 Jun 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0D3xBfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB164A;
	Wed, 12 Jun 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164141; cv=none; b=bDhL1OLq+MQYt2vOCNrAxg1gYSRA7zX5+GcrqhYbt4su0MI6A/wzbhBYuvuiiaUF81EekyMeB1EPWZx6ciaeI/FUfQDfddBa4OXOYlfgsXxCYOGnW3nWaC0f8cU4D0IV36mWT2qNfVGa9z5oxKi1G/j6q5twBI+ByfLSFcV6syU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164141; c=relaxed/simple;
	bh=2bGFqyYWgIFafnW6kCWkCegqO3LxE+Mz/mpKZMHMASI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HwKOyj+l2ZKYPzBgMxswXwOcW+ZMT19k2NEfnxIFBuD0Axdnb2qJvuWBXeiM8zi+nv5j1vMDmmVl+O/UCg7v4i5myX6jSUMxJvE+gstZGE4JLG/GUIL6eBkoHnb1WQYOTJ651md529t07nRH9gZL2x757xjOh82UuQb6E7xxLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0D3xBfI; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b3364995b4so1117260eaf.0;
        Tue, 11 Jun 2024 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718164139; x=1718768939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxHZ3G7e4eNkBw3CVTCI8BN8ws2ri/rJinLTe7rU6BY=;
        b=a0D3xBfIAmxWIKQ5BI2ktMVGHmUgYQyQRlfElJWR5rp9/6EtP2Mrs1yrw+ipn7KRI+
         q+PQrECuF0A61trgjaQIQamWJagZaSNQ4qzpmHRIV4sLgs64IHvNSJOYzytXBWCGIhF+
         IMu1zScKT/O0NiTxWPwtsoc2ilySYpOtWW1YAxKff3RfQfaqh6+qoV2oKgR6vTz2L/4p
         SUCinm9QU45veVXHvMCVXd0m2nMgFYhh3CrigVoA+I4ZVbxEvX6nmuoK/fny2uDYNlYA
         jOrbhidYsqF7/K/Pr1H2575EF59qRwFaW5AjwBdCEPpI556SLblwh+iiZeOSTJvkb1Pf
         xc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718164139; x=1718768939;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxHZ3G7e4eNkBw3CVTCI8BN8ws2ri/rJinLTe7rU6BY=;
        b=n6a8/t19wAuVwJcNTBqoC0W3FetHPJj9UhcGZ3kZfyiEmMbwUMIwcNNBjF4dAH4ydZ
         DLhyuJbn/HGiT1W1hOjINklZ5mLsrByFF6N+STqzjJW4fasjhQgJCYGOeCQ6CK35JsHo
         kIBOwsi5EqaYOLMMvtke7i3S9z0qByiGRwkzpHeCTAXuDb6ZjwP5HyxJxS1vhDu276mq
         yvshl7O4neG8lPE/x5C6RF7emBx+bsfwN1xuEp+U2S+zF13yaX2OcBnwBamYD6C6Uk8m
         MMDVMLYnC4OEsFdPelpNNXHoeD94FKIVhC5UIbWvKOoI2JJqTXHMevezYTN873AFbnVE
         clcg==
X-Forwarded-Encrypted: i=1; AJvYcCViED4SWKSlnDI9CBkdL6rcXxs/VoVcF0hdcIkIG7yyZuhWep+2G13ZX+dCym+oAzuZJfas3+YQ@vger.kernel.org, AJvYcCWqhVlkq2lSB6ldn5/NTRWQhOEcQQMJKuQd7HbDJEIVTW4WFjJDB+PYhpDUJKkwuPjl5uRL53ZffTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXjsKa/rGrySyqau0JDHmvDgc0sYrWPvGefgcmOZfD0O6SiP6
	wCJ4KKejjPjxLHJXt8GnSL72p1fMWZW0rT32EeXV4sBtkUiuBTiE
X-Google-Smtp-Source: AGHT+IG+AWbPhKhCFdnv1wIqiv2DmkrXKaYR4UzYcncsb0LZndSCa0sz+IBMu5fWTwJgG4z+y2DeLg==
X-Received: by 2002:a05:6808:23cd:b0:3d1:df68:4fa with SMTP id 5614622812f47-3d23de930damr733482b6e.0.1718164138476;
        Tue, 11 Jun 2024 20:48:58 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de225006bbsm9204357a12.49.2024.06.11.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:48:58 -0700 (PDT)
Date: Wed, 12 Jun 2024 12:48:51 +0900 (JST)
Message-Id: <20240612.124851.944860878036469042.fujita.tomonori@gmail.com>
To: helgaas@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 1/7] PCI: add Edimax Vendor ID to pci_ids.h
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240611150134.GA981546@bhelgaas>
References: <20240611045217.78529-2-fujita.tomonori@gmail.com>
	<20240611150134.GA981546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 10:01:34 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jun 11, 2024 at 01:52:11PM +0900, FUJITA Tomonori wrote:
>> Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
>> Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
>> rt28xx wireless drivers.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> If you have a chance, update the subject line with s/add/Add/ to match
> history of this file.

Got it, thanks a lot!

