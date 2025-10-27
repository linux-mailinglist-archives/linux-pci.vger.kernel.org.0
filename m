Return-Path: <linux-pci+bounces-39445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64FC0ED78
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22ABE341EB2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EF2FF679;
	Mon, 27 Oct 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hS5m5Fu+"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCE2D94BB;
	Mon, 27 Oct 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577976; cv=pass; b=YzYEbNZebbJC7km5ahFlwUkL3vGhOut0vrwDsMCxqSDggnCkdCaBPHH6HA0mbxedty/v/1KfWJHthUyDdHVTqRWK/o8KizwdGJ4ehUvja2fPGqIkfB3Un7xz2B83Yzxww/YET2C8GCeGGSUs3muZehx6gm1daP3MrTWpeuXMlPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577976; c=relaxed/simple;
	bh=UYF3ENKqXIB577KVE58eeSno4Lvyr4l0ez5z8HTbll0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy40O3fZw+g+oI5cIG98eicqSfdgIEDZI+NsUnGnt1tasFHu7aoygB0KZf3/lIVC7k5TCL2Dk3PZVMrZhsjUe+Fw4JQ75vV6aIR5EUgsYe2QosCS/OtAjWWRVBwi8V0mfbk3GnzIY7ptPjS93PzVbtDXZBoZEukU3socfxiQI84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hS5m5Fu+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761577951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QgkEdgY84nDWlJ/3RhFF846BGSqh3D7YQ6hxECQL/DQWvrN3pHPvR1l/0/05a6aHiBlcUyieSh1W/u1dQnC7ZSWvQgQHigfMQVCPD+Lbd8byITn/PVqYUrpEMAVQB6hXDobgINgf81tcobj82dyF/ojK8Pg7X0nAXvxB8jVmKx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761577951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hW97odhM9uO/XARUDOadwueA3k57Xsj3ULKP5Obq3Vs=; 
	b=mzChHXJbbaJkZ1lQwuPmdJWcTNzjqGIH/g+QQy2Iz2xWVUAaYtToT7X4Nd7cD5ARIeFUlT8JDII1ptORL9aydQONJvs3v7p8t1ywMK590d1nJod/Pl8HBtbe5v9P3v/V6JAMG6RNf7QeN3o4u3jOoraqfp4zUubftHHJ4JjlnvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761577951;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=hW97odhM9uO/XARUDOadwueA3k57Xsj3ULKP5Obq3Vs=;
	b=hS5m5Fu+MbHy/oVUia09FXh9MSx2928G7K7rUAdUmS5oNrJeniJsasiZP09KkZcc
	VA2npHN/ClJZTanUpVQjZG4prHxslpVmUp1hv9+KtZOBwKGcdNPsy7nwCqdyYf0HfOg
	VsYV1QAXcpKUX7bsq4z8no+D/oYFengFbSYqY3zA=
Received: by mx.zohomail.com with SMTPS id 17615779488931001.9507216437198;
	Mon, 27 Oct 2025 08:12:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Hans Zhang <18255117159@163.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>
Subject:
 Re: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
Date: Mon, 27 Oct 2025 16:12:19 +0100
Message-ID: <5235617.GXAFRqVoOG@workhorse>
In-Reply-To: <20251027145602.199154-2-linux.amoon@gmail.com>
References:
 <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 27 October 2025 15:55:29 Central European Standard Time Anand Moon wrote:
> Introduce a .remove() callback to the Rockchip DesignWare PCIe
> controller driver to ensure proper resource deinitialization during
> device removal. This includes disabling clocks and deinitializing the
> PCIe PHY.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 87dd2dd188b4..b878ae8e2b3e 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void rockchip_pcie_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +	/* Perform other cleanups as necessary */
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	rockchip_pcie_phy_deinit(rockchip);

You may want to add a

    if (rockchip->vpcie3v3)
            regulator_disable(rockchip->vpcie3v3);

here, since it's enabled in the probe function if it's found.

Not doing so means the regulator core will produce a warning
splat when devres removes it I'm fairly sure.

Kind regards,
Nicolas Frattaroli

> +}
> +
>  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> @@ -754,5 +764,6 @@ static struct platform_driver rockchip_pcie_driver = {
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = rockchip_pcie_probe,
> +	.remove = rockchip_pcie_remove,
>  };
>  builtin_platform_driver(rockchip_pcie_driver);
> 





