Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA91DF3ED
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 03:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgEWBsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 21:48:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44472 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgEWBsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 21:48:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04N1lrnx103671;
        Fri, 22 May 2020 20:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590198473;
        bh=yiS4eaMZLr5N5lmPgiZnhfhO2vD8vhckjgLQdVGEMjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S4YFKaPjhOkUmRmWvAvIofxQwMmQgsvHxCns71fok5YuWB7WhcCRLFKqmwszgJaPi
         PrEBqH060yekOMhsht0ZOKFWWEkEwoKoFWaoBvWAYnxyDT4xIJ2CNQGxtx3ckdnaBs
         xLSBF2n5eQBYQZkHWaFD0BLjVwIg3tCioxNciMes=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04N1lrQL067401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 20:47:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 20:47:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 20:47:52 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04N1lmIK029381;
        Fri, 22 May 2020 20:47:48 -0500
Subject: Re: [PATCH 00/19] Implement NTB Controller using multiple PCI EP
To:     Rob Herring <robh+dt@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20200514145927.17555-1-kishon@ti.com>
 <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d0c4c813-2af7-7fd4-e401-6fd5de69d4e4@ti.com>
Date:   Sat, 23 May 2020 07:17:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/22/2020 9:41 PM, Rob Herring wrote:
> On Thu, May 14, 2020 at 8:59 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> This series is about implementing SW defined NTB using
>> multiple endpoint instances. This series has been tested using
>> 2 endpoint instances in J7 connected to two DRA7 boards. However there
>> is nothing platform specific for the NTB functionality.
>>
>> This was presented in Linux Plumbers Conference. The presentation
>> can be found @ [1]
> 
> I'd like to know why putting this into DT is better than configfs.
> Does it solve some problem? Doing things in userspace is so much
> easier and more flexible than modifying and updating a DT.

It's a lot cleaner to have an endpoint function bound to two different endpoint
controller using device tree than configfs.

+    epf_bus {
+      compatible = "pci-epf-bus";
+
+      func@0 {
+        compatible = "pci-epf-ntb";
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";
+        reg = <0>;
+        epf,vendor-id = /bits/ 16 <0x104c>;
+        epf,device-id = /bits/ 16 <0xb00d>;
+        num-mws = <4>;
+        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
+      };

For device tree, just using phandles is enough and the driver can easily parse
DT to get EPCs bound to the endpoint function
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";

This would be
ln -s functions/pci-epf-ntb/func1 controllers/2900000.pcie-ep/
ln -s functions/pci-epf-ntb/func1 controllers/2910000.pcie-ep/

pci_epc_epf_link() should then maintain the order of EPC bound to EPF and
designate one as PRIMARY_INTERFACE and the second as SECONDARY_INTERFACE.
pci_epf_bind() should be made to behave differently for NTB case.

While the standard properties (like vendorid, deviceid) has configfs entries,
additional logic would be required for adding function specific fields like
num-mws and mws-size above.

While all this support could be added in configfs, it looks simpler to
represent then in DT.

> 
> I don't really think the PCI endpoint stuff is mature enough to be
> putting into DT either.

I think this will anyways come when we have to export real HW peripherals to
the remote HOST using EP controller.

Thanks
Kishon
