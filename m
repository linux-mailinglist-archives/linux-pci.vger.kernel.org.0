Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5156D13A2EF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgANIYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:24:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgANIYx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 03:24:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 88C923E44881A71F48EE;
        Tue, 14 Jan 2020 16:24:49 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 16:24:39 +0800
Subject: Re: PCI: bus resource allocation error
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
 <1bcc117a-3fce-35c2-a52c-f417db3ce030@hisilicon.com>
 <PSXP216MB0438E92832F08A1AEC015D8180380@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <376bafc4-b2a2-a08f-3aa1-8be69ce909a5@hisilicon.com>
Date:   Tue, 14 Jan 2020 16:25:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438E92832F08A1AEC015D8180380@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I cannot get the log on the original machine.
So I tested on another one and got the same error prints.
You can find the console output at
https://paste.ubuntu.com/p/5VHVnKWSty/
as well as the "lspci -xxxx" infomation.

Thanks,
Yang

On 2020/1/10 15:40, Nicholas Johnson wrote:
> Hi,
>
> On Fri, Jan 10, 2020 at 03:33:27PM +0800, Yicong Yang wrote:
>> Hi,
>>
>> It seems the attachments are blocked by the server.
>> The necessary console output is below.
>> The kernel version is 5.4, centos release 7.6.  I didn't
>> change the PCI codes.
> It is very difficult for me to get the wider picture of your system 
> without the full output of "sudo lspci -xxxx". Can you place them on 
> PasteBin and send the links, rather than attaching them directly?
>
> I can try to speculate based on what you sent, but I cannot be sure it 
> will be enough. For example, I do not know if your computer has multiple 
> root complexes, which have shown to complicate things.
>
> Thanks!
>
>


