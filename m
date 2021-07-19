Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0603CD73B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jul 2021 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhGSOOZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 10:14:25 -0400
Received: from mx.socionext.com ([202.248.49.38]:2017 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhGSOOZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 10:14:25 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jul 2021 23:55:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 62CCB2022041;
        Mon, 19 Jul 2021 23:55:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 19 Jul 2021 23:55:04 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 310B4B631E;
        Mon, 19 Jul 2021 23:55:04 +0900 (JST)
Received: from [10.212.31.132] (unknown [10.212.31.132])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id A64B0B1D52;
        Mon, 19 Jul 2021 23:54:55 +0900 (JST)
Subject: Re: [PATCH] PCI: endpoint: Use sysfs_emit() in "show" functions
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210719034313.GA274232@rocinante>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <af1d4c61-53ff-f4e9-a708-33251b7e6470@socionext.com>
Date:   Mon, 19 Jul 2021 23:54:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719034313.GA274232@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

Thank you for reviewing.

On 2021/07/19 12:43, Krzysztof Wilczyński wrote:
> Hello Hayashi-san,
> 
> Thank you for sending the patch over!
> 
>> Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
>> check for buffer overruns in sysfs outputs.
> 
> Nice catch!

I actually executed "cat" against configfs to meet the issue and found
your solution in pci-sysfs.

> 
> A small nitpick: what you are changing here are technically not sysfs
> objects since all of these are related to configfs.  Having said that,
> configfs shares the same semantics for normal attributes with sysfs, so
> a maximum size of PAGE_SIZE applies here too, and thus sysfs_emit()
> would work fine.

Thank you for helpful information.
I understand that applying sysfs_emit() to configfs is no problem.

> 
> Thank you for taking care of this!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> 	Krzysztof
> 
Thank you,

---
Best Regards
Kunihiko Hayashi
