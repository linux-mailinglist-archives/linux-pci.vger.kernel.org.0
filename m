Return-Path: <linux-pci+bounces-1563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB8820454
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBDD28222C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A361C0F;
	Sat, 30 Dec 2023 10:33:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CE23A5;
	Sat, 30 Dec 2023 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 594B6300002D0;
	Sat, 30 Dec 2023 11:33:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3DE44254B5A; Sat, 30 Dec 2023 11:33:13 +0100 (CET)
Date: Sat, 30 Dec 2023 11:33:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 01/10] PCI: Protect Link Control 2 Register with RMW
 locking
Message-ID: <20231230103313.GA12257@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929115723.7864-2-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 29, 2023 at 02:57:14PM +0300, Ilpo Järvinen wrote:
> PCIe Bandwidth Controller performs RMW accesses the Link Control 2
                                                 ^
						 to

> Register which can occur concurrently to other sources of Link Control
> 2 Register writes. Therefore, add Link Control 2 Register among the PCI
> Express Capability Registers that need RMW locking.
[...]
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -218,7 +218,7 @@ that is shared between many drivers including the service drivers.
>  RMW Capability accessors (pcie_capability_clear_and_set_word(),
>  pcie_capability_set_word(), and pcie_capability_clear_word()) protect
>  a selected set of PCI Express Capability Registers (Link Control
> -Register and Root Control Register). Any change to those registers
> -should be performed using RMW accessors to avoid problems due to
> -concurrent updates. For the up-to-date list of protected registers,
> -see pcie_capability_clear_and_set_word().
> +Register, Root Control Register, and Link Control 2 Register). Any
> +change to those registers should be performed using RMW accessors to
> +avoid problems due to concurrent updates. For the up-to-date list of
> +protected registers, see pcie_capability_clear_and_set_word().

Maybe use a list of bullet points of the affected registers so that
this can be extended more easily in the future.

Otherwise,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

