Return-Path: <linux-pci+bounces-1502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411B81F8E5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 14:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7058A28180A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008D8495;
	Thu, 28 Dec 2023 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvBYgIdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DF8485;
	Thu, 28 Dec 2023 13:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1CBC433C7;
	Thu, 28 Dec 2023 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703770894;
	bh=gC61R1jrcwV7pU5xh4n9nO3mVijXwltfHIta7hT0HJs=;
	h=Date:From:To:Cc:Subject:From;
	b=UvBYgIdxVZ5zsu0As0EnguD/s45k4i0tisoPM6dNT8eCB+FgVURkmXj7kPxrua0lG
	 1FUE03KF1bdwebEUpqbkVcb9xqxzsxqtTjCzARmeCoMhgbheXzFbNoP5a2su+0zgmB
	 8gEUmP1/yIwRDa6kyp0HHFBvo/wyWlXxsn9jY0u3GCBXFxVKsJ5XxdTMESyv3cCw/X
	 SByhO+VD90thouRfJ2UnXO0iU093uOAuevManaB2cprVgoL9c1lNSkS9w5sRADg0tR
	 b+gJqp4w/wiAgsOhNEJPtn0/rLXS+XK4pRc1I2gl76b/qgiSdV2TnSL0pbBBNFWnAK
	 JRmM3oHrKPJKQ==
Date: Thu, 28 Dec 2023 07:41:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tom Joseph <tjoseph@cadence.com>
Cc: Parshuram Thombare <pthombar@cadence.com>,
	Pawel Laszczak <pawell@cadence.com>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Nadeem Athani <nadeem@cadence.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Is Cadence PCIe IP orphaned?
Message-ID: <20231228134132.GA1486379@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Tom Joseph <tjoseph@cadence.com> is listed as the maintainer of the
Cadence PCIe IP, but email to that address bounces and lore has no
correspondence from Tom in the past two years
(https://lore.kernel.org/all/?q=f%3Atjoseph).

Does anybody want to step up to maintain this?  Should we apply a
patch like the one below?

Bjorn


diff --git a/CREDITS b/CREDITS
index f33a33fd2371..55be8af1c74f 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1855,6 +1855,10 @@ D: Fedora kernel maintenance (2003-2014).
 D: 'Trinity' and similar fuzz testing work.
 D: Misc/Other.
 
+N: Tom Joseph
+E: tjoseph@cadence.com
+D: Cadence PCIe driver
+
 N: Martin Josfsson
 E: gandalf@wlug.westbo.se
 P: 1024D/F6B6D3B1 7610 7CED 5C34 4AA6 DBA2  8BE1 5A6D AF95 F6B6 D3B1
diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..595aa56acde4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16511,11 +16511,10 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
 F:	drivers/pci/controller/dwc/pcie-armada8k.c
 
 PCI DRIVER FOR CADENCE PCIE IP
-M:	Tom Joseph <tjoseph@cadence.com>
 L:	linux-pci@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
-F:	drivers/pci/controller/cadence/
+F:	drivers/pci/controller/cadence/*cadence*
 
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>

