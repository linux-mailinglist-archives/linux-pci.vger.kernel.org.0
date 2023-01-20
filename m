Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7848D674F57
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjATIXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 03:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjATIXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 03:23:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C478ABD;
        Fri, 20 Jan 2023 00:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1IBDSfDrpMYQx8rkav9qJHt8V5y0Ox1ZCl4BB8a2/Bk=;
        t=1674202986; x=1675412586; b=pngvZ9yP6r4n0NnbN3OmU4sL0mQQpf34xbgHKq0AGQH3N29
        NdK13ddKlue/984BTjlSPkT46vBhohdnw5UfeBwq2TWkt2fuBnbcptS7q7/0OrRNLGSiGS+CXohLF
        UNoN9H5a/CPdEQgvCopqQEtbnOGj/WgqvZPZSj52cwM70HkUCNbUwVnUqs+kMfazyrYQrLALBmu+/
        3/XxTVXhq/ChVbHS/MwhZiSXMvhtDeDlBxmg2DD8tOMZJqm4CTi+bfPz3DfXU9E6pLsdiO4+2bZv9
        SckdFl3Jurr36yGbF4dKDKjpL8idF2ooeiUSne+Q/kmRi83k92437XC5nirtHSvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pImfp-007Mhu-2I;
        Fri, 20 Jan 2023 09:22:57 +0100
Message-ID: <49d7ebeb4617e9a1e42ef1608da6a907201c6c38.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virt-pci: implement pcibios_get_phb_of_node()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Date:   Fri, 20 Jan 2023 09:22:56 +0100
In-Reply-To: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
References: <20230120-uml-pci-of-v1-1-134fb66643d8@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2023-01-20 at 09:02 +0100, Vincent Whitchurch wrote:
> Implement pcibios_get_phb_of_node() as x86 does in order to allow PCI
> busses to be associated with devicetree nodes.
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/drivers/virt-pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 3ac220dafec4..6884e1be38e4 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -533,6 +533,25 @@ static void um_pci_irq_vq_cb(struct virtqueue *vq)
>  	}
>  }
> =20
> +/* Copied from arch/x86/kernel/devicetree.c */
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)

Hah. I was going to ask how that works without any ifdef or anything,
but then I found the __weak version :-)

Acked-by: Johannes Berg <johannes@sipsolutions.net>


Or maybe I should finally put on my tentative ARCH=3Dum maintainer hat and
start taking patches :)

johannes

