Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F442574C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbhJGQE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 12:04:26 -0400
Received: from marcansoft.com ([212.63.210.85]:55964 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhJGQEZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 12:04:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C2AE4419BC;
        Thu,  7 Oct 2021 16:02:25 +0000 (UTC)
Subject: Re: [PATCH v5 12/14] arm64: dts: apple: t8103: Add PCIe DARTs
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
 <20210929163847.2807812-13-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <6939501d-23b6-59ba-a2e4-b1217e7918a8@marcan.st>
Date:   Fri, 8 Oct 2021 01:02:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929163847.2807812-13-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/09/2021 01.38, Marc Zyngier wrote:
> PCIe on the Apple M1 (aka t8103) requires the use of IOMMUs (aka
> DARTs). Add the three instances that deal with the internal PCIe
> ports and route each port's traffic through its DART.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/boot/dts/apple/t8103.dtsi | 30 ++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
