Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6307B0830
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjI0P1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjI0P1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:27:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE2193;
        Wed, 27 Sep 2023 08:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2991CC433C8;
        Wed, 27 Sep 2023 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695828435;
        bh=aw0/9cgQsDBVjjrJdDVGrqkQ0FgYmL9yWqvaxanLjY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yp2KYFnf4VWnAK/lJysjzMKIFpbq+du6gQLBicsR+070pWL2pSKTmaAMM/Yk5TJLE
         Tl5WvzYaMBYJ5ZgyzmJFa2wQyH7MXjToZ4cexLLrsP9e3lyUvOIWDfEp1AhZYBGZuu
         vfy49iaR/HIsyBM2Nfezqn90Bm9DYGJhiAnmEigrDWSCc49yWjauA9xA3zOXO2o1CQ
         8A5o3GqoGZDhHpXxEQtGayajJo3egrXAG1Rs2XWyU0Z6rmdJOoVqXNHBivMGpg+yRf
         5SWe47QVd+0OvrIIDKVBU9DYM0fhm5kPqxn7kP1w3a8+w4Ew2UdNh3VvMcxd0m8mF8
         vQyZPflYJ0x4w==
Date:   Wed, 27 Sep 2023 16:27:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: brcm,iproc-pcie: Fix example
 indentation
Message-ID: <20230927-overspend-that-c5f8e7b9eac7@spud>
References: <20230926155351.31117-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GSZxDkacQH77W/rI"
Content-Disposition: inline
In-Reply-To: <20230926155351.31117-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GSZxDkacQH77W/rI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 10:53:40AM -0500, Rob Herring wrote:
> The example's indentation is off. While fixing this, the 'bus' node
> is unnecessary and can be dropped. It is also preferred to split up
> unrelated examples to their own entries.

Damn, it really was all over the shop..

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GSZxDkacQH77W/rI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRJzQAKCRB4tDGHoIJi
0qrpAQCAWVNdifbs6d9PzfN2w0yFtF1Mwu3kcAeK1uBd8DruPwEAuwbhxNAGfQKR
QACYiLmwo+89BCxaqwXBtMDqQj9lkQQ=
=kNLS
-----END PGP SIGNATURE-----

--GSZxDkacQH77W/rI--
