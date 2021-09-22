Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21412415268
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhIVVK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 17:10:26 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43399 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237759AbhIVVK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 17:10:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 603C0580595;
        Wed, 22 Sep 2021 17:08:55 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 17:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=mtdkC9smfEGkMzwp5suu4GvLvKNj
        WQU2LGQHltLYlT4=; b=S1hEFyFv9XbXLQhnLt70N1EPGX/H3bqcz7U/MTIXWzkw
        wjFnltIWbkCxSWXhkZ09pkN9PBdvJcXgXaaZDg43vKzH86JWQAFF0P16qRNxDusR
        DSOVexTv9E329Q/vNDDRarloQdeRlcCsgCvxbDGoHLAmzIAo6589gJodPaXg3cqL
        wSMdKh6hh65xGeeceNltm/HQZD/grayJnUa5Xn5ZEkFy2PDyG1+JWR/Rd1pQdkXa
        CDJI2hQvclzQdDj6qpE8xKRKDNH6/uiVm415vxyBkTGX3BpepJMpnbsYdsi0jH5h
        /gMQuiINTLrDZLwjGMHlSP1QAcsMFSlhqBGEE5X2qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mtdkC9
        smfEGkMzwp5suu4GvLvKNjWQU2LGQHltLYlT4=; b=dO0DKpYX8ksx/l1tM1e/3h
        4PgDCXCTAx5CzpddSXz5rI6mss6MPKKpXPi+sO2vsKrEnAs2xOBhQNwT7iruX1Uk
        dBdHR87saCwTCBcBatfzVdNgri9VUL5I1lciIMr5Uh+ORBhf7Zp//GDFT8IIjSib
        f6AYJlTh3uONfUcAZqiGM27PGdIcHSvnWUjHG5p2dBT2GoePAQbmC+bji4hNov9a
        PpQeHJ8a2cBKg1shDxYtQtgQkuYr7c32DSjKdAiW6dytBHaCsT6HmW8lW1m4Hpcl
        wuJacvTn/fKTt+NyCiilH0n22pH37glqtJMhYCPSLm0YMr9ItK5sYF6lgN7OM/+g
        ==
X-ME-Sender: <xms:ZptLYaM3aQSub063T-u9M_oVgzdSZ8SYlZSyOaZCq8exahzXjS7ulQ>
    <xme:ZptLYY8-A1UBpyV6drToJYdkWbBgbKz5Lj9IuwocOhlB_P2IxJvuu9SCzIype1K-r
    fZ235nsNS8giSTtC4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ZptLYRR1ysE6ysxMFcC_EJolM675ZddONG6UYG1wbHEAqaVr_ypO5g>
    <xmx:ZptLYas9t_PU6dXz0UYx6uXUu404nxsxwIzE9iJFWPENu1n9qJ_A0Q>
    <xmx:ZptLYSeoVMaZIPUzx_hFgB5N8Q4ZXPieQS3NX3t2E8KM5z6X4Zuy4g>
    <xmx:Z5tLYe3mwGoWR4khHxQQCo45zl-3fXpebvo1c3_yyr8U6Y_YNjPycg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0652651C0060; Wed, 22 Sep 2021 17:08:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <86507f22-d824-4f7c-ba94-d3105c5206c2@www.fastmail.com>
In-Reply-To: <20210922205458.358517-5-maz@kernel.org>
References: <20210922205458.358517-1-maz@kernel.org>
 <20210922205458.358517-5-maz@kernel.org>
Date:   Wed, 22 Sep 2021 23:08:33 +0200
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
Subject: Re: [PATCH v4 04/10] PCI: apple: Add initial hardware bring-up
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On Wed, Sep 22, 2021, at 22:54, Marc Zyngier wrote:
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>
[...]
> +
> +	/* Use the first reg entry to work out the port index */
> +	port->idx = idx >> 11;
> +	port->pcie = pcie;
> +	port->np = np;
> +
> +	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
> +	if (IS_ERR(port->base))
> +		return -ENODEV;
> +
> +	rmw_set(PORT_APPCLK_EN, port + PORT_APPCLK);

I think this should be

    rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);

> +
> +	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> +	gpiod_set_value(reset, 1);
> +
> +	ret = readl_relaxed_poll_timeout(port->base + PORT_STATUS, stat,
> +					 stat & PORT_STATUS_READY, 100, 250000);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "port %pOF ready wait timeout\n", np);
> +		return ret;
> +	}
> +
> +	/* Flush writes and enable the link */
> +	dma_wmb();

I don't think this barrier is required.

> +
> +	writel_relaxed(PORT_LTSSMCTL_START, port->base + PORT_LTSSMCTL);
> +
> +	return 0;
> +}
> +
[...]


Looks good to me otherwise,

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,


Sven
