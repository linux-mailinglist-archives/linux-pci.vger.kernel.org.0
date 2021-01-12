Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7112F28B1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 08:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391854AbhALHJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 02:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391833AbhALHJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 02:09:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD8C061794;
        Mon, 11 Jan 2021 23:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1MbR0KEingEiKHlJFPhYyg+QeqNPZLYQbX0i3UjPXTk=; b=vhei9Ns0AlUgL+KS/3ubkU3MBB
        cMpDUcV8rALaC0Ch6YZpbTIjw6rXMTQ9mjs0aa3eTxwUWXpo8d+zgXGhbwk/toOzLjlrivj9faQ3j
        tAWckufDiJncyXVxkfbbC9gXhX1mICT/7D36d0ai6KFxJCH9qviKhZCESZ5deoX/FUCaeQaL0bdfA
        nsnj9UdiO0zMD7mGMbrSgLc6TLaIW8jINo9vRiU56ahARidc2I3WhvrC+7auB1Il4qALEi74GHSA7
        wFJh7Me+IPzBYu9Vot8OyeERrIn1dqt91O9VcP8P56m7yIWukM0fkCuiRNLTsuJkQdzL7NgGVuKhk
        WZKcMfTw==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzDn8-0003DJ-A1; Tue, 12 Jan 2021 07:08:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-3-ben.widawsky@intel.com>
Message-ID: <6403137e-a93f-1714-03a3-9e80cc48a4e6@infradead.org>
Date:   Mon, 11 Jan 2021 23:08:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111225121.820014-3-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/11/21 2:51 PM, Ben Widawsky wrote:
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..68da926ba5b1
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	help
> +	  CXL is a bus that is electrically compatible with PCI-E, but layers
> +	  three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem).
> +	  The CXL.cache protocol allows devices to hold cachelines locally, the
> +	  CXL.mem protocol allows devices to be fully coherent memory targets,
> +	  the CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support
> +	  for the configuration and management of devices supporting these
> +	  protocols.
> +
> +if CXL_BUS
> +
> +config CXL_BUS_PROVIDER
> +	tristate
> +
> +config CXL_ACPI
> +	tristate "CXL ACPI: Platform Support"
> +	depends on ACPI
> +	default CXL_BUS
> +	select CXL_BUS_PROVIDER
> +	help
> +	  Say 'y/m' to enable a driver (named "cxl_acpi.ko" when built
> +	  as a module) that will enable support for CXL.mem endpoint
> +	  devices. In general, CXL Platform Support is a prerequisite
> +	  for any CXL device driver that wants to claim ownership of a
> +	  component register space. By default platform firmware assumes
> +	  Linux is unaware of CXL capabilities and requires explicit
> +	  opt-in. This platform component also mediates resources
> +	  described by the CEDT (CXL Early Discovery Table).  See
> +	  Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL 2.0
> +	  specification.
> +
> +	  If unsure say 'm'

End above sentence with a '.', please.

> +endif


-- 
~Randy

