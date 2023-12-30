Return-Path: <linux-pci+bounces-1568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126198206D9
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3405A1C20F10
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F08F5C;
	Sat, 30 Dec 2023 15:19:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BE8F59;
	Sat, 30 Dec 2023 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CD95D2800BBD8;
	Sat, 30 Dec 2023 16:19:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C07F640FBD; Sat, 30 Dec 2023 16:19:31 +0100 (CET)
Date: Sat, 30 Dec 2023 16:19:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 06/10] PCI: Cache PCIe device's Supported Speed Vector
Message-ID: <20231230151931.GA25718@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929115723.7864-7-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 29, 2023 at 02:57:19PM +0300, Ilpo Järvinen wrote:
> The Supported Link Speeds Vector in the Link Capabilities Register 2
> corresponds to the bus below on Root Ports and Downstream Ports,
> whereas it corresponds to the bus above on Upstream Ports and
> Endpoints.

It would be good to add a pointer to the spec here.  I think the
relevant section is PCIe r6.1 sec 7.5.3.18 which says:

 "Supported Link Speeds Vector - This field indicates the supported
  Link speed(s) of the associated Port."
                       ^^^^^^^^^^^^^^^

Obviously the associated port is upstream on a Switch Upstream Port
or Endpoint, whereas it is downstream on a Switch Downstream Port
or Root Port.

Come to think of it, what about edge cases such as RCiEPs?


> Only the former is currently cached in pcie_bus_speeds in
> the struct pci_bus. The link speeds that are supported is the
> intersection of these two.

I'm wondering if caching both is actually necessary.  Why not cache
just the intersection?  Do we need either of the two somewhere?


> Store the device's Supported Link Speeds Vector into the struct pci_bus
> when the Function 0 is enumerated (the Multi-Function Devices must have
> same speeds the same for all Functions) to be easily able to calculate
> the intersection of Supported Link Speeds.

Might want to add an explanation what you're going to need this for,
I assume it's accessed frequently by the bandwidth throttling driver
in a subsequent patch?

Thanks,

Lukas

