Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6C430E99
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 06:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhJRET6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 00:19:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhJRET5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 00:19:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19I4HgBa015750;
        Sun, 17 Oct 2021 23:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634530662;
        bh=uK8Un6BEAjJA4vFp0uQJcU/uxzHzMOhc/QjBLD/GMCs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g9jYvVt088hxRhZCH11fN0WaPuyGsreOUz8IDsDx1BxzEo5VZ3PjmwtshCsocu8+G
         sXz+gMZ5Q6116yy5ip1jfwxkY7LOLv8OTMncvHEp6x5jeUiV7HIj5/3DSnJq2jtUzx
         zXVffl7Wi2djwFuFT+1LgNdIOnhpr0B/rZNAyS6E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19I4HgRb100323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 17 Oct 2021 23:17:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 17
 Oct 2021 23:17:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 17 Oct 2021 23:17:42 -0500
Received: from [10.250.233.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19I4Hd7w035463;
        Sun, 17 Oct 2021 23:17:40 -0500
Subject: Re: Linux PCIe EP NTB function
To:     Frank Li <frank.li@nxp.com>, "kw@linux.com" <kw@linux.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <AS8PR04MB850055DFB524C99D64560B6188B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
 <AS8PR04MB85008E09EAE36DFD6A51F4B588B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com>
Date:   Mon, 18 Oct 2021 09:47:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AS8PR04MB85008E09EAE36DFD6A51F4B588B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

On 15/10/21 2:10 am, Frank Li wrote:
> Sorry, correct Linux-pci mail list address.
> 
>> -----Original Message-----
>> From: Frank Li
>> Sent: Thursday, October 14, 2021 3:35 PM
>> To: kishon@ti.com; kw@linux.com; Sherry Sun <sherry.sun@nxp.com>; Richard
>> Zhu <hongxing.zhu@nxp.com>
>> Cc: inux-pci@vger.kernel.org
>> Subject: Linux PCIe EP NTB function
>>
>> Kishon:
>>
>> 	We use VOP(virtio over PCIe) communication between PCI RC and EP side.
>> But VOP already removed and switch into NTB solution.
>> 	I saw you submit patch and already accepted by community about pci-
>> epf-ntb.
>>
>> 	According to document, whole system work as Device1 (PCI host) -> EP1
>> -> EP2 -> Device2(PCI host).
>> 	But our user case is Device 1(RC Host) ->  Device 2(EP).
>>
>> 	I am not sure how to apply ntb frame work into this user case.

NTB by definition is PCIe RC-to-RC communication. For RC-to-EP, see
pci_endpoint_test.c (RC) and pci-epf-test.c (EP) that provides sample endpoint
usecase.

One more RC<->EP communication model was built in [1], but that is not yet
upstreamed.

[1] -> https://lore.kernel.org/r/20200702082143.25259-1-kishon@ti.com

Thanks,
Kishon

>>
>> 	I think we can modify pci-epf-ntb to register a ntb devices. But I am
>> not sure that this is recommunicate method.  I think this user case is
>> quite common. I don't want to implement a local solution.
>>
>> 	Any suggestion?
>>
>>
>> Best regards
>> Frank Li
