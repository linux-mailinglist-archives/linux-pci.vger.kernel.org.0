Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6022C06A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXIDj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 24 Jul 2020 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXIDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 04:03:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA9C0619D3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2020 01:03:37 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jysfi-0003q5-UH; Fri, 24 Jul 2020 10:03:14 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jysff-00016x-SE; Fri, 24 Jul 2020 10:03:11 +0200
Message-ID: <e89fa4f3ba2b1b6fe94e662c6ab3cfbaa25867fa.camel@pengutronix.de>
Subject: Re: [PATCH V3 1/3] reset: imx7: Support module build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net,
        amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        vidyas@nvidia.com, hayashi.kunihiko@socionext.com,
        jonnyc@amazon.com, eswara.kota@linux.intel.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Fri, 24 Jul 2020 10:03:11 +0200
In-Reply-To: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-07-20 at 22:21 +0800, Anson Huang wrote:
> Use module_platform_driver(), add module device table, author,
> description and license to support module build, and
> CONFIG_RESET_IMX7 is changed to default 'y' ONLY for i.MX7D,
> other platforms need to select it in defconfig.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- use module_platform_driver() instead of builtin_platform_driver().

Thank you, applied to reset/next.

regards
Philipp
