Return-Path: <linux-pci+bounces-44608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 850AAD1936B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C36D304C672
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BB38E5E8;
	Tue, 13 Jan 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aurlwhdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63853921F3
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312576; cv=none; b=TrZJK4qCrSNyQVr+vXbqi8Ysu61Dx/SbFfk1rwBh/+x+Dr1Kml+WuMOnEA7C39BKet3eRno4muFaqcLhIGHULG5WVE8Py3JH838j91CkDdGQk8rJLV+nTi2pDMP3dg03yrkkcicsLj8PI3jbSZT6zT1WPfpc0Fweh+J93inopr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312576; c=relaxed/simple;
	bh=bkX4l6bShJ5JPLZtU6DOHZU1fn91ZPS1ZErO6EOXX+s=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StCJOG1qAyU/VYqbt8UR8VCn99FzMKutcur/ksEEPyKhVeqjGOKJMR+0Gg8ek+nG72/uGcqEuH/9R/ysGZypNpuzwDSozI9Aj6igTNThW1wN3BXXSSRpN+XTTOiPZBj9LZqpTG8kKcuY9rCklz5GIbcAZGIRg8z1/x216wgk7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aurlwhdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BF8C2BCB5
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312576;
	bh=bkX4l6bShJ5JPLZtU6DOHZU1fn91ZPS1ZErO6EOXX+s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=AurlwhdwkIDyLEEG1sDbKkz1AhNR3/Z5B0OmENZhddhZy9Apv45pXt8G717qw2Lz6
	 /wMCF4Db57+njRq6vjzM2d9xyHq5S7KLZ3CQak3zgy9vZ4JU3STtcQnU4JZv4TCzjf
	 7mt/3IvqU5a+I1QKoQsePvwpAWenYAejouhzo/LyJoUhebTR3OxmBL2E05CuvqNDzz
	 Kj1gLE5zwszow8T7weIvBpi0VyXdtt26q6Nc/F0nJblhM3F11u8RtCADNkMyNtRMjq
	 9PBl1Gc8Mzd6JD2R9Z+p89SNm/naQtqwIhLTjNAj3gz5j42VcBGgUgLs01JGmt3YS4
	 bNS5apfy9VhJA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fd6cbae1so52698331fa.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 05:56:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+KzRoDTG2dxzj5qNiN0g8uHTS5nBmhuIjfJbQmrkzHMV761o9Lhx3WRmMcETAo9mtDEWBdPSjTNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiOTRlkkWyolfPxIPc3ol5GQVIsVKRrQz3jfWAhpsRKJ2anTU
	y7m5c1kxWMUUm2mzeIxqv2crphpQyn1aKt+alLw4eCCjToyITSeIuj09aN2/YaCQaeYxcfCSrNr
	S7tf5lWVRMIr00c4s22F0ij8O16KDYXlxpl9uRTIC0A==
X-Google-Smtp-Source: AGHT+IEIfAh+J1nW6a76QEZoxI99d1qiBCcpn0QuzyvBuvRQ90+CAZIf0T8IjrVOHV8vEbr04kW7VOMKTvIbkja0v0c=
X-Received: by 2002:a2e:bc09:0:b0:37b:aafa:5af6 with SMTP id
 38308e7fff4ca-382ff69a4f9mr56878211fa.16.1768312575104; Tue, 13 Jan 2026
 05:56:15 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 08:56:14 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 08:56:14 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260112-pci-m2-e-v4-7-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com> <20260112-pci-m2-e-v4-7-eff84d2c6d26@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 08:56:14 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfGWkg1qA63N2gqagVyYrVCX9OqXYRZk_Q97+H2KaoKsQ@mail.gmail.com>
X-Gm-Features: AZwV_QgANpTS7RywRZ1G49K6N4fcP2tHLCImYNmU5c2lsGoEnaRUFh6sWYEGZio
Message-ID: <CAMRc=MfGWkg1qA63N2gqagVyYrVCX9OqXYRZk_Q97+H2KaoKsQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 17:26:06 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> the existing pwrseq APIs can be used to control the power supplies of the
> M.2 card.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 888176b0faa9..4d562596ebf9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -26,6 +26,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/consumer.h>
> @@ -2384,6 +2385,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
>  	case QCA_WCN6750:
> +		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
> +								   "uart");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the
>
> --
> 2.48.1
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

