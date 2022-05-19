Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61B52D067
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiESK0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiESK0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 06:26:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68144562DF;
        Thu, 19 May 2022 03:26:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so8311870lfg.7;
        Thu, 19 May 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=negqOIW3riyv4Rgyp3xgj8bj8ByH2iI1Tooe+4lRwyA=;
        b=W5AClr2GatCF9LTeqYGRAOqwfncpcgKQWhn2VcYkwKssCgu2D3EWG3+jYivcu7+hb9
         W3dVD4ulDqWveFc+cSMHYSV7fkIR4FLptYcIO28hifW3IB2E0CcADKuza7mKvPS+oLPA
         yu9HbtDeS/OkL3cBSExz8s+L7G/jC4MPgrSyxqPorAvhwBpO/kK+tkUNsmfkan4fG4UF
         ekl3D/AbsltASBwNX8qUHb/KmUdx+bLNkjVsxRmeQfdyfT4OwDHaypnMcH1eygVlUYdZ
         2IN1ZXQutAPnFzaaSjxI5ZXjKR0AvQyviubokpGzapZuJUbl45rp2RcOAuoFtyJvZCXL
         cCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=negqOIW3riyv4Rgyp3xgj8bj8ByH2iI1Tooe+4lRwyA=;
        b=tBcbL7hUeNiaEKGXkgd5PYEemyQuPlmSLn7AIffEdjR6Nwb6c57ZAFylhmqvozRdK+
         1rXQgRjPNaQ65haBlqRY2cXqh5yupCNWxx2ZBMYYd4KNPliuIkanTKGhClx3zuXnS16V
         qNqxmpHGjlXhVDRNR9rQBLIBJWexwJV4ieCFRrALHt3/FuvpLJsg7rTUHyRNLGgZAOg/
         rYUf9CIthQQYrGIYXr8+kMQvs2Ky/lLYZvt01bmfGTUGVOuwIZhKAcOrfm+Rj94mvcSh
         YhJN7M1ql+SxLnMruFs3P2ENwDvl1RqGmaCZTB1h8I69OeZPnubEwgoIcA2kOgXey9GT
         z3hg==
X-Gm-Message-State: AOAM530W2FWNwdMhcwOR6i2g/XNqT//0yfQakqlGkafYSPjcdQEFdcOc
        mHzhGOxxNw89WqyH6IqaNIg=
X-Google-Smtp-Source: ABdhPJxbq9+Yb/Hb0Yymu/rt2fjevgfXQXPXuklmquXOls1UOtgmjVswZGExq6SNgt3/5IBy4R0s8w==
X-Received: by 2002:a19:4343:0:b0:474:d7a:634d with SMTP id m3-20020a194343000000b004740d7a634dmr2855210lfj.168.1652955995493;
        Thu, 19 May 2022 03:26:35 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9f46000000b0024f3d1daee2sm525589ljk.106.2022.05.19.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:26:34 -0700 (PDT)
Date:   Thu, 19 May 2022 13:26:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
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
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 01/17] dt-bindings: PCI: dwc: Define common and native
 DT bindings
Message-ID: <20220519102632.qggcv64igf3zowuc@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru>
 <20220516201153.GA3073005-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516201153.GA3073005-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 03:11:53PM -0500, Rob Herring wrote:
> On Wed, May 04, 2022 at 12:46:22AM +0300, Serge Semin wrote:
> > Currently both DW PCIe Root Port and End-point DT bindings are too generic
> > to be used as a descriptive set the device properties. Yes, it's very handy
> > to have them that way so the DT-schemas could be used to evaluate as many
> > DW PCIe-related DT-nodes as possible. But at the same time they don't
> > provide well defined DW PCIe RP/EP DT interface description thus leaving
> > too much flexibility for the new platforms, no encouraging the developers
> 

> s/no/not/

Thanks. will be fixed in v3.

> 
> > to preserve a compatible interface. It causes having many
> > platform-specific DT bindings of the same generic properties.
> > 
> > Instead of currently implemented approach we suggest to be more
> > restrictive and yet preserve some level of flexibility in the DW PCIe
> > DT-bindings description. The device tree DT-schema is split up into
> > three parts: a common YAML-schema applicable for both DWC Root Port and
> > End-point controller configs, DWC PCIe Root Port-specific YAML-schema
> > and DWC PCIe End-point-specific YAML-schema, where
> > 1) pci/snps,dw-pcie-common.yaml - the common DT-schema describes the most
> > generic constraints of the "reg", "interrupts", "clocks", "resets" and
> > "phys" properties together with a set of common for both device types
> > PCIe/AXI bus properties like a maximum number of lanes or a maximum link
> > speed, number of inbound and outbound iATU windows. In addition to that a
> > set of schema definitions declared under the "definitions" property with
> > "reg", "interrupt", "clock" and "reset" names common for DWC PCIe Root
> > Port and End-point devices. They can be used by the successive DT-schemas
> > in case they are supposed to be compatible with the generic DWC PCIe
> > controller DT-bindings.
> > 2) pci/snps,dw-pcie.yaml, pci/snps,dw-pcie-ep.yaml - generic DW PCIe Root
> > Port and End-point DT-bindings which aside with the device-specific
> > properties set also contain more restrictive constraints. All new DW PCIe
> > platforms are supposed to be compatible with one of these bindings by
> > using "allOf: " property and additionally defining their own constraints
> > to close up the DT-bindings set.
> > 
> > So to speak in case if a DW PCIe-based device for some reason has too many
> > specific properties or it's bindings have already been defined in a
> > non-generic way, it's DT-schema is supposed to include 1) YAML-file and
> > provide its own constraints. Otherwise the ready-to-use bindings from 2)
> > should be utilized. There are only two DT-schemas compatible with 2) at the
> > moment are samsung,axynos-pcie.yaml and intel-gw-pcie.yaml. The
> > rest of the DW PCIe-related DT-schemas are supposed to use more generic
> > DW PCIe DT-bindings - pci/snps,dw-pcie-common.yaml.
> > 
> > Note the provided here generic properties and their possible values are
> > derived from the DW PCIe RC/EP hardware manuals and from the interface
> > implemented in the driver. The DT-bindings schemas are created to be as
> > full as possible with detailed properties/names description for the
> > easier interface comprehension and new platforms bindings development.
> > 
> > Also note since there are no generic DT-nodes can be found in the kernel
> > dts-es which would have a pure "snps,dw-pcie" compatible string, these
> > DT-bindings have been created to not be selected by default for
> > evaluation. They are supposed to be used by the new vendor-specific
> > DT-schemas to at least stop adding new bindings for the same set of DWC
> > PCIe signals or properties.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > If the '$defs' property is used instead of the 'definitions' one, the next
> > error will be spotted:
> > 
> > >  DTC     Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> > >  CHECK   Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
> > >        'dbi' is not of type 'array'
> > >        From schema: /.../snps,dw-pcie.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:1: 'oneOf' conditional failed, one must be fixed:
> > >         'config' is not of type 'array'
> > >         From schema: /.../snps,dw-pcie.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'anyOf' conditional failed, one must be fixed:
> > >         /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> > >                 'msi' is not of type 'array'
> > >         /../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> > >                 'msi' is not of type 'array'
> > >         From schema: /.../snps,dw-pcie.yaml
> > 
> > The problem is caused by the 'def fixup_sub_schema()' method defined in
> > the dtschema parser. AFAIU It skips the sub-'$defs'-schemas evaluation thus
> > not having them fixed up properly. The next patch solves the denoted
> 

> It's actually the opposite. The schemas in $defs are fixed-up, but you 
> don't want them to be because your definition entries apply to a single 
> entry where-as what the fix-ups do is make everything an array. It's 
> debatable whether $defs should be fixed up or not, but I'm pretty sure 
> we already have cases depending on the fixups.
> 
> > problem:
> > --- a/lib.py     2022-04-23 19:51:38.829759258 +0300
> > +++ b/lib.py     2022-04-23 20:17:16.218137170 +0300
> > @@ -470,7 +470,7 @@
> >              for subschema in v:
> >                  fixup_sub_schema(subschema, True)
> > 
> > -        if k not in ['dependentRequired', 'dependentSchemas', 'dependencies', 'properties', 'patternProperties', '$defs']:
> > +        if k not in ['dependentRequired', 'dependentSchemas', 'dependencies', 'properties', 'patternProperties']:
> 
> This list is all the json-schema keywords which have a dictionary of DT 
> properties under them. So $def belongs in the list. 'definitions' is not 
> there as it is used in limited places and those that exist don't need 
> fixups. Within the kernel tree, only $defs should be used and only if 
> really necessary. Primarily, I think it is cases where it saves writing 
> the same property schema more than once.

Got it. Thanks for clarification.

> 
> 

> This patch is doing multiple things and should be split up some if 
> possible. 

Ok, but we need to settle the suggested modification design before
the next patchset re-submission. The splitting up is a lot of additional work,
while I have already spent so much time on this and on the rest of the
DW PCIe-related patches.

> No doubt splitting the common schema from the 'generic' device 
> schema is needed. We've done that in other cases. 

> 
> The main part I have issue with is how reg-names and interrupt-names are 
> handled. For reg-names currently, if a platform wants to add another 
> name, they have to modify the commmon binding. That's not great, but we 
> don't want that to happen and don't want to make that easier to do.

When it comes to the generic and vendor-specific IP-core device
implementations the approach suggested by me is more flexible, but yet
restrictive enough to cover your case. It is suitable for all already
defined vendor-specific DT bindings, the generic DW PCIe-compatible
bindings, new DT bindings yet to come. Here are the cases it can be
used for:

1) DW PCIe platforms fully compatible with the generic IP-core
schema, but with already defined vendor-specific resource
names. Solution:
$ref: /schemas/pci/snps,dw-pcie-common.yaml#
and define all the vendor-specific resource names. If the
reg/interrupt/clock/reset-names are partly compatible with the
generic schema, then they can be directly referenced from the
"definitions" property in the "oneOf" composition.

2) DW PCIe platforms partly compatible with the generic IP-core
DT schema. Solution:
$ref: /schemas/pci/snps,dw-pcie-common.yaml#
and define all the vendor-specific resource names. Refer to the
generic "reg/interrupt/clock/reset"-names in the particular names
arrays aside with the platform-specific resource names (this especially
concerns the reg-names property, which aside with the standard CSRs
may have additional non-standard CSRs defined).

3) DW PCIe platforms fully compatible with the generic IP-core
DT schema. Solution:
$ref: /schemas/pci/snps,dw-pcie.yaml#
or
$ref: /schemas/pci/snps,dw-pcie-ep.yaml#
If there are resource names which are defined in the generic schema
and are applicable to the platform-specific device (like additional
required names) they can be added to the vendor DT-schema otherwise
the generic schema reference is enough (see the baikal,bt1-pcie.yaml
DT-schema being added in the framework of this patchset).

New DW PCIe platforms are encouraged to use schema 3). In case if
there are resources not specific to the generic DW PCIe IP-core,
they need to have the schema 2) utilized. Since we can't change the
already defined bindings, we have no choice but to use schema 1) for
them. Thus the suggested here schemas can be used to create more
descriptive and restrictive enough DT-schemas hierarchy covering all
the currently defined bindings and new ones.

In anyway regarding what you said in the message above adding new
generic names is possible only in case if they are applicable to the
generic DW PCIe IP-core (almost all of them I've already listed in the
snps,dw-pcie-common.yaml#definitions property) otherwise such names
need to be defined in the platform-specific schema.

Traditional generic schema design when all the generic properties are
directly listed in the generic DT-schema in the corresponding property
is too restrictive to implement the cases 1) and 2). Thus such generic
schema needs to be extended with the non-generic names (or not to have
the names listed in the generic schema at all). It implicitly
makes all the platforms permitting such resources, which isn't true.

> Part 
> of the reason we have so many already is because no one stopped all the 
> random variations of the same names.

Sadly, but you're right. In the framework of this patchset I suggest a
method to organize all old and new DT bindings (for DW PCIe devices)
in a way so them all be using the generic DW PCIe DT-schema at the
most applicable part. 

> The biggest validation gap I see is 
> we don't enforce the order and this patch does nothing to address that.

I happen to have the opposite opinion regarding the order of the
names listed in the *-names properties. Why do you need them to be
defined in a strict order? reg and reg-names are tightly coupled.
The DW PCIe driver refer to the CSRs and IRQs by their names. So the
order is irrelevant in this case. If the order is required, then it
can be constrained in the platform-specific schema.

-Sergey

> 
> Rob
