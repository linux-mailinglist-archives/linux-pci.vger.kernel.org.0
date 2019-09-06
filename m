Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44463AB0E8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 05:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfIFDWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 23:22:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:3028 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731938AbfIFDWc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 23:22:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 20:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="267231270"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2019 20:22:30 -0700
Received: from [10.226.39.8] (leichuan-mobl.gar.corp.intel.com [10.226.39.8])
        by linux.intel.com (Postfix) with ESMTP id F14005808CB;
        Thu,  5 Sep 2019 20:22:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <ce4e04ee-9a8f-fbe1-0133-4a18c92dc136@linux.intel.com>
Date:   Fri, 6 Sep 2019 11:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/6/2019 4:31 AM, Martin Blumenstingl wrote:
> Hi Dilip,
>
> On Wed, Sep 4, 2019 at 12:11 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> [...]
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-pcie
> should we add the "snps,dw-pcie" here (and in the example below) as well?
> (this is what for example
> Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt does)
Thanks for pointing out this. We should add this.
>
> [...]
>> +  phy-names:
>> +    const: pciephy
> the most popular choice in Documentation/devicetree/bindings/pci/ is "pcie-phy"
> if Rob is happy with "pciephy" (which is already part of two other
> bindings) then I'm happy with "pciephy" as well
Agree.
>
>> +  num-lanes:
>> +    description: Number of lanes to use for this port.
> are there SoCs with more than 2 lanes?
> you can list the allowed values in an enum so "num-lanes = <16>"
> causes an error when someone accidentally has this in their .dts (and
> runs the dt-bindings validation)
Our SoC(LGM) supports single lane or dual lane. Again this also depends 
on the board. I wonder if we should put this into board specific dts.  
To make multiple lanes work properly, it also depends on the phy mode. 
In my internal version, I put it into board dts.
>
> [...]
>> +  reset-assert-ms:
> maybe add:
>    $ref: /schemas/types.yaml#/definitions/uint32
Agree
>> +    description: |
>> +      Device reset interval in ms.
>> +      Some devices need an interval upto 500ms. By default it is 100ms.
>> +
>> +required:
>> +  - compatible
>> +  - device_type
>> +  - reg
>> +  - reg-names
>> +  - ranges
>> +  - resets
>> +  - clocks
>> +  - phys
>> +  - phy-names
>> +  - reset-gpios
>> +  - num-lanes
>> +  - linux,pci-domain
>> +  - interrupts
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pcie10:pcie@d0e00000 {
>> +      compatible = "intel,lgm-pcie";
>> +      device_type = "pci";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      reg = <
>> +            0xd0e00000 0x1000
>> +            0xd2000000 0x800000
>> +            0xd0a41000 0x1000
>> +            >;
>> +      reg-names = "dbi", "config", "app";
>> +      linux,pci-domain = <0>;
>> +      max-link-speed = <4>;
>> +      bus-range = <0x00 0x08>;
>> +      interrupt-parent = <&ioapic1>;
>> +      interrupts = <67 1>;
>> +      #interrupt-cells = <1>;
>> +      interrupt-map-mask = <0 0 0 0x7>;
>> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
>> +                      <0 0 0 2 &ioapic1 28 1>,
>> +                      <0 0 0 3 &ioapic1 29 1>,
>> +                      <0 0 0 4 &ioapic1 30 1>;
> is the "1" in the interrupts and interrupt-map properties IRQ_TYPE_EDGE_RISING?
> you can use these macros in this example as well, see
> Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml for
> example

No. 1 here means index from arch/x86/devicetree.c

static struct of_ioapic_type of_ioapic_type[] =
{
     {
         .out_type    = IRQ_TYPE_EDGE_RISING,
         .trigger    = IOAPIC_EDGE,
         .polarity    = 1,
     },
     {
         .out_type    = IRQ_TYPE_LEVEL_LOW,
         .trigger    = IOAPIC_LEVEL,
         .polarity    = 0,
     },
     {
         .out_type    = IRQ_TYPE_LEVEL_HIGH,
         .trigger    = IOAPIC_LEVEL,
         .polarity    = 1,
     },
     {
         .out_type    = IRQ_TYPE_EDGE_FALLING,
         .trigger    = IOAPIC_EDGE,
         .polarity    = 0,
     },
};

static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
                   unsigned int nr_irqs, void *arg)
{
     struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
     struct of_ioapic_type *it;
     struct irq_alloc_info tmp;
     int type_index;

     if (WARN_ON(fwspec->param_count < 2))
         return -EINVAL;

     type_index = fwspec->param[1]; // index.
     if (type_index >= ARRAY_SIZE(of_ioapic_type))
         return -EINVAL;

I would not see this definition is user-friendly. But it is how x86 
handles at the moment.

>
> Martin
