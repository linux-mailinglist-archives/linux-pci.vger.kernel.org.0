Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B952565E2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZJsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 05:48:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4361 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZJsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 05:48:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d133f5f0000>; Wed, 26 Jun 2019 02:48:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 26 Jun 2019 02:48:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 26 Jun 2019 02:48:13 -0700
Received: from [10.24.47.31] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Jun
 2019 09:48:09 +0000
Subject: Re: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 &
 Tegra30
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC:     Thierry Reding <thierry.reding@gmail.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190618073810.30270-1-vidyas@nvidia.com>
 <20190620111854.GA15501@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7eef7afa-e61f-e2ff-f429-338fc2008792@nvidia.com>
Date:   Wed, 26 Jun 2019 15:18:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190620111854.GA15501@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561542495; bh=XTAmoN+lvAZ098uaoKf9ignkET7M76DLX8Bn9FgNknc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mB5gii9KGPq1VEmQZ36N1PbtGXz9ms5pU+1QLy4myylFp0BUCin2PHrQiDDIyrynU
         uM21URXDKDdtS9MTFL2j8fLaPHj8sxTpGnQ/bQWyvnLCw2lYzB4aY/dM+9W7QGS05+
         UbsUnmMrz8mT6Sg/evDS6ROmVVPvqh/yjU9ni5KLeq62yXCjBiBg2erOyKjgIwz3MM
         xzX4nlAbI3UmagZ02RPnCfMrQfoyQdhNKC8YEP6bHGxppPptbL5t3Qlx9bkIdMmnBR
         uXc+M9BdQc7bZhgtHD65Vt6xINp/ThyEY+82EtORdqqeFCsC6zRk2ybAJX6Lz9Wmx/
         ezSTTAhLQOGwg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/20/2019 4:48 PM, Thierry Reding wrote:
> On Tue, Jun 18, 2019 at 01:08:10PM +0530, Vidya Sagar wrote:
>> Currently Relaxed Ordering bit in the configuration space is enabled for
>> all devices whereas it should be enabled only for root ports for Tegra20
>> and Tegra30 chips to avoid deadlock in hardware.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/pci-tegra.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
Bjorn / Lorenzo,
Can you please consider this patch?

Thanks,
Vidya Sagar
