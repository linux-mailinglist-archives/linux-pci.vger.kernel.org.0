Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C9778294
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjHJVRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHJVRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 17:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D0273E;
        Thu, 10 Aug 2023 14:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B986066681;
        Thu, 10 Aug 2023 21:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D001C433C7;
        Thu, 10 Aug 2023 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702271;
        bh=H2Fe2WzfS4nYZxQ85T3Gjwc0OY1MLGyAZf3vqore6kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=on1Ni0qf34UiCHe/AOHA9GESvReYxmnMI5GWmmQ1exJPibdTYQSv4vlLVJJ44HtNH
         DsvaiX8AuOtFZfykb20FBXP9TACfQ8QH13HDV5XsMKTYVNfTiYi/k6OHTn44zDfe+P
         iRaZQZb71+okZhKYFhxKMb79WuzizEuBjTrrUdCF+th52kp1NZ9ZBao16TlYw+bMgX
         Ge35QPlR0xbeKR6Ff8p9n4xShjdeop3gq90HRi9itu4wm793/fnIHp9htQ+uANaI18
         0dufedMs44QuaO/S7SlQXGNzItXYq1C6VKmNhfN+ykpUu74TwAHLFB9l1S+eIXlpyk
         m2Y1bfm9aAxFw==
Received: (nullmailer pid 1203977 invoked by uid 1000);
        Thu, 10 Aug 2023 21:17:49 -0000
Date:   Thu, 10 Aug 2023 15:17:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        michal.simek@amd.com, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, bharat.kumar.gogada@amd.com,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-nwl: Modify ECAM size in
 example
Message-ID: <169170226804.1203889.12436909993182119395.robh@kernel.org>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
 <20230810122002.133531-3-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810122002.133531-3-thippeswamy.havalige@amd.com>
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

Acked-by: Rob Herring <robh@kernel.org>

