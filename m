Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C518C6FF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 06:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgCTF22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 01:28:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36060 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTF21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 01:28:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K5SMrC082854;
        Fri, 20 Mar 2020 00:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584682102;
        bh=zHxYKKWIaosTlCILFLFF5LIC/0opcQMkhcXV4k8W0Vk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EDOe/aU7w2H0Iiq0xFVtuXZjiuDyhuWgpEeDD5791C9wvzPYgd49Mjt1Sw/kgamww
         qXyKOUDKryGmaIV/1EOUaId7h816hDoLG6r1Pzh5qFhan639Tf/PAwY7Pac2NiuCsk
         0fTYtDCxtr3jBKblt1qvlGoZoReCew7i5thvcDQA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02K5SMHB048636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 00:28:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 00:28:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 00:28:22 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K5SJu2015007;
        Fri, 20 Mar 2020 00:28:20 -0500
Subject: Re: PCIe EPF
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
Date:   Fri, 20 Mar 2020 10:58:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 3/18/2020 5:07 PM, Lad, Prabhakar wrote:
> Hi Kishon,
> 
> I rebased my rcar-endpoint patches on endpoint branch, which has
> support for streaming DMA API support, with this  read/write/copy
> tests failed, to make sure nothing hasn't changed on my driver I
> reverted the streaming DMA API patch
> 74b9b4da84c71418ceeaaeb78dc790376df92fea "misc: pci_endpoint_test: Use
> streaming DMA APIs for buffer allocation" and tests began to pass
> again.
> 
> If add a GFP_DMA flag for kzalloc (with streaming DMA), the test cases
> for read/write/copy pass as expected.
> 
> Could you please through some light why this could be happening.

Do you see any differences in the address returned by dma_map_single() like is
it 32-bit address or 64-bit address?

Thanks
Kishon
