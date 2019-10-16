Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C52D87A0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 06:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391119AbfJPEqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 00:46:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50834 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391117AbfJPEqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 00:46:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G4k1Q9130349;
        Tue, 15 Oct 2019 23:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571201161;
        bh=2e1ep+jz9ThULjwuPHURE/WBfxKsgQ0iJmPcL/PVeZo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SfJcnijlf1XwiD6nqRxlO3e9zzuqWTguFxaNWOVio66d/ssT0/dJd4IzEZMiEqzea
         KRFef42cOE1obpQC6z4BX4mf0X6fh08o33i9nOX+whSfsc1OK5JIeVQqRZuvJSc7ph
         cP+UWXKr3skoqMbAefp3lWgOo0a1IVNdamID15UA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9G4k1NQ001573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Oct 2019 23:46:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 15
 Oct 2019 23:45:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 15 Oct 2019 23:46:00 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G4jqTh107770;
        Tue, 15 Oct 2019 23:45:54 -0500
Subject: Re: [RFC PATCH 02/21] dt-bindings: PCI: Endpoint: Add DT bindings for
 PCI EPF Device
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
References: <20190926112933.8922-1-kishon@ti.com>
 <20190926112933.8922-3-kishon@ti.com> <20191015184243.GA10228@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <af3483e0-0533-4b13-64d1-b2cd6fedf514@ti.com>
Date:   Wed, 16 Oct 2019 10:15:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015184243.GA10228@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16/10/19 12:12 AM, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 04:59:14PM +0530, Kishon Vijay Abraham I wrote:
>> Add device tree bindings for PCI endpoint function device. The
>> nodes for PCI endpoint function device should be attached to
>> PCI endpoint function bus.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/endpoint/pci-epf.txt         | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
> 
> This and the previous patch for the bus should be combined and please 
> convert to a schema.

Sure Rob. Thanks for the review.

-Kishon
> 
>>
>> diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
>> new file mode 100644
>> index 000000000000..f006395fd526
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
>> @@ -0,0 +1,28 @@
>> +PCI Endpoint Function Device
>> +
>> +This describes the generic bindings to be used when a device has to be
>> +exposed to the remote host over PCIe. The device could be an actual
>> +peripheral in the platform or a virtual device created by the software.
>> +
>> +epcs : phandle to the endpoint controller device
>> +epc-names : the names of the endpoint controller device corresponding
>> +	    to the EPCs present in the *epcs* phandle
> 
> Other than the NTB case, I'd expect the parent device to be the 
> controller. Let's make NTB the exception...
> 
> 
>> +vendor-id: used to identify device manufacturer
>> +device-id: used to identify a particular device
>> +baseclass-code: used to classify the type of function the device performs
>> +subclass-code: used to identify more specifically the function of the device
> 
> Are these codes standard?
> 
> Powerpc has "class-code" already...
> 
>> +subsys-vendor-id: used to identify vendor of the add-in card or subsystem
> 
> Powerpc has "subsystem-vendor-id" already...
> 
>> +subsys-id: used to specify an id that is specific to a vendor
>> +
>> +Example:
>> +Following is an example of NTB device exposed to the remote host.
>> +
>> +ntb {
> 
> This is going to need some sort of addressing (which implies 'reg')? If 
> not, I don't understand why you have 2 levels.
> 
>> +	compatible = "pci-epf-ntb";
>> +	epcs = <&pcie0_ep>, <&pcie1_ep>;
>> +	epc-names = "primary", "secondary";
>> +	vendor-id = /bits/ 16 <0x104c>;
>> +	device-id = /bits/ 16 <0xb00d>;
> 
> These have a long history in OF and should be 32-bits (yes, we've let 
> some cases of 16-bit creep in).
> 
>> +	num-mws = <4>;
> 
> Doesn't this apply to more than NTB?
> 
> Can't you just get the length of 'mws-size'?
> 
>> +	mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
> 
> Need to support 64-bit sizes?
> 
>> +};
>> -- 
>> 2.17.1
>>
