Return-Path: <linux-pci+bounces-18395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF89F126F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50372161533
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93D1DFE01;
	Fri, 13 Dec 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fysSowvu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB716A395;
	Fri, 13 Dec 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108217; cv=none; b=pW7ZgL3WqLZKo05ZF0H1pe7WdsRSRnNPgxN1X/PeMZNaS4pu29ofg59XOM8aMLZKnnPVGmd1efPrYA4jMy5Kd2Hl6aA3HscNj2URWQBvz2UuyOi9LjOvFrPDL2nV/Y0RSnuCrM9272QkZ+ASmyQyoJzAjaKERHjjc9FcgMESRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108217; c=relaxed/simple;
	bh=7SMi3ynl1by2FW9RHSSDMVVshYHz6HwImISHlqdcnQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I6lPJofRJ4Y7VQsyxN/00++m7WPsvayE9LHV0EIA4MGIqQQHlBdCHCHL1xZzb9eQCYlvc4yEGTQ1E+Mfl3e4KEMmpaezCkK62MazbC0i6520KSPzTieeTo63BA1K6PN3uT9IVu3dTSSeK9173agy/bQSeT7QTd8DLognoYvLJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fysSowvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E81C4CED0;
	Fri, 13 Dec 2024 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734108217;
	bh=7SMi3ynl1by2FW9RHSSDMVVshYHz6HwImISHlqdcnQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fysSowvuU/8vugTZiQthQ6TNE2s1XsrWgdqVk9NFrIY3NQO/pLMC9/u2UMBAJyYo3
	 6MYIUxV0gfBGefeDgm8WVDdm60WOf5PTrehZHz90y1PwHTpVWxq+YkadxYjPACDVV0
	 0O5+ca/z6l2PlmlBLuciAnwmDJhDUD05SKdCCIrw0fC1Nh/R+5GzQfyi0cDbzbZeSr
	 tiwgiOnrgHkrI1LxMK+r9eNDx5RC8SMCatkm5Lq9mhsukDbxvVzjco+/JYrX10+3Nf
	 rzD25qwjMYCIOb/fwiLwCvXiJjj7S+CX/xz+rUurItLTjt01cUUayE6rXURv+oRaz6
	 kayEOM8KTNEvg==
Date: Fri, 13 Dec 2024 10:43:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	You-Sheng Yang <vicamo.yang@canonical.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.ntel.com>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <20241213164335.GA3381091@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402b2e32-3b54-4e80-92fd-9237549ffa14@panix.com>

[+cc David, Nirmal, linux-pci]

On Thu, Dec 12, 2024 at 03:04:53PM -0800, Kenneth Crudup wrote:
> On 12/12/24 12:56, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
> > > So we're on 6.13-rc2 and the patches are getting closer and
> > > closer, but they still need to be manually added.
> > > 
> > > The good news is now only (variants of) "PCI/ASPM: Enable LTR
> > > for endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links
> > > under VMD domain" are needed.
> ...

> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679

This is "UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind
VMD", which writes PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT
for PCI_CLASS_STORAGE_EXPRESS devices directly below VMDs with Device
IDs 0x9a09, 0xa0b0, or 0xa0bc.

This looks equivalent in spirit to upstream
https://git.kernel.org/linus/f492edb40b54 ("PCI: vmd: Add quirk to
configure PCIe ASPM and LTR"), which writes PCI_LTR_MAX_SNOOP_LAT and
PCI_LTR_MAX_NOSNOOP_LAT for any kind of device below VMDs tagged with
VMD_FEATS_CLIENT, which includes 0x467f, 0x4c3d, 0x7d0b, 0x9a0b,
0xa77f, 0xad0b, 0xb06f, 0xb60b.

However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
so I'd be surprised if VMD worked for those devices unless BIOS set
up the VMD itself.

Maybe David or Nirmal can comment on this?

> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526

This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
IDs 0x9a09 and 0xa0b0.

This looks like it should also be handled by upstream f492edb40b54
("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
"pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".

But again, the Device IDs mentioned in the Ubuntu commit are NOT
included in the upstream VMD_FEATS_CLIENT list.

> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981

This is "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
instead", which applies the quirk that writes PCI_LTR_MAX_SNOOP_LAT
and PCI_LTR_MAX_NOSNOOP_LAT for PCI_CLASS_STORAGE_EXPRESS devices
below any VMD claimed by the "vmd" driver, not just VMDs with Device
IDs 0x9a09, 0xa0b0, or 0xa0bc.

I think the only thing that's missing is that the upstream vmd_ids[]
needs to be updated with some new VMD Device IDs that are tagged with
VMD_FEATS_CLIENT.

I don't know what the vmd_ids[] strategy is, but Kenneth, you might
try an upstream patch like the one below.  If that resolves the
standby/low-power issues, maybe David or Nirmal can figure out the
"right" way to do this.

Bjorn

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350..4de7ff3bbf23 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1109,6 +1109,12 @@ static const struct pci_device_id vmd_ids[] = {
                 .driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb06f),
                 .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0x9a09),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xa0b0),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xa0bc),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);

