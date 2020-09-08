Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4D260AA7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgIHGNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 02:13:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:34653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgIHGNt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599545604;
        bh=FtvlKZBcLfL0ZeBa4yq1cs6S15KNeaEEgYiZUVowl6I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j+jw864NiUmoSbdyiy0n/Y/cYEeJYNPiZ1fYd50O8pvUU+cdWu+B3xd1wJTfRz8O5
         52QOkU7N4XxgFVYSLgNbwHBLL8qsOjLe0HZej2aITTpDBGVswKVcmmzctpShpwOYkw
         c5hFh4zKsBOMUe2ehpvXUAmm4XB7ri2V1mnKxZK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.76.97.104] ([185.76.97.104]) by web-mail.gmx.net
 (3c-app-gmx-bs38.server.lan [172.19.170.90]) (via HTTP); Tue, 8 Sep 2020
 08:13:24 +0200
MIME-Version: 1.0
Message-ID: <trinity-74abdbb2-2ddc-440a-85c8-97e80e9eb2ed-1599545604475@3c-app-gmx-bs38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chuanjia Liu <Chuanjia.Liu@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjun.wang@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v4 0/4] Split PCIe node to comply with hardware
 design
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 8 Sep 2020 08:13:24 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <1596440772.7361.35.camel@mhfsdcap03>
References: <20200721074915.14516-1-Chuanjia.Liu@mediatek.com>
 <1596440772.7361.35.camel@mhfsdcap03>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:i6KFmqNKBH4PPSKlvcjghT5P+X5pFNBaGxFipv86Hh4ReWRpG5btRSd5XiIXZJ19HB0fq
 lgu0117WGrFBfEeINB8o1KuUaaV7TDQ+uJfn2owNCVVBEH787lTai5JXTDzUs5z06ifZ6KkqM068
 CHEfY3tbNEchcofDgcxvyl1DyaeDsar+qW8RT1V4FwRahaaQCfEJSgVT4HuK6aL23QBZCK30Qbk6
 ADW5xYBonXsg7PVN/KC8zKrwMmW2+e+k2ZeFaiOGPrySBzn3oEwhiDFz5sdPNs7RNV7AY7gvORiL
 ls=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UuOHfeuoCbE=:9+dhFkMTeCWaxGimh72pme
 AXCI9Y9xGHGWKFDqsMgQqnWZrJY2YqBq76iSi1YO5tOrNKXrTSX3uqbY8fS/jP1WX2iMC9DYR
 +pX7nJGZ40FTXl+MGsiXRhVx7EviYmeoLucDYKbSX/S39Sn6YJvoegAOFfuXo1QwVFnLRmp/c
 HbxmmPfLit37E7Bqz6XkNszj9lsQId47HEH05CJyWDSb28/ugBq0fUAcyb3m09PslVweJv1rk
 qHaZddgaFRHrenOpq3ypq4qmj9nIenbCmmTL5ghmu2r3TcThugrBUHf7qboUSVQjZCyAuqpED
 auxdiMgcwe5tZ2YpuQT8qmidOi4snmZkPdUhay9XVMrm/2QA1FjHUphWv9swexNLYN8vsJoga
 zpk41DbFHEhCt/jlWLMkGVk0/P5BhfwQg4jLzaHctQfs4dNGsv4IZsG6wLCISutSVE54Ljri6
 aWuaF03BXX/k7NJIQniJIajWZnD1CpRHj77qSLYH58vyIXl6UwgHqNZ45x0fgE8hmkYIw2KHW
 nzldWFN0Z734a4GtfYqmFYrUW5zpU/997Jcj4nUOvbxLIM42TgZ7k5KTc7fqCmMDiPO+Bhy06
 kKlLKUW+gz+xbE3KHJoWQVdvX1PAA/8wnqhPtKeOZdtbYUUvlwWBrpqL4Qp7DWrg2n9wDXPdS
 N6xjzIeB54WE6YbyD7LPBooLeXbpWBqIw3ypLvZNrWWcqtbeof5OMzbKHbash1xbryAE=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

i don't see this Patchset in 5.9-rc4

is anything missing?

regards Frank
