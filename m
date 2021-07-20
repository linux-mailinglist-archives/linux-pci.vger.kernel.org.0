Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA65B3CF131
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 03:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGTAd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 20:33:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:10511 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381046AbhGTA2Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jul 2021 20:28:25 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Jul 2021 10:08:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 8647A205902A;
        Tue, 20 Jul 2021 10:08:53 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 20 Jul 2021 10:08:53 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 52BE7B638F;
        Tue, 20 Jul 2021 10:08:53 +0900 (JST)
Received: from [10.212.31.2] (unknown [10.212.31.2])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 161D9B1D52;
        Tue, 20 Jul 2021 10:08:52 +0900 (JST)
Subject: Re: [PATCH] PCI: endpoint: Use sysfs_emit() in "show" functions
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210719034313.GA274232@rocinante>
 <af1d4c61-53ff-f4e9-a708-33251b7e6470@socionext.com>
 <20210719151837.GA473693@rocinante>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <6d10e89b-3518-faff-e320-6d03013567a1@socionext.com>
Date:   Tue, 20 Jul 2021 10:08:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719151837.GA473693@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 2021/07/20 0:18, Krzysztof Wilczy?ski wrote:
 > [+cc Sasha for visibility]
 >
 > Hi!
 >
 > [...]
 >>> Nice catch!
 >>
 >> I actually executed "cat" against configfs to meet the issue and found
 >> your solution in pci-sysfs.
 >
 > Oh!  That's not good...  I am curious, which attribute caused this?

Sorry I misunderstood.

I found this "cat" issue on next-20210713 and all configfs attribues had
the same issue.

However, my patch wasn't the solution for the issue. This has been fixed by
7fe1e79b59ba ("configfs: implement the .read_iter and .write_iter methods").

The function replacement was found in the process of finding the issue.

 > Also, if this is fixing a bug, then it might warrant letting the folks who look
 > after the long-term and stable kernels know.  I also wonder if there would be
 > something to add for the "Fixes:" tag, if there is a previous commit this
 > change fixes.

So my patch doesn't fix any issues.

Thank you,

---
Best Regards
Kunihiko Hayashi
