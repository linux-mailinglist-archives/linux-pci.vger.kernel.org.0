Return-Path: <linux-pci+bounces-30180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2282AE0629
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305907A76F5
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7A217723;
	Thu, 19 Jun 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwYq1A2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207D35963;
	Thu, 19 Jun 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337139; cv=none; b=iY+HeKBublaZDjoFlEO9zSOFbGypTlWWzERHB1Aam+w3xmAH+0KVU5bW94jM4LM4m42yF8CRogRVS4sJA9/m1/4clkwqoknGgWR0t1oDbMFaOImfI0pDF1+UT8aLv7O2NJsSIWctgrHg1jBITHwjk7Mq2Q1nudSolwRb8B7I6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337139; c=relaxed/simple;
	bh=KNqb7eHKDRfrbzB+nYR6iggc29bY0RRO9LiF69GOYI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzss1yyje8DIW/+rODWIQazytSnHPmtvgmM8bt6zUmoOcZvBhn3OtQ+/XV8D/vsrHST8EBLFbbpypeB6+IEr9xlfzLMCQDeYCI9nvphDSx1iFvR7Kz8NAar3sFpYcM2JskQwe/L5U/4hNUrFp5t5lNG+aBizihhUNkUUXfJy3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwYq1A2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7822AC4CEEA;
	Thu, 19 Jun 2025 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750337138;
	bh=KNqb7eHKDRfrbzB+nYR6iggc29bY0RRO9LiF69GOYI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwYq1A2fmSqsQaRBsaydPOG21gcTZCtQd7cYOYCEGO+WYBLtTuJT/9uNfzsZ+9Vps
	 uRYjx7+K7cWyyYCYOX7eUU4RfG2XNfDlCo6xWjQ7PYuRl/PzOJXe6nvvBDtX/uim+B
	 S++kc8EQVH9INpuVvcdjMfHmT4svUZZczCZtatRH2PfF9UihMu6fU14qbAlXLb1Mpv
	 +dGKfzMHYSWmGMR49wGjHkrOzbB14t3DjHD8EsCMEcJlsBD4d23TFosFIDV/Tlv4pf
	 VUf6hio6bIfjEW3X23Gwmg3ePGgwhy3m5ko6QI5XDep/RFn6Qpjf0pzXz0kY1PaAl4
	 8Snes676Vd6wg==
Date: Thu, 19 Jun 2025 18:15:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Niklas Cassel <cassel@kernel.org>, lpieralisi@kernel.org, kw@linux.com, 
	bhelgaas@google.com, heiko@sntech.de, manivannan.sadhasivam@linaro.org, 
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, 
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
Message-ID: <rjgmkdk33h64plssiw2euna3wo4ejw4t3gisqkt3ibco62vjin@w2yu6wnzwled>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com>
 <co2q55j4mk2ux7af4sj6snnfomditwizg5jevg6oilo3luby5z@6beqtbn3l432>
 <aEwRAZgLJUECbGz6@ryzen>
 <1e3ba7e1-dad3-4728-85d2-276945119ab0@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3ba7e1-dad3-4728-85d2-276945119ab0@163.com>

On Fri, Jun 13, 2025 at 11:31:01PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/6/13 19:52, Niklas Cassel wrote:
> > On Fri, Jun 13, 2025 at 12:08:31PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
> > > > Current PCIe initialization logic may leave root ports operating with
> > > > non-optimal Maximum Payload Size (MPS) settings. While downstream device
> > > > configuration is handled during bus enumeration, root port MPS values
> > > > inherited from firmware or hardware defaults might not utilize the full
> > > > capabilities supported by the controller hardware. This can result is
> > > > uboptimal data transfer efficiency across the PCIe hierarchy.
> > > > 
> > > > During host controller probing phase, when PCIe bus tuning is enabled,
> > > > the implementation now configures root port MPS settings to their
> > > > hardware-supported maximum values. By iterating through bridge devices
> > > > under the root bus and identifying PCIe root ports, each port's MPS is
> > > > set to 128 << pcie_mpss to match the device's maximum supported payload
> > > > size.
> > > 
> > > I don't think the above statement is accurate. This patch is not iterating
> > > through the bridges and you cannot identify root ports using that. What this
> > > patch does is, it checks whether the device is root port or not and if it is,
> > > then it sets the MPS to MPSS (hw maximum) if PCIE_BUS_TUNE_OFF is not set.
> > 
> > Correct.
> > Later, when the bus is walked, if any downstream device does not support
> > the MPS value currently configured in the root port, pci_configure_mps()
> > will reduce the MPS in the root port to the max supported by the downstream
> > device.
> > 
> > So even we start off by setting MPS in the root port to the max supported
> > by the root port, it might get reduced later on.
> > 
> > 
> 
> Dear Mani and Niklas,
> 
> Is it okay to modify the commit message as follows? The last paragraph
> remains unchanged.
> 
> 
> 
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result in
> suboptimal data transfer efficiency across the PCIe hierarchy.
> 
> During host controller probing phase, when PCIe bus tuning is enabled,
> the implementation now configures root port MPS settings to their
> hardware-supported maximum values. Specifically, when configuring the MPS
> for a PCIe device, if the device is a root port and the bus tuning is not
> disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
> match the device's maximum supported payload size. The Max Read Request

s/device/Root Port

> Size (MRRS) is subsequently adjusted through existing companion logic to
> maintain compatibility with PCIe specifications.
> 
> Note that this initial setting of the root port MPS to the maximum might
> be reduced later during the enumeration of downstream devices if any of
> those devices do not support the maximum MPS of the root port.
> 

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

