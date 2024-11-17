Return-Path: <linux-pci+bounces-17007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63E9D04B9
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C019EB22276
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2418BC2F;
	Sun, 17 Nov 2024 17:02:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E2101E6;
	Sun, 17 Nov 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731862956; cv=none; b=svXCB+GuawNfp1pQP33YRIaXt3oMix3N45fh4WKbbqBwiydiMOLaXzCrTeJskIPzDq/RiMg0xymDGY4jC3Xjxg/4PzlJCSnQ5a9zsa2kBrCtXAS41R57v87O4lVHhkFhijXp8HHk9N7r2zKJFYboU72jaa9w1i09w3WbaxMmklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731862956; c=relaxed/simple;
	bh=x3fbqqyaDUEI1z5L8HhpzlEawRcNm9+yHV/9jvt8KAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ46QQcJleyf+5KZ5NnPV3gKfHQGt6Li/LG3cnzCDgmBFJZ2ijSLA6DB8rKwc/GXQ7pMcVO5j6AJnznoU5eJM8kZHjjKLbzxixXYM+DkE8hb0sgoC/EC5h95SjtAZgYNUzROZNvHDf+CnezU3xeJJ5nMjuaCYCPHovBo4rii9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CB551300000BE;
	Sun, 17 Nov 2024 18:02:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B37533C4905; Sun, 17 Nov 2024 18:02:23 +0100 (CET)
Date: Sun, 17 Nov 2024 18:02:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <Zzohn1nGk1-ZpMlc@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com>
 <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com>
 <ZzYq2GIUoD2kkUyK@wunner.de>
 <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com>
 <ZzcKoOXTVVj3bTnE@wunner.de>
 <f8fb0737-3450-4dcf-87a1-3b9f03ec94f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fb0737-3450-4dcf-87a1-3b9f03ec94f2@amd.com>

On Fri, Nov 15, 2024 at 07:54:37AM -0600, Bowman, Terry wrote:
> On 11/15/2024 2:47 AM, Lukas Wunner wrote:
> > On Thu, Nov 14, 2024 at 11:07:26AM -0600, Bowman, Terry wrote:
> > > I will remove the "if (!pcie_is_cxl(dev))" block as you suggested.
> > 
> > Ah, this is meant as a speed-up.  Actually that makes sense,
> > so feel free to keep it.
> >
> > If you do remove it, I think you'll have to move the cxl_port_dvsec()
> > invocation up in the function, in front of the pci_pcie_type() checks.
> > The latter require that one first checks that the device is PCIe.
> > That's done implicitly by cxl_port_dvsec() because it returns 0 in
> > the non-PCIe case.  (Due to the "if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)"
> > check in pci_find_next_ext_capability().)
> >
> > Another idea would be to put a "if (!pcie_is_cxl(dev)) return 0;" speed-up
> > in cxl_port_dvsec() so that the other caller benefits from it as well.
> 
> Ok, I'll look at adding the same pcie_is_cxl() call and check in
> cxl_port_devsec().

If you put "if (!pcie_is_cxl(dev)) return 0;" in cxl_port_devsec()
and move the call to cxl_port_devsec() in pcie_is_cxl_port() up in front
of the pci_pcie_type() checks, I think you won't need an additional
"!pcie_is_cxl(dev)" check in pcie_is_cxl_port().

Thanks,

Lukas

