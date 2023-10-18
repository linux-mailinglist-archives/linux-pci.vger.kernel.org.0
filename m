Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD57CD96C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJRKkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjJRKkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 06:40:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24910D;
        Wed, 18 Oct 2023 03:40:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD70C433C7;
        Wed, 18 Oct 2023 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697625640;
        bh=6l2WAUtlA/ULfa6NCxDUETqJdzJBr+uJX9Jc00RLa6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/C5LuA/3W86f45UzFmRsSluYAyI+NSFtCRiONkE73zYopAHjvTcxWK67TNxMxVq3
         au1QLL4hxTbPD9lARsdyXNcs4uN0xRqYXK2ykPlRFpPtffcxvBljAJE9XZj7JrqNyz
         In+MytDdk+07dsr61GI0PyIlcK1rihDofRTlA3Gc4Q0xfYm4K7eidg/E1Ko62tRvfg
         En9zIAweZyweybmuTdSSKgeiKmwcIGKp+5rSSuVQzG9cxQt413w1xY04lJfwnbbI7Y
         k7D7lZ4mY2gfFpRRFGxZc4WlfDhO+LXic3sQzeMJW7j3nt2BvcCZnng2AbBlkP0bM4
         HDVGmh1ZoB+ow==
Date:   Wed, 18 Oct 2023 11:40:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v8 05/22] PCI: microchip: Rename two PCIe data structures
Message-ID: <20231018-secret-tightrope-818ef4ffd2b7@spud>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
 <20231011110514.107528-6-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hDtbUqOVfdHu31+w"
Content-Disposition: inline
In-Reply-To: <20231011110514.107528-6-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hDtbUqOVfdHu31+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--hDtbUqOVfdHu31+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS+2IgAKCRB4tDGHoIJi
0mowAQDAMLOnsRviLr4bHPlvbZB4oFttuKiB+rGTUeGDfrjp3gD/X/YaDWfTmR6B
zMS6AwCbC9ZxUmq46s34IQx6IlfBng4=
=mxSE
-----END PGP SIGNATURE-----

--hDtbUqOVfdHu31+w--
