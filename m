Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7301D74B2
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgERKF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 06:05:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:2449 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgERKF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 06:05:27 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 May 2020 19:05:25 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 26634180B84;
        Mon, 18 May 2020 19:05:26 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 18 May 2020 19:05:26 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id DEC7D41C5A;
        Mon, 18 May 2020 19:05:25 +0900 (JST)
Received: from [10.213.31.127] (unknown [10.213.31.127])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 26A161207BB;
        Mon, 18 May 2020 19:05:25 +0900 (JST)
Subject: Re: [PATCH v2 4/5] PCI: uniphier: Add iATU register support
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-5-git-send-email-hayashi.kunihiko@socionext.com>
 <DM5PR12MB1276D6181D86C8DF0F98427ADABD0@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <e3c5a841-7098-542d-cf71-9591fd24db5c@socionext.com>
Date:   Mon, 18 May 2020 19:05:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1276D6181D86C8DF0F98427ADABD0@DM5PR12MB1276.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 2020/05/15 22:16, Gustavo Pimentel wrote:
> Hi Kunihiko,
> 
> On Fri, May 15, 2020 at 10:59:2, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> 
>> This gets iATU register area from reg property. In Synopsis DWC version
> 
> s/Synopsis/Synopsys
> in all patches
Thank you for pointing out.
I'll fix and be careful about this.

Thank you,

---
Best Regards
Kunihiko Hayashi
