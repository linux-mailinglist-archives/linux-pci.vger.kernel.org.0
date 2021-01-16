Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E912F8EB8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jan 2021 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAPSpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jan 2021 13:45:52 -0500
Received: from mail-41103.protonmail.ch ([185.70.41.103]:43623 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbhAPSpw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jan 2021 13:45:52 -0500
X-Greylist: delayed 4203 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2021 13:45:52 EST
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 6D9822000E01
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 15:29:07 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GY1ol3C9"
Date:   Sat, 16 Jan 2021 15:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1610810857; bh=ewLrxUjradkPA1ru1Wz2k9bHtjXJsODmOn92IB7cjQE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=GY1ol3C9eZiVNw2YFAP0h7hmKMQ5WULAQN33gm4LWs4zvT7US/paN1oaHFkxGnne8
         RyalSLdFtHfXvgwY/6DFnEf7C1Dsv8YIEfc74JTA07/fcwBLPBJPOUdSizKaqlw4rV
         TVXFVwEWLfhmbDatVyZUgv3VDsjSPpcQtRx5O0CBzJonzTdL0WMmfoNNJbQnZHtH3N
         YScFQwe2vKKdZuYgO70Ae7JKMkmWJi3QWTEftsx+Hg2FjhM/U3EsUMVAXJYceTKLJE
         ZC0p8FkkbKECoGfAMjihEByW6n0dDeV/3I4t6YEcjxQ48jiUv3/Dfnf8TZVz+jST82
         ZCJM7weNrwaWg==
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH pci-next] PCI: dwc: put struct dw_pcie::{ep,pp} into a union to reduce its size
Message-ID: <20210116152711.23411-1-alobakin@pm.me>
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

A single dw_pcie entity can't be a root complex and an endpoint at
the same time.
We can use this to reduce the size of dw_pcie by 80, from 280 to 200
bytes (on x32, guess more on x64), by putting the related embedded
structures (struct pcie_port and struct dw_pcie_ep) into a union.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/pci/controller/dwc/pcie-designware.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 5d979953800d..924ebeaa3885 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -265,8 +265,10 @@ struct dw_pcie {
 =09size_t=09=09=09atu_size;
 =09u32=09=09=09num_ib_windows;
 =09u32=09=09=09num_ob_windows;
-=09struct pcie_port=09pp;
-=09struct dw_pcie_ep=09ep;
+=09union {
+=09=09struct pcie_port=09pp;
+=09=09struct dw_pcie_ep=09ep;
+=09};
 =09const struct dw_pcie_ops *ops;
 =09unsigned int=09=09version;
 =09int=09=09=09num_lanes;
--=20
2.30.0


