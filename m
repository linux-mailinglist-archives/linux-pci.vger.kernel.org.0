Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09145290A4
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiEPU3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347540AbiEPU3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:29:04 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936981CFDA;
        Mon, 16 May 2022 13:11:56 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m25so20002111oih.2;
        Mon, 16 May 2022 13:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbR9l3pEjMl565dCavHPHWBXS1kr8LPe02PwsIH5GqA=;
        b=Z7UFX6gYuAmNVo7+v14VhON/XWbX4bjw6SwgHe/ilu3WEPQ/KwAcMjT6+HykqSGdsr
         yBfvVOFRbeDrPcUQ+SoLZjNFAPY3htBpcuUST0agHfcBKFNDvvhOXCWj9Wj1QzvYJ6fp
         Dc6/AENxlY7qDM18JSPRTHynESdM+WGRDcTANuwdW2gS4MMCWBZuzVlEOTXIMXQZu7V6
         clOaJ0yGdtxM9LWW3EI27V2RGGklJXen4QtdlrCs+ijoaiWS+FXXwoSGX5iqqvKGRICq
         4ZsT4FTLjI5ebt8PKfcl0Q4KvplEpoL7yMReZQeuf5T23hoTsS49tcwhqgw6055GlIjV
         4pKA==
X-Gm-Message-State: AOAM532RblGJgrEo3yzo27s9C8A/KYOZ7pkzqAoOkEqYeF/DIYd4COqs
        RcTstUsEenJncrsjdvUaYw==
X-Google-Smtp-Source: ABdhPJzwngEn9PkcNX4eL6HIcc7veNtCe+uYOBZrmAqyqNkFnT8oDJRNMhVasycVSkPEvktxfWzmEQ==
X-Received: by 2002:a05:6808:1a1e:b0:326:3846:c4a1 with SMTP id bk30-20020a0568081a1e00b003263846c4a1mr14856541oib.80.1652731915819;
        Mon, 16 May 2022 13:11:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e686d13897sm5969446oap.49.2022.05.16.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:55 -0700 (PDT)
Received: (nullmailer pid 3187391 invoked by uid 1000);
        Mon, 16 May 2022 20:11:53 -0000
Date:   Mon, 16 May 2022 15:11:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 01/17] dt-bindings: PCI: dwc: Define common and native
 DT bindings
Message-ID: <20220516201153.GA3073005-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 12:46:22AM +0300, Serge Semin wrote:
> Currently both DW PCIe Root Port and End-point DT bindings are too generic
> to be used as a descriptive set the device properties. Yes, it's very handy
> to have them that way so the DT-schemas could be used to evaluate as many
> DW PCIe-related DT-nodes as possible. But at the same time they don't
> provide well defined DW PCIe RP/EP DT interface description thus leaving
> too much flexibility for the new platforms, no encouraging the developers

s/no/not/

> to preserve a compatible interface. It causes having many
> platform-specific DT bindings of the same generic properties.
> 
> Instead of currently implemented approach we suggest to be more
> restrictive and yet preserve some level of flexibility in the DW PCIe
> DT-bindings description. The device tree DT-schema is split up into
> three parts: a common YAML-schema applicable for both DWC Root Port and
> End-point controller configs, DWC PCIe Root Port-specific YAML-schema
> and DWC PCIe End-point-specific YAML-schema, where
> 1) pci/snps,dw-pcie-common.yaml - the common DT-schema describes the most
> generic constraints of the "reg", "interrupts", "clocks", "resets" and
> "phys" properties together with a set of common for both device types
> PCIe/AXI bus properties like a maximum number of lanes or a maximum link
> speed, number of inbound and outbound iATU windows. In addition to that a
> set of schema definitions declared under the "definitions" property with
> "reg", "interrupt", "clock" and "reset" names common for DWC PCIe Root
> Port and End-point devices. They can be used by the successive DT-schemas
> in case they are supposed to be compatible with the generic DWC PCIe
> controller DT-bindings.
> 2) pci/snps,dw-pcie.yaml, pci/snps,dw-pcie-ep.yaml - generic DW PCIe Root
> Port and End-point DT-bindings which aside with the device-specific
> properties set also contain more restrictive constraints. All new DW PCIe
> platforms are supposed to be compatible with one of these bindings by
> using "allOf: " property and additionally defining their own constraints
> to close up the DT-bindings set.
> 
> So to speak in case if a DW PCIe-based device for some reason has too many
> specific properties or it's bindings have already been defined in a
> non-generic way, it's DT-schema is supposed to include 1) YAML-file and
> provide its own constraints. Otherwise the ready-to-use bindings from 2)
> should be utilized. There are only two DT-schemas compatible with 2) at the
> moment are samsung,axynos-pcie.yaml and intel-gw-pcie.yaml. The
> rest of the DW PCIe-related DT-schemas are supposed to use more generic
> DW PCIe DT-bindings - pci/snps,dw-pcie-common.yaml.
> 
> Note the provided here generic properties and their possible values are
> derived from the DW PCIe RC/EP hardware manuals and from the interface
> implemented in the driver. The DT-bindings schemas are created to be as
> full as possible with detailed properties/names description for the
> easier interface comprehension and new platforms bindings development.
> 
> Also note since there are no generic DT-nodes can be found in the kernel
> dts-es which would have a pure "snps,dw-pcie" compatible string, these
> DT-bindings have been created to not be selected by default for
> evaluation. They are supposed to be used by the new vendor-specific
> DT-schemas to at least stop adding new bindings for the same set of DWC
> PCIe signals or properties.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> If the '$defs' property is used instead of the 'definitions' one, the next
> error will be spotted:
> 
> >  DTC     Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> >  CHECK   Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
> >        'dbi' is not of type 'array'
> >        From schema: /.../snps,dw-pcie.yaml
> > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:1: 'oneOf' conditional failed, one must be fixed:
> >         'config' is not of type 'array'
> >         From schema: /.../snps,dw-pcie.yaml
> > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'anyOf' conditional failed, one must be fixed:
> >         /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> >                 'msi' is not of type 'array'
> >         /../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> >                 'msi' is not of type 'array'
> >         From schema: /.../snps,dw-pcie.yaml
> 
> The problem is caused by the 'def fixup_sub_schema()' method defined in
> the dtschema parser. AFAIU It skips the sub-'$defs'-schemas evaluation thus
> not having them fixed up properly. The next patch solves the denoted

It's actually the opposite. The schemas in $defs are fixed-up, but you 
don't want them to be because your definition entries apply to a single 
entry where-as what the fix-ups do is make everything an array. It's 
debatable whether $defs should be fixed up or not, but I'm pretty sure 
we already have cases depending on the fixups.

> problem:
> --- a/lib.py     2022-04-23 19:51:38.829759258 +0300
> +++ b/lib.py     2022-04-23 20:17:16.218137170 +0300
> @@ -470,7 +470,7 @@
>              for subschema in v:
>                  fixup_sub_schema(subschema, True)
> 
> -        if k not in ['dependentRequired', 'dependentSchemas', 'dependencies', 'properties', 'patternProperties', '$defs']:
> +        if k not in ['dependentRequired', 'dependentSchemas', 'dependencies', 'properties', 'patternProperties']:

This list is all the json-schema keywords which have a dictionary of DT 
properties under them. So $def belongs in the list. 'definitions' is not 
there as it is used in limited places and those that exist don't need 
fixups. Within the kernel tree, only $defs should be used and only if 
really necessary. Primarily, I think it is cases where it saves writing 
the same property schema more than once.


This patch is doing multiple things and should be split up some if 
possible. No doubt splitting the common schema from the 'generic' device 
schema is needed. We've done that in other cases. 

The main part I have issue with is how reg-names and interrupt-names are 
handled. For reg-names currently, if a platform wants to add another 
name, they have to modify the commmon binding. That's not great, but we 
don't want that to happen and don't want to make that easier to do. Part 
of the reason we have so many already is because no one stopped all the 
random variations of the same names. The biggest validation gap I see is 
we don't enforce the order and this patch does nothing to address that.

Rob
