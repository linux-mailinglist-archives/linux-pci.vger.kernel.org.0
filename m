Return-Path: <linux-pci+bounces-44490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2864D12104
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11811301D6BD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDC34F257;
	Mon, 12 Jan 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER9uDpKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE534FF47
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215260; cv=none; b=BajYWFebMQ3ylA9pOY+1p00nhliYyPaFETZDUe2wYcyMbDFC4h5gaUw1k4R0FV7mr1Bo1p5AKE5eR+MFy138J+3pcts3Sy3On1CfD47GzE5O0zLNV0HV/IRb6NvLfK/tFGVAU1NgqN7XxpE4PWPf3bVjitABVZIzfwJ3s7Zcfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215260; c=relaxed/simple;
	bh=JN8Tx9lcEFa1feWSSo2+DawtEa+D5nz6pKkmTYdd80o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfQ2OZv+ONmBoPgSbJG4oJXsMUg1lbs3YUb7GephxfvlxBnn9rfLvrpHSwpkR/R1M/n2b10TIROvWZYcANHEaqQM5TeI5XdUIQa9oqzQ0Is87z/SLWxDPUGlQPyTKmKxeahes+r79FDBgpWyY0oB4g2iOxN7lQiOFaoEnTLPhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER9uDpKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B8C2BCAF
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768215259;
	bh=JN8Tx9lcEFa1feWSSo2+DawtEa+D5nz6pKkmTYdd80o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=ER9uDpKU0gKhm7Mmd4Cxsn7MpqOQ7vgt/ZcySJ+A9bsTzXxToNbycaa4e7QBta8wD
	 T8NSpwycbQYwIUTgh19uyJzFyLVV6QQKvVGN6qt0KMPkIdc7nYA5/U/QaOUJfI/kHy
	 4Sd8Rvl0QCaU2Atg20NBcAm9QKTOwrxoxTsSOFizYh1bMtgu6MnsGhGFxsls0+Oizc
	 Xfu6WwhJvA9CBk8mYony8E2iuqdfKr+rPvb+ZNEc0SiWYI7T1hZhsiyqoKBkOzwwuA
	 E1rPydvvuBL8GGQHD+ufLKpzTd1tbTNHHZ6tGNWh5Zxq05oWl3ZtIWyApP4xskyR6/
	 fc8kgRKSlTMpg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b7be7496dso4464259e87.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 02:54:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/YP83iwJKeGzKwK9k7n/bWnRstzF6sN726dH9KUSOKb4CVqxwNQdK/NjoWTkpgvHD27bqVnlxCDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTs5kqQBfAAZSbEolFMCsFT5ChFR4Cx+BoT9tpb+JPvUHrNlC
	95u+RDQ4TPjUWS9HOqroHIHUV+rtURoB3X2GyfAR6qRM6/+XGMRdaO0bkfEf+7b+JdbLFkkU21J
	qx6CAyYWj7fWQDCFXEHiBEXHBnRn3v4Y51/cwEUDAww==
X-Google-Smtp-Source: AGHT+IFOFA8kXD2/ntFFnMuqlDdI+7/+mE0Jg2kNrYOPk8LLfb+NDy962k4fw01JMa4nCZndlay6ttujw6BSDeEvZxc=
X-Received: by 2002:a05:651c:210d:b0:383:4b8:435c with SMTP id
 38308e7fff4ca-38304b844c3mr52338991fa.9.1768215257586; Mon, 12 Jan 2026
 02:54:17 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 02:54:16 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 02:54:16 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aWSq_7_5kkQIv9Hc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com> <aWSq_7_5kkQIv9Hc@smile.fi.intel.com>
Date: Mon, 12 Jan 2026 02:54:16 -0800
X-Gmail-Original-Message-ID: <CAMRc=MfoUi-qvZnOcM5pgvmVhPMEK+gvs5m2APrqLXc2J7x1AQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgkgd0gbVuBhbU6fLauSpqstnPMp3OpP37gMnJcwjV2eQkZ3qyjBa1-dnE
Message-ID: <CAMRc=MfoUi-qvZnOcM5pgvmVhPMEK+gvs5m2APrqLXc2J7x1AQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Add support for handling PCIe M.2 Key E
 connectors in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Sui Jingfeng <sui.jingfeng@linux.dev>, 
	manivannan.sadhasivam@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 09:04:15 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Sat, Jan 10, 2026 at 12:26:18PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>

[snip]

>> Though this series adds the relevant functionality for handling the M.2 Key M
>> connectors, there are still a few open questions exists on the design.
>>
>> 1. I've used the DT compatible for the serdev swnode to match the existing OF
>> device_id of the bluetooth driver. This avoids implementing custom serdev id
>> matching as implemented till v2.
>
> Yeah, swnodes are not designed to replace the real DT or other firmware
> interface. The idea of swnodes is to have them providing quirks if needed (i.e.
> fixing up the broken or missed FW device properties). This should not have been
> done this way. Please, consider another approach, e.g. DT-overlay.
>

This may have been true historically but software nodes were introduced before
the auxiliary bus. With platform devices, the question has a clear response:
DT or ACPI first, then possibly additional software node. But with auxiliary
devices, where does the entirety of device properties come from if we - for
whatever reason - don't want to propagate any "real" firmware node?

This is not even about this particular series, rather it's a wider architecture
question.

Bartosz

