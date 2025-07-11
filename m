Return-Path: <linux-pci+bounces-31960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A421B02671
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA091CA4FCE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282121D432D;
	Fri, 11 Jul 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxanN+Z4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9118D;
	Fri, 11 Jul 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269765; cv=none; b=uGEanzEBGKzRd8hn9TUcfMPfSSEbp6W18ip2fq9Y7Z00ufdiAzHT84sf1mjqKR8J18/TV2+2ib/QBD+MWgljYvFnpf4I6ohPWqEjyoi8DM6/GHlGH60gbuHpQ1/nyiRzrfUruSANoJDdw4JrOlTYna2zsLZjGRG4ydqqrDU5YIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269765; c=relaxed/simple;
	bh=6vFUYFx/VhN3Xm63hxLlS9XvwMe/jnHsYahek8vfgTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h4fgcJI3JnVoqy5GYtPCU1NJyDiO17JSLHKrRDRz2nvKHnmobUaZc6WE8u4K67Tqap+A0v8hRHnGJdmuhZ7fsYwXq8SfeqlznsqXZRwxHdeB8RKTb3XDtMYZ1H2yp16FJ8Fw+HiEKx0wWrsp7a1IW3n/itvXAY4unCwso/lWveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxanN+Z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C7DC4CEED;
	Fri, 11 Jul 2025 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752269764;
	bh=6vFUYFx/VhN3Xm63hxLlS9XvwMe/jnHsYahek8vfgTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OxanN+Z43huYfALidhi0ROpjH9PpXq7t9mMZrUH4TSYanrqRwi8nkqjE56+aGjBy+
	 YFZZgvzoI+OeDWdipSfxD1AuW+Xd8OGrquYI9BJdPH4yLhyqWrEkrmqBohkwDray5f
	 f6qdjzW9zngI7xFlClSOgDRnRZIKFj9PF4TMCl6n1iRsHeuOEBnGOA7oFIPcxBafbj
	 stBDdIPaAlrO7MlH0yFZp5aiczKaXnSIb5fg3ys2AySgREE4orAbFhG9jPW4h6RGc8
	 2t+QBZO6AR9bY4CrZTFKZmUpffq3MSa9aWWqj1t6BeHtHu6IBCpHZqJvbAHUGvFmnE
	 bTHQlrHT1SmYA==
Date: Fri, 11 Jul 2025 16:36:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
Message-ID: <20250711213602.GA2307197@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-mhi_bw_up-v4-2-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
> If the driver wants to move to higher data rate/speed than the current data
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
> In case of PCIe switch, if there is a request to change target speed for a
> downstream port then no need to call these function ops as these are
> outside the scope of the controller drivers.

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

No need to repeat the entire comment.  s/.././

These pointers feel awfully specific for being in struct
pci_host_bridge, since we only need them for a questionable QCOM
controller.  I think this needs to be pushed down into qcom somehow as
some kind of quirk.

> +	 */
> +	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
> +				       struct pci_dev *dev, int speed);

