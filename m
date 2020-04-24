Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B81B7D7B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgDXSDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 14:03:44 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17802 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbgDXSDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 14:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587751397; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=lwSKKc8bGEb08Yw9SQhy7JOaYUDCCnpIWNEoH4WfSQ3RFpxNt2R4VdiqkdhGys3P27TbMDGl/3nK43URBUL8mMOrL34WDuz12eEKXR59OC5MVSI+rTM4AByEXRyEAVgFckWrhqkkEIk1kt0p1nZU3Bjkcga2aD5npBltHqCcOUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1587751397; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=JFPPVC9jj5f6wCUGiIdI/tjl90bno75idKtqMqLKtKs=; 
        b=LsB8yPdBkTFg5CXrr4OaIpJEK70qHZK81+3QsZeHUhFBvvhDY3MbZMXg8UlGBDbzpVmQJNVmZ7deO3Yig9C04cA/oFa6yRcUDw218hQtOdE9VG3ceHyYJudK/mwnWTVmyjJfjxakOLP2MxQICSQvWh4lv555rTr6fUpWVxqFjvU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=flygoat.com;
        spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
        dmarc=pass header.from=<jiaxun.yang@flygoat.com> header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1587751397;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:CC:Subject:Reply-to:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=JFPPVC9jj5f6wCUGiIdI/tjl90bno75idKtqMqLKtKs=;
        b=PZMDSLIHrjQ5AXgEowlm2usG+vmi3H4R6zmuEZJyW/TKRLU5vq1Xrf/LI4kjJyBF
        TthGf/iJvUQf6UGPQ+nC1ebyN4qyQCMeSs93rcg0jlKv3ZJTJsra8QkgIdAE7hXuzR1
        Wlf4VlCwLcxePN0OuXB5DlxnBOBkEoRf0WnhUQeg=
Received: from [127.0.0.1] (122.235.213.3 [122.235.213.3]) by mx.zoho.com.cn
        with SMTPS id 1587751393295109.35899408288469; Sat, 25 Apr 2020 02:03:13 +0800 (CST)
Date:   Sat, 25 Apr 2020 02:03:11 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] PCI: OF: Don't remap iospace on unsupported platform
User-Agent: K-9 Mail for Android
Reply-to: jiaxun.yang@flygoat.com
In-Reply-To: <CAL_JsqKsZrsnn92XHL4QdFkAgFKqVTBZXDz9wVv-_7oywOOsBQ@mail.gmail.com>
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com> <20200424130847.328584-2-jiaxun.yang@flygoat.com> <CAL_JsqKsZrsnn92XHL4QdFkAgFKqVTBZXDz9wVv-_7oywOOsBQ@mail.gmail.com>
Message-ID: <D5CC0902-F84F-43F1-88E5-C03018B25050@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B44=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
:47:23, Rob Herring <robh+dt@kernel=2Eorg> =E5=86=99=E5=88=B0:
>On Fri, Apr 24, 2020 at 8:09 AM Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>=
 wrote:
>>
>> There are some platforms that don't support I/O space remapping
>> like MIPS=2E However, our PCI code will try to remap iospace
>> unconditionally and reject io resources on these platforms=2E
>>
>> So we should remove I/O space remapping check and use a range
>> check instead on these platforms=2E
>>
>> Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>> --
>> v4: Fix a typo in commit message=2E
>> v5: Commit message massage
>> ---
>>  drivers/pci/of=2Ec | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/of=2Ec b/drivers/pci/of=2Ec
>> index 81ceeaa6f1d5=2E=2E36e8761b66c6 100644
>> --- a/drivers/pci/of=2Ec
>> +++ b/drivers/pci/of=2Ec
>> @@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct device=
 *dev,
>>
>>                 switch (resource_type(res)) {
>>                 case IORESOURCE_IO:
>> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
>
>We already have the same condition in pci_remap_iospace()=2E All this
>does is suppress a WARN=2E If a WARN is not desired, then change it=2E
>Perhaps just a single line rather than backtrace would be okay=2E
>Whether to WARN or not shouldn't be a decision for firmware code=2E
>
>Though really, if I/O space can never be supported, then it's an error
>in your DT to describe it=2E

In MIPS world, we do have inb/oub family of I/O functions
to support I/O space=2E But we're not using remap_iospace as it's breaking
some of our assumptions=2E
We have our own inb/outb implementation=2E

In that case, I think make a range check instead of remapping would
be more practical=2E

Thanks=2E

>
>>                         err =3D devm_pci_remap_iospace(dev, res, iobase=
);
>>                         if (err) {
>>                                 dev_warn(dev, "error %d: failed to map =
resource %pR\n",
>>                                          err, res);
>>                                 resource_list_destroy_entry(win);
>>                         }
>> +#else
>> +                       /* Simply check if IO is inside the range */
>
>Why do you care if it's never used?
>
>> +                       if (res->end > IO_SPACE_LIMIT) {
>> +                               dev_warn(dev, "resource %pR out of the =
I/O range\n",
>> +                                       res);
>> +                               resource_list_destroy_entry(win);
>> +                       }
>> +#endif
>>                         break;
>>                 case IORESOURCE_MEM:
>>                         res_valid |=3D !(res->flags & IORESOURCE_PREFET=
CH);
>> --
>> 2=2E26=2E0=2Erc2
>>

--=20
Jiaxun Yang
