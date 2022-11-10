Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5B624CC4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKJVSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKJVSk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:18:40 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3EB18362;
        Thu, 10 Nov 2022 13:18:39 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so1831230otb.8;
        Thu, 10 Nov 2022 13:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQYEV0yuvAFKXfXfXPWLe2h/Dtk7ZrvGn4iuEOi+yK4=;
        b=qJ3vxkfEjKoN5+Ke1toOxv7oILl4xI8yVf7U1oTLC3rk2Re3kgd17n7VarYLnMHlUZ
         RiioeOBID/jLZaWoouaJahqav3HIwxhAyov14wSG2St//FsAHymgYqDDT12RXJ3aW0BT
         J/kZpZQ7PSdD/Fd7hbMDzRspQOQghygyT+ZciyZWaygf7FUqro9WUzISLc07bEa2Q9st
         tPjDJWIRTElqlInW4Zqtmi/UxBs01IATs8nJkiktZ9lUKaGNlbK4s1hPcLDLWNvI49ln
         1AI4ygcMatvTkZibysqGaqmFUqi+n4gP4DEKl3k8o2DaFZnW0kp81qFXOzulaNZBbFtO
         giHg==
X-Gm-Message-State: ACrzQf2IYGhWr9F5m5oQ+FkHIsmiiLJCzn4+AQMZ8DhCgabSHCS8WiqE
        ejXWH11G+cGvVzD7XYqYGg==
X-Google-Smtp-Source: AMsMyM7oQ4Ol1gBBxJonigdAuxDwjy/LR46XN4ccCYBY1im4NIoAy/a29peGtg/WLuJLCh8oS9VdPg==
X-Received: by 2002:a9d:730c:0:b0:661:ab16:3623 with SMTP id e12-20020a9d730c000000b00661ab163623mr2151184otk.91.1668115118340;
        Thu, 10 Nov 2022 13:18:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek24-20020a056870f61800b0013b1301ce42sm329233oab.47.2022.11.10.13.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:18:37 -0800 (PST)
Received: (nullmailer pid 1062808 invoked by uid 1000);
        Thu, 10 Nov 2022 21:18:39 -0000
Date:   Thu, 10 Nov 2022 15:18:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        caihuoqing <caihuoqing@baidu.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <166811511627.1062682.15955440634711266362.robh@kernel.org>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 07 Nov 2022 23:49:23 +0300, Serge Semin wrote:
> Currently the 'interrupts' and 'interrupt-names' properties are defined
> being too generic to really describe any actual IRQ interface. Moreover
> the DW PCIe End-point devices are left with no IRQ signals. All of that
> can be fixed by adding the IRQ-related properties to the common DW PCIe
> DT-schemas in accordance with the hardware reference manual. The DW PCIe
> common DT-schema will contain the generic properties definitions with just
> a number of entries per property, while the DW PCIe RP/EP-specific schemas
> will have the particular number of items and the generic resource names
> listed.
> 
> Note since there are DW PCI-based vendor-specific DT-bindings with the
> custom names assigned to the same IRQ resources we have no much choice but
> to add them to the generic DT-schemas in order to have the schemas being
> applicable for such devices. These names are marked as vendor-specific and
> should be avoided being used in new bindings in favor of the generic
> names.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note without the next dtschema tool fix
> 
> --- a/lib.py 2022-09-29 15:17:13.100033810 +0300
> +++ b/lib.py     2022-09-29 15:19:54.886172794 +0300
> @@ -1307,7 +1307,7 @@
>  def format_error(filename, error, prefix="", nodename=None, verbose=False):
>      src = prefix + os.path.abspath(filename) + ':'
> 
> -    if error.linecol[0] >= 0:
> +    if hasattr(error, 'linecol') and error.linecol[0] >= 0:
>          src = src + '%i:%i: ' % (error.linecol[0]+1, error.linecol[1]+1)
>      else:
>          src += ' '
> @@ -1342,10 +1342,10 @@
>      else:
>          msg = error.message
> 
> -    if error.note:
> +    if hasattr(error, 'note') and error.note:
>          msg += '\n\t' + prefix + 'hint: ' + error.note
> 
> -    if error.schema_file:
> +    if hasattr(error, 'schema_file') and error.schema_file:
>          msg += '\n\t' + prefix + 'from schema $id: ' + error.schema_file
> 
>      return src + msg
> 
> any DT-bindings error will cause the dt-schema script crash:
> 
> Traceback (most recent call last):
>   File "/home/fancer/.local/bin/dt-validate", line 175, in <module>
>     sg.check_trees(filename, testtree)
>   File "/home/fancer/.local/bin/dt-validate", line 122, in check_trees
>     self.check_subtree(dt, subtree, False, "/", "/", filename)
>   File "/home/fancer/.local/bin/dt-validate", line 111, in check_subtree
>     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
>   File "/home/fancer/.local/bin/dt-validate", line 111, in check_subtree
>     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
>   File "/home/fancer/.local/bin/dt-validate", line 106, in check_subtree
>     self.check_node(tree, subtree, disabled, nodename, fullname, filename)
>   File "/home/fancer/.local/bin/dt-validate", line 84, in check_node
>     print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
>   File "/home/fancer/.local/lib/python3.8/site-packages/dtschema/lib.py", line 1332, in format_error
>     msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
>   File "/home/fancer/.local/lib/python3.8/site-packages/dtschema/lib.py", line 1310, in format_error
>     if error.linecol[0] >= 0:
> AttributeError: 'ValidationError' object has no attribute 'linecol'
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> 
> Changelog v5:
> - Add platform-specific interrupt names, but mark them as deprecated.
> 
> Changelog v6:
> - Move the common interrupt-names definitions to the RP/EP schemas.
>   Thus drop the 'definitions' property. (@Rob)
> - Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 19 ++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 52 +++++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 90 ++++++++++++++++++-
>  3 files changed, 158 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
