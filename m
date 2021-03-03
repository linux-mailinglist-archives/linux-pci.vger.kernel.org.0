Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7377132C8EF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 02:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhCDA7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 19:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352892AbhCDACj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 19:02:39 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F283C061762;
        Wed,  3 Mar 2021 15:14:41 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w3so5633134oti.8;
        Wed, 03 Mar 2021 15:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yXVmeSl5oOevxfQxlrfETF+M/MDbt5WdR8xryqID+Tw=;
        b=oQU6nvWULZkiQX21JwzS3zUmIYS3Y9QNCASf3m+dbAZvX/CHjqhP8KRZfTWDfhnAWV
         6MX6kco8J5FPyk4LsWA6XmXRHcebMLr5+0NHuNb5Izcp0v0A0PUKWk6IeA2ut87StRuk
         DGF/o4AeGViZlsUmVatRWsWPyBSv9Aq29RiU9FDoD4LiRMtLZh4JfUy7EQB9PNUXqREK
         a3mCEQOVPG5uVx8I+iLI1FoodnlVVWiIxQMwnlGOpYbatbXQNRJzDsEZ3fnj0gEykX2Q
         4/e+nZu/ejmb9SoYUno4hnAvH9rw6iH8sMWUafxtzMxI+pg5hkbWd+FECszvbzOGhKfG
         U2gw==
X-Gm-Message-State: AOAM531N9BaDDfnXAIx7d3ZsdAN1iJqeZzhRjyjPJsWG9xu/r3UUXVJF
        o3H7DiTLdNTA87u7jNwgVw==
X-Google-Smtp-Source: ABdhPJwrBA/11mAg/pOkn/zbVpAwEHWyNgvNOkMVN9xeD9R31M6hU7b8jv46jT4ggUwLalDuSU1VGQ==
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr1194688ota.311.1614813280679;
        Wed, 03 Mar 2021 15:14:40 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f193sm1879302oig.8.2021.03.03.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:14:39 -0800 (PST)
Received: (nullmailer pid 846313 invoked by uid 1000);
        Wed, 03 Mar 2021 23:14:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     bhelgaas@google.com, hes@sifive.com, p.zabel@pengutronix.de,
        khilman@baylibre.com, vidyas@nvidia.com,
        linux-riscv@lists.infradead.org, jh80.chung@samsung.com,
        lorenzo.pieralisi@arm.com, alex.dewar90@gmail.com,
        sboyd@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, paul.walmsley@sifive.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        erik.danie@sifive.com, robh+dt@kernel.org, mturquette@baylibre.com,
        hayashi.kunihiko@socionext.com
In-Reply-To: <4e63c5515f9755d0cf4cd65ab70048554d917d89.1614681831.git.greentime.hu@sifive.com>
References: <cover.1614681831.git.greentime.hu@sifive.com> <4e63c5515f9755d0cf4cd65ab70048554d917d89.1614681831.git.greentime.hu@sifive.com>
Subject: Re: [RFC PATCH 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Wed, 03 Mar 2021 17:14:36 -0600
Message-Id: <1614813276.374609.846312.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 02 Mar 2021 18:59:15 +0800, Greentime Hu wrote:
> Add PCIe host controller DT bindings of SiFive FU740.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml:114:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 88, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 114, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml:  while scanning a block scalar
  in "<unicode string>", line 88, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 114, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1446288

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

