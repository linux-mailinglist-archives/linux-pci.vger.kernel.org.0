Return-Path: <linux-pci+bounces-39489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B56C12E20
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A031896537
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 04:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90824338F;
	Tue, 28 Oct 2025 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W75aNDa+"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED98220F21;
	Tue, 28 Oct 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627320; cv=none; b=mlzw7GpBK7KqT9DyVhtgQDxGRDorkgNUDUpKqciAdTo2t+S2dGxzkg8/54+ganfpm1bKvrypfakNPuQqRVI2ICboktSw0Sjt1ZHrOVcPqf0P2GKiMXxfSiWoK/8mT5tJ3FYVGbJ+UvfsNJsnKndDE1FBe66ouOzC4jOglkWiH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627320; c=relaxed/simple;
	bh=VW4ffFj1JqUqF9Dw59lZsILROjW/IzzB3ffJCoGw6vk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zh/TWBqOU9KE6MjGhk3YKsoJ+iIB9oB6Qf3owT0gXsmBZm9nfnCWFGvqWOboMI/DkCC1/lcWekv8W4Ub5KkcrUiFIK8nJ7361pm+Y5UpTpRK1npJvUt7uyuouBep8H6T2O3UtPcRP8CtKLsSztcvOQZhAgktPGyijHr7zX13JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W75aNDa+; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S4smQQ2554711;
	Mon, 27 Oct 2025 23:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761627288;
	bh=TqaWtbjCCQta5htr0klKwsxO0Blg0VSeqN2ETZLOGxc=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=W75aNDa+LO/wUyG4fF7coUwKIwzKg6vRPQIdf6nFfSMT4u6xR6L6DB0bq6DjXf06s
	 q/y+wPYiHmNEWU60tlpyHsJcAwZaZZA5Z+lCK8f6Zbzz2z5Tr31IIbD4oYnkbWAW3e
	 kA80TTqHH2QUQc8SpmwkZw/B71AKn2PKbyniZd4g=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S4slrc1407743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 23:54:47 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 23:54:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 23:54:47 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S4sfDS1777174;
	Mon, 27 Oct 2025 23:54:41 -0500
Message-ID: <44b90ca1a10fe737cb20b76327846c5cda420924.camel@ti.com>
Subject: Re: [PATCH v4 4/4] PCI: keystone: Add support to build as a
 loadable module
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: kernel test robot <lkp@intel.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 28 Oct 2025 10:24:51 +0530
In-Reply-To: <202510281008.jw19XuyP-lkp@intel.com>
References: <20251022095724.997218-5-s-vadapalli@ti.com>
	 <202510281008.jw19XuyP-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, 2025-10-28 at 11:06 +0800, kernel test robot wrote:
> Hi Siddharth,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.18-rc3 next-20251=
027]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapall=
i/PCI-Export-pci_get_host_bridge_device-for-use-by-pci-keystone/20251022-18=
0213
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20251022095724.997218-5-s-vadapa=
lli%40ti.com
> patch subject: [PATCH v4 4/4] PCI: keystone: Add support to build as a lo=
adable module
> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/2025102=
8/202510281008.jw19XuyP-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251028/202510281008.jw19XuyP-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202510281008.jw19XuyP-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes=
/test-kprobes.o
> > > ERROR: modpost: "hook_fault_code" [drivers/pci/controller/dwc/pci-key=
stone.ko] undefined!
> ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefine=
d!

I had built the driver for ARM64 platforms but missed building it for ARM32
platforms. I will fix the build error for ARM32 platforms and will post the
v5 series.

Regards,
Siddharth.

