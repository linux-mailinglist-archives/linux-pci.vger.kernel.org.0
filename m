Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679846B5CEF
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCKOlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCKOlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 09:41:37 -0500
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Mar 2023 06:41:35 PST
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641710975F
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 06:41:35 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
        s=key1; t=1678545280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBm7qCElugUk3cf4BPO+3k33A5MOaMMu/5uGtC/rD4U=;
        b=FxA/VVQAfMXyId7rkd7f32NeMw3N88hEF/puQCJWeOWApF8QQpDjcixdA9ydVb6SiQtJ/T
        gzk0cak5UgvpI5yZvlWuaXDIV2EB7jK6pjF3mKaxAvgOBs9ZSonQ0sMAObNYwYfu9RM9Xd
        8rpQgZVhV9JukB/FogxlT6GFwLG340xII6r6rAuyXyUBshEuMbFN3sWq+npY4wFAj5gF5l
        z0rDrsZK6y8oGm12IW5llw/9i1t169+tI3FyrE4NzdWdq0VninIMTYDS4FVJHNCM/84KWv
        ENqlCX/LMHgICBqkt9shuNVT6MhtlXexy8em5cCzYi1OMjx6O06vgemr39EN+g==
Date:   Sat, 11 Mar 2023 14:34:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   alyssa@rosenzweig.io
Message-ID: <64cbf509004d6f34831f8257d3d9e82a@rosenzweig.io>
Subject: Re: [PATCH] PCI: apple: Initialize pcie->nvecs before using it
To:     "Sven Peter" <sven@svenpeter.dev>, "Marc Zyngier" <maz@kernel.org>
Cc:     "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=" <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230311133453.63246-1-sven@svenpeter.dev>
References: <20230311133453.63246-1-sven@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Whoops!=0A=0AReviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>=0A=0AM=
arch 11, 2023 8:34 AM, "Sven Peter" <sven@svenpeter.dev> wrote:=0A=0A> ap=
ple_pcie_setup_port computes ilog2(pcie->nvecs) to setup the number of=0A=
> MSIs available for each port. It is however called before apple_msi_ini=
t=0A> which actually initializes pcie->nvecs.=0A> Luckily, pcie->nvecs is=
 part of kzalloc-ed structure and thus=0A> initialized as zero. ilog2(0) =
happens to be 0xffffffff which then just=0A> configures more MSIs in hard=
ware than we actually have. This doesn't=0A> break anything because we ne=
ver hand out those vectors.=0A> Let's swap the order of the two calls so =
that we use the correctly=0A> initialized value.=0A> =0A> Fixes: 476c41ed=
4597 ("PCI: apple: Implement MSI support")=0A> Signed-off-by: Sven Peter =
<sven@svenpeter.dev>=0A> ---=0A> drivers/pci/controller/pcie-apple.c | 6 =
+++++-=0A> 1 file changed, 5 insertions(+), 1 deletion(-)=0A> =0A> diff -=
-git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-=
apple.c=0A> index 66f37e403a09..8b7b084cf287 100644=0A> --- a/drivers/pci=
/controller/pcie-apple.c=0A> +++ b/drivers/pci/controller/pcie-apple.c=0A=
> @@ -783,6 +783,10 @@ static int apple_pcie_init(struct pci_config_windo=
w *cfg)=0A> cfg->priv =3D pcie;=0A> INIT_LIST_HEAD(&pcie->ports);=0A> =0A=
> + ret =3D apple_msi_init(pcie);=0A> + if (ret)=0A> + return ret;=0A> +=
=0A> for_each_child_of_node(dev->of_node, of_port) {=0A> ret =3D apple_pc=
ie_setup_port(pcie, of_port);=0A> if (ret) {=0A> @@ -792,7 +796,7 @@ stat=
ic int apple_pcie_init(struct pci_config_window *cfg)=0A> }=0A> }=0A> =0A=
> - return apple_msi_init(pcie);=0A> + return 0;=0A> }=0A> =0A> static in=
t apple_pcie_probe(struct platform_device *pdev)=0A> -- =0A> 2.25.1
