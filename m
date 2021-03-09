Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57D332D11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCIRT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 12:19:26 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42450 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIRTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 12:19:22 -0500
Received: by mail-io1-f41.google.com with SMTP id u20so14728524iot.9;
        Tue, 09 Mar 2021 09:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3v0eMTH8433dvD8WyTqDlgb7DpNe8skVjkraZ8DYNdA=;
        b=sX/8GxQ8g9E6jq0trIeIJlSzsfaaqeVtAjXZokOq47jT7Xcx72Ix+u/WMTZYHjuHAJ
         ERn8z8igzhANG081F4jz3bx5+uQmBLBv3n+oMMDHhLbgCH+PCrHP2FsZHdq7SLHdhVUC
         Dhl1AqUSoYsehsfz4DCep0cEJVNCnKudF2Rg4sIWGRyIGRhLQo53zGyTjJ01k2RAEjQm
         2khvWK1qanJSh+AyMGJWyXRec7hytWzbkO36NS4BWQVSM2zyWk9Q/ix4Vd5UErXA5/cO
         KRUrs8oamQyUX8pTPvBVN/yOwM7GDr23iS1AeefJfbYreJ61IP9aCXKDizcAtZ8D5y4P
         D2Gg==
X-Gm-Message-State: AOAM533u4zty9fkPEp6veTQeSq/n0dy9zOqSjFuQ/4cq2Pzgb1i11qYt
        K7xX2I7FAyDk7xtXLFDYBw==
X-Google-Smtp-Source: ABdhPJxJwhk6pjOGdqvwXLnsQwFs7VE5qlF3nsYlT9QSxepYs8eSWVZLKzNlXgQY/gr5GmVy/xNkdA==
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr23765483ioj.156.1615310361748;
        Tue, 09 Mar 2021 09:19:21 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k3sm7828786ioj.35.2021.03.09.09.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:19:20 -0800 (PST)
Received: (nullmailer pid 485084 invoked by uid 1000);
        Tue, 09 Mar 2021 17:19:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     mparab@cadence.com, devicetree@vger.kernel.org,
        tjoseph@cadence.com, sjakhade@cadence.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, pthombar@cadence.com
In-Reply-To: <20210309073142.13219-2-nadeem@cadence.com>
References: <20210309073142.13219-1-nadeem@cadence.com> <20210309073142.13219-2-nadeem@cadence.com>
Subject: Re: [PATCH 1/2] dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
Date:   Tue, 09 Mar 2021 10:19:11 -0700
Message-Id: <1615310351.616908.485083.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 09 Mar 2021 08:31:41 +0100, Nadeem Athani wrote:
> The parameter detect-quiet-min-delay can be used to program the minimum
> time that LTSSM waits on entering Detect.Quiet state.
> 00 : 0us minimum wait time in Detect.Quiet state.
> 01 : 100us minimum wait time in Detect.Quiet state.
> 10 : 1000us minimum wait time in Detect.Quiet state.
> 11 : 2000us minimum wait time in Detect.Quiet state.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml:33:10: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 33, column 10
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 33, column 10
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.example.dts'
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1449563

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

