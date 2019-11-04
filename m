Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBBEDDD3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfKDLn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 06:43:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13413 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDLn6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 06:43:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc00f030000>; Mon, 04 Nov 2019 03:44:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 03:43:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 03:43:57 -0800
Received: from [10.25.75.8] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov
 2019 11:43:53 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <bhelgaas@google.com>
CC:     Thierry Reding <treding@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
 <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
 <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
 <afa16546-e63d-6eba-8be0-8e52339cd100@nvidia.com>
 <aed391af-f54c-c25e-43b9-ed9db01bd3cf@nvidia.com>
 <4424cd45-e441-0d8d-548e-5c025f48bb03@kernel.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <065d1b8a-29e1-9282-27ba-5512f9f4f1d4@nvidia.com>
Date:   Mon, 4 Nov 2019 17:13:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <4424cd45-e441-0d8d-548e-5c025f48bb03@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572867843; bh=gcy2haXpNW5l0d5bnASisCYz6bV/g3KmIK8t0wh0Pjs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eJ2t/pG6AtJ3pZAw84zry50ncfS++CgjZ+sawxj7CgRuWOV59SQ00NHCkEQfxxeNM
         ekFuZK4PPNbdHYxwAJjYi5FXIuA1d6jpklX6PxlKr/O6FOgDxUWIS6qEzG0xVmtBLA
         HtMRLKONlrkLwfnjT47xBMHvX3GKZaaNLP5P85pvDu0wn0bLAhspLDVPKYcc5FlOHT
         2BQve3GeQnygDfJI1vt9qKlMaQzMiMh2lrAmVjB/a0KfoWZ0xgTaUCmjWviCZR0z/o
         H7WAl6QsB7XJz4E8zqBLe90xFCI6SqJnbRIlpw2PL1TUpajaju3U925PlKLCSbytKv
         XZMYAboxUNwHQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/2019 7:29 PM, Sinan Kaya wrote:
> On 10/25/2019 7:58 AM, Vidya Sagar wrote:
>> On 10/21/2019 11:13 AM, Vidya Sagar wrote:
>>
>> Hi Sinan / Rafael,
>> Apologies for the ping again.
>> Do you guys have any further comments on this?
>>
>> -Vidya Sagar
> 
> I think you'll need some attention from Bjorn here to see the complete
> picture.
> 
> As I said, changing pci_device_is_present() is not right. This needs to
> be done at one level higher.

Hi Bjorn,
Could you please help me understand why this change can't be done in pci_device_is_present()
API?

- Vidya Sagar

> 

