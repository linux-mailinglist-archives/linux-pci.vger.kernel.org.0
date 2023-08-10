Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F007777979
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjHJNWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjHJNWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 09:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F71703;
        Thu, 10 Aug 2023 06:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F8664A2A;
        Thu, 10 Aug 2023 13:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69963C433C7;
        Thu, 10 Aug 2023 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691673715;
        bh=3FGd5iLaspzTip2vzsXav1OxSBEUVMbyCh2/1tfzB58=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C1gP2ldUyUalJN2465Mi+R5Rj/LgCKExYE2+Q49pwsj6qOB012wORn9+raXk7CFiU
         58kYWysUcun2+oshKP+r6XJ8SQRKkkiPrC3ZRtsvU8G2RydUjVz7wV4MSfhqQ08/+1
         jwBSeraasrqpNfZSzx3ct7l/yYrnGEIN0LIqpGlfTXanb0jmwQGXZ3kY/8QdJk1aTF
         ad6w6s8e9z5OIHiSvixgTH8CIJCBQ71fqhpkHOkVDK6CgQ563L0bnB9UFxwqNyEQvN
         2zcTTI4tMBfyCQvR/6DqR/DoO5iodfiEmZPsNz9/6g7wvhr4HkzsFgpm1hH8L+st4x
         +Ol1+y8cCuhiw==
Received: (nullmailer pid 249906 invoked by uid 1000);
        Thu, 10 Aug 2023 13:21:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        lpieralisi@kernel.org, michal.simek@amd.com,
        linux-pci@vger.kernel.org, bharat.kumar.gogada@amd.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        conor+dt@kernel.org
In-Reply-To: <20230810122002.133531-3-thippeswamy.havalige@amd.com>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
 <20230810122002.133531-3-thippeswamy.havalige@amd.com>
Message-Id: <169167371324.249877.9344349772495865636.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size
 in example
Date:   Thu, 10 Aug 2023 07:21:53 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 10 Aug 2023 17:50:01 +0530, Thippeswamy Havalige wrote:
> Update ECAM size in example to discover up to 256 buses.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v2:
> None.
> changes in v1:
> None.
> ---
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810122002.133531-3-thippeswamy.havalige@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

