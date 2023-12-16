Return-Path: <linux-pci+bounces-1086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026CF8155A2
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65629B244D0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65931C38;
	Sat, 16 Dec 2023 00:25:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CC134AF
	for <linux-pci@vger.kernel.org>; Sat, 16 Dec 2023 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b844357f7cso1013997b6e.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Dec 2023 16:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702686298; x=1703291098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NUCxOkHyw4lCic/7M7fshZHbsUvhfuQZCBzH6f0nHM=;
        b=biSUJ4AwH9Uo8VDse40BrQ6RJ72sosfP7GeTP7CM7vtcB+iw8OHh0JzY4XG/SZ1Hbe
         rUWLw2JdCggs5ILLm0FK3syiY5Wc2xMuvvElflsjPd5cLaxt8QpStX1FutvfqI8fyT1a
         0Dq+WRF2HP0mdjkrc9AZ1uMcJMwJ6WH8XNYcB9jK3wQEKFm0JnPN32g1hstX63xNgUiv
         Sn5XYAVVTPjUoy4JqbZSzhNB3i3FIhu0QK8eQzAEVgd2WM2J8Ii2tA63iCVnf6eXPQla
         1NdvKfOkHfXro8M0jWZFaUcDN1W2ligPKH3EcgFUKAv4GE/5F0da2rqsRAv4qQ78MF2X
         mCSQ==
X-Gm-Message-State: AOJu0Yxcvef3o8XsBHa7YFza0Ba7Bbq7e8iIYiZbmh9W4O9LSwKSjsE1
	VGeBcwPpnlHEgABhAtMErSruIZ70zw/YVE8i
X-Google-Smtp-Source: AGHT+IGGXzm6pBY8bcBRa6cIb0Pv8G7mGvLvYshYb5cmbK96DzsXVAsG7qP8BnkcexdjNg9CwwpzTQ==
X-Received: by 2002:a05:6808:d52:b0:3b2:db61:ff8e with SMTP id w18-20020a0568080d5200b003b2db61ff8emr17342596oik.33.1702686298442;
        Fri, 15 Dec 2023 16:24:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id fa11-20020a056a002d0b00b006cb95c0fff4sm14101618pfb.71.2023.12.15.16.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:24:57 -0800 (PST)
Date: Sat, 16 Dec 2023 09:24:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-pci@vger.kernel.org, conor@kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: dwc: convert SOC_SIFIVE to ARCH_SIFIVE
Message-ID: <20231216002456.GF1570493@rocinante>
References: <20230918-safeness-cornflake-62278bc3aaaa@wendy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-safeness-cornflake-62278bc3aaaa@wendy>

Hello,

> As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> use of such symbols on other architectures, convert the SiFive PCI
> drivers to use the newer symbol.

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: Convert SOC_SIFIVE to ARCH_SIFIVE
      https://git.kernel.org/pci/pci/c/edd6ae1022a6

	Krzysztof

