Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5DC2E0C78
	for <lists+linux-pci@lfdr.de>; Tue, 22 Dec 2020 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgLVPJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Dec 2020 10:09:18 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:45502 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgLVPJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2020 10:09:18 -0500
Date:   Tue, 22 Dec 2020 15:07:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1608649672; bh=Qx0+gSCQI+zwlEgYtmJbydKr/M0gl5zfTxgSnTu7KjM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=l8olzOOFqQl9PpAudL0kQlto9/wJQ3L9VKguKXGkYaEfDWjLD6fDIZuKb7U350kFv
         pHdowhTtIOLbdW0JHiO+X4M35VvCLrYSvM5jeUaydv4TBQywZZWG2TY+QKFIxwXq7e
         waOQLsroh4qjjR6LgXx2ytkd9qhe14JvyC+eVsYNqL5Qj6Bx8eV/lX+TKxgp5JbqyU
         2kRlyer4REV/tAxZPd5S793BJ3wrfHAu92ExDOW3ikn6dxhp/XzSZzI3QoXsZNcFJW
         OUw12ESRn/uDnK3d3AtJ/8g+ixZudY1oD/KkhJonL35OzTlzxcuVp477fUuXqojOII
         xxnAezm/k28tQ==
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Lobakin <alobakin@pm.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH pci] PCI: dwc: fix inverted condition of DMA mask setup warning
Message-ID: <20201222150708.67983-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 660c486590aa ("PCI: dwc: Set 32-bit DMA mask for MSI target
address allocation") added dma_mask_set() call to explicitly set
32-bit DMA mask for MSI message mapping, but for now it throws a
warning on ret =3D=3D 0, while dma_set_mask() returns 0 in case of
success.
Fix this by inverting the condition.

Misc: remove redundant braces around single statement.

Fixes: 660c486590aa ("PCI: dwc: Set 32-bit DMA mask for MSI target address =
allocation")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 516b151e0ef3..fa40cc2e376f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -397,12 +397,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 =09=09=09=09=09=09=09    pp);
=20
 =09=09=09ret =3D dma_set_mask(pci->dev, DMA_BIT_MASK(32));
-=09=09=09if (!ret) {
+=09=09=09if (ret)
 =09=09=09=09dev_warn(pci->dev,
 =09=09=09=09=09 "Failed to set DMA mask to 32-bit. "
 =09=09=09=09=09 "Devices with only 32-bit MSI support"
 =09=09=09=09=09 " may not work properly\n");
-=09=09=09}
=20
 =09=09=09pp->msi_data =3D dma_map_single_attrs(pci->dev, &pp->msi_msg,
 =09=09=09=09=09=09      sizeof(pp->msi_msg),
--=20
2.29.2


