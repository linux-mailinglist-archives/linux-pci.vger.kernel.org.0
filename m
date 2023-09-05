Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70A792FB4
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbjIEUOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjIEUO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 16:14:27 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:14:06 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282591711;
        Tue,  5 Sep 2023 13:14:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D04C433D9;
        Tue,  5 Sep 2023 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937337;
        bh=VVC3ib3yzE5r+s4aYfv/gsIn3joMY0xc0kaVf9r7Pjo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Glp/DEi794B19AMkAOdIIUixhFhfqKy+S3zCb/RYTWw5CVfyaOr7GzrqrSqy5Q23T
         gEMybJBxWZVovfCR+BIeD8IMVKlYaRw0omHeILDvJ8l4PNrz3bJG9vDv63rmvcNkXu
         RQZ2vY5NCGYbUMj/pKIq0U+9ZEQph85omsAF1BMSo/9z7VsmiDr7MYp0au9wbndkz1
         I0SaBQTjBzUk4k+rHLKT+ejWyvyjDlKRPB5gSu2YlvP/iQT+D/+bjKv72we8T6zw3b
         9JyCyU9O/Of7wJvahxZPIR6oYIGCzR20UJcnZVuy5OqYIxLGzT3FgncoqpMQdPyZmF
         gptmozQSDwfhQ==
Received: (nullmailer pid 3699774 invoked by uid 1000);
        Tue, 05 Sep 2023 18:08:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Achal Verma <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
In-Reply-To: <20230905114816.2993628-2-a-verma1@ti.com>
References: <20230905114816.2993628-1-a-verma1@ti.com>
 <20230905114816.2993628-2-a-verma1@ti.com>
Message-Id: <169393733505.3699703.7061210607519627009.robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: PCI: ti,j721e-pci-*: Add
 "ti,syscon-pcie-refclk-out" property
Date:   Tue, 05 Sep 2023 13:08:55 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 05 Sep 2023 17:18:15 +0530, Achal Verma wrote:
> Added "ti,syscon-pcie-refclk-out" property to specify the ACSPCIE clock
> buffer register offset in SYSCON, which would be used to enable serdes
> reference clock output.
> 
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:171:6: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:172:6: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:173:6: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:174:6: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:177:10: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:178:10: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:180:9: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:197:18: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:198:18: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:199:17: [warning] wrong indentation: expected 8 but found 16 (indentation)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dts'
Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:180:9: expected <block end>, but found '<block mapping start>'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 33, in <module>
    sys.exit(load_entry_point('yamllint==1.29.0', 'console_scripts', 'yamllint')())
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 228, in run
    prob_level = show_problems(problems, file, args_format=args.format,
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 113, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 200, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 137, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 583, in check
    yield from _check(conf, token, prev, next, nextnext, context)
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 344, in _check
    if expected < 0:
       ^^^^^^^^^^^^
TypeError: '<' not supported between instances of 'NoneType' and 'int'
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:180:9: expected <block end>, but found '<block mapping start>'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230905114816.2993628-2-a-verma1@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

