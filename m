Return-Path: <linux-pci+bounces-1976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EB82941F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FD9B24130
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9A2374CF;
	Wed, 10 Jan 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQWylD6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC639ADD
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-203fb334415so2604006fac.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704871005; x=1705475805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOW57OUXuZU3/Ye+Ce6TauP/AqyMCBhkCXYeKvnbDiM=;
        b=nQWylD6MxA00wQulKFciH5AmQT4R5MTW59P7dLiNYv+IeMCHhgJpIBKbN7WZNQu5MQ
         rlkGutiM7w3bdsgLlWUqUsNXKnQcEgQPRmF/bOJcSRNymtuiN4jj5+bqZ1RbPyn0S1+g
         rtblC09UU17Nv+r6Tgs3JBaWdsX7eW3U5eNyUhqFQNWMdwIuvyFWtCkEBv/RWEhCjeld
         /daIM696Lep6tWOwZaqBMigG9QQKgUkILhrSeU/oRz6qM8upqILzIIa14nEnC5B9mx/q
         6uj7ayRk+PsMm3sqZ79Q/x0me38jxsxtlruX64jhQ72nY5LJE6FGMMlyJwdy4Cky9LQB
         Sgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871005; x=1705475805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOW57OUXuZU3/Ye+Ce6TauP/AqyMCBhkCXYeKvnbDiM=;
        b=Ogdnu1CFiGlO75BKQOfYARAD6sF76FlW5ICWFgcAQOJm1+rAUd3ojlVfryiMIhQPPu
         S61zedg9u2CPFzch1JT/nP9w6/7Qff7pW+2B+8I2jnxW4uib8ZLdXKizMoYmo825dooR
         19CH+Cw2wYqmkLmAKlMpqctUilqe8uC3uvHxMzp+P8tiyYU3dMsfxl5oeA5e4Tjgf3Gl
         WEm3bQv7RWoC58wC/k721n5RKa7CT50diNi8XMbvDxpP/Ll9V4O+UtByBTp7LdmTOl6f
         dRV/5L/MooFNzwD7ZBHd4p216BTv8VrxH+yYFlPLvLe2P21WmoXVTBauHjrS1UWZurw/
         7aag==
X-Gm-Message-State: AOJu0Yzv/s4+AkmAsV20GY4m/olN2grZyVzKJjouXXhnlcJLCHCMalCg
	SMJsjtf1QtBuev+/2y5oiikUzPywH6+GfwfFBsr+JRqloEY=
X-Google-Smtp-Source: AGHT+IGbFlTQKx2TfF5clBJ9JA66JR2JWDmAGPOibvE5cwQq6NBl7iD5x8WXUwXlqfeGFyOutmMU4gZJ06dM/Lw3/sk=
X-Received: by 2002:a05:6871:7a3:b0:1fb:2c68:6c0b with SMTP id
 o35-20020a05687107a300b001fb2c686c0bmr356822oap.37.1704871005578; Tue, 09 Jan
 2024 23:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109235148.GA2082000@bhelgaas>
In-Reply-To: <20240109235148.GA2082000@bhelgaas>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Wed, 10 Jan 2024 08:16:33 +0100
Message-ID: <CAMhs-H_7EovAntGwmDUDS3HNKV5H4w1UM=7cpk9GMi7Hi_kQVQ@mail.gmail.com>
Subject: Re: mt7621 static check warning
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thanks for the report.

On Wed, Jan 10, 2024 at 12:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> Hi Sergio,
>
> FYI:
>
>   $ make W=3D1 drivers/pci/
>     CC      drivers/pci/controller/pcie-mt7621.o
>   drivers/pci/controller/pcie-mt7621.c: In function =E2=80=98mt7621_pcie_=
probe=E2=80=99:
>   drivers/pci/controller/pcie-mt7621.c:228:49: error: =E2=80=98snprintf=
=E2=80=99 output may be truncated before the last format character [-Werror=
=3Dformat-truncation=3D]
>     228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>         |                                                 ^
>   drivers/pci/controller/pcie-mt7621.c:228:9: note: =E2=80=98snprintf=E2=
=80=99 output between 10 and 11 bytes into a destination of size 10
>     228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>

Would you be happy if I just increment the buffer as follows?

diff --git a/drivers/pci/controller/pcie-mt7621.c
b/drivers/pci/controller/pcie-mt7621.c
index 79e225edb42a..d97b956e6e57 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -202,7 +202,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *p=
cie,
        struct mt7621_pcie_port *port;
        struct device *dev =3D pcie->dev;
        struct platform_device *pdev =3D to_platform_device(dev);
-       char name[10];
+       char name[11];
        int err;

        port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);

Or should I use scnprintf instead? Since the statement is not using
function return value at all snprintf looks more correct and simpler
at a first glance.

diff --git a/drivers/pci/controller/pcie-mt7621.c
b/drivers/pci/controller/pcie-mt7621.c
index 79e225edb42a..0eae1b5b079e 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -225,7 +225,7 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *p=
cie,
                return PTR_ERR(port->pcie_rst);
        }

-       snprintf(name, sizeof(name), "pcie-phy%d", slot);
+       scnprintf(name, sizeof(name), "pcie-phy%d", slot);
        port->phy =3D devm_of_phy_get(dev, node, name);
        if (IS_ERR(port->phy)) {
                dev_err(dev, "failed to get pcie-phy%d\n", slot);


Both of them silence the warning, so let me know your preference here.

> I know we'll never actually hit this, but it'd be nice to clean this
> up, and I don't think it would really cost us anything.  I think it's
> currently the only "W=3D1" warning in drivers/pci/.

I am also getting this:

drivers/pci/controller/dwc/pci-dra7xx.c: In function =E2=80=98dra7xx_pcie_p=
robe=E2=80=99:
drivers/pci/controller/dwc/pci-dra7xx.c:754:41: error: =E2=80=98%d=E2=80=99=
 directive
output may be truncated writing between 1 and 10 bytes into a region
of size 2 [-Werror=3Dformat-truncation=3D]
  754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
      |                                         ^~
drivers/pci/controller/dwc/pci-dra7xx.c:754:32: note: directive
argument in the range [0, 2147483646]
  754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
      |                                ^~~~~~~~~~~~
drivers/pci/controller/dwc/pci-dra7xx.c:754:3: note: =E2=80=98snprintf=E2=
=80=99 output
between 10 and 19 bytes into a destination of size 10
  754 |   snprintf(name, sizeof(name), "pcie-phy%d", i);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Best regards,
    Sergio Paracuellos

>
> Bjorn

