Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65534C386
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 08:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2GIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 02:08:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14176 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2GIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 02:08:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F82BB1RW4znWsB;
        Mon, 29 Mar 2021 14:05:38 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 14:07:53 +0800
Subject: Re: [PATCH] dt-bindings: PCI: hisi: Delete the useless HiSilicon PCIe
 file
To:     Zhou Wang <wangzhou1@hisilicon.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
 <2003b874-f692-09b3-732d-09ee2665fe7f@hisilicon.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <88e17f2c-fbc0-dafa-a24c-cebfd7f35b6e@huawei.com>
Date:   Mon, 29 Mar 2021 14:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2003b874-f692-09b3-732d-09ee2665fe7f@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zhou

Mant thanks for your review
On 2021/3/29 9:23, Zhou Wang wrote:
> On 2021/3/27 18:47, Dongdong Liu wrote:
>> The hisilicon-pcie.txt file is no longer useful since commit
>> c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
>> hip05/hip06 driver), so delete it.
>
> No, it is no needed now. Thanks for removing this, and please
> also remove related code in MAINTAINERS file :)
>
OK, Will do.

Thanks,
Dongdong
> Best,
> Zhou
>
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 43 ----------------------
>>  1 file changed, 43 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>> deleted file mode 100644
>> index d6796ef..0000000
>> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>> +++ /dev/null
>> @@ -1,43 +0,0 @@
>> -HiSilicon Hip05 and Hip06 PCIe host bridge DT description
>> -
>> -HiSilicon PCIe host controller is based on the Synopsys DesignWare PCI core.
>> -It shares common functions with the PCIe DesignWare core driver and inherits
>> -common properties defined in
>> -Documentation/devicetree/bindings/pci/designware-pcie.txt.
>> -
>> -Additional properties are described here:
>> -
>> -Required properties
>> -- compatible: Should contain "hisilicon,hip05-pcie" or "hisilicon,hip06-pcie".
>> -- reg: Should contain rc_dbi, config registers location and length.
>> -- reg-names: Must include the following entries:
>> -  "rc_dbi": controller configuration registers;
>> -  "config": PCIe configuration space registers.
>> -- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
>> -- port-id: Should be 0, 1, 2 or 3.
>> -
>> -Optional properties:
>> -- status: Either "ok" or "disabled".
>> -- dma-coherent: Present if DMA operations are coherent.
>> -
>> -Hip05 Example (note that Hip06 is the same except compatible):
>> -	pcie@b0080000 {
>> -		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
>> -		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
>> -		reg-names = "rc_dbi", "config";
>> -		bus-range = <0  15>;
>> -		msi-parent = <&its_pcie>;
>> -		#address-cells = <3>;
>> -		#size-cells = <2>;
>> -		device_type = "pci";
>> -		dma-coherent;
>> -		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
>> -		num-lanes = <8>;
>> -		port-id = <1>;
>> -		#interrupt-cells = <1>;
>> -		interrupt-map-mask = <0xf800 0 0 7>;
>> -		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
>> -				 0x0 0 0 2 &mbigen_pcie 2 11
>> -				 0x0 0 0 3 &mbigen_pcie 3 12
>> -				 0x0 0 0 4 &mbigen_pcie 4 13>;
>> -	};
>>
>
> .
>
