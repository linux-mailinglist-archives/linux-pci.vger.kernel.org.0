Return-Path: <linux-pci+bounces-293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B77FF497
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8012816FC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCBD54BFF;
	Thu, 30 Nov 2023 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfCmaJXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A44E54BFC;
	Thu, 30 Nov 2023 16:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB9DC433CC;
	Thu, 30 Nov 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361141;
	bh=ev/3cQ8WkO4ZH4x0KC/Ak2z7sd7hRQCPFQGQ6Q/urBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfCmaJXBScFzJTswaF+Ez0GyO6+FrNirwBnvtipOEyATe/Oj7aCtY4gb2IbLvIw3v
	 UT2OisJ5UHOnYXLTF2YapcC795BuXiQBsvxfvlRuOmQxZquDtKxyYzfD+NVeAOOjsM
	 Fp0hFHIoBvU0J4PDqQNXpCRvtJrSXeTPGFsEA4Nc=
Date: Thu, 30 Nov 2023 16:18:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: of: Attach created of_node to existing device
Message-ID: <2023113008-prenatal-pushchair-956f@gregkh>
References: <20231130152418.680966-1-herve.codina@bootlin.com>
 <20231130152418.680966-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130152418.680966-3-herve.codina@bootlin.com>

On Thu, Nov 30, 2023 at 04:24:04PM +0100, Herve Codina wrote:
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created.
> For each PCI devices a struct device is already present (created and
> handled by the PCI core).
> Having a second struct device to represent the exact same PCI device is
> not correct.
> 
> On the of_node creation, tell the of_platform that there is no need to
> create a device for this node (OF_POPULATED flag), link this newly
> created of_node to the already present device and tell fwnode that the
> device attached to this of_node is ready (fwnode_dev_initialized()).
> 
> With this fix, the of_node are available in the sysfs device tree:
> /sys/devices/platform/soc/d0070000.pcie/
> + of_node -> .../devicetree/base/soc/pcie@d0070000
> + pci0000:00
>   + 0000:00:00.0
>     + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
>     + 0000:01:00.0
>       + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0
> 
> On the of_node removal, revert the operations.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org

How can this be cc: stable when the api it relies on is not?

confused,

greg k-h

