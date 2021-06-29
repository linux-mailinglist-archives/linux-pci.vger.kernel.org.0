Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867713B714E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhF2L26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 07:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbhF2L26 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 07:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE8061DAC;
        Tue, 29 Jun 2021 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624965991;
        bh=F30hBRWClVvbBmTrrAiINYq8PfBD0IeyRejhMfNe8HI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bv7Q/bJabeGrvtp/eoCESx/GBrSDJ/OwQPDgjEq55Yc4PgbexRakbi5VVkln1j/S0
         4ub4D+srGvKv8296+h9MHI/6+7XBatQ1bPQerLGeD58WSpQK9WR3UTAZsl1KWNZjhI
         VgSiKKL+HGSKWSEmqW+Lyr5fhZnEH3bI8iJWPSi957+Rg1CNw+YZPXnVv20eyQIxAh
         hblJ6I9hj/ppVFYHsTaI5FPhKdyK8bsShoiGXILVOTKjRrzI3GtyCl6Yvd9txhrIb7
         57BfwFWG+ZoqCuPLf8UlNLOLQDxAAP1l/xAlF2ICt8ZogPGHfl+o2C97S59OBtb7G0
         9ctkLP4Y3Mf/A==
Subject: Re: [PATCH V5 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20210629085521.2976352-1-chenhuacai@loongson.cn>
 <20210629085521.2976352-2-chenhuacai@loongson.cn>
 <980b31f6-d9ad-802b-1b9d-4c882f75fa50@kernel.org>
 <CAAhV-H637pWg03KLUz4-CKLweqLmM+RH1DbfidT2pq=eVhO9OA@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <5badf90a-1b85-692e-2206-a1fdf06f5543@kernel.org>
Date:   Tue, 29 Jun 2021 14:26:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H637pWg03KLUz4-CKLweqLmM+RH1DbfidT2pq=eVhO9OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/29/2021 1:35 PM, Huacai Chen wrote:
> Yes, this is more or less a quirk, and we have already found the root
> cause in hardware. However, as I said before, there are other
> platforms that also have similar problems.

Proper way is to fix the driver's shutdown routine not workaround it.

Even if that's not possible, Is there a reason why we cannot quirk them
too if they are broken?

If you are aware of such other platforms, please file a bug.
We should get the owner's to look.


