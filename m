Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD802425748
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhJGQDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 12:03:45 -0400
Received: from marcansoft.com ([212.63.210.85]:55784 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhJGQDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 12:03:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 574A2419BC;
        Thu,  7 Oct 2021 16:01:46 +0000 (UTC)
Subject: Re: [PATCH v5 11/14] arm64: apple: Add PCIe node
To:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com
References: <20210929163847.2807812-1-maz@kernel.org>
 <20210929163847.2807812-12-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <b7399231-22bc-f22a-52f1-f56cc292ea06@marcan.st>
Date:   Fri, 8 Oct 2021 01:01:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929163847.2807812-12-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/09/2021 01.38, Marc Zyngier wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Add node corresponding to the apcie,t8103 node in the
> Apple device tree for the Mac mini (M1, 2020).
> 
> Power domain references and DART (IOMMU) references are left out
> at the moment and will be added once the appropriate bindings have
> been settled upon.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210921183420.436-5-kettenis@openbsd.org
> ---
>   arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
