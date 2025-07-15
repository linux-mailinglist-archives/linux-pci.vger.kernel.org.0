Return-Path: <linux-pci+bounces-32183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD16B064E5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 19:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEE34E5169
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3027B4F7;
	Tue, 15 Jul 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBweZLif"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB81DE4E1;
	Tue, 15 Jul 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599233; cv=none; b=s3L8UW02ikbLsZePuM2AvEDJPkwpY8VMQZtPK7DndCCKMw8VZ/4P4USMsaS1hPMb3dg3MWEaYzw+lksLyrbZMbsm3UdXJvxKNoTCoNK0c6RKtyo7tv2T//q/7nvTD8FwFgVS7AVXp5clB/JLUHZ4vZcHjjJnMtHMyFG5Xjv/A6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599233; c=relaxed/simple;
	bh=9G4DPMLc3V6Kqc+YEESQ26iQmayIypZSFV1NfnFRgYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M2KfDE+K7JQjmMgzrLXIAAQdKSRdTu1pG495dJXSCLYOLAPwM5fN/+YuzFyIcFOPQ8d1jfHIS3GOwBtZDA0bfs0btU2wgVcaZfq+vOeIT2e9aYiBmBRUbYn/MYTST1ajhV2CfdrfYFudjOXpmfEp9gugV+iJ9O6tr8nv53KEtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBweZLif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7322CC4CEE3;
	Tue, 15 Jul 2025 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752599232;
	bh=9G4DPMLc3V6Kqc+YEESQ26iQmayIypZSFV1NfnFRgYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bBweZLifiRV+tHUaSKX0xSnHlsH+cD65JbpVqEISEb9/xrkIq262JFfcbWxDZbzEX
	 WX1ozZlOj/fBILfQpCBNZ1iMEL0DbexeSyPI6y+U5q7qhzMMMa0X0QGqtkRGS3oGvk
	 8WwuVIDBKDFa2W8gDqMClE2/8KVgXv/aDcF0FUuOo5Fem/OOehhEBWwS60SKZ8oeEF
	 tTSv1f6BdjOv+80X5hO0dkwzLOzBjGU/yGvJkUtjY8eepfvyIBcSx1xQXAITQbk510
	 bo1Y6mC3Di83vV0gDwGCZ8AmTDnzdje9Hy4O+J84m+EqFO/rtpaJfLH1GNNKlnE5aq
	 d5wTyRdNez/RQ==
Date: Tue, 15 Jul 2025 12:07:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: imx6: Correct the epc_features of i.MX8M EPs
Message-ID: <20250715170711.GA2467369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708091003.2582846-1-hongxing.zhu@nxp.com>

On Tue, Jul 08, 2025 at 05:10:01PM +0800, Richard Zhu wrote:
> IMX8MQ_EP has three 64-bit BAR0/2/4 capable and programmable BARs. For
> IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4) instead
> of imx8m_pcie_epc_features (64-bit BARs 0, 2).
> 
> For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 and reserved BAR 5
> in imx8m_pcie_epc_features.
> 
> Main changes in v3:
> Seperate the patch into two commits and update the commit logs refer to
> Bjorn's suggestions.
> v2: https://lkml.org/lkml/2025/6/17/267
> 
> [PATCH v3 1/2] PCI: imx6: Correct the epc_features of IMX8MQ_EP
> [PATCH v3 2/2] PCI: imx6: Correct the epc_features of IMX8MM_EP and
> 
> drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, Richard, I updated pci/controller/imx6 with these patches.

