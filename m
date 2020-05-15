Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586351D4394
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 04:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgEOCiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 22:38:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37409 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgEOCiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 22:38:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so782396oto.4;
        Thu, 14 May 2020 19:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptFVEDg6umdMtCllBkJHixw/+OkA7uIpMhN7I/D6mxg=;
        b=T9HoXctrf2ly3F8s0wkBH5Oi7NJSsqvFuodBC5CLce7GmrVSVLqw0+grh/txUDfIR0
         XeS2RYwz1nNUidnhq3R4vOdqVdfRYnl/FepCPpAy5q83SPP5t2BJR4lL1+W+CknDKAt6
         e00rBc9JwsUuHYJyh+DhK8b36fmn96/i41WleHKHPe9p0N9JTqhxS2LdW1312IiytCkG
         J1Lu+JG5L8kr6tjZyqc8WcA1UL4te2rf1OdfgXkuXsndjDk2vMPI9+eO+eyM80JUin4F
         BScyN+t+x5zqIYSkG597A2JZqNDT0/UrCkwaMHK8q8R/4zRedOVwH6CBGlNBeV+Tx3W6
         EMQQ==
X-Gm-Message-State: AOAM531LzcUobmINq16UEUkbum+HOUpuBkDU1ak0iDcTRb1VOYkVJkkR
        iyAUdudj6cjsbRgp+s0KvQ==
X-Google-Smtp-Source: ABdhPJxObpjMpwzOqzN0xtCAmCuXpkdbEHiKZzCEQfCkL5D2OlKXkEMqhrrbkrWQy27y36CRQFZnmw==
X-Received: by 2002:a05:6830:2378:: with SMTP id r24mr678472oth.113.1589510333173;
        Thu, 14 May 2020 19:38:53 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm239100ote.10.2020.05.14.19.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 19:38:51 -0700 (PDT)
Received: (nullmailer pid 11325 invoked by uid 1000);
        Fri, 15 May 2020 02:38:50 -0000
Date:   Thu, 14 May 2020 21:38:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-ntb@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 01/19] dt-bindings: PCI: Endpoint: Add DT bindings for
 PCI EPF NTB Device
Message-ID: <20200515023850.GA10278@bogus>
References: <20200514145927.17555-1-kishon@ti.com>
 <20200514145927.17555-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514145927.17555-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 20:29:09 +0530, Kishon Vijay Abraham I wrote:
> Add device tree schema for PCI endpoint function bus to which
> endpoint function devices should be attached. Then add device tree
> schema for PCI endpoint function device to include bindings thats
> generic to all endpoint functions. Finally add device tree schema
> for PCI endpoint NTB function device by including the generic
> device tree schema for PCIe endpoint function.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/endpoint/pci-epf-bus.yaml    | 42 +++++++++++
>  .../bindings/pci/endpoint/pci-epf-device.yaml | 69 +++++++++++++++++++
>  .../bindings/pci/endpoint/pci-epf-ntb.yaml    | 68 ++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret = check_doc(args.yamldt)
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 592, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/pci/endpoint/pci-epf-device.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.yaml: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:41: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.yaml'
Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 34, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 5, column 1
found duplicate key "properties" with value "{}" (original value: "{}")
  in "<unicode string>", line 17, column 1

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

Documentation/devicetree/bindings/Makefile:45: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 123
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.yaml'
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1290443

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

