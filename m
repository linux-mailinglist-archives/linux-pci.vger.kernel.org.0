Return-Path: <linux-pci+bounces-21593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47BA37E68
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350423A6A2B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0D212FA6;
	Mon, 17 Feb 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXucOYvP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258A212F82;
	Mon, 17 Feb 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784541; cv=none; b=PCH2dbkr3lqj2R1hj+4ggXTbWU5J5OsEjcqvZJtAblGOpQiJw/XAgQCit33yt6SjWsdzpOSx3oSxPCwRnAqn8YKSlTikDUVcgn+OLCn8uPRUhrhlE1lLe45dXxkFGkGeqJYI5k11Y0VXVGEQ5sCSqSIztLS+iyxU3aiwDveT8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784541; c=relaxed/simple;
	bh=uR0ahrBe/WAWEbfMIemRA6wzjqECzyWw0ycIUrRe8OA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eTOKRwROY5ehrYW5r9P/Vj7dQdGhtSNSu6Qwt0U/cjZV/9NIZ8Gy2GoBnrsOq5bMDeQBVhythrA0R4akZaip5d4id6uwkGQIcNapslQAsKf9eVrmyuR3CpXJbVIxV3f8JQf95rwhvrebeeEbSPXiBQXby20OSetkdl0WpV0R7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXucOYvP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739784539; x=1771320539;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uR0ahrBe/WAWEbfMIemRA6wzjqECzyWw0ycIUrRe8OA=;
  b=ZXucOYvPLWMmjCEqAEj1Y9Jfd+4iGeudDMiPXVVMUEA9GkLsuk6GQvEL
   Xu/Ggdm/1sftlSZLdMoYtoeSS3K3mReNvHwhcTGK5d9AmQWmvj7Q2Hgrq
   Vnc7sKZ8dFvF/VJN7DhnpRtxOHoyzcQSB4rsohmPXDryPm9dnM8dm2pEd
   CYQ6CYOoRuE2HXyOwbhKWw8BIZK15l7o56Igk7uQQplMgAOGuwoieSdkO
   jHFyarHF8ZwvYuj/uiWzYpRYm5a4E8mPYpXqQaYr8oJ3OoyEuYRDcT84h
   lq0EdMNvsKucUdaKeD64DnsQ4zCANATNGyDGrA8g2R7Mg6Uf0mSFR5PLx
   w==;
X-CSE-ConnectionGUID: VIM0Fa91SfqMLsvgUaY4tA==
X-CSE-MsgGUID: s2QfhcR2RHSsiSnvmTzU1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40723656"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40723656"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:28:58 -0800
X-CSE-ConnectionGUID: 1d74vD5uQOeDd00f7fDiXQ==
X-CSE-MsgGUID: WrTi6TyuSnSs1+mMwsmFlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119283191"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:28:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 17 Feb 2025 11:28:49 +0200 (EET)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
    Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
    mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
    ath11k@lists.infradead.org, quic_jjohnson@quicinc.com, 
    quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 2/8] PCI/bwctrl: Add support to scale bandwidth before
 & after link re-training
In-Reply-To: <20250217-mhi_bw_up-v1-2-9bad1e42bdb1@oss.qualcomm.com>
Message-ID: <f58ff91f-95a1-1a0d-91e9-972f0eeddd4c@linux.intel.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com> <20250217-mhi_bw_up-v1-2-9bad1e42bdb1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Feb 2025, Krishna Chaitanya Chundru wrote:

> If the driver wants to move to higher data rate/speed than the current data
> rate then the controller driver may need to change certain votes so that
> link may come up at requested data rate/speed like QCOM PCIe controllers
> need to change their RPMh (Resource Power Manager-hardened) state. Once
> link retraining is done controller drivers needs to adjust their votes
> based on the final data rate.
> 
> Some controllers also may need to update their bandwidth voting like
> ICC bw votings etc.
> 
> So, add pre_scale_bus_bw() & post_scale_bus_bw() op to call before & after
> the link re-train.
> 
> In case of PCIe switch, if there is a request to change target speed for a
> downstream port then no need to call these function ops as these are
> outside the scope of the controller drivers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
>  include/linux/pci.h       |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 0a5e7efbce2c..e3faa4d1f935 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -161,6 +161,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
> +	bool is_root = pci_is_root_bus(port->bus);

is_rootport ?

>  	struct pci_bus *bus = port->subordinate;
>  	u16 target_speed;
>  	int ret;
> @@ -173,6 +175,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  
>  	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>  
> +	/*
> +	 * The controller driver may need to be scaled for targeted speed
> +	 * otherwise link might not come up at requested speed.
> +	 */
> +	if (is_root && host->ops->pre_scale_bus_bw) {
> +		ret = host->ops->pre_scale_bus_bw(host->bus, target_speed);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
>  		struct pcie_bwctrl_data *data = port->link_bwctrl;
>  
> @@ -197,6 +209,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  	    !list_empty(&bus->devices))
>  		ret = -EAGAIN;
>  
> +	if (is_root && host->ops->post_scale_bus_bw)
> +		host->ops->post_scale_bus_bw(host->bus, pci_bus_speed2lnkctl2(bus->cur_bus_speed));

Is the naming of these callbacks too specific for your use case? Does PCIe 
spec actually call changing the Target Speed "scaling bus bandwidth" or 
something along those line?

>  	return ret;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..58f1de626c37 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -804,6 +804,8 @@ struct pci_ops {
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> +	int (*pre_scale_bus_bw)(struct pci_bus *bus, int target_speed);
> +	void (*post_scale_bus_bw)(struct pci_bus *bus, int current_speed);

Please document these, including the locking requirements.

-- 
 i.


