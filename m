Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45666709FC8
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjESTOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 15:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjESTOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 15:14:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831061700;
        Fri, 19 May 2023 12:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3494D65979;
        Fri, 19 May 2023 19:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A17C433D2;
        Fri, 19 May 2023 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684523629;
        bh=aRtZRFDPNv2lrbP2lIfnc2TEqimUVJtOgDJ+yrSIzM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucfD65VKM5HSOr4GO3Gg4K2RHy6M3cnOZ1s8CQVP5XXQvHClZK11nkekfnaS4YIzO
         o9plZkK1LRsPyjBm2JIr7ByxO/ek+XRNdYGzzRVxP+G8d+cxnqqpgXV9tmU+mTE9uH
         IilcJYLL3WejjdXLofd5QpNe1b88MN8qST8yoK0+TR7VS4hzW/d66oDxND+LacqwuG
         AImBQc3Hsa752WLn85yLBtyyh2p1ulsOnE0fsa8MYxhUqRXcfppiR11tYdn+FfDKev
         ZdF+mKQjKmLEjcJEfqDRItazZqa+WrTFLw3++HQXyxTVw0/1EVWNGDZQuBS/oN4a7r
         aCmXrzuAH9LQg==
Date:   Fri, 19 May 2023 20:13:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bharat.kumar.gogada@amd.com,
        michals@amd.com, nagaradhesh.yeleswarapu@amd.com
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Message-ID: <20230519-decidable-prelude-2f0d58041f02@spud>
References: <20230519105901.2399452-1-thippeswamy.havalige@amd.com>
 <20230519105901.2399452-3-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7bJMJIS2ploL3DA8"
Content-Disposition: inline
In-Reply-To: <20230519105901.2399452-3-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7bJMJIS2ploL3DA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 04:29:00PM +0530, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>

Looks like you might've forgotten a Co-developed-by?

> diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/=
Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml

> +properties:
> +  compatible:
> +    const: xlnx,xdma-host-3.00

Perhaps not a question for you Thippeswamy, but is there a reason for
PCI root ports not having any soc-specific compatibles? Rob (if you see
this when you're back)?

> +                interrupt-controller ;

Looks like you didn't see Michal's comment about the extra space.
If you resubmit for some other reason, you should fix that in the
process :)

Cheers,
Conor.

--7bJMJIS2ploL3DA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGfKaAAKCRB4tDGHoIJi
0mh8AP4ydIHMh7sRSzRZ6kiE5FV0mOSkS2bEjL2NdWzUiw105QEAmv7RBaLYL3BM
Zxji3IjueRdX8XSUwIHtseRmCnO7ZAg=
=1KAV
-----END PGP SIGNATURE-----

--7bJMJIS2ploL3DA8--
