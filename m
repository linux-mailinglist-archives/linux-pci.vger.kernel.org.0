Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234A429FDF1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 07:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgJ3Gpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 02:45:41 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2211 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3Gpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 02:45:41 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9bb6970000>; Thu, 29 Oct 2020 23:45:43 -0700
Received: from [10.40.204.14] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 06:45:30 +0000
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
To:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201029053959.31361-1-vidyas@nvidia.com>
 <20201029053959.31361-3-vidyas@nvidia.com>
 <SL2P216MB04759A928ACAA6F411718E01AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3695ce8b-1635-750e-eb81-d453a828378d@nvidia.com>
Date:   Fri, 30 Oct 2020 12:15:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <SL2P216MB04759A928ACAA6F411718E01AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604040343; bh=GWjtJhVGhiEd9MgQUBVrG6Pzm5milcqorcIchRc378U=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hF1y2OpGXwlSUq4cllI7lJQq5AG/LWvWcYSYe4E6HeuV+5Hyid+cv2H9FTN3U2qZd
         zmV0wpRlHSIFUBTHq5EVg0+OcCHheYRKCMJh6zNpkWJE8K5m6gctHd1EK0tnoII4eI
         ir6OGvlWO6fyaWT5NFoNiQhJo2sVk32l+cWZYmKiILIi5IDxtPKwtx92Rt2wRKQCjo
         8vaVQ6+n/QeoHb5K+e2m/AGC31rhSrS/plkvSY1CnaVrXPn/DYa3vOdMYYiF1/1PSD
         ErgOnptwRsFhrrveQkb0SpOqeaNiEuA7xEnz/8E1pdswz81V1H2RmKKq+xHRh4FWHR
         ha33MAr+YJ7YQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/30/2020 3:33 AM, Jingoo Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 10/29/20, 1:40 AM, Vidya Sagar wrote:
>>
>> DesignWare core has a TLP digest (TD) override bit in one of the control
>> registers of ATU. This bit also needs to be programmed for proper ECRC
>> functionality. This is currently identified as an issue with DesignWare
>> IP version 4.90a. This patch does the required programming in ATU upon
>> querying the system policy for ECRC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> 
> No, it should be Acked-by. I gave you Acked-by, not Reviewed-by.
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
Apologies. My bad. I saw the 'Reviewed-by' of the other patch (i.e. 
PCI/AER: Add pcie_is_ecrc_enabled() API) and put that for this patch as 
well. I'll update.

> 
> 
> Best regards,
> Jingoo Han
> 
>> ---
>> V3:
>> * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
>>
>> V2:
>> * Addressed Jingoo's review comment
>> * Removed saving 'td' bit information in 'dw_pcie' structure
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>>   drivers/pci/controller/dwc/pcie-designware.h | 1 +
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> [...]
> 
