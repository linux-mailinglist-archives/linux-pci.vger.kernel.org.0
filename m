Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27C7409E54
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhIMUrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:47:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34997 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242818AbhIMUrU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:47:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 19635580DFD;
        Mon, 13 Sep 2021 16:46:04 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 13 Sep 2021 16:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=PfoyBwEONGeRoetozh4VCrcWNl2W
        CSyw2EgpFS0D5cI=; b=k1mMXwbiYYKILsn2bMLbgszknQRsbYl8plnufj6LOySp
        6HazilS3iMP4mdZKQUXl7NGkrndHiaMXO5DmyPwjsX3Sd9EE603ZfkJK9RD5neY0
        1PIzm9otjEK9m1PgswIfeCK1O/oNTY9dpuao00737PgzxbICzd9ydM2WMKULAMNf
        +ALlHEsWBS1DTz+9Ng5Bgmqk0ScWxm6eGaKaI5bh6fDKZCf3JEzM1D+2l04wDJhw
        LU7CPAYHz0Dy0WcJX84EczLugcJxQZVcdQTrvgrC8lc3x6/NnaG3EanVyxuqWMkv
        0i5X2AmYBg2SN9MCk7751leNtahKNwRIZdrW/MXthg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PfoyBw
        EONGeRoetozh4VCrcWNl2WCSyw2EgpFS0D5cI=; b=YPDQgZUHQ2A5ycPuflPU0j
        fNjm9aVJkyyeL8n0G0WbCTqBwGzlOJLUO06HjHM24+Rn8GdDDussHZ/Edi8UZdcd
        cmM59uhX/D6rpIVRxvc0fvs9VIp7x2+hPIgRTjX50CubSnfDEPkWkLXTlM6lb1+p
        b+AkJ2cy/XE3yheGu9kY1lRqVuAKDRWKoELlws6FzHceLVeyBR7jrH4JAd6AQJ2b
        nkrRjnf4TRNBnE7GCjnYsV/AiJznhv7R6oQOLFVOzfJpQpBNroHtFr2mU7cm3rAO
        tbdK/Cg24AL3filKekCBKZ4R9MWwQ+NkwAUvfa2bcw33cm+eivqAycXRTsfUwArw
        ==
X-ME-Sender: <xms:irg_Yb2YnMOcs-u5R2BCwC7xMkJOL4MOsZJTMGw6E5-1vGIQ3npi4Q>
    <xme:irg_YaHyGPc4HQM8FlFhVYZacLvgCX_HTQYAtT88aOx98ME4OTaQ_UKrhXSFccjUo
    lPN6XCQB1xpInmuVbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegjedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
    hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:irg_Yb5MaOHGY-wC4_JCR-lQ_33Q4PjyZgGXPXB8b0oPIM3tF2soTA>
    <xmx:irg_YQ3NZnbOQSKcqFEx_7bqkB8KvOMYAvWXr4IUS3vQvCEeXYpZrg>
    <xmx:irg_YeHAPlDigLLTaEWNtGSzn8Kqt1Ngyltd6SbKISzGwN2LOW-MOQ>
    <xmx:jLg_YZ-6842H3o-Ag_-Ql80arHOBU1hNuV5gqLOCnB-yo7g6Tumonw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9509A51C0060; Mon, 13 Sep 2021 16:46:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <b502383a-fe68-498a-b714-7832d3c8703e@www.fastmail.com>
In-Reply-To: <20210913182550.264165-11-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-11-maz@kernel.org>
Date:   Mon, 13 Sep 2021 22:45:13 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Robin Murphy" <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: =?UTF-8?Q?Re:_[PATCH_v3_10/10]_PCI:_apple:_Configure_RID_to_SID_mapper_o?=
 =?UTF-8?Q?n_device_addition?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> The Apple PCIe controller doesn't directly feed the endpoint's
> Requester ID to the IOMMU (DART), but instead maps RIDs onto
> Stream IDs (SIDs). The DART and the PCIe controller must thus
> agree on the SIDs that are used for translation (by using
> the 'iommu-map' property).
> 
> For this purpose, parse the 'iommu-map' property each time a
> device gets added, and use the resulting translation to configure
> the PCIe RID-to-SID mapper. Similarily, remove the translation
> if/when the device gets removed.
> 
> This is all driven from a bus notifier which gets registered at
> probe time. Hopefully this is the only PCI controller driver
> in the whole system.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pcie-apple.c | 158 +++++++++++++++++++++++++++-
>  1 file changed, 156 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c 
> b/drivers/pci/controller/pcie-apple.c
> index 76344223245d..68d71eabe708 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -23,8 +23,10 @@
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/notifier.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
>  
> @@ -116,6 +118,8 @@
>  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
>  #define PORT_PREFMEM_ENABLE		0x00994
>  
> +#define MAX_RID2SID			64

Do these actually have 64 slots? I thought that was only for
the Thunderbolt controllers and that these only had 16.
I never checked it myself though and it doesn't make much
of a difference for now since only four different RIDs will
ever be connected anyway.



Sven
