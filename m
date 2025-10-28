Return-Path: <linux-pci+bounces-39584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FCC172D4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D72406472
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CDB35581F;
	Tue, 28 Oct 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW8rRUrB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF51355814;
	Tue, 28 Oct 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689769; cv=none; b=sYuFRJfLMVTLpNQaS0rtu0CDDSwI1sZh6ZwlFlf2fV+o6gdKhDpoYIeWw14GhN5VpicG3RQFIhjYd6r8/PjBsA/rqKGuju5k6pLPD8RjapmlDsJFZsvHiXCMtdffEdm2lg/X8PzsMPJFxg4LounD0XY/zJs50N48L3x217oPtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689769; c=relaxed/simple;
	bh=NxQA4oKj6S/J9ShJx5/SQ4Cwfe8hUWFvyW9NNm3a+Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZJjbdH8Z8cQ1U2gJKgEqPC2uXTTN9zuYf3YoGLBdScsv9u2a+WtwchZu6zNItVVynMBwpq5cNoe7CZlBiyDj8nd4vKBUwdzsgD52Igm7KSZAb3dUN9Is61XUQTkb8s1DdMCocGrl+8yqHMnrAn0dwMKbo1rgAqEsX6y4soPjGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW8rRUrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D1C4CEE7;
	Tue, 28 Oct 2025 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761689768;
	bh=NxQA4oKj6S/J9ShJx5/SQ4Cwfe8hUWFvyW9NNm3a+Nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qW8rRUrB+EZgZTiEdhF/sYqZRKC4Rv6g/hbbiIeQmSnCDV2ksc36AMCqHtvCz6qVH
	 hWFkgBCxxRd5/E8Cc8TI7aBr/HjBCsmmESgcnfSwJxQyzAUNjjccO+Z5vmUIQfEBTn
	 PLe1DmLzDq1kgWsUCvl5xyNB0Us7HrG9g5S1JVa+03Rirj3DQ1L8OF0qKVzxSLIwOh
	 l0XQDvUize8wTPl17SvS9uRsGmXWEdUksBQ8HSr8+65I2K3p9RAmH/qMuOSKhoI4dA
	 210hY1/TcUCkQz+pwcvwMRRDxg8RfJX55Skd3QRhf7Z7fytnfZzngOny5eqI6N7WiY
	 JVkmpKr/75rDg==
Date: Tue, 28 Oct 2025 17:16:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <20251028221607.GA1533456@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR05MB102705BB2124288C68EEFDA04C7FCA@DM4PR05MB10270.namprd05.prod.outlook.com>

On Tue, Oct 28, 2025 at 02:19:13AM +0800, Linnaea Lavia wrote:

> On 6.18-rc3 with the change the link does not come up without pcie_aspm=off.

Thanks for testing this!

I think there are two problems:

  1) On v6.18-rc2, the meson-pcie probe failed with:

       meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]

     so we didn't even try to bring up the link.  I think this was
     fixed in v6.18-rc3 by a1978b692a39 ("PCI: dwc: Use custom pci_ops
     for root bus DBI vs ECAM config access").

  2) On v6.18-rc3, we brought up the link and enumerated 01:00.0, but
     as soon as we tried to enable ASPM L1, the link stopped working:

> [    5.396341] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
> [    5.474722] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.480590] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
> [    5.484394] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
> [    5.511625] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
> [    5.578507] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
> [    5.587460] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    5.656009] [     T50] pci 0000:01:00.0: ASPM: default states L1
> [    5.701063] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.724147] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
> [    5.779528] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.822074] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.864902] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.907448] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
> [    5.987517] [     T50] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
> [    6.081421] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)

Can you try the patch below on top of v6.18-rc3?  It should prevent
enabling ASPM L1.  Can you also collect the output of "sudo lspci -vv"
on some working kernel?

I'm a little concerned that [16c3:abcd] is too general because it
looks like that ID has really been abused by vendors:
https://patchwork.kernel.org/patch/10798497/

I wonder if there's a way for meson-pcie to write a corrected
Vendor/Device ID in the Root Port so we could make a quirk that's
specific to the Meson controller.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..9cd12924b5cb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

