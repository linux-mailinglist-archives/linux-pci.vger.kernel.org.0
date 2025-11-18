Return-Path: <linux-pci+bounces-41505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF57C6A0C0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 106164FC8A2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21C35A95C;
	Tue, 18 Nov 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lq4z7uIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1D304BAF
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476207; cv=none; b=OUM7cLMx4QtD/FiLVpyMcGAh1q7znCOi8pxNdVDNPB6wj0cnr7OD04Att1fMtQXqyd/nSC8PZcC4jA5nPvHt9D9MP+Df7nKk4uhMAIZz/eeWhV4HoKJpWSg3yemoDPpZDfek3cY7atAUvufvutIVABJJu1EM8lVhmAVdxOYiZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476207; c=relaxed/simple;
	bh=812u0/kE8U6KIifXA4o4gTvauRi/MWbHZ1WwZdLX1Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg8boPUoQx35/g3feZqf4z/yckaZuzZd4QsrfsEoBtCMPZuLYUUUIn00gVoVReac/xqLfqPS1DGkzBAS33J+CCNbE0fEbjv+vQL73YbEDMYiSSwdbT9b7Wig1M476qrSLL0PEDagn/jqHBqoCqezjb5v5mffihEme/HJzLJs3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lq4z7uIo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so499324e87.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763476202; x=1764081002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPuRb3+haxxFSoGOZ/Vv3ClCGfszWqWGAZKDKrczFMg=;
        b=Lq4z7uIoHwX+T0oZpnQeE7Sgq9N1okHHPsxFDCimKWGvAYYyd1L3RkOxAFX6qqwgAK
         n7bdZ81LqGV1aeevTqZ8wYxo8zm2fcmodj9xNDXKeQJspHWeAezhpEaV3ItXy5cPjLX4
         6lleapZWGYLkpOGJxS/+B70xq3sqzhS76pnHvh3KpwGhTjAk0fG5Bfaevs8HoAynZMpF
         6Y9f9b3Bef5JuVIba38qaCDqJwveVXQ19CNrRhMaBrwVBCOxUcjdGZbK08iPRuO8sCQ+
         nlyYi9cr1Cu3HHRMrga2WbosxHKUD2ZvZJFSImC9bw3VIP1RTXdGahqstC5GX3Xx94Lo
         LSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476202; x=1764081002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPuRb3+haxxFSoGOZ/Vv3ClCGfszWqWGAZKDKrczFMg=;
        b=IvlziV3wdC8o516sksmS4CTA7AWOz12EVaUuKWcz4+Tfl4lCNstVtuCdXJCV1NZT/0
         SIFwfXMXUbtqP355ItpnmvV7AaqsRGwYB6nxAQGsW66xfQTsQM+sJOOfl660/zcimg7A
         jJtHc3U5Pkrwhmxg8lCJqkTfMsy9Y9hua/CXZ1AX3qSMjewIeze7zf0JCil929pkKRPr
         rWeqjiOhEOPsvPoV93Gq458C0B22potIX+BNaU3uQ0ywsqXLzIzFhPPgSU73ifwIHCzh
         r69+ewUC6PJoZMLufoO4rBOLC/+dMa9Ga8hcMeL4xqiFdWxdgfEVJR+y83LSbnf3FS2L
         xV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzYN0Gnda/N+riv0k6PL79E3rBAq59neXIBqcvjg6iKVwoEx+k4/tqVZ55jZ0hdfnVx8LzvqVQKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nMm0piHyMEG0Gx+G6mwUsK3zoQJIgls9yXLGPgS606QTrvL6
	Ht1+iEaI5G82C4gQrBVxqqt1YEkr4RCn0unzvEkK7KgOhAfUfHeSBEibkPpYRavTO86yF961EfT
	doIIg6QQluc/JelJbPBAtaYDw9k3h40+VFzzT+cGhNA==
X-Gm-Gg: ASbGnct+zGiCRY4PaVDqS9edKFE0ZmtPa1jcHKD/UYh0ujPJDGSNOExibpBspNnvGJN
	znDiKsKAawQhfeD4ndKpyS3pIE58Gjl31qPIWrYaDDNv49H3L5lIuEHl8Z0HAPUDSXe8HqJdykd
	VR9hcoij6UMEfU45oGF7MaZC4irPPKEND0RW51tz5UEy+jWRCwuCbO8e2x9X6NgU22UKLBizca7
	m2tU8XR8GnQB//DcXknMXQsp2XdqFonKiV0Wbvbokowt7KLV4TFBBNq1Wf+QJlorfesvV/LBrBE
	Vs3kN0wIDSKbC1o+KL0KCHgy/P0VAku2KZx5
X-Google-Smtp-Source: AGHT+IG/8x599leRbcc55AKG5x7ewC54AAGqLK2r1ZPyGFLtbdnyvhRmFu7yQc8cTfZdSXpR6fRtj7AIKLBehJrw2m0=
X-Received: by 2002:a05:6512:3ca2:b0:57a:2be1:d779 with SMTP id
 2adb3069b0e04-595841febd2mr6716947e87.31.1763476201587; Tue, 18 Nov 2025
 06:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-8-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-8-97413d6bf824@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 15:29:49 +0100
X-Gm-Features: AWmQ_bnS7J2LiofnEnjv4l_cFHHTAIWcbKZPMExzLrGKBD6vTSaTLBGi1oU52Ic
Message-ID: <CAMRc=MdRw+spjN0ySJ7We_GJ8GaDU2Nb4unaxcnr2ZLjLOeSrA@mail.gmail.com>
Subject: Re: [PATCH 8/9] Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:45=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The WCN7850 PCIe M.2 card connected to the UART controller exposes the
> 'WCN7850' serdev device and is controlled using the pwrseq framework.
>
> Hence, add support for it in the driver. It reuses the existing
> 'qca_soc_data_wcn7850' driver data.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/bluetooth/hci_qca.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4cff4d9be3132561ee9bae4ddf2c8ac0bc13ecd7..09bfb3bba93698f496947775b=
f6b31f2f20279f1 100644
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
> @@ -2344,6 +2345,9 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>         qcadev->serdev_hu.serdev =3D serdev;
>         data =3D device_get_match_data(&serdev->dev);
> +       if (!data && serdev->id)
> +               data =3D (const struct qca_device_data *) serdev->id->dri=
ver_data;
> +
>         serdev_device_set_drvdata(serdev, qcadev);
>         device_property_read_string_array(&serdev->dev, "firmware-name",
>                                          qcadev->firmware_name, ARRAY_SIZ=
E(qcadev->firmware_name));
> @@ -2384,6 +2388,15 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>         case QCA_WCN6855:
>         case QCA_WCN7850:
>         case QCA_WCN6750:
> +               if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
> +                       qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->ctrl->dev,
> +                                                                  "uart"=
);
> +                       if (IS_ERR(qcadev->bt_power->pwrseq))
> +                               qcadev->bt_power->pwrseq =3D NULL;
> +                       else
> +                               break;
> +               }

Did you by any chance copy this logic from commit: db0ff7e15923
("driver: bluetooth: hci_qca:fix unable to load the BT driver")? This
commit is wrong and it flew under my radar during the summer and I
never got around to fixing it. It doesn't take into account probe
deferral.

Bartosz

> +
>                 if (!device_property_present(&serdev->dev, "enable-gpios"=
)) {
>                         /*
>                          * Backward compatibility with old DT sources. If=
 the
> @@ -2740,6 +2753,12 @@ static const struct acpi_device_id qca_bluetooth_a=
cpi_match[] =3D {
>  MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
>  #endif
>
> +static const struct serdev_device_id qca_bluetooth_serdev_match[] =3D {
> +       { "WCN7850", (kernel_ulong_t)&qca_soc_data_wcn7850 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_bluetooth_serdev_match);
> +
>  #ifdef CONFIG_DEV_COREDUMP
>  static void hciqca_coredump(struct device *dev)
>  {
> @@ -2756,6 +2775,7 @@ static void hciqca_coredump(struct device *dev)
>  static struct serdev_device_driver qca_serdev_driver =3D {
>         .probe =3D qca_serdev_probe,
>         .remove =3D qca_serdev_remove,
> +       .id_table =3D qca_bluetooth_serdev_match,
>         .driver =3D {
>                 .name =3D "hci_uart_qca",
>                 .of_match_table =3D of_match_ptr(qca_bluetooth_of_match),
>
> --
> 2.48.1
>
>

