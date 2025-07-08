Return-Path: <linux-pci+bounces-31694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65EAFD0A3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E210482FF8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854C2DC34C;
	Tue,  8 Jul 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwzkQmWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DF2D9790;
	Tue,  8 Jul 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991945; cv=none; b=Rnkm8hJ3MkKODaJzZ4nhZoFn6m3azt6B9/Nk629UTHQXLXgMvfAWtNalh81zkHjriYbOwtKbgwnGToY35Vm1/H/4ZamiTkAJSc6kM5h3/RaV2rkQphOb5GttUncPm5qsqk5sMmKceJysvHNalssbC09bsnJ9jTyfFAWyl7e8yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991945; c=relaxed/simple;
	bh=QmoHd8cC81xmIDIbZJg1nKxwCyWUf9E8OERsbTNGp54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QScfuie6OdSLqrL7Imr2kydSzrL0r1MuVc7ygR7LeczM0G0pL4W0GSJ7KKpskZwssjT6zIu+h8VVBW/mTEl319G3nQb3ayBqsHHotqbQCNHotG+jjHH3Abpz1XlKvKkT0DNDs8oyRfheVXic/U3GmdyRl4vnGz/iJh3WJjfXGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwzkQmWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE8C4CEED;
	Tue,  8 Jul 2025 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991944;
	bh=QmoHd8cC81xmIDIbZJg1nKxwCyWUf9E8OERsbTNGp54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwzkQmWYtKwmnrBgCnqdCq4I0KvH45mkaufs0g2zpZphsVw0UrX4WEkPeny+dVWaw
	 M6AZK2sUINh5mh2Ry+BOP31dYkOZ+/mdz31oE6MwgCU8/kx+NLU4b9QF9QSwKguRYI
	 FIl2/JTGLBdDbv+oquP1D1XzoJcXFefS6Zp0J/u0AA2TIyur4qjm2nIG7PdYsVGKs6
	 reWPwpXw9y0Y/x/T4lVcbnYE/kfos1SMLIZmrqeWPEehNk5niV0pPeKHk7cAZwdgxb
	 zBjpN9lr4h7umBdF0vmo+B/aP8G47E+Db71104HEEjjkmtNoTrlcJ1ZODG8HXjfNVQ
	 NI2rF/+EjfqEQ==
Date: Tue, 8 Jul 2025 21:55:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
Message-ID: <fhi7q5mbe75xbfmff6k4qe5pe6xveya5dsfqkm6bqpz7rcn3vr@jyn4uxl2exp7>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-2-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-2-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:23PM GMT, Krishna Chaitanya Chundru wrote:
> If the driver wants to move to higher data rate/speed than the current data

s/driver/PCI client driver

> rate then the controller driver may need to change certain votes so that
> link may come up at requested data rate/speed like QCOM PCIe controllers
> need to change their RPMh (Resource Power Manager-hardened) state. Once
> link retraining is done controller drivers needs to adjust their votes
> based on the final data rate.
> 
> Some controllers also may need to update their bandwidth voting like
> ICC BW votings etc.
> 
> So, add pre_link_speed_change() & post_link_speed_change() op to call
> before & after the link re-train. There is no explicit locking mechanisms
> as these are called by a single client Endpoint driver.
> 

What if client drivers of multiple endpoints connected to different RP of the
same Host Bridge call this API? Won't you need locking?

- Mani

> In case of PCIe switch, if there is a request to change target speed for a
> downstream port then no need to call these function ops as these are
> outside the scope of the controller drivers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
>  include/linux/pci.h       | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 36f939f23d34e8a3b25a2d1b9059e015f298ca94..dafb8d4f1cfba987e1ff08edfc7caba527f0c76b 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -140,6 +140,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  			  bool use_lt)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
> +	bool is_rootbus = pci_is_root_bus(port->bus);
>  	struct pci_bus *bus = port->subordinate;
>  	u16 target_speed;
>  	int ret;
> @@ -152,6 +154,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  
>  	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>  
> +	/*
> +	 * The host bridge driver may need to be scaled for targeted speed
> +	 * otherwise link might not come up at requested speed.
> +	 */
> +	if (is_rootbus && host->pre_link_speed_change) {
> +		ret = host->pre_link_speed_change(host, port, target_speed);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
>  		struct pcie_bwctrl_data *data = port->link_bwctrl;
>  
> @@ -176,6 +188,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>  	    !list_empty(&bus->devices))
>  		ret = -EAGAIN;
>  
> +	if (bus && is_rootbus && host->post_link_speed_change)
> +		host->post_link_speed_change(host, port, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..1740bab514b0a9a61c027463a1fb154843312a22 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>  	void (*release_fn)(struct pci_host_bridge *);
>  	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	/*
> +	 * Callback to the host bridge drivers to update ICC BW votes, clock
> +	 * frequencies etc.. for the link re-train to come up in targeted speed.
> +	 * These are intended to be called by devices directly attached to the
> +	 * Root Port. These are called by a single client Endpoint driver, so
> +	 * there is no need for explicit locking mechanisms.
> +	 */
> +	int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
> +				     struct pci_dev *dev, int speed);
> +	/*
> +	 * Callback to the host bridge drivers to adjust ICC BW votes, clock
> +	 * frequencies etc.. to the updated speed after link re-train. These
> +	 * are intended to be called by devices directly attached to the
> +	 * Root Port. These are called by a single client Endpoint driver,
> +	 * so there is no need for explicit locking mechanisms.
> +	 */
> +	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
> +				       struct pci_dev *dev, int speed);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

