Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC06DCBF5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 22:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDJUBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDJUBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 16:01:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0501FC2;
        Mon, 10 Apr 2023 13:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB466117D;
        Mon, 10 Apr 2023 20:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137BC433EF;
        Mon, 10 Apr 2023 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681156865;
        bh=PR/yeP5ggYJVyJI7BlJL+FFHBpjj8PG7UidZk22cHyY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=byarW1i32BvM+CLSKo0WLY02E9BKd5Ebg3Sbbd7e/irTguplkWlbjf5F56AYxSy/F
         FUQXGkVIkuONmbdMMU/zQH4qoes0EL2SiOcp1SvoR1ky3GV/jNb4XEwx94I/BrJUtp
         wPpbXCL1P4tNAAopGUs6hXdjPEAROIIZHyzRpThXYsk6oAIsXws/KNcW5AUihAUUHb
         zAWC+F4U0EYBcWlYGJ/7v8OCzhbsk6wohFX7PnPnve/FvQGEYRrEJNZNmKmdzfvaHM
         QOgltxlqBH2UgffXDUIjmsx8KTxppevV+qo+Z84MtNHSyS/LGPI54NDS+TwFve2PVE
         X8Lkg2epPMfvg==
Message-ID: <44961379683ad0afd30436752d78cc39.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406-groovy-trustable-15853ac0a130@spud>
References: <20230406-undertake-stowing-50f45b90413a@spud> <20230406-groovy-trustable-15853ac0a130@spud>
Subject: Re: [PATCH v1 1/4] clk: sifive: make SiFive clk drivers depend on ARCH_ symbols
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Date:   Mon, 10 Apr 2023 13:01:03 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Conor Dooley (2023-04-06 13:57:47)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> use of such symbols on other architectures, convert the SiFive clk
> drivers to use the new symbol.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next
