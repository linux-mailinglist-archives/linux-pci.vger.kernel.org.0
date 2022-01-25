Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC949AC78
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 07:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353694AbiAYGip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 01:38:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbiAYGg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 01:36:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20P6aK79060164;
        Tue, 25 Jan 2022 00:36:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643092580;
        bh=0ahs03idH8cYYf0yCflB2h0MYTuJLcMpZXgSS7OYavk=;
        h=Subject:CC:References:From:To:Date:In-Reply-To;
        b=wdTr5U2xMvJv4ekstl2CmYehRTvcVI/GvCl5+1enm780PVT2g3vqNrrO2/DmNSy38
         QiXWGWyyVpKcM8mmZR3B/ePGD8RS3CS3URJJycAokW/3CmW6LzzmjZcNI1Vt9T3E5A
         i6EP1gdaJCQfeBVJfowckqdhSPmB2KE8XtvfbMZc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20P6aJUw011293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jan 2022 00:36:20 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 25
 Jan 2022 00:36:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 25 Jan 2022 00:36:19 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20P6aGqH071812;
        Tue, 25 Jan 2022 00:36:17 -0600
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e: Add device id for J721S2
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211130035608.13492-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <ab490690-eac2-c714-1359-b4058e2f98ff@ti.com>
Date:   Tue, 25 Jan 2022 12:06:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130035608.13492-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 30/11/21 9:26 am, Aswath Govindraju wrote:
> Document the device id of J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 

May I know if this patch can be picked up?

Thanks,
Aswath

> changes since v1:
> - changed (oneOf, items) into enum
> 
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index cc900202df29..41df8f1c2d4c 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -64,13 +64,11 @@ properties:
>      const: 0x104c
>  
>    device-id:
> -    oneOf:
> -      - items:
> -          - const: 0xb00d
> -      - items:
> -          - const: 0xb00f
> -      - items:
> -          - const: 0xb010
> +    enum:
> +      - 0xb00d
> +      - 0xb00f
> +      - 0xb010
> +      - 0xb013
>  
>    msi-map: true
>  
> 

