Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24193D27FC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJJLcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 07:32:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60586 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJLcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 07:32:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9ABWjjN016942;
        Thu, 10 Oct 2019 06:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570707165;
        bh=TpKArzSl6lBD7+MmSnD3ZjDvM3Q7de4dM9n8QXkNu+U=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=DcwvaIw993bG9WAtq8Y+Mk9ffRGkmPAa6i3tAybCvLoVKfJHIxUfMaHD8jaGVrXpm
         nm2Xs+g6soJo0+0DL3CVYPisHf0dv8VK8NsYMzwiCGrWDIS1RbkV7ioyXvSUS3cQW9
         MiDLK0yMc/h7K5dsQf2/3tgIEcM6u7g2I/Bu9b7I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9ABWjXk022543
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Oct 2019 06:32:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 10
 Oct 2019 06:32:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 10 Oct 2019 06:32:41 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9ABWhsW062910;
        Thu, 10 Oct 2019 06:32:44 -0500
Subject: Re: [Query] : PCIe - Endpoint Function
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        <linux-pci@vger.kernel.org>
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com>
Date:   Thu, 10 Oct 2019 17:02:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
> Hello,
> 
> I am currently working on adding pcie-endpoint support for a
> controller, this controller doesn't support outbound- inbound address
> translations, it has 1-1 mapping between the CPU and PCI addresses,
> the current endpoint framework is based on  outbound-inbound
> translations, what is the best approach to add this support, or is
> there any WIP already for it ?

How will the endpoint access host buffer without outbound ATU? I assume the PCI
address reserved for endpoint is not the full 32-bit or 64-bit address space?
In that case, the endpoint cannot directly access the host buffer (unless the
host already knows the address space of the endpoint and gives the endpoint an
address in its OB address space).

Thanks
Kishon
