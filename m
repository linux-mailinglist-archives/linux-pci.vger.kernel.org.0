Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69C22D6CA
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 12:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGYKgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 06:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2020 06:36:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6EC0619D3;
        Sat, 25 Jul 2020 03:36:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so681215pju.4;
        Sat, 25 Jul 2020 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B23U6TGnP6I2VN/If9ysGQ7jNwuYSviY699aZo0z2yM=;
        b=F+rtXTld25M+7eWuLtkC8woPCSiLmMNbyxzhxmqdhDQG+InNnCuLtJzMqaB5KZiROB
         mpcjcLAEzLRFmhNqMAJxJ4uwFq1sF+Py/i73cSrQtwVkdAHuvEyvEcw8H1o7c5SEiL1b
         dSu/QNaeShspYZuQQoY/Cc5OxMLLcQxCSbowCTZpKbgqiXi15si01o/fYpPEeXCOC2YQ
         LMqghddlagdLNVsQnHXiZNb7yNSxjdAwYqhE3QrYbxvgfAMJvnf52eGV70EtlTqYIizN
         Rjq7yoLYtylCrm+a5NGRHkgEg57c4s1R7V7F9kHbHk/FFsCiFZWnszbVN305hlDkFgaD
         iKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B23U6TGnP6I2VN/If9ysGQ7jNwuYSviY699aZo0z2yM=;
        b=Yu+7mz980c2Ack50HsFquSCGrJosLb/YtjecbckCiHUTY2ax2MFmAoVPqkWpYD7FZB
         PX00Y3MB2A6DQF1DUqcaLbXDHBGeVxl4E0ZksdoxuEmKFTv72FcaAH2VwoCyfQBJz3EF
         EQ0jmv1DvL3uyulfd11wtwTv941bmdgGQvAsMJ8JJUS1x+04AxoIyfYysx3/OHoWL1Gd
         f57+FJptOSMRQecNXauSkDAFSR9IxkFDFpR6CpYrjnui8sHns/ExipYMMoVRzpLl1x1s
         awLSH8RdRHYbWV2BNDG6j5WfnFeHRlakjoqa3cRmrTKqvPrVjGiEtxVhwCNGPHU7UJ91
         D07A==
X-Gm-Message-State: AOAM531ZiKO9AKGmwX+km0bBuvI4SqCp6ot6yCKvo87oRI/FfmZyI2om
        MG15BtzvqofJbUFwihO1/ofQMZYiMLSNRM912zk=
X-Google-Smtp-Source: ABdhPJxh/LpkqsYiBmOtQ6sJOOQq8mBeXc35QFQP0dPZqtAEC5QY3LnhJ1EUR44/+xbBPpPZinj3BNujb71xzCpDXpQ=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr9409744pjb.181.1595673359620;
 Sat, 25 Jul 2020 03:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com> <ba80aa1cab7d244730c5abd48f3036bf527578cc.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ba80aa1cab7d244730c5abd48f3036bf527578cc.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Jul 2020 13:35:43 +0300
Message-ID: <CAHp75VcswirG0EdtM0cVo4xx_p3C+3Unb4+c7p6=QLZe5LjOoQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 25, 2020 at 7:01 AM
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> pcie_ports_native is set only if user requests native handling

the user

> of PCIe capabilities via pcie_port_setup command line option.
> User input takes precedence over _OSC based control negotiation
> result. So consider the _OSC negotiated result only if
> pcie_ports_native is unset.
>
> Also, since struct pci_host_bridge ->native_* members caches the
> ownership status of various PCIe capabilities, use them instead
> of distributed checks for pcie_ports_native.

...

> +static char *get_osc_desc(u32 bit)
> +{

> +       int i = 0;

Unneeded assignment.

> +       for (i = 0; i < ARRAY_SIZE(pci_osc_control_bit); i++)
> +               if (bit == pci_osc_control_bit[i].bit)
> +                       return pci_osc_control_bit[i].desc;
> +
> +       return NULL;
> +}

...

>         host_bridge = to_pci_host_bridge(bus->bridge);
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -               host_bridge->native_pcie_hotplug = 0;
> +       if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)) {
> +               if (!pcie_ports_native)
> +                       host_bridge->native_pcie_hotplug = 0;
> +               else

> +                       dev_warn(&bus->dev, "OS overrides %s firmware control",

pci_warn() ?

> +                       get_osc_desc(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL));
> +       }
> +

>         if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
>                 host_bridge->native_shpc_hotplug = 0;

Group them in the same way you did in the previous patch.

> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> -               host_bridge->native_aer = 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> -               host_bridge->native_pme = 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> -               host_bridge->native_ltr = 0;
> -       if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> -               host_bridge->native_dpc = 0;
> +
> +       if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL)) {

> +               if (!pcie_ports_native)
> +                       host_bridge->native_aer = 0;
> +               else
> +                       dev_warn(&bus->dev, "OS overrides %s firmware control",
> +                       get_osc_desc(OSC_PCI_EXPRESS_AER_CONTROL));

Looks like a lot of duplication here. Perhaps split out a helper ?

> +       }

-- 
With Best Regards,
Andy Shevchenko
