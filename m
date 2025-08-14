Return-Path: <linux-pci+bounces-34075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815AB270AD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F28565310
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F826C3AA;
	Thu, 14 Aug 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/ueKFr2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1224DFE6;
	Thu, 14 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206219; cv=none; b=QovQL/0KQLj2xMLqwXFUtHb34bKtiN6raGtF6Jjx9h56S33KNXkV2utJU1XJbax8Q5rgyOQ8luXGKOr6XU21LOTwH7XPuG5PSxNYIijgo+Lblp32TlcD1wvALxAfgyB/8Q2+B5rhS+3rCLHYzbqPUnK40W9P3NfH9IIlQiowj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206219; c=relaxed/simple;
	bh=7mVKEQKMNEIRj9xSvfxfFDaMvYFrSJwGFWyxPNN9BYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FQS08YRCdahQhPAnbQB8WwMNyZIv6sO1tmgjMjDEXGH49l5SlqkugPvyb8oH9FisYlGRx5a6niOOwnPfMEV78UVDnztX/BiV6lk5RYU9ywaw8UbvYsbbDLi0E7/6/6Tqzrs0EbxJagYZsHosJpCbAGTe1kJUjcVtfGXPUF+ld3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/ueKFr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7863BC4CEED;
	Thu, 14 Aug 2025 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206218;
	bh=7mVKEQKMNEIRj9xSvfxfFDaMvYFrSJwGFWyxPNN9BYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g/ueKFr2aF8+mvYmRNIGBdU+rP1u57UCPsJlMNN2dUBoQgIE34CWcYYg1S1WaBCvP
	 e5USPHW8qKEKoyiwj0RVYBMg1RIsH4eXwNCHh0NVUTkYVpW3dvcn8xSGm+U4MeRLTl
	 YgKlLmbak2b7WLGDAML99z2WV6R1kbYLkZlQLiCS2P/WuIjsctZGEyk2+FcQQtD07f
	 pIKGUVdA6vroOB9qdd9rOpoiQW4dfrqDUufEttb5Ur5NlXECGyGy5vXuqPgR4JHJYI
	 M2NoChsEFxxV1w3wqhq7p38P4lx6Q0V63FXyJxmFipWRVxrYQcQeddkumHTQoQWjfa
	 nTpHpxiZSuk9w==
Date: Thu, 14 Aug 2025 16:16:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] PCI: cadence: Split PCIe controller header file
Message-ID: <20250814211657.GA349149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-3-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:20PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Split the Cadence PCIe header file by moving the Legacy(LGA)
> controller register definitions to a separate header file for
> support of next generation PCIe controller architecture.

s/Legacy(LGA)/Legacy (LGA)/

Similar for "HPA(High Performance architecture)" elsewhere.

> +++ b/drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
> @@ -0,0 +1,228 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe controller driver.
> +// Author: Manikandan K Pillai <mpillai@cadence.com>

I'm not trying to be a killjoy, but the only author listed in
pcie-cadence.h is Cyrille Pitchen, and I don't think simply moving
these definitions to a separate file really counts as becoming the
author.  I would at least preserve Cyrille's authorship.

Bjorn

