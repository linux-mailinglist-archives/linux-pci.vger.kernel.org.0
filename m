Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC931E9A0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 13:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBRMPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 07:15:54 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:35734 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhBRL5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2021 06:57:43 -0500
Received: by mail-qt1-f179.google.com with SMTP id g24so1136867qts.2;
        Thu, 18 Feb 2021 03:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2kEv8sIFU+zpk6Mq8W5TYFeq6VABHf9B9emGrVNqUxw=;
        b=P5Cq27fWBFe56Jgi5mVg4WDyYBWU5CS6aXI5sEIoLRJhM5N1yM9s1ZZyyu1dKnm+ZF
         FPdG/H6PJ+kfU2GigYgBhk//vQJmXrkaOVA99hfyxvhKt1Xdnn11zIje1m27xOK41C2L
         CIqbAfrRpp+4pVop3C6m6IxIj1whsqp12kV4ZY7wQhqsswuff+FH+fkSNr4dwWzh3SfO
         lPnKV4DzNy1E1CcYi2F6IrgM6S6yre6yBbG9PKlV6WAJe3GXrtMe+AvFl/sALC+W2y/A
         4CbLWq8mp4JqpzHjV8oSekPEx0XNcuH3yH/kXZC4zxsVWG/nU9hbjLGhdCpZtEhTwmWv
         1zfg==
X-Gm-Message-State: AOAM533R+rIFFLRpt9IbqfY7FT6TJzJHtqlM3bNvkP9fxqSSWVXvaEZ1
        lqN4H6xJGJw+h2B5Kuc7HMM=
X-Google-Smtp-Source: ABdhPJwq4o+OkO9IbuRkPF2GzLzPv1GdXZmEb2PU7uYq1lEm+iWIvWB4fZ/UW01rHB9BLj9o4u3yuA==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr3735807qtw.225.1613649309429;
        Thu, 18 Feb 2021 03:55:09 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 16sm3001512qtp.38.2021.02.18.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:55:09 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:55:05 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, helgaas@kernel.org, stefan@agner.ch,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] PCI: imx6: Limit DBI register length for imx6qp pcie
Message-ID: <YC5VmRTIylDHSFPt@rocinante>
References: <1613624980-29382-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1613624980-29382-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Thank you for sending the patch over!

> Refer to commit 075af61c19cd ("PCI: imx6: Limit DBI register length"),
> i.MX6QP PCIe has the similar issue.
> Define the length of the DBI registers and limit config space to its
> length for i.MX6QP PCIe too.

You could probably flip these two sentences around to make the commit
message read slightly better, so what about this (a suggestion):

Define the length of the DBI registers and limit config space to its
length. This makes sure that the kernel does not access registers beyond
that point that otherwise would lead to an abort on a i.MX 6QuadPlus.

See commit 075af61c19cd ("PCI: imx6: Limit DBI register length") that
resolves a similar issue on a i.MX 6Quad PCIe.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0cf1333c0440..853ea8e82952 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1175,6 +1175,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX6QP,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> +		.dbi_length = 0x200,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
