Return-Path: <linux-pci+bounces-1607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F88220EE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57FC1C22974
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFF156EA;
	Tue,  2 Jan 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX+diyF0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65665156E3;
	Tue,  2 Jan 2024 18:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8583EC433C7;
	Tue,  2 Jan 2024 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704219718;
	bh=oavpCV5JrAJzdhCL01iv99+74mbDtupZw0so3YeF/4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UX+diyF04X1Mk9kCS14fnlp3Bzd5JfmCCga1RlJ68hf4NTIsu4K8P6qw7W/7aIsjI
	 tKu+WE2xNPe6uoAXcrT85bH3J4oIn5Nk1lPPPLtAd7FgNhF3opJS+XSp5Exk302yA9
	 Si5Wye7BIG6wQy5bF3o/++VO3i8Ff85zY6VoP6MnT64Qh/Rv6eXfY3SQsD4T+AsT2s
	 eJIMF1OrLP5D4SLzC4Am/zzIPE4nVxy7rY/qgkBdZPMkyOyIe26+TNaG6/9BHzmDpf
	 T+9aTFa1JM7zktrUenVuLP7xPhPlFVbYQAl9O0jmOqRUHFPngfJ4/IXWsu2CLBNAfj
	 /tX+KQCUpXdow==
Date: Tue, 2 Jan 2024 12:21:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Chen <me@linux.beauty>
Cc: Tom Joseph <tjoseph@cadence.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Pawel Laszczak <pawell@cadence.com>,
	=?utf-8?B?IlByemVteXPFgmF3IEdhaiI=?= <pgaj@cadence.com>,
	Nadeem Athani <nadeem@cadence.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	=?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is Cadence PCIe IP orphaned?
Message-ID: <20240102182157.GA1732664@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18cb4f78be7.118217ede232604.6825928402358580565@linux.beauty>

On Fri, Dec 29, 2023 at 04:46:11AM -0500, Li Chen wrote:
>  ---- On Thu, 28 Dec 2023 08:41:32 -0500  Bjorn Helgaas  wrote --- 
>  > Tom Joseph tjoseph@cadence.com> is listed as the maintainer of the
>  > Cadence PCIe IP, but email to that address bounces and lore has no
>  > correspondence from Tom in the past two years
>  > (https://lore.kernel.org/all/?q=f%3Atjoseph).
>  > 
>  > Does anybody want to step up to maintain this?  Should we apply a
>  > patch like the one below?
> 
> AFAIK, Cadence people are preparing to upstream their Gen5
> controller and PHY drivers. They may update the maintainers when
> they do so.

I hope so.  In the meantime, I applied the patch below to for-linus
for v6.7.  I don't think there's value in keeping an email address
that goes nowhere.

Bjorn


commit 54d52fb6fe70 ("MAINTAINERS: Orphan Cadence PCIe IP")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Dec 26 18:43:03 2023 -0600

    MAINTAINERS: Orphan Cadence PCIe IP
    
    Tom Joseph <tjoseph@cadence.com> is listed as the maintainer of the Cadence
    PCIe IP, but email to that address bounces and lore has no correspondence
    from Tom in the past two years
    (https://lore.kernel.org/all/?q=f%3Atjoseph).
    
    Mark the Cadence IP orphaned and add Tom to CREDITS.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


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

