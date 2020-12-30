Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC302E76B1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 07:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgL3Gz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 01:55:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11368 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgL3Gz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 01:55:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fec24560000>; Tue, 29 Dec 2020 22:55:18 -0800
Received: from [10.25.75.115] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Dec
 2020 06:55:09 +0000
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201228040513.GA611645@bjorn-Precision-5520>
 <88d569d8-09c-6bfc-c246-f4989bfbc1@panix.com>
 <cb32b83e-108b-47e5-812-9c26712de9a0@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <73f7f072-583c-cf54-a034-55e2f1990c52@nvidia.com>
Date:   Wed, 30 Dec 2020 12:25:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cb32b83e-108b-47e5-812-9c26712de9a0@panix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1609311318; bh=pGhx0x6gcGo+CvOkFeFXFsYPgldX6j2ocaj4Tw3h3hw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=LI9Y2d9v9LWO9i0IsJCU936nhEmLtierdqwpd7WkoJB8nrHTI3TVsluR0Q9cTTN0k
         QEUipDdPJPegmWY9zDDH8nmB8AEbtdGaj3xuMjAp/pGmHTurLgzKVuOHXKIqhF8jhC
         r4Rc6IYAy97gmSFrIhKQwAPR2eOIOW5SPbZy6qgDJ0tbeIQgWtBKwInDGGTiP2KEzu
         Hi1TO8GNSAWUqhySXdz9qiDECx99m8VK+M6+m/PHfsH03g9HxxT4/YrQYUQARxcrhY
         E4VBOoFPPOjqsknzksSMeN6GXs+2h3pifzCn5HBBJV/Ns0/Qk6JbQCDP1bN3Lu4XpD
         yAB+P43tccO5A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ideally Bjorn's patch should have worked.
Could you please collect 'sudo lspci -vv' (please don't forget to give 
sudo) with Bjorn's patch before and after hibernate?
Also, is it right to say that with policy set to "performance" there is 
no issue during hibernate/resume?

- Vidya Sagar

On 12/28/2020 12:00 PM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 27 Dec 2020, Kenneth R. Crudup wrote:
> 
>> I'll try your patch after the revert and see if anything changes.
> 
> I just realized today's patch makes no sense if it's reverted, so nevermind.
> 
>          -Kenny
> 
> --
> Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
