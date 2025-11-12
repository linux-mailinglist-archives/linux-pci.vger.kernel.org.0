Return-Path: <linux-pci+bounces-41003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE0C52FD8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB8354EAC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8E33AD97;
	Wed, 12 Nov 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CkseN0T6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C133A033
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959651; cv=none; b=juKzJI9dpjoUWkDIbRXHd3uJZ55VmCP76MGsMI60W09/dE3ESGj4kdIL1iRU9lo4cWridDdqVbaa094Yst1R2riNGeQxyb57PZIoOdwRr83mJpld0pPk+jZkBE56U7FnwdycVzI1RiLE+IX8W33d0G9ZECrBdAsd0PA1xau+p94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959651; c=relaxed/simple;
	bh=6nRufZYMmMPdekb2l3DMopXSyHBxvFoDBeGjeLuuf3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AelXZgsJQyQjo0kbuVwjppG8QL3LWtX2u+1vte+e5vSzvSyQJrStSoao9MgXGI2VSdtPoTF+fKgZsc4721+nYJXXOCezVEAPcuc6FrHqt+1wfRInlTVuHRG6gjD1/K+CJ2IpQpbyWBYmBL87Dp8tQXggMaRTByElTfc22fztqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CkseN0T6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso8783041fa.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 07:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762959647; x=1763564447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJYkmTTA8zJtnbxM6NWrgFrNZ52Y7C1R8o6kZvano1w=;
        b=CkseN0T6wByGPn3Hkvz9zZE8oL65XyzNFZ2x/b6gLQbRLuEwfGTPfl0H8O6xYoxJYA
         DPbtQCpeF+foRUu/o8fXjvV+OwpzLscFWlFXG5Hco2dJeTc2rAgUkeCetWjKTwGBXVcL
         jD/2qO8yRkfWbBFs2u/F5KoTrdfXzj8VhGaOGgk+QQYtGf9CySu5H26GPwc/QyWoT59P
         I0Ygw8tQ5kWneyPkmwTiHPV8QpJLCyyMXGJ0fBTF0L/D4lEoBadYIMsk4GT5+fUgMAYy
         O1NY8FT6ctAsrLUazJ/K+nJuJAMul4ttetAF+xKE1WiW8dXUqTdWPZ8bRxv+cEX04/B4
         jodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959647; x=1763564447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJYkmTTA8zJtnbxM6NWrgFrNZ52Y7C1R8o6kZvano1w=;
        b=RAmHQ0rI25HqCTiRDzNv9F073cqImb7VIXkGaFnALd5j46Nk6mPMQ5z+i1zCv1KUNh
         fQ9GagWCYGOq1iepQnjKF1KvrXuSrTdwucTFf8F/5yhrdqRGShpNvY8/Dl3RuqBjCMIr
         RO5J4VKYNE9db5opvgmkIfhGv3FzhWWUBQoHCjFBdmdDr7ue31FLUPHJhjTyycImS65F
         d7IBtLUi5bBB7cpnVLkmvCS9QrcS7FzThLGXwa+rX5TbHWx73cr83LQRc8XcW7fl+xjl
         9WKdntHppXN1rY0fRYOBC+8WzWIjPgEvU9rdMeLirqvNvkSYwWD89iriegU2ZiQsaI8M
         NTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7g1Me4DHRgj46zUsEyL7rxTijRy++/vxE19NGPIj2MGXsbDpps/G6VVrSrAxrjKS/F4FobAkX4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XwBCPwb3hXiJvDZ8wyXrkxl3C+j6qlzFJBNJ6pmxfJK1FDIo
	mnv6MdhO7snxqpcA+Cv107pojT4DNv9Kr9cNLo/oM15evk8TThv8061W0gcsgx3ENvsPF00IKKu
	njIboMumkyGQAOt4MWDCzvbxo0zygiOsm6Wur5bOWdA==
X-Gm-Gg: ASbGncuQwp5bHix+VIMjkeEcRPNCYYSt7LtiFPc0GhecsHgxx1IhAHvKYUGy2jreLHW
	Sslp1bElhP/4sQlex8ge99pjdj3iULCid6WIk+3vpJOqUkTFoxOW8gj7VAKBQRaKdu2lWEJWR1q
	78YDqkVmb2CMnY544ncBXO1neYwU6tWs2x+Xj3wei+pljGfyGFB3kLUDpo7mLpxscv8f93fG1LT
	eLkj/sEZexccShP3bYPD/RZbncfnj85s1lNL6ynxQry+azMqa06SnIYcsNgK5+vRj7HCClcu8SJ
	ZQKqKwpBVJAv
X-Google-Smtp-Source: AGHT+IF/0lzxcENopPd7uz7maIwHNsxTmjPcBJfKsoF4Ymi/nL3fpwtDvaukn2F5jX9CEPwtr5hReZRpIgz3sULtVdE=
X-Received: by 2002:a05:651c:41d5:b0:37a:45b0:4654 with SMTP id
 38308e7fff4ca-37b8c440e36mr9499951fa.39.1762959647449; Wed, 12 Nov 2025
 07:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com> <20251108-pci-m2-v2-3-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-3-e8bc4d7bf42d@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 16:00:34 +0100
X-Gm-Features: AWmQ_bnRDrKZUl3b2_L2xXcxEgtoJqMJ2M2YBAmLBys8sYtSb3rTkaUH3Raiodk
Message-ID: <CAMRc=Md_4r74hFZ52WZxmsYchELv0B3uDzDsY1BDwGFJ=G02CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:23=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> The devicetree node of the PCIe Root Port/Slot could have the graph port
> to link the PCIe M.2 connector node. Since the M.2 connectors are modelle=
d
> as Power Sequencing devices, they need to be controlled by the pwrctrl
> driver as like the Root Port/Slot supplies.
>
> Hence, create the pwrctrl device if the graph port is found in the node.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c83e75a0ec1263298aeac7f84bcf5513b003496c..9c8669e2fe72d7edbc2898d60=
ffdda5fc769d6f5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/msi.h>
> +#include <linux/of_graph.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> @@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_d=
evice(struct pci_bus *bus, in
>          * not. This is decided based on at least one of the power suppli=
es
>          * being defined in the devicetree node of the device.
>          */
> -       if (!of_pci_supply_present(np)) {
> +       if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
>                 pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name)=
;
>                 goto err_put_of_node;
>         }
>
> --
> 2.48.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

