Return-Path: <linux-pci+bounces-25742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE1A872DF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95A7188BF5A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7A1EC00B;
	Sun, 13 Apr 2025 17:14:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6C1EB1B5;
	Sun, 13 Apr 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564491; cv=none; b=iQs59jey7zzj9xdDY5PoAHxcpO7b0Zkxr4Hv83pjLVBhQlGjXp29TBDGyINxww1kF3XmRKK5+VvPTW0jDIsoSLUBn/eW4IpLy/5DrogkzWosFVm1vT+MAz4KqNKTCjW1JZ3V2RZOwDa/H4XKM5SDnu+ec7N8ki8kZGhbdS9AsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564491; c=relaxed/simple;
	bh=/9QIEj3PSUi5gKC7fRNdPDpM6GW5b6WkHu9fzuhe19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iml4a0vfKBc2FNOPWB8FBEEszLMkwpzU1bl/CxQP68nZC0jrT+/KQPGlGZtE/QBBfX7srPRR4rXpm8cEFfwmsooSuu90XPkHWG9JhYhJA3CChfCsGPW81LSwPKYJmpeHCTyv59X3tvHV2MK8TxkAOk2yaKgca0h3ZWqM/8RHSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7E71E2C0600F;
	Sun, 13 Apr 2025 19:14:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A0E6B4914D; Sun, 13 Apr 2025 19:14:38 +0200 (CEST)
Date: Sun, 13 Apr 2025 19:14:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 7/9] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
Message-ID: <Z_vw_i1P_Y2gCYrR@wunner.de>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>
 <Z_njmA49Gda-m0aH@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_njmA49Gda-m0aH@wunner.de>

On Sat, Apr 12, 2025 at 05:52:56AM +0200, Lukas Wunner wrote:
> On Sat, Apr 12, 2025 at 07:19:56AM +0530, Krishna Chaitanya Chundru wrote:
> > Introduce a common API to check if the PCIe link is active, replacing
> > duplicate code in multiple locations.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Looking at this with a fresh pair of eyeballs, I realize there's an issue
here, so unfortunately I have to retract the Reviewed-by:

pcie_link_is_active() differs from the existing pciehp_check_link_active()
in that it returns 0 not only if the link is down, but also if the
Config Space read returns with an error.

In particular, if Config Space of a hotplug bridge is inaccessible,
0 is returned instead of -ENODEV with this patch.  That can happen if
the hotplug bridge itself has been hot-removed, which is common with
Thunderbolt, but also on servers with nested PCIe switches.

The existing invocations of pciehp_check_link_active() do the right
thing if the hotplug bridge has been hot-removed, but after this patch
they no longer do.  For example in this hunk ...

> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> >  	 * Synthesize it to ensure that it is acted on.
> >  	 */
> >  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > -	if (!pciehp_check_link_active(ctrl))
> > +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
> >  		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> >  	up_read(&ctrl->reset_lock);
> >  }

... pciehp_request() will be called if the hotplug bridge was
hot-removed, which isn't the right thing to do.  The current
behavior is to do nothing.

I realize I steered you in the wrong direction because in my
review of your v4 I asked why pcie_link_is_active() doesn't
return a bool:

https://lore.kernel.org/all/Z72TRBvpzizcgm9S@wunner.de/

So I sincerely apologize for that!  You actually did the right
thing in v4 by returning a negative int if the Config Space read
returned an error.

Thanks,

Lukas

