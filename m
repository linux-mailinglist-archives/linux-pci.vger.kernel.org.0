Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5740AFB4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhINNzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 09:55:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35097 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233217AbhINNzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 09:55:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id E3E1D580339;
        Tue, 14 Sep 2021 09:54:29 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 14 Sep 2021 09:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=o1rdGWrst3yz3l9o6PKhZvLFS00Y
        bNnCxVpsc8+ZQ0Q=; b=Tkq2hX5SCFOnZrVbkgcBZ6C6zgNZnqwDeKDEAjc0NlUx
        tw5bG6yUexZ4EiHLAk4a4XRv0dUTjluL6jp62KFZR+yzY5+2da7QpDhWFfra0FHZ
        hx+JqOyJ2RaarqAY0q7ysbF7dQH0E7nAspoMq1+jKJhdON/rPKJeS8FKPjXvYN7p
        AXx0GqctvFlNzuJFcACMJpAZdGaFX/neNQvEwM4Y7+OEuNSI0uiqQY+Xy7u/f/GW
        gBtxBoQl9Yc5AQWZVZnQ8pFbgvs8ZJnXMm6Lz418NB7BpuS7knvr+VoZlNnBosJK
        O2Uiwp3kLDlmYZSVbIXabkhOTb5T3gfAAwtD13h6xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=o1rdGW
        rst3yz3l9o6PKhZvLFS00YbNnCxVpsc8+ZQ0Q=; b=OTd+/B8/GhaKtCl5w+ORGZ
        V1Sy7PpckAAeRXVr8xCe8GPuN9wSnI3MjtEPqP43BGveZZaRGDxpad8//sZ7YxFM
        lO8caKEhcnCAtUsY2d+wzz4gAjlfF9HfvbkrCgdBlzg/VxsvXxmVPS5WO/d63i+f
        51PPUsBAXUoEtCFNClwnWx7krafITnQN78kI+5gwiN0wvJvQWtNL5rHjDyKNcqMH
        tuOGqLjWZ/tzYbxPiLelmUNlYMm6lDYh/7eWwP3LXbnjuftEZL7nOlBJdxrGtJcG
        HVwCMP9cplCcwho7HNWCBbPFd/yDV3lfI/ttXy8RN5176rbt2H6h7v3qpnVXp8pg
        ==
X-ME-Sender: <xms:k6lAYdv7JqoISe3lrX5D0y4S16ThaQHVo_KrWlBV9OP8IJOp_dFNXg>
    <xme:k6lAYWcauth90l5fAWQxijDbpHRN9IK-C1gDWGtoFFZ-nwh_Do6e6VR6OKHX6i7hE
    3pzGEj0sVOUUl60Z9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
    geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:lKlAYQwgShuYZRz0nDGskuRWSkl7oNvRViw9Zj43VNfeJePf-eTYPA>
    <xmx:lKlAYUPZTW9WZLQzjppIYv7a7iuVgDs5dSASbuc6DZKddu8KZlXNEA>
    <xmx:lKlAYd93X_WmtOjDPurl38ReC6DvgqgDW80CvyTWXHqYGcWEei1eNA>
    <xmx:lalAYUWubXw0R-fU5jlgsxl97F3gUCmqxtgmvOpoJ-YW2wRfr8qv8A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C241151C0060; Tue, 14 Sep 2021 09:54:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <479322ce-b0e4-40e4-831e-387415b4e310@www.fastmail.com>
In-Reply-To: <20210913182550.264165-10-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-10-maz@kernel.org>
Date:   Tue, 14 Sep 2021 15:54:07 +0200
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
Subject: =?UTF-8?Q?Re:_[PATCH_v3_09/10]_iommu/dart:_Exclude_MSI_doorbell_from_PCI?=
 =?UTF-8?Q?e_device_IOVA_range?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> The MSI doorbell on Apple HW can be any address in the low 4GB
> range. However, the MSI write is matched by the PCIe block before
> hitting the iommu. It must thus be excluded from the IOVA range
> that is assigned to any PCIe device.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It's not pretty but I'm not aware of any better solution and this should
work as long as these two are always paired. With the small nit below
addressed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>

> ---
>  drivers/iommu/apple-dart.c          | 25 +++++++++++++++++++++++++
>  drivers/pci/controller/Kconfig      |  5 +++++
>  drivers/pci/controller/pcie-apple.c |  4 +++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 559db9259e65..d1456663688e 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -721,6 +721,29 @@ static int apple_dart_def_domain_type(struct device *dev)
>  	return 0;
>  }
>  
> +#define DOORBELL_ADDR	(CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR & PAGE_MASK)
> +
> +static void apple_dart_get_resv_regions(struct device *dev,
> +					struct list_head *head)
> +{
> +#ifdef CONFIG_PCIE_APPLE

I think using IS_ENABLED would be better here in case the pcie driver is built as
a module which would then only define CONFIG_PCIE_APPLE_MODULE AIUI.


Thanks,


Sven
