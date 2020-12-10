Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCD2D5423
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 07:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgLJGsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 01:48:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbgLJGs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 01:48:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BA6lK6G058566;
        Thu, 10 Dec 2020 00:47:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607582840;
        bh=qgITTTZSkIihUU/af1ffR6ZvBdt+qsA59Qd9Not4R7E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FgOkCepwyKxkuu4EcETOJr2tWYn56YV4N8ZbOSd1mg7OzrL2hECkWyusJaJ9iny0J
         uzxgS8MLsHGhFWXczHaYU1wvoxhDQGShcmlejsn1+ZSFDPUJ9n5GcXkz2lb148/zZO
         jvWSW1j/XJT6UmLqu+hbUgpPbkEN1Fgk42A6FbdI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BA6lKQS086512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 00:47:20 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 00:47:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 00:47:20 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BA6lG7A048565;
        Thu, 10 Dec 2020 00:47:17 -0600
Subject: Re: [PATCH v2 0/3] PCI: J721E: Fix Broken DT w.r.t SYSCON DT
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20201204075117.10430-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6c846ae3-0bb5-f8de-0f3e-5e0239a7aa6c@ti.com>
Date:   Thu, 10 Dec 2020 12:17:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204075117.10430-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 04/12/20 1:21 pm, Kishon Vijay Abraham I wrote:
> Previously a subnode to syscon node was added which has the
> exact memory mapped address of pcie_ctrl but based on review comment
> provided by Rob [1], the offset is now being passed as argument to
> "ti,syscon-pcie-ctrl" phandle.
> 
> This series has both driver change and DT change. The driver change
> should be merged first and the driver takes care of maintaining old
> DT compatibility.

Can you queue the 1st two patches of this series for this merge window?
I'll ask NM to queue the DTS patch. Let me know if you want me to resend
only the first two patches as a separate series.

Thank You,
Kishon

> 
> Changes frm v1:
> *) Remove use of allOf in schema
> *) Added Fixes tag
> *) Maintain old DT compatibility
> 
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> 
> Kishon Vijay Abraham I (3):
>   dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
>   PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl"
>     phandle arg
>   arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
>     pcieX_ctrl
> 
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 11 +++--
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 11 +++--
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 48 ++++---------------
>  drivers/pci/controller/cadence/pci-j721e.c    | 28 +++++++----
>  4 files changed, 41 insertions(+), 57 deletions(-)
> 
