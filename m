Return-Path: <linux-pci+bounces-42471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D50CFC9B091
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88DD83444B7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2930BF52;
	Tue,  2 Dec 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG1IlhZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45D30C36B;
	Tue,  2 Dec 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670352; cv=none; b=FVsICdY/W3glQULMJJLSLGcWe/ZPvd5eTBFwsd+OKpeC2zdFPg5dpEeqABEkTB/6Cwt1/Fs1DRP8ZG2rd5dEt7jqFof8xjn1DdcKUwu3wDW4VzPaCKXjunnm+PR2MPDu6HWKT6lD9FngOuSF2GrSSzhRUYfa9FljOxWNMROMKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670352; c=relaxed/simple;
	bh=sqiX0jb1v0UmMdokJRTSMz9MKkDH/LfxCka2MIljKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA1OIUouTtGXOnZ9VHCKfHfPW7d4dxXzSGRkR4KzHjMPk8SJsnJn8xz7Qt3X27XMiB3vKH86BOvcSowihlVfmfkpNLxVYgg92+hjfQ0oaqTvk1cU2pnfZBj5ZPlD5UqqsqUwdDinx32Ww/boksHgeNaza/kHN0t8dkbSLhq45J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG1IlhZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571FC4CEF1;
	Tue,  2 Dec 2025 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764670352;
	bh=sqiX0jb1v0UmMdokJRTSMz9MKkDH/LfxCka2MIljKkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG1IlhZZ8dxGIeplIChggbvAm6CB+XG5ghS+Z5ft06za/moeDXhEhbtqR2Y5LKOiK
	 3sdL3KSs/gX9hnn7Fzh27/S9J6rXmfpf5fU+D6/kqPzykqS08yzTme1ML+7XY7t2if
	 H246ARoydoc1WQQE1IbRnppQHzZW0ECCJzQ+6VeKwEAbc0ji517FSlHE83/el9UsIu
	 QHh7O40B1GlgiMrYQbKeXPXvrL3ZH6iO5oQyZ7qkQS1wtOecypo+VUDNd/5K2K2Aey
	 9AgFvpAVHlzI0PwrordRV5G5YWk2onFQ7tLwnYpZyIEbQzU5qdHAEEMdvImtxd23Qo
	 1jg3tefoudENw==
Date: Tue, 2 Dec 2025 15:42:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
Message-ID: <6ulzkdgd6j35ptu5mesgtgh2xa6fwalcmkgcxr2fdjwwfvzhrf@4dtcadsl2mvm>
References: <20251128162928.36eec2d6@canb.auug.org.au>
 <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
 <ykmo5qv46mo7f3srblxoi2fvghz722fj7kpm77ozpflaqup6rk@ttvhbw445pgu>
 <CAKfTPtA-wir5GzU7aTywe7SZG18Aj8Z9g1wjV-Y8vKoyKF1Mkg@mail.gmail.com>
 <vb6pcyaue6pqpx626ytfr2aif4luypopywqoazjsvy4crh6zic@gfv75ar7musy>
 <CAKfTPtCKmj_dHGU-2WPsEevf7CR-isRiyM0+oftCrMy5MswE4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCKmj_dHGU-2WPsEevf7CR-isRiyM0+oftCrMy5MswE4A@mail.gmail.com>

On Tue, Dec 02, 2025 at 11:03:07AM +0100, Vincent Guittot wrote:
> On Tue, 2 Dec 2025 at 10:53, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Dec 02, 2025 at 09:54:24AM +0100, Vincent Guittot wrote:
> > > On Tue, 2 Dec 2025 at 05:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > + Vincent
> > >
> > > Thanks for looping me in.
> > > >
> > > > On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> > > > >
> > > > >
> > > > > On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > Changes since 20251127:
> > > > > >
> > > > >
> > > > > on i386 (allmodconfig):
> > > > >
> > > > > WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)
> > >
> > > Are there details to reproduce the warning ? I don't have such warning
> > > when compiling allmodconfig locally
> > >
> > > s32 pcie can only be built in but I may have to use
> > > builtin_platform_driver_probe() instead of builtin_platform_driver()
> > >
> >
> > The is due to calling a function belonging to the __init section from non-init
> > function. Ideally, functions prefixed with __init like memblock_start_of_DRAM()
> > should be called from the module init functions.
> >
> > One way to fix would be to call memblock_start_of_DRAM() in probe(), and
> > annotate probe() with __init. Since there is no remove, you could use
> > builtin_platform_driver_probe().
> >
> > This also makes me wonder if we really should be using memblock_start_of_DRAM()
> > in the driver. I know that this was suggested to you during reviews, but I would
> > prefer to avoid it, especially due to this being the __init function.
> 
> yeah, I suppose I can directly define the value in the driver has
> there is only one memory config for now anyway
> 
> /* Boundary between peripheral space and physical memory space */
> #define S32G_MEMORY_BOUNDARY_ADDR 0x80000000
> 

Ok. I fixed it up myself with below diff:

diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index eacf0229762c..70b1dc404bbe 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -7,7 +7,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
@@ -35,6 +34,9 @@
 #define PCIE_S32G_PE0_INT_STS                  0xE8
 #define HP_INT_STS                             BIT(6)
 
+/* Boundary between peripheral space and physical memory space */
+#define S32G_MEMORY_BOUNDARY_ADDR              0x80000000
+
 struct s32g_pcie_port {
        struct list_head list;
        struct phy *phy;
@@ -99,10 +101,10 @@ static struct dw_pcie_ops s32g_pcie_ops = {
 };
 
 /* Configure the AMBA AXI Coherency Extensions (ACE) interface */
-static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
+static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci)
 {
-       u32 ddr_base_low = lower_32_bits(ddr_base_addr);
-       u32 ddr_base_high = upper_32_bits(ddr_base_addr);
+       u32 ddr_base_low = lower_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
+       u32 ddr_base_high = upper_32_bits(S32G_MEMORY_BOUNDARY_ADDR);
 
        dw_pcie_dbi_ro_wr_en(pci);
        dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
@@ -149,7 +151,7 @@ static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
         * Make sure we use the coherency defaults (just in case the settings
         * have been changed from their reset values)
         */
-       s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
+       s32g_pcie_reset_mstr_ace(pci);
 
        dw_pcie_dbi_ro_wr_en(pci);

- Mani

-- 
மணிவண்ணன் சதாசிவம்

