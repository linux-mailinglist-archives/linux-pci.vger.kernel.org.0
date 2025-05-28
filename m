Return-Path: <linux-pci+bounces-28495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCCAC6217
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 08:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BF4A0A63
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8791242D98;
	Wed, 28 May 2025 06:39:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C53242D95;
	Wed, 28 May 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414342; cv=none; b=VqPFk8GZ7AWrq297v2AeSPBT5tEQlHkWhbQ/ajUnd3W8QrM16zlcV7WcSFvk60kf1MutXp4iJ04CuYi/8rUElssivM9PmUTYne9wEEdfmv1Hj8hhKiO709lQM23FUZjycUDt416OAZrGriurXAQTronxMxJZE39CrPEvXVuryOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414342; c=relaxed/simple;
	bh=Duw0wz08mc2oHMqHnxezalaq0om2rCtkTpHvQTZc+XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P71+4y/HwGLpzILQnTUM0IFSMb7gciaIA6wLgv8sZSUmABxEVXIhtQdFBTpCtuRyw7D7FXZRWtPiL810D4+F+lEiyFv7ktkQnagx0r4dbHLMJE9vvbv18xLSYPQW0sk6Vag5DAe+wL3wA+/UcdNzywZI9c+rfg/KC0DZfuiwJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7F9772C0AD18;
	Wed, 28 May 2025 08:38:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3F699176016; Wed, 28 May 2025 08:38:51 +0200 (CEST)
Date: Wed, 28 May 2025 08:38:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 13/20] PCI/ERR: Add printk level to
 pcie_print_tlp_log()
Message-ID: <aDave5XyXZoKWole@wunner.de>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-14-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522232339.1525671-14-helgaas@kernel.org>

On Thu, May 22, 2025 at 06:21:19PM -0500, Bjorn Helgaas wrote:
> @@ -130,6 +132,6 @@ void pcie_print_tlp_log(const struct pci_dev *dev,
>  		}
>  	}
>  
> -	pci_err(dev, "%sTLP Header%s: %s\n", pfx,
> +	dev_printk(level, &dev->dev, "%sTLP Header%s: %s\n", pfx,
>  		log->flit ? " (Flit)" : "", buf);
>  }

Nit: pci_printk() ?

The definition in include/linux/pci.h was retained by fab874e12593.

