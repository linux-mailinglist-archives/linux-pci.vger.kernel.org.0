Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E052222D
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiEJRXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347883AbiEJRXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 13:23:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423E239D83;
        Tue, 10 May 2022 10:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiL3qjNIqnieqx6g28PTF0iqG3cosrNpsLDFR+vSOSTv76kKG2ntQ8kZS/+3xCqEu8O9SEGlcqc7/0y6EYaBwFTtuqpuzEABoTRtqPalWkviGqvg7ElQXc8GM3IV8r7N1MgVxe2p0KH9nRHWmq0ZelIPiOjMptQMBThZXy0X9vqaYIDZEhqsgAag6g/1kArPGmSgSPiry291Bo093B9dLQfUZvqi89lPzOKWbd2n5ezldUDjNN4RkKyyJW8iTUjYbsBW6ZztCiD5tIy2VXNYftH6HHEsLSrOjz52IcxwsexJk21VWJjbgbhLLYWS669fxY/MzCcprenpHslfrNMAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARNY4n9av3Owx4GbO/Nx8CiNiF3VUxSNWrvpDjK+97c=;
 b=dT5dTDJK6aiiIe3E7ItrWYMRsFveQmowJ+o+CKc/I2E1QUzvX+SWlXtNVD4K+FSJEVEw3PgGNkF5Xd2hDjSAICKtq+5Q8zJ6OcIsRS38Pmib8WFs1uiEd8zPwU5a/N2GZ8WQRGaFQn2Kxv2WJMqjRjFce4ER1A5RGLOMK9xAEm9y4BJwUOyvCcUPelBRAT7ma6586moz/v6q2vuuZDfmRjoiRB5lQ3L6PycmkR9veDEGrjXJK2vFQROHTsdheEvE8bNNMxbtzC53ec22jIIVFBjjM+yPpLUj6Hj21kPsqpeqMw7oYn/e3DSVfWVofs2tWhbntuZDJiSlgBA6io4fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARNY4n9av3Owx4GbO/Nx8CiNiF3VUxSNWrvpDjK+97c=;
 b=kQZ50sKGXZjcRiz7zh2lhFN075pNQ2luyC/TqZ18wP2ZaUGhu4WJJi/+10gdwpTz/8pCcBZk67LDFhmbtYVKuR6Y8RA6kLTtBNLcsKY0/114SjD9W+Mnjaf/ifNQJ84s5HTw+NFU+FnDy180IXEtKwa+l37W6fSEnADjCeAocdI=
Received: from SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34)
 by SJ0PR02MB8813.namprd02.prod.outlook.com (2603:10b6:a03:3d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 17:19:00 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::1) by SN1PR12CA0099.outlook.office365.com
 (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 17:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 17:19:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 10:18:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 10:18:58 -0700
Envelope-to: robh@kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.254.241.50] (port=39360)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1noTVh-0004EE-Qa; Tue, 10 May 2022 10:18:58 -0700
Message-ID: <3169f67c-a056-2693-8792-4a6df20175d4@xilinx.com>
Date:   Tue, 10 May 2022 19:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com>
 <eea7db0b-b483-e61c-8f2d-174f2032fd51@xilinx.com>
 <CAL_JsqJj_CPPn9+by3rSpSXW9ufUcbsUbNbE3wE5qFRrJ-PjKg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <CAL_JsqJj_CPPn9+by3rSpSXW9ufUcbsUbNbE3wE5qFRrJ-PjKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d5c31f-1e3c-4452-b264-08da32a92c7c
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8813:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB88134D8D569AFB47D7E16770C6C99@SJ0PR02MB8813.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSv/qiKJYbLGkRDgvaek27rGxdQjzqKgwo1eL2jK8R/zICVkqHwywTZMcGoiLAApF4JygAk5JBla3Her4ZyiJSUGbvVxhQskDFQVI99Mw3+Vu6s2c62Z6k4ffVlQAnWIG1d4e0krNxKe1n7+Hiol4oAmpIstwAwCe8MKQclnaRVRh20fnfcL8RS0pJg7S4OizPZ3GPzfXTHt8TvCJqREechCT026CAsT2vky6xOJ3W85y7Iycyl+sBbdsAxVNRV5zc/XFcnj5c8lYZbSx8PNgyi92K59ExnCSZYe4kWZ5lIRggzTTe631i6/D9aLd1/Yh24ZhLRKlTrzifwzi6teBkVRheSedluDoXUWQYIJw7pxequmprO76vUNDXioqs6Maiy3JpNNrXo8+Dbizi7YSxPFgVC1/H8whRgslb0AuKv03iXb3w7sGIqjeHy+uM0Prg5I0jWtO7/H+jGYLtCvL5Yo+mvckGtW2i5pDVDmaRsctc7PicL/XaIjf+EQjjgApOC8Ql9lhzVx6wc+arSK6l+m6Gl91boTtyiJQ19GteIdmu38JAVJergUWcKoIrqs/ZzovFq8sn7ypOPvIvbLh89IqQ01YVmFVcf2xuy73PsiEERFVDaWEbR4hTbm6SlEGwUQ7ySczpTDGw6CFyVAtmkCSJg87b9LIxmAA1KGq9+f4KMuLk/ModLyF7mp63gbXC9c2agbbN7EsXBrG0gNyyqsvjpmxqiR+AVGZeLcojvXJiZ1gJCbVCIctN587crR6tbOcQxnwZ0rrzwuvhH/RC4Zfe9jvcS4cq/uV8BG+yJQwDh3ah/AgMh45Zd99qC3
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(7636003)(110136005)(54906003)(36756003)(2616005)(31686004)(36860700001)(70206006)(356005)(8676002)(4326008)(316002)(53546011)(47076005)(26005)(426003)(6666004)(40460700003)(70586007)(966005)(8936002)(2906002)(83380400001)(9786002)(508600001)(5660300002)(186003)(44832011)(31696002)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 17:19:00.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d5c31f-1e3c-4452-b264-08da32a92c7c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8813
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/10/22 18:00, Rob Herring wrote:
> On Tue, May 10, 2022 at 2:29 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>
>>
>> On 5/4/22 17:43, Rob Herring wrote:
>>> On Fri, Apr 29, 2022 at 8:02 AM Bharat Kumar Gogada
>>> <bharat.kumar.gogada@xilinx.com> wrote:
>>>>
>>>> Describe cpm reg property before cfg reg property to align with
>>>> node name.
>>>
>>> The order is an ABI. If breaking it is okay, explain why here.
>>
>> I didn't push any description for versal to upstream u-boot or linux yet but
>> xilinx is using this order for years. DT binding order wasn't aligned to it.
>>
>> For example: (Xilinx Linux is in sync with this).
>> https://github.com/Xilinx/u-boot-xlnx/blob/master/arch/arm/dts/versal.dtsi
> 
> Good to know, but if there are upstream dts files, what do they use?

I didn't push any versal DTs. But origin source are my xilinx repos where we 
have this order:

reg = <0x0 0xfca10000 0x0 0x1000>, <0x6 0x00000000 0x0 0x1000000>;


> 
>> Driver itself is working with reg-names and order of regs doesn't matter. It
>> means changed order doesn't break any functionality.
> 
> While in general I consider the order part of the ABI, if that's
> enough to avoid breakage on anything you care about, then just state
> that.

right.

> 
>> Right now reg order really matter in binding doc but would be good in these
>> examples to record that both ways are fine.
>> Would it be better to describe that both ways are fine?
> 
> Only if that's what you need. If you are fine with the order changing,
> then make the change and fix all the dts files.

I structure DT files in a way that we have versal.dtsi as description for all 
fixed peripherals. All platforms, boards are just sourcing it. That's why change 
is simple but this issue is really just in dt binding doc than our dts file 
which all uses order mentioned above.


>>
>>     reg-names:
>>       oneOf:
>>       - items:
>>         - const: cfg
>>         - const: cpm_slcr
>>       - items:
>>         - const: cpm_slcr
>>         - const: cfg
>>
>>
>> Another small reason is that all hard IPs in Versal are normally placed below
>> 4GB address range. And there are some others which also have mapping above. This
>> is one of that example and we normally aligned with 32bit address.
>>
>> And the biggest reason is that current node name is pcie@fca10000 which should
>> be aligned with the first register base which is before this patch 0x600000000
>> but name suggest that the first reg should be cpm_slcr instead of cfg. That's
>> why I consider this patch as a fix and the patch should contain fixed tag.
> 
> I don't disagree. I'm only asking for a better commit message.

Great.
Bharat: Please update commit message and sent new version.

Thanks,
Michal
