Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E6ABE8A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406003AbfIFRRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 13:17:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45570 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391459AbfIFRRX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 13:17:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so2602948oti.12;
        Fri, 06 Sep 2019 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9evHry1UrtWiGWxeLaRDwMC+G1/K0C5Wqdz0SlRBtRA=;
        b=S03AX30pGa/riu4c+Jmvw31thlqCJ6/58BYW5EDstl8tut2pIX6DS+XKqBIPly98j0
         arM5bAlXCV9be8gl83690pSpmR1J9dMDi2ACleKB3PCN5J9KZL6g5iAoRmxWbMiqvNF3
         qC3itT8bwqPnQpFTXFxeLKOfYW+dUY5c8Ct8IOQFoscT2ROpSB17Myo1f6++Q3q3E9fp
         YGPB3qdZDIGk5096953Vhf6t3BQbyOG0UHoqwucW8WvoqVupxW0PUzT6nbVdjrekix1i
         O6TPhnexuV9aJm6HkgAJNlwlltU27I7emzs4SGZ34QBV1oyDhJrvrzc/OMHGJmk+Mg+o
         HEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9evHry1UrtWiGWxeLaRDwMC+G1/K0C5Wqdz0SlRBtRA=;
        b=GZ/IPlsfDs05a2d9jg5rDFN55JR6lH7JbywClAN6a64YkubQBRsq1DQM8V+gkputfR
         6SDxjto03hnwz4cZNWHLlXpUk4FOD5BL/xJVBujqLkODhkJDaZdVZRzzmaYQRmVELy46
         L8wrDLlD/oBlLWJ8sw6Vudl2fzdx40yGv8la22g80Mv4CSuD5516p2+ssOkx1cLxhc2s
         OReOy0E3Rxzm3NhJ4xNi+pHRJELNLAsMnQm1KAE6CwhEIo4By6RFbGmo3pAIL0nRvEgh
         +hyYRMfrboso/yr1jSP09xXR/VGGt7VSwS0e/5tQRlbOcokRnJMMH1vkoNCu2/RJjmb/
         7JaQ==
X-Gm-Message-State: APjAAAWfhXc4VhLY8S/XZlS+R07PTRTn2MD/rZCCCBhcTaRmUpRKzh0J
        5xHBOG35rKQh9KdPdVIeYMIzCQ3LUBS+gBYvvtA=
X-Google-Smtp-Source: APXvYqzV1urVgS9fUf9+vvQ7IvYRo7AJa7S38jSC4wqoAIa6jp3rnZyJDk83rUwj6UtOcAdQvzQUeXid+CeNTa1O5po=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr7852824otj.96.1567790242296;
 Fri, 06 Sep 2019 10:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com> <ce4e04ee-9a8f-fbe1-0133-4a18c92dc136@linux.intel.com>
In-Reply-To: <ce4e04ee-9a8f-fbe1-0133-4a18c92dc136@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 6 Sep 2019 19:17:11 +0200
Message-ID: <CAFBinCABoe89Z9CiG=3Bz6+JoRCYcpxWJ6jzEqMo16SCCoXPmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 6, 2019 at 5:22 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
[...]
> >> +examples:
> >> +  - |
> >> +    pcie10:pcie@d0e00000 {
> >> +      compatible = "intel,lgm-pcie";
> >> +      device_type = "pci";
> >> +      #address-cells = <3>;
> >> +      #size-cells = <2>;
> >> +      reg = <
> >> +            0xd0e00000 0x1000
> >> +            0xd2000000 0x800000
> >> +            0xd0a41000 0x1000
> >> +            >;
> >> +      reg-names = "dbi", "config", "app";
> >> +      linux,pci-domain = <0>;
> >> +      max-link-speed = <4>;
> >> +      bus-range = <0x00 0x08>;
> >> +      interrupt-parent = <&ioapic1>;
> >> +      interrupts = <67 1>;
> >> +      #interrupt-cells = <1>;
> >> +      interrupt-map-mask = <0 0 0 0x7>;
> >> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
> >> +                      <0 0 0 2 &ioapic1 28 1>,
> >> +                      <0 0 0 3 &ioapic1 29 1>,
> >> +                      <0 0 0 4 &ioapic1 30 1>;
> > is the "1" in the interrupts and interrupt-map properties IRQ_TYPE_EDGE_RISING?
> > you can use these macros in this example as well, see
> > Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml for
> > example
>
> No. 1 here means index from arch/x86/devicetree.c
>
> static struct of_ioapic_type of_ioapic_type[] =
> {
>      {
>          .out_type    = IRQ_TYPE_EDGE_RISING,
>          .trigger    = IOAPIC_EDGE,
>          .polarity    = 1,
>      },
>      {
>          .out_type    = IRQ_TYPE_LEVEL_LOW,
>          .trigger    = IOAPIC_LEVEL,
>          .polarity    = 0,
>      },
>      {
>          .out_type    = IRQ_TYPE_LEVEL_HIGH,
>          .trigger    = IOAPIC_LEVEL,
>          .polarity    = 1,
>      },
>      {
>          .out_type    = IRQ_TYPE_EDGE_FALLING,
>          .trigger    = IOAPIC_EDGE,
>          .polarity    = 0,
>      },
> };
>
> static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
>                    unsigned int nr_irqs, void *arg)
> {
>      struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
>      struct of_ioapic_type *it;
>      struct irq_alloc_info tmp;
>      int type_index;
>
>      if (WARN_ON(fwspec->param_count < 2))
>          return -EINVAL;
>
>      type_index = fwspec->param[1]; // index.
>      if (type_index >= ARRAY_SIZE(of_ioapic_type))
>          return -EINVAL;
>
> I would not see this definition is user-friendly. But it is how x86
> handles at the moment.
thank you for explaining this - I had no idea x86 is different from
all other platforms I know
the only upstream x86 .dts I could find
(arch/x86/platform/ce4100/falconfalls.dts) also uses the magic x86
numbers
so I'm fine with this until someone else knows a better solution


Martin
