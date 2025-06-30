Return-Path: <linux-pci+bounces-31062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD8AED66B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EC217400C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D183324677F;
	Mon, 30 Jun 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpZelXZ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013F239E98;
	Mon, 30 Jun 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270316; cv=none; b=cVPHyiH5TaLDGdBLrz9Dqsqdu+rDZk/j9ybPJ2jlj1Vbw5WwNbFHDC8o+FPN02zzPZKf67De0wIJsMxnw3CvDiJvZyJgVhLuMYG4qDIH9V7+UsAPSHvZyD8VYm72sJx58UDMHIQxnUhrlRIGRxMf170KL4oBkzuGfnegmOs0Inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270316; c=relaxed/simple;
	bh=x2faBQFCPbJgkBeeErZ1FyYIo0+DBd/41+qTcGQaV/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX6XeW7coJDt8iqL2EwGygMc4DwLrUDGmaNysa498TPWE59B7Zm94p8T2tTk3uQyd4oW4LccpoGQ28WRCxGj+XkwxJOUWQQWkHLnTusTnlSn966dbnySFfJFn6dRIl1fwlPiTp9+tWgUqRqO+E2NSQ61xyM4jIXvqzwDT9g8Pi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpZelXZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8C1C4CEE3;
	Mon, 30 Jun 2025 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751270316;
	bh=x2faBQFCPbJgkBeeErZ1FyYIo0+DBd/41+qTcGQaV/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpZelXZ/xs/xYeF1gZ0fhMdMjGIAVXlRd3Icg1uLbmZRVVpGsmrrlelKHPQ62zRaS
	 W2EviIEd6qX9ID6TBl7rmy6lswzNJlmQrQlShpH31kyWGWHLu1WvNkJcBTS54pALsE
	 T7jgfnyR1/osdhPJsSJXcs43aqveX2OCgha1Ju2zEoEK5q6CBkfY/deAxU9a4sKr8k
	 NSMHVeeCNFzUnC8N6nvVkOb73/IiFOwrd3LlNU6k0GgPjQWHEDeAX0OzOA8yYHyBs8
	 NTB0xTSKtNin1GsOSRZ1juMpiScu1740DT28shdr/+1QPCzbIbHi6CTFpsgivzv+o/
	 YOpWw5klv/XuA==
Date: Mon, 30 Jun 2025 09:58:28 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 24/31] of/irq: Add of_msi_xlate() helper function
Message-ID: <aGJDpBBY6tnvmLup@lpieralisi>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
 <20250626-gicv5-host-v6-24-48e046af4642@kernel.org>
 <20250627213241.GA168190-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627213241.GA168190-robh@kernel.org>

On Fri, Jun 27, 2025 at 04:32:41PM -0500, Rob Herring wrote:
> On Thu, Jun 26, 2025 at 12:26:15PM +0200, Lorenzo Pieralisi wrote:
> > Add an of_msi_xlate() helper that maps a device ID and returns
> > the device node of the MSI controller the device ID is mapped to.
> > 
> > Required by core functions that need an MSI controller device node
> > pointer at the same time as a mapped device ID, of_msi_map_id() is not
> > sufficient for that purpose.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/of/irq.c       | 22 +++++++++++++++++-----
> >  include/linux/of_irq.h |  5 +++++
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index f8ad79b9b1c9..74aaea61de13 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -670,8 +670,20 @@ void __init of_irq_init(const struct of_device_id *matches)
> >  	}
> >  }
> >  
> > -static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> > -			    u32 id_in)
> > +/**
> > + * of_msi_xlate - map a MSI ID and find relevant MSI controller node
> > + * @dev: device for which the mapping is to be done.
> > + * @msi_np: Pointer to store the MSI controller node
> > + * @id_in: Device ID.
> > + *
> > + * Walk up the device hierarchy looking for devices with a "msi-map"
> > + * property. If found, apply the mapping to @id_in. @msi_np pointed
> > + * value must be NULL on entry, if an MSI controller is found @msi_np is
> > + * initialized to the MSI controller node with a reference held.
> > + *
> > + * Returns: The mapped MSI id.
> > + */
> > +u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
> >  {
> >  	struct device *parent_dev;
> >  	u32 id_out = id_in;
> > @@ -682,7 +694,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> >  	 */
> >  	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> >  		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> > -				"msi-map-mask", np, &id_out))
> > +				"msi-map-mask", msi_np, &id_out))
> >  			break;
> >  	return id_out;
> >  }
> > @@ -700,7 +712,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> >   */
> >  u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
> 
> Can we replace the 2 callers of of_msi_map_id() with of_msi_xlate()? 

Yes we could - with a separate patch, it is a clean-up (current
of_msi_map_id() users call it with a specific of_node target, I did not
convert it in *this* patch to prevent adding issues - I will also add
relevant kdoc info related to the of_node parameter in of_msi_xlate()
that will need to be changed).

> The series is already big enough, so that can be a follow-up or do it 
> for 6.17 if the series isn't going to make it.

I will put together a patch - I don't think it belongs in this series
but depending on whether I need to do a v7 I will see what's best.

Thanks,
Lorenzo

